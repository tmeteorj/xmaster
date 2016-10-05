package cn.edu.tju.bigdata.biz;

import cn.edu.tju.bigdata.entity.PlaneFormMap;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

import java.util.Arrays;
import java.util.List;

/**
 * Created by xliu on 2016/9/29.
 */
public class PlaneBiz {
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
        json.put("lng",map.get("lng"));
        json.put("lat",map.get("lat"));
        JSONObject polygon=JSONObject.parseObject(map.get("polygon").toString());
        JSONObject attr=JSONObject.parseObject(map.get("attr").toString());
        json.put("polygon",polygon.get("edge"));
        if(type==null||!attr.containsKey(type)) json.put("attr",attr);
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
            double y=attrjs.getDouble(attr);
            timearr.add(x);
            valuearr.add(y);
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
}
