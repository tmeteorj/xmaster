package cn.edu.tju.bigdata.biz.location;

import cn.edu.tju.bigdata.entity.PlaneFormMap;
import cn.edu.tju.bigdata.entity.siteselection.LocationRelitu;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

import java.util.List;

/**
 * Created by aloha on 2016/10/25.
 */
public class LocatBiz {
    public static JSONObject searchByYMA(List<LocationRelitu> list, String attr) {
        JSONArray data = new JSONArray();
        int cn=0;
        for (LocationRelitu pfm:list) {
            ++cn;
            data.add(toMapJSON(pfm,attr));
        }
        JSONObject result = new JSONObject();
        result.put("data", data);
        result.put("msg", "success");
        result.put("code", 0);
        return result;
    }
    public static JSONObject toMapJSON(LocationRelitu map,String type){
        JSONObject json=new JSONObject();
        json.put("count",map.getInt("cnt")*10);
        json.put("lng",Double.parseDouble(map.getStr("lng")));
        json.put("lat",Double.parseDouble(map.getStr("lat")));
        return json;
    }
}
