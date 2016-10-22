package cn.edu.tju.bigdata.util.operator;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by NING on 2016/10/17.
 */
public class CommonOperator {
    public static Map coutSingleList(List<String> data){
        Map<String,Integer> hs = new HashMap<>();
        for(String da:data){
            if(hs.containsKey(da)){
                hs.put(da,hs.get(da)+1);
            }
            else{
                hs.put(da,1);
            }
        }
        List<String> name = new ArrayList<>();
        List<String> count = new ArrayList<>();
        for(Map.Entry entry:hs.entrySet()){
            name.add(String.valueOf(entry.getKey()));
            count.add(String.valueOf(entry.getValue()));
        }
        Map ans = new HashMap<>();
        ans.put("name",name);
        ans.put("count",count);
        return ans;
    }

    public static Map constructNetworkTwoList (List<String> id,List<String> label
            ,List<String> fromid,List<String> toid,String remark){


        Map ans = new HashMap<>();
        ans.put("id",id);
        ans.put("label",label);
        ans.put("fromid",fromid);
        ans.put("toid",toid);
        ans.put("remark",remark);
        return ans;
    }
}
