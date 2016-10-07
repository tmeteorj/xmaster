package cn.edu.tju.bigdata.biz.plane;

import cn.edu.tju.bigdata.entity.plane.Plane;
import cn.edu.tju.bigdata.entity.plane.Point;
import cn.edu.tju.bigdata.util.plane.GeoUtil;
import com.alibaba.fastjson.JSONObject;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by xliu on 2016/10/5.
 */
public class PlaneDataGenerate {

    private static String [] typeArray=new String[]{"Storage Facility,1","News Facility,2","Library Facility,3",
            "Adult Education Facility,4","Sports Facility,5","Hotel Facility,6","Military Facility,7",
            "Middle Education Facility,8","Office Facility,9","Logistic Facility,10","Traffic Facility,11",
            "Entertainment Facility,12","Service Facility,13","Higher Education Facility,14",
            "Medical Facility,15","Industry Facility,16","Research Facility,17","Primary Education Facility,18",
            "Government Facility,19","Public Facility,20","Financial Facility,21","Residential Facility,22"};
    private static String randomType() {
        return typeArray[(int)(Math.random()*22)];
    }
    public static JSONObject makeAttr(String type){
        JSONObject js = new JSONObject();
        js.put("Type", type);
        js.put("Area", Math.random() * 10000);
        js.put("Population", Math.random() * 10000);
        js.put("CallOutCnt", Math.random() * 10000);
        js.put("CallInCnt", Math.random() * 10000);
        js.put("CallOutInter", Math.random() * 10000);
        js.put("CallInInter", Math.random() * 10000);
        js.put("CallInter", Math.random() * 10000);
        js.put("MessOutCnt", Math.random() * 10000);
        js.put("MessInCnt", Math.random() * 10000);
        js.put("MessOutInter", Math.random() * 10000);
        js.put("MessInInter", Math.random() * 10000);
        js.put("MessInter", Math.random() * 10000);
        js.put("CallDegree", Math.random() * 10000);
        js.put("MessDegree", Math.random() * 10000);
        js.put("CallComCnt", Math.random() * 10000);
        js.put("MessComCnt", Math.random() * 10000);
        js.put("CallMessNMI", Math.random());
        js.put("CallEntropy", Math.random());
        js.put("MessEntropy", Math.random());
        return js;
    }

    public void genOne(double sx, double sy, int pid)  {
        List<Point> org=new ArrayList<Point>();
        org.add(new Point(sx,sy));
        for(int i=0;i<20;i++){
            sx+=Math.random()/500.0-0.001;
            sy+=Math.random()/500.0-0.001;
            org.add(new Point(sx,sy));
        }
        org= GeoUtil.convexHull(org);
        sx=0;
        sy=0;
        for(Point p:org){
            sx+=p.lng;
            sy+=p.lat;
        }
        sx/=org.size();
        sy/=org.size();
        for(int year=2014;year<=2015;year++) {
            for (int month = 1; month <= 12; month++) {
                Plane pl = new Plane(year, month, sx,sy);
                pl.setPolygon(org);
                pl.setAttr(makeAttr(randomType()));
                SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
                String sql = String.format("insert into bd_plane(plane_id,year,month,lng,lat,polygon,attr,deleted_mark,meta_created,meta_updated) values(%d,%s,1,%s)", pid, pl.toInsertSQLString(),
                        String.format("\'%s\',\'%s\'",sdf.format(new Date()),sdf.format(new Date())));
               // MySQLUtil.updateResult("plane", sql);
            }
        }
    }

}
