package cn.edu.tju.bigdata.biz.gsm;

import cn.edu.tju.bigdata.entity.GSMRecordFormMap;
import cn.edu.tju.bigdata.util.plane.MySQLUtil;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2016/10/7.
 */
public class GSMRecordDataLoad {
    public List<String> dataList;
    public String insertSQL;
    public SimpleDateFormat sdf;
    public GSMRecordDataLoad(){
        dataList=new ArrayList<String>();
        insertSQL="insert into bd_gsmrecord(dataset_id,type,time,subject,object,lng,lat,remark,meta_created) values";
        sdf=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
    }
    public void add(GSMRecordFormMap gsmRecordFormMap) throws SQLException {
        dataList.add(String.format("(%d,%d,\"%s\",%d,%d,%f,%f,\"%s\",\"%s\")",
                gsmRecordFormMap.getInt("dataset_id"),
                gsmRecordFormMap.getInt("type"),
                gsmRecordFormMap.getStr("time"),
                gsmRecordFormMap.getInt("subject"),
                gsmRecordFormMap.getInt("object"),
                gsmRecordFormMap.getDouble("lng"),
                gsmRecordFormMap.getDouble("lat"),
                gsmRecordFormMap.getStr("remark"),
                sdf.format(new Date())
                ));
        if(dataList.size()>1000){
            insert();
        }
    }
    public void insert() throws SQLException {
        StringBuilder sb=new StringBuilder();
        sb.append(insertSQL);
        String split="";
        for(String s:dataList){
            sb.append(split+s);
            split=",";
        }
        MySQLUtil.updateResult(sb.toString());
        dataList.clear();
    }

}
