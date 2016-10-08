package cn.edu.tju.bigdata.biz.gsm;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Random;

import cn.edu.tju.bigdata.util.plane.Const;

/**
 * Created by Administrator on 2016/10/7.
 */
public class GSMRecordDataGenerate {

    private static Logger LOGGER= LoggerFactory.getLogger(GSMRecordDataGenerate.class);
    private static SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
    private static HashMap<Integer,double[]> pos;
    private static HashMap<Integer,Date> lastdate;
    private static Random rd;
    private static String generateOne(Date now){
        //type,time,subject,object,lng,lat

        int types[]=new int[]{1,3,6,7,12,13};
        int type=rd.nextInt(types.length);
        String time=sdf.format(now);
        int subject=rd.nextInt(Const.MAX_POPULATION);
        int object=subject;
        while(type<4&&object==subject)object=rd.nextInt(Const.MAX_POPULATION);
        double ps[]=pos.get(subject);
        Date last=lastdate.get(subject);
        double diff=(now.getTime()-last.getTime())/360000.0;
        for(int i=0;i<2;i++){
            ps[i]+=2*diff*rd.nextDouble()-diff;
        }
        pos.put(subject,ps);
        lastdate.put(subject,now);
        return String.format("%d,%s,%d,%d,%f,%f",types[type],time,subject,object,ps[0],ps[1]);
    }

    public static void generateData(String starttime, String endtime, String filepath) throws ParseException, IOException {
        rd=new Random();
        Date last=sdf.parse(starttime);
        Date enddate=sdf.parse(endtime);
        Date now=null;
        pos=new HashMap<Integer, double[]>();
        lastdate=new HashMap<Integer, Date>();
        for(int i=0;i<Const.MAX_POPULATION;i++){
            pos.put(i,new double[]{Const.MIN_LNG+(Const.MAX_LNG-Const.MIN_LNG)*rd.nextDouble(),
                    Const.MIN_LAT+(Const.MAX_LAT-Const.MIN_LAT)*rd.nextDouble()});
            lastdate.put(i,last);
        }
        OutputStreamWriter fw=new OutputStreamWriter(new FileOutputStream(new File(filepath)),"utf-8");
        while(last.before(enddate)){
            long difftime=(long)(5000*rd.nextDouble());
            now=new Date(last.getTime()+difftime);
            String record=generateOne(now);
            fw.write(record+"\n");
            last=now;
            if(rd.nextInt(1000)==0)LOGGER.info(record);
        }
        fw.close();
    }
    public static void main(String args[]) throws IOException, ParseException {
        generateData("2015-01-01 00:00:00","2015-02-01 00:00:00",Const.SAMPLE_DATA_PATH);
    }
}
