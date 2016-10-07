package cn.edu.tju.bigdata.entity.plane;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

import java.util.List;

/**
 * Created by xliu on 2016/10/5.
 */
public class Plane {
    public int planeid;
    public int year;
    public int month;
    public double lng;
    public double lat;
    public JSONObject polygon;
    public JSONObject attr;
    public Plane(){}

    public Plane(int year,int month,String attr){
        this.year = year;
        this.month = month;
        this.attr = JSON.parseObject(attr);
    }

    public Plane(int year,int month,double lng,double lat){
        this.year = year;
        this.month = month;
        this.lng = lng;
        this.lat = lat;
    }
    public Plane(int planeid, double lng, double lat, String polygon, String attr) {
        this.planeid = planeid;
        this.lng = lng;
        this.lat = lat;
        this.polygon = JSON.parseObject(polygon);
        this.attr = JSON.parseObject(attr);
    }

    public Plane(int planeid, int year, int month, double lng, double lat, String polygon, String attr) {
        this.planeid = planeid;
        this.year = year;
        this.month = month;
        this.lng = lng;
        this.lat = lat;
        this.polygon = JSON.parseObject(polygon);
        this.attr = JSON.parseObject(attr);
    }
    public String toFullSQLString(){
        return String.format("%d,%d,%d,%f,%f,\"%s\",\"%s\"", planeid,year,month,lng,lat,polygon.toJSONString(),attr.toJSONString());
    }
    public String toInsertSQLString(){
        return String.format("%d,%d,%f,%f,\"%s\",\"%s\"",year,month,lng,lat,polygon.toJSONString().replace("\"","\\\""),attr.toJSONString().replace("\"","\\\""));
    }
    public void setPolygon(String polygonStr){
        this.polygon=JSON.parseObject(polygonStr);
    }
    public void setPolygon(JSONObject polygon){
        this.polygon=polygon;
    }
    public void setPolygon(List<Point> list){
        JSONArray jsa=new JSONArray();
        for(Point p:list){
            JSONObject tmp=new JSONObject();
            tmp.put("lng",p.lng);
            tmp.put("lat",p.lat);
            jsa.add(tmp);
        }
        JSONObject js=new JSONObject();
        js.put("edge",jsa);
        this.polygon=js;
    }
    public void setAttr(String attr){
        this.attr= JSON.parseObject(attr);
    }
    public void setAttr(JSONObject attr){
        this.attr=attr;
    }
    public JSONObject toMapJSON(String type){
        JSONObject json=new JSONObject();
        json.put("planeid", planeid);
        json.put("lng",lng);
        json.put("lat",lat);
        json.put("polygon",polygon.get("edge"));
        if(type==null||!attr.containsKey(type)) json.put("attr",attr);
        else{
            JSONObject single=new JSONObject();
            single.put(type,attr.get(type));
            json.put("attr",single);
        }
        return json;
    }
    public JSONObject toLineJSON(){
        JSONObject json=new JSONObject();
        json.put("year",year);
        json.put("month",month);
        json.put("attr",attr);
        return json;
    }
}
