package cn.edu.tju.bigdata.biz.plane;

import cn.edu.tju.bigdata.util.plane.MySQLUtil;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.SQLException;
import java.util.Arrays;

import cn.edu.tju.bigdata.util.plane.Const;

/**
 * Created by xliu on 2016/10/5.
 */
public class PlaneGridDataGenerate {
    private static Logger LOGGER= LoggerFactory.getLogger(PlaneGridDataGenerate.class);

    private static boolean mat[][]=new boolean[Const.WIDTH][Const.HEIGHT];
    private static String [] typeArray=new String[]{"Storage Facility,1","News Facility,2","Library Facility,3",
            "Adult Education Facility,4","Sports Facility,5","Hotel Facility,6","Military Facility,7",
            "Middle Education Facility,8","Office Facility,9","Logistic Facility,10","Traffic Facility,11",
            "Entertainment Facility,12","Service Facility,13","Higher Education Facility,14",
            "Medical Facility,15","Industry Facility,16","Research Facility,17","Primary Education Facility,18",
            "Government Facility,19","Public Facility,20","Financial Facility,21","Residential Facility,22"};
    private static String randomType() {
        return typeArray[(int)(Math.random()*22)];
    }

    public static boolean check(int lx,int rx,int ly,int ry) {
        if(rx>=Const.WIDTH||ry>=Const.HEIGHT)return false;
        for (int i = lx; i <= rx; i++) {
            for (int j = ly; j <= ry; j++) {
                if (mat[i][j]) return false;
            }
        }
        return true;
    }
    public static void full(int lx,int rx,int ly,int ry){
        lx=Math.max(0,lx);
        rx=Math.min(Const.WIDTH-1,rx);
        ly=Math.max(0,ly);
        ry=Math.min(Const.HEIGHT-1,ry);
        for (int i = lx; i <= rx; i++) {
            for (int j = ly; j <= ry; j++) {
                mat[i][j]=true;
            }
        }
    }
    public static void generatePlane(int lx,int ly,int idx) throws SQLException {
        int rx=lx,ry=ly;
        int t=10;
        while(t>0&&Math.random()<Const.EXTEND_RATE){
            int d=(int)(Math.random()*4);
            if(d==0){
                if(rx<Const.WIDTH-1&&check(rx+1,rx+1,ly,ry)){
                    rx++;
                }else{
                    t--;
                }
            }else if(d==1){
                if(ry<Const.HEIGHT-1&&check(lx,rx,ry+1,ry+1)){
                    ry++;
                }else{
                    t--;
                }
            }else if(d==2){
                if(lx>0&&check(lx-1,lx-1,ly,ry)){
                    lx--;
                }else{
                    t--;
                }
            }else if(d==3){
                if(ly>0&&check(lx,rx,ly-1,ly-1)){
                    ly--;
                }else{
                    t--;
                }
            }
        }
        full(lx-1,rx+1,ly-1,ry+1);
        double dlx=Const.MIN_LNG+lx*Const.GRID_SIZE;
        double dly=Const.MIN_LAT+ly*Const.GRID_SIZE;
        double drx=Const.MIN_LNG+rx*Const.GRID_SIZE+Const.GRID_SIZE;
        double dry=Const.MIN_LAT+ry*Const.GRID_SIZE+Const.GRID_SIZE;
        JSONObject polygon=new JSONObject();
        JSONArray edge= JSON.parseArray(String.format("[{\"lng\":%f,\"lat\":%f},{\"lng\":%f,\"lat\":%f},{\"lng\":%f,\"lat\":%f},{\"lng\":%f,\"lat\":%f}]",
                dlx,dly,drx,dly,drx,dry,dlx,dry));
        polygon.put("edge",edge);
        JSONObject attr=new JSONObject();
        attr.put("Type",randomType());
        attr.put("Area",(ry-ly+1)*(rx-lx+1)*Const.GRID_AREA);
        for(int i=2014;i<=2015;i++){
            for(int j=1;j<=12;j++){
                String sql=String.format("insert into bd_plane(plane_id,year,month,lng,lat,polygon,attr) values(%d,%d,%d,%f,%f,\"%s\",\"%s\")",
                        idx,i,j,(dlx+drx)/2.0,(dly+dry)/2.0,polygon.toJSONString().replace("\"","\\\""),attr.toJSONString().replace("\"","\\\""));
//                System.out.println(sql);
//                System.exit(0);
                MySQLUtil.updateResult(sql);
            }
        }
    }
    private static void generatePlane(int num) throws SQLException {
        for(int i=0;i<Const.WIDTH;i++){
            Arrays.fill(mat[i],false);
        }
        int cnt=0;
        for(int i=1;i<=num;i++) {
            int x = (int) (Math.random() * Const.WIDTH);
            int y = (int) (Math.random() * Const.WIDTH);
            if(!mat[x][y])generatePlane(x, y, ++cnt);
            LOGGER.info(String.format("gen %d->%d %.5f%%",i,cnt,cnt*100.0/i));
        }
    }
    public static void main(String args[]) throws SQLException {
        generatePlane(1500);
    }

}
