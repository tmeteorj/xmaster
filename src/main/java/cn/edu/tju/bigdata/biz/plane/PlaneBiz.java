package cn.edu.tju.bigdata.biz.plane;

import cn.edu.tju.bigdata.entity.PlaneFormMap;
import cn.edu.tju.bigdata.util.ConstMap;
import cn.edu.tju.bigdata.util.plane.MySQLUtil;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by xliu on 2016/9/29.
 */
public class PlaneBiz {
    public static Logger LOGGER = LoggerFactory.getLogger(PlaneBiz.class);
    public static JSONObject searchByYMA(List<PlaneFormMap> list, String attr) {
        JSONArray data = new JSONArray();
        for (PlaneFormMap pfm:list) {
            data.add(toMapJSON(pfm,attr));
        }
        JSONObject result = new JSONObject();
        result.put("data", data);
        result.put("msg", "success");
        result.put("code", 0);
        return result;
    }
    public static JSONObject toMapJSON(PlaneFormMap map,String type){
        JSONObject json=new JSONObject();
        json.put("planeid", map.get("plane_id"));
        json.put("planename", map.get("plane_name"));
        json.put("lng",map.get("lng"));
        json.put("lat",map.get("lat"));
        JSONObject polygon=JSONObject.parseObject(map.get("polygon").toString());
        JSONObject attr=JSONObject.parseObject(map.get("attr").toString());
        json.put("polygon",polygon.get("edge"));
        if(type==null||!attr.containsKey(type)) {
            JSONObject single=new JSONObject();
            single.put(type,0);
            json.put("attr",attr);
        }
        else{
            JSONObject single=new JSONObject();
            single.put(type,attr.get(type));
            json.put("attr",single);
        }
        return json;
    }

    public static JSONObject searchByPA(List<PlaneFormMap> list, String attr) {
        JSONArray timearr=new JSONArray();
        JSONArray valuearr=new JSONArray();
        for(PlaneFormMap pfm:list){
            String x=pfm.get("year")+"-"+pfm.get("month");
            JSONObject attrjs=JSONObject.parseObject(pfm.get("attr").toString());
            if(attrjs.containsKey(attr))valuearr.add(attrjs.getDouble(attr));
            else valuearr.add(0.0);
            timearr.add(x);
        }
        JSONObject result = new JSONObject();
        JSONObject data = new JSONObject();
        data.put("time",timearr);
        data.put("value",valuearr);
        result.put("data", data);
        result.put("msg", "success");
        result.put("code", 0);
        return result;
    }

    public static void genRandomData() throws SQLException {
        ResultSet rs = MySQLUtil.queryResult("select plane_id,attr from bd_plane where year=2015 and month=1");
        List<Object[]> list = new ArrayList<Object[]>();
        while (rs.next()) {
            int pid = rs.getInt("plane_id");
            JSONObject attr = JSONObject.parseObject(rs.getString("attr"));
            list.add(new Object[]{pid, attr});
        }
        int tot = list.size();
        int solve = 0;
        for (Object[] items : list) {
            int pid = (Integer) items[0];
            JSONObject attr = (JSONObject) items[1];
            for (int month = 2; month <= 12; month++) {
                for (String[] its : ConstMap.attrMap) {
                    if (its[0].equals("Price")) {
                        attr.put(its[0], attr.getDoubleValue(its[0]) * (0.99 + Math.random() / 3));
                    } else if (its[0].contains("NMI") || its[0].contains("Entropy")) {
                        attr.put(its[0], Math.random());
                    } else {
                        attr.put(its[0], Math.random() * 100000);
                    }
                }
                MySQLUtil.updateResult(String.format("update bd_plane set attr=\'%s\' where year=2015 and month=%d and plane_id=%d",
                        attr.toJSONString().replace("\"", "\\\""), month, pid));
            }
            ++solve;
            LOGGER.info(String.format("%d/%d=%.4f%%", solve, tot, solve * 100.0 / tot));
        }
    }

    public static void main(String args[]) throws SQLException {
        genRandomData();
    }
}
