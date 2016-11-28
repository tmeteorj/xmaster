package cn.edu.tju.bigdata.biz.dataGen;

import cn.edu.tju.bigdata.util.RandomUtil;
import cn.edu.tju.bigdata.util.plane.MySQLUtil;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.HashSet;

/**
 * Created by xliu on 2016/11/25.
 */
public class GenNormal {
    public static void main(String args[]) throws SQLException, IOException, ParseException {
        GenNormal G = new GenNormal();
        //G.genNormalPlane();
        //G.genNormalAction();
        G.genNormalEvent();
    }

    public void genNormalPlane() throws SQLException {
        ResultSet rs = MySQLUtil.queryResult("select plane_id,plane_name,lng,lat,polygon,attr from bd_plane");
        JSONArray planeList = new JSONArray();
        HashSet<Integer> hs = new HashSet<>();
        while (rs.next()) {
            int id = rs.getInt("plane_id");
            if (hs.contains(id)) continue;
            hs.add(id);
            JSONObject plane = new JSONObject();
            plane.put("id", id);
            plane.put("name", rs.getString("plane_name"));
            plane.put("center_lng", rs.getDouble("lng"));
            plane.put("center_lat", rs.getDouble("lat"));
            plane.put("boundary", rs.getString("polygon"));
            plane.put("purpose", JSONObject.parseObject(rs.getString("attr")).getString("Type").split(",")[0]);
            planeList.add(plane);
        }
        for (int i = 0; i < planeList.size(); i++) {
            JSONObject js = planeList.getJSONObject(i);
            MySQLUtil.updateResult(String.format("insert into bd_normal_plane(id,name,center_lng,center_lat,country,region" +
                            ",locality,purpose,boundary) values(%d,\'%s\',%f,%f,\'CN\',\'TJ\',\'TJ\',\'%s\',\'%s\')",
                    js.getIntValue("id"), js.getString("name"), js.getDouble("center_lng"), js.getDouble("center_lat"),
                    js.getString("purpose"), js.getString("boundary")));
        }
    }

    public void genNormalAction() throws IOException, ParseException, SQLException {
        RandomUtil ru = new RandomUtil();
        String date = "2015-01-01 00:00:00";
        for (int i = 0; i < 10000; i++) {
            date = ru.randomDate(date, ru.randomInt(0, 24), ru.randomInt(0, 60));
            MySQLUtil.updateResult(String.format("insert into bd_normal_action(action_time,action_type," +
                            "subject_id,subject_lng,subject_lat) values(\'%s\',\'%s\',%d,%f,%f)",
                    date, ru.randomAction(), ru.randomInt(1, 124), 117 + Math.random(), 39 + Math.random()));
        }
    }

    public void genNormalEvent() throws IOException, ParseException, SQLException {
        RandomUtil ru = new RandomUtil();
        String date = "2015-01-01 00:00:00";
        for (int i = 0; i < 10000; i++) {
            String start_date = date = ru.randomDate(date, ru.randomInt(0, 24), ru.randomInt(0, 60));
            String end_date = date = ru.randomDate(date, ru.randomInt(0, 24), ru.randomInt(0, 60));
            String dztp[] = ru.randomPlace();
            String dz = dztp[0] + dztp[1] + ru.randomChoice(new String[]{"街", "道", "区", "乡"});
            int level = ru.randomInt(0, 4);
            String type = ru.randomEvent();
            String aj = dz + ru.getAJJB(level) + type + "案";
            MySQLUtil.updateResult(String.format("insert into bd_normal_event(number,name," +
                            "start_time,end_time,event_level,event_type," +
                            "event_description) values(\'%s\',\'%s\',\'%s\',\'%s\',%d,\'%s\',\'%s\')",
                    ru.randomID(10), aj, start_date, end_date, level, type, aj));
        }
    }
}
