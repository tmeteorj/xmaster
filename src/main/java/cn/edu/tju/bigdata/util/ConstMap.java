package cn.edu.tju.bigdata.util;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by xliu on 2016/9/29.
 */
public class ConstMap {
    public static List<String[]> attrMap;
    static{
        attrMap=new ArrayList<String[]>();
        //attrMap.add(new String[]{"Type","类型"});
        attrMap.add(new String[]{"Price", "房价"});
        attrMap.add(new String[]{"Resident", "住户数"});
        attrMap.add(new String[]{"Green", "绿化覆盖率"});
        attrMap.add(new String[]{"StopCar", "停车位"});
        attrMap.add(new String[]{"Population","人口"});
        attrMap.add(new String[]{"CallOutCnt","电话呼出次数"});
        attrMap.add(new String[]{"CallInCnt","电话呼入次数"});
        attrMap.add(new String[]{"CallOutInter","电话呼出间隔"});
        attrMap.add(new String[]{"CallInInter","电话呼入间隔"});
        attrMap.add(new String[]{"CallInter", "电话间隔"});
        attrMap.add(new String[]{"MessOutCnt", "短信发出次数"});
        attrMap.add(new String[]{"MessInCnt", "短信接收次数"});
        attrMap.add(new String[]{"MessOutInter", "短信发出间隔"});
        attrMap.add(new String[]{"MessInInter", "短信接收间隔"});
        attrMap.add(new String[]{"MessInter", "短信间隔"});
        attrMap.add(new String[]{"CallDegree", "通话度数"});
        attrMap.add(new String[]{"MessDegree", "短信度数"});
        attrMap.add(new String[]{"CallComCnt", "通话社团个数"});
        attrMap.add(new String[]{"MessComCnt", "短信社团个数"});
        attrMap.add(new String[]{"CallMessNMI", "通话短信社团互信息"});
        attrMap.add(new String[]{"CallEntropy", "通话社团熵"});
        attrMap.add(new String[]{"MessEntropy", "短信社团熵"});
    }
}
