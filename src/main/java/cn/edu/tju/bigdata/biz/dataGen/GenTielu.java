package cn.edu.tju.bigdata.biz.dataGen;

import cn.edu.tju.bigdata.util.RandomUtil;
import cn.edu.tju.bigdata.util.plane.MySQLUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by xliu on 2016/11/11.
 */
public class GenTielu {
    private static Logger LOGGER = LoggerFactory.getLogger(GenTielu.class);

    public static void main(String args[]) throws ParseException, SQLException, IOException {
        GenTielu gtl = new GenTielu();
        gtl.createRecords(2015);
    }

    public void insertPeople(int year, String id_no, String id_name) throws IOException, ParseException, SQLException {
        RandomUtil ru = new RandomUtil();
        String[] status = new String[]{"Z", "G", "T", "F"};
        String[] che = new String[]{"K", "Z", "G", "T", "C"};
        int times = ru.randomInt(1, 50);
        String preffix = "insert into bd_tielu(id_no,id_name,train_date,board_train_code" +
                ",from_station_name,to_station_name,ticket_no,coach_no,seat_no,ticket_status) values";
        String sql = preffix;
        for (int i = 0; i < times; i++) {
            String train_date = ru.randomDate(year, year);
            String board_train_code = che[ru.randomInt(0, 4)] + ru.randomInt(100, 999);
            String from_station_name = ru.randomCity();
            String to_station_name = ru.randomCity();
            int ticket_no = ru.randomInt(1000, 9999);
            int coach_no = ru.randomInt(1, 15);
            String seat_no = ru.randomInt(1, 30) + ru.randomUpper(6);
            String ticket_status = status[ru.randomInt(0, 3)];
            if (!sql.equals(preffix)) sql += ",";
            sql += String.format("(\'%s\',\'%s\',\'%s\',\'%s\',\'%s\',\'%s\',\'%d\',\'%d\',\'%s\',\'%s\')",
                    id_no, id_name, train_date, board_train_code, from_station_name, to_station_name, ticket_no, coach_no, seat_no, ticket_status);
        }
        MySQLUtil.updateResult(sql);
    }

    public void createRecords(int year) throws SQLException, IOException, ParseException {
        List<String[]> ps = new ArrayList<String[]>();
        ResultSet rs = MySQLUtil.queryResult("select GMSFHM,XM from bd_rkxx");
        while (rs.next()) {
            if (Math.random() * 1 < 1) {
                ps.add(new String[]{rs.getString(1), rs.getString(2)});
            }
        }
        int total = ps.size();
        int solve = 0;
        for (String[] items : ps) {
            insertPeople(year, items[0], items[1]);
            solve++;
            LOGGER.info(String.format("solved %d/%d = %.4f%%", solve, total, solve * 100.0 / total));
        }
    }
}
