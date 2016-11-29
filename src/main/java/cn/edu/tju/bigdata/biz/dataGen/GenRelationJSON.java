package cn.edu.tju.bigdata.biz.dataGen;

import cn.edu.tju.bigdata.util.RandomUtil;
import cn.edu.tju.bigdata.util.plane.MySQLUtil;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashSet;

/**
 * Created by xliu on 2016/11/15.
 */
public class GenRelationJSON {

    public static void main(String args[]) throws SQLException, IOException {
        GenRelationJSON G = new GenRelationJSON();
        JSONObject result = new JSONObject();
        result.put("category", JSONArray.parse("[{\"base\":\"地块\",\"name\":\"地块\"}]"));
        result.put("nodes", G.getNodeList());
        result.put("type", "force");
        result.put("links", G.genLinks());
        String rs = JSON.toJSONString(result).replace("\"", "\\\"");
        MySQLUtil.updateResult("update bd_nav set network=\"" + rs + "\" where id=8");
    }

    public JSONArray getNodeList() throws SQLException {
        ResultSet rs = MySQLUtil.queryResult("select id,name from bd_plane_only");
        JSONArray res = new JSONArray();
        int cnt = 0;
        while (rs.next()) {
            JSONObject elem = new JSONObject();
            elem.put("value", rs.getInt("id"));
            elem.put("name", rs.getString("name"));
            elem.put("dataset", "247");
            elem.put("category", 1);
            elem.put("metadata", "id");
            elem.put("remark", ++cnt);
            res.add(elem);
        }
        return res;
    }

    public JSONArray genLinks() throws IOException {
        int top = 273, bot = 1;
        RandomUtil ru = new RandomUtil();
        JSONArray links = new JSONArray();
        HashSet<String> hs = new HashSet<>();
        for (int i = 270 * 27; i > 0; i--) {
            int a = ru.randomInt(bot, top);
            int b = ru.randomInt(bot, top);
            if (hs.contains(a + "-" + b)) continue;
            hs.add(a + "-" + b);
            JSONObject link = new JSONObject();
            link.put("name", "迁徙");
            link.put("source", a);
            link.put("target", b);
            links.add(link);
        }
        return links;
    }

}
