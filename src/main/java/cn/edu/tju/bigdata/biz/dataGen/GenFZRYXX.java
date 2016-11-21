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
public class GenFZRYXX {
    private static Logger LOGGER = LoggerFactory.getLogger(GenFZRYXX.class);

    public static void main(String args[]) throws ParseException, SQLException, IOException {
        GenFZRYXX fz = new GenFZRYXX();
        fz.createRecords(1980, 2015);
    }

    public void insertPeople(int start_year, int end_year, String gmsfhm, String xm,
                             String xb, String csrq, String cym, String whcd,
                             String mz, String sg, String sfbm) throws IOException, SQLException, ParseException {
        RandomUtil ru = new RandomUtil();
        String preffix = "insert into bd_fzryxx(gmsfhm,xm,xb,csrq,cym,whcd,mz,sg,ajlb,rsrq,cljg,cljgflwsh,xq,sfbm) values";
        String sql = preffix;
        int times = ru.randomInt(1, 5);
        String ajlbs[] = {"盗窃", "抢劫", "杀人", "诈骗", "寻性滋事", "聚众斗殴", "强奸", "放火"};
        String cljgs[] = {"刑拘", "罚款", "死刑", "批评教育"};
        for (int i = 0; i < times; i++) {
            String zc = String.valueOf(ru.randomInt(25, 45));
            String ajlb = ajlbs[ru.randomInt(0, 7)];
            String rsrq = ru.randomDate(start_year, end_year);
            String cljg = cljgs[ru.randomInt(0, 3)];
            String cljgflwsh = ru.randomID(20);
            int tot = ru.randomInt(1, 480);
            String xq = (tot / 12) + "年" + (tot % 12) + "月";
            if (!sql.equals(preffix)) sql += ",";
            sql += String.format("(\'%s\',\'%s\',\'%s\',\'%s\',\'%s\',\'%s\',\'%s\',\'%s\',\'%s\',\'%s\',\'%s\',\'%s\',\'%s\',\'%s\')",
                    gmsfhm, xm, xb, csrq, cym, whcd, mz, sg, ajlb, rsrq, cljg, cljgflwsh, xq, sfbm);
        }
        MySQLUtil.updateResult(sql);
    }

    public void createRecords(int start_year, int end_year) throws SQLException, IOException, ParseException {
        List<String[]> ps = new ArrayList<String[]>();
        ResultSet rs = MySQLUtil.queryResult("select GMSFHM,XM,XBDM,CSRQ,CYM,XLDM,MZDM,SG,CSD_SSXQDM from bd_rkxx");
        while (rs.next()) {
            if (Math.random() * 1000 < 1) {
                ps.add(new String[]{rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6),
                        rs.getString(7), rs.getString(8), rs.getString(9)});
            }
        }
        int total = ps.size();
        int solve = 0;
        RandomUtil ru = new RandomUtil();
        for (String[] items : ps) {
            insertPeople(start_year, end_year, items[0], items[1], ru.getXB(items[2]), items[3], items[4], ru.getXL(items[5]), ru.getMZ(items[6]), items[7], items[8]);
            solve++;
            LOGGER.info(String.format("solved %d/%d = %.4f%%", solve, total, solve * 100.0 / total));
        }
    }
}
