package cn.edu.tju.bigdata.biz.dataGen;

import cn.edu.tju.bigdata.util.RandomUtil;
import cn.edu.tju.bigdata.util.plane.MySQLUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;

/**
 * Created by xliu on 2016/11/10.
 */
public class GenRKXX {
    private static Logger LOGGER = LoggerFactory.getLogger(GenRKXX.class);

    public static void main(String args[]) throws IOException, ParseException, SQLException {
        GenRKXX rkxx = new GenRKXX();
        rkxx.createRecords(1, 1000000);
    }

    public void createRecords(int start_id, int end_id) throws ParseException, SQLException, IOException {
        String preffix = "insert into bd_rkxx(XH,GMSFHM,XM,CYM,CSRQ,HH,YHZGXDM,XBDM,MZDM,CSD_GJHDQDM,CSD_SSXQDM" +
                ",JG_GJHDQDM,JG_SSXQDM,XLDM,HYZKDM,HJDZ_SSXQDM,CYZK_ZYLBDM,SG,XXDM,RKXXJBDM,RKGLZXLBDM,SJDM,DSDM" +
                ",ZT,ZHWHLX,SJGSDWDM,RKBM) values";
        String sql = preffix;
        RandomUtil ru = new RandomUtil();
        for (int id = start_id; id < end_id; id++) {
            if (!sql.equals(preffix)) sql += ",";
            String record = String.format("(%d,\'%s\',\'%s\',\'%s\',\'%s\',\'%d\',\'%d\',\'%d\',\'%d\',\'%d\',\'%d\'" +
                            ",\'%d\',\'%d\',\'%d\',\'%d\',\'%d\',\'%d\',\'%d\',\'%d\',\'%d\',\'%d\',\'%d\',\'%d\'" +
                            ",\'%d\',\'%d\',\'%d\',\'%d\')", id, ru.randomID(18), ru.randomName(), ru.randomName(), ru.randomDate(1920, 2015), ru.randomInt(1, 1000000)
                    , ru.randomInt(1, 10), ru.randomInt(1, 2), ru.randomInt(1, 56), ru.randomInt(1, 300), ru.randomInt(1, 34), ru.randomInt(1, 300), ru.randomInt(1, 340)
                    , ru.randomInt(1, 10), ru.randomInt(1, 10), ru.randomInt(1, 3400), ru.randomInt(1, 10), ru.randomInt(150, 190), ru.randomInt(1, 10), ru.randomInt(1, 10)
                    , ru.randomInt(1, 10), ru.randomInt(1, 34), ru.randomInt(1, 340), ru.randomInt(1, 3), ru.randomInt(1, 5), ru.randomInt(1, 10000), ru.randomInt(1, 1000000)
            );
            sql += record;
            if (Math.random() * 100 < 1 || id == end_id - 1) {
                MySQLUtil.updateResult(sql);
                sql = preffix;
            }
            if (Math.random() * 10000 < 1) {
                LOGGER.info(String.format("completed %d/%d = %.4f%%", id - start_id + 1, end_id - start_id, (id - start_id + 1.0) * 100.0 / (end_id - start_id)));
            }
        }
    }
}
