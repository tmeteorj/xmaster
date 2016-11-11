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
public class GenWBSW {
    private static Logger LOGGER = LoggerFactory.getLogger(GenWBSW.class);

    public static void main(String args[]) throws ParseException, SQLException, IOException {
        GenWBSW wb = new GenWBSW();
        wb.createRecords(2015);
    }

    public void insertPeople(int year, String id, String yycsmc, String dzqh, String dz,
                             String swryxm, String zjhm) throws IOException, ParseException, SQLException {
        RandomUtil ru = new RandomUtil();
        int times = ru.randomInt(1, 150);
        String preffix = "insert into bd_wbsw(id,yycsmc,dzqh,dz,swryxm,zjlx,zjhm,swkssj,xwsj) values";
        String sql = preffix;
        for (int i = 0; i < times; i++) {
            String swkssj = ru.randomDate(year, year);
            String xwsj = ru.randomDate(swkssj, ru.randomInt(1, 10));
            if (!sql.equals(preffix)) sql += ",";
            sql += String.format("(\'%s\',\'%s\',\'%s\',\'%s\',\'%s\',\'身份证\',\'%s\',\'%s\',\'%s\')",
                    id, yycsmc, dzqh, dz, swryxm, zjhm, swkssj, xwsj);
        }
        MySQLUtil.updateResult(sql);

    }

    public void createRecords(int year) throws SQLException, IOException, ParseException {
        List<String[]> ps = new ArrayList<String[]>();
        ResultSet rs = MySQLUtil.queryResult("select GMSFHM,XM from bd_rkxx");
        while (rs.next()) {
            if (Math.random() * 10 < 1) {
                ps.add(new String[]{rs.getString(1), rs.getString(2)});
            }
        }
        List<String[]> wb = new ArrayList<String[]>();
        RandomUtil ru = new RandomUtil();
        for (int i = 1; i <= 10000; i++) {
            String qhdz[] = ru.randomPlace();
            wb.add(new String[]{String.valueOf(i), qhdz[1] + "网咖", qhdz[0], qhdz[0] + qhdz[1] + "街"});
        }
        int total = ps.size();
        int solve = 0;

        for (String[] items : ps) {
            String[] tmp = wb.get(ru.randomInt(0, 9999));
            insertPeople(year, tmp[0], tmp[1], tmp[2], tmp[3],
                    items[1], items[0]);
            solve++;
            LOGGER.info(String.format("solved %d/%d = %.4f%%", solve, total, solve * 100.0 / total));
        }
    }
}
