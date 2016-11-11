package cn.edu.tju.bigdata.biz.plane;

import cn.edu.tju.bigdata.util.plane.MySQLUtil;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by xliu on 2016/10/5.
 */
public class PlaneDataTransform {
    private static Logger LOGGER = LoggerFactory.getLogger(PlaneDataTransform.class);
    private static String[] typeArray = new String[]{"Storage Facility,1", "News Facility,2", "Library Facility,3",
            "Adult Education Facility,4", "Sports Facility,5", "Hotel Facility,6", "Military Facility,7",
            "Middle Education Facility,8", "Office Facility,9", "Logistic Facility,10", "Traffic Facility,11",
            "Entertainment Facility,12", "Service Facility,13", "Higher Education Facility,14",
            "Medical Facility,15", "Industry Facility,16", "Research Facility,17", "Primary Education Facility,18",
            "Government Facility,19", "Public Facility,20", "Financial Facility,21", "Residential Facility,22"};

    private static String randomType() {
        return typeArray[(int) (Math.random() * 22)];
    }

    private static void transformOneRecord(int plane_id, String plane_name, double price, double resident, double green, double stopcar, String edge) throws SQLException {
        JSONObject result = new JSONObject();

        result.put("plane_id", plane_id);
        result.put("plane_name", plane_name);
        result = formPolygon(result, edge);
        JSONObject attr = new JSONObject();
        attr.put("Type", typeArray[21]);
        attr.put("Price", price);
        attr.put("Resident", resident);
        attr.put("Green", green);
        attr.put("StopCar", stopcar);
        for (int i = 2015; i <= 2015; i++) {
            for (int j = 1; j <= 12; j++) {
                String sql = String.format("insert into bd_plane(plane_id,plane_name,year,month,lng,lat,polygon,attr) " +
                                "values(%d,\"%s\",%d,%d,%f,%f,\"%s\",\"%s\")",
                        result.getInteger("plane_id"), result.getString("plane_name"), i, j, result.getDouble("lng"), result.getDouble("lat"),
                        result.getJSONObject("polygon").toJSONString().replace("\"", "\\\""), attr.toJSONString().replace("\"", "\\\""));
                MySQLUtil.updateResult(sql);
            }
        }
    }

    private static JSONObject formPolygon(JSONObject result, String input) {
        JSONObject polygon = new JSONObject();
        JSONArray edge = new JSONArray();
        double x = 0, y = 0, cnt = 0;
        for (String item : input.split(" ")) {
            String xy[] = item.split(",");
            edge.add(JSON.parseObject(String.format("{\"lng\":%s,\"lat\":%s}", xy[0], xy[1])));
            x += Double.parseDouble(xy[0]);
            y += Double.parseDouble(xy[1]);
            cnt += 1.0;
        }
        polygon.put("edge", edge);
        result.put("lng", x / cnt);
        result.put("lat", y / cnt);
        result.put("polygon", polygon);
        return result;
    }

    private static int getInt(String numStr) {
        if (numStr == null || numStr.length() == 0) return 0;
        Pattern p = Pattern.compile("[0-9]+");
        Matcher m = p.matcher(numStr);
        if (m.find()) {
            return Integer.parseInt(m.group(0));
        } else {
            return 0;
        }
    }

    private static void transformAll() throws SQLException {
        ResultSet rs = MySQLUtil.queryResult("mapjdbc", "select `名称`,`房价`,`总户数`,`绿化率`,`停车位`,`坐标` from map");
        int plane_id = 0;
        int total = 0, solve = 0;
        while (rs.next()) {
            String plane_name = rs.getString(1);
            if (null == plane_name || plane_name.length() == 0) plane_name = "(空)";
            double price = getInt(rs.getString(2));
            double resident = getInt(rs.getString(3));
            double green = getInt(rs.getString(4));
            double stopcar = getInt(rs.getString(5));
            String edge = rs.getString(6);
            total++;
            if (null == edge || edge.length() == 0) continue;
            solve++;
            LOGGER.info("{}-{}", solve, total);
            transformOneRecord(++plane_id, plane_name, price, resident, green, stopcar, edge);
        }
    }

    public static void main(String args[]) throws SQLException {
        transformAll();
    }

}
