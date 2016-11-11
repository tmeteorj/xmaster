package cn.edu.tju.bigdata.util;

import java.io.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

/**
 * Created by xliu on 2016/11/11.
 */
public class RandomUtil {
    public List<String> Xing;
    public List<String> Ming;
    public List<List<String>> City;
    public Random random;
    private int DAY[][] = {
            {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31},
            {31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}
    };
    private String MZ[] = {"汉族", "阿昌族", "白族", "保安族", "布朗族", "布依族", "朝鲜族", "达斡尔族", "傣族", "德昂族", "侗族", "东乡族", "独龙族", "鄂伦春族", "俄罗斯族", "鄂温克族", "高山族", "仡佬族", "哈尼族", "哈萨克族", "赫哲族", "回族", "基诺族", "京族", "景颇族", "柯尔克孜族", "拉祜族", "黎族", "傈僳族", "珞巴族", "满族", "毛南族", "门巴族", "蒙古族", "苗族", "仫佬族", "纳西族", "怒族", "普米族", "羌族", "撒拉族", "畲族", "水族", "塔吉克族", "塔塔尔族", "土族", "土家族", "佤族", "维吾尔族", "乌兹别克族", "锡伯族", "瑶族", "彝族", "裕固族", "藏族", "壮族"};
    private String WHCD[] = {"无", "小学", "初中", "高中", "职业高中", "大专", "本科", "硕士", "博士", "博士后"};
    private SimpleDateFormat SDF = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    public RandomUtil() throws IOException {
        random = new Random();

        BufferedReader br;
        String line;

        br = new BufferedReader(new InputStreamReader(new FileInputStream(new File("data/xing.data")), "utf-8"));
        Xing = new ArrayList<String>();
        while ((line = br.readLine()) != null) {
            for (String item : line.trim().split(",")) {
                Xing.add(item);
            }
        }

        br = new BufferedReader(new InputStreamReader(new FileInputStream(new File("data/ming.data")), "utf-8"));
        Ming = new ArrayList<String>();
        while ((line = br.readLine()) != null) {
            for (String item : line.trim().split(",")) {
                Ming.add(item);
            }
        }

        br = new BufferedReader(new InputStreamReader(new FileInputStream(new File("data/city.data")), "utf-8"));
        City = new ArrayList<List<String>>();
        for (int i = 0; i < 34; i++) {
            List<String> instance = new ArrayList<String>();
            instance.add(br.readLine().trim());
            for (String item : br.readLine().trim().split(",")) {
                instance.add(item);
            }
            City.add(instance);
        }
    }

    public int randomInt(int a, int b) {
        return random.nextInt(b - a + 1) + a;
    }

    public String randomName() {
        return Xing.get(randomInt(0, Xing.size() - 1)) + Ming.get(randomInt(0, Ming.size() - 1));
    }

    public String randomID(int len) {
        String res = "";
        for (int i = 0; i < len; i++) {
            res += String.valueOf(randomInt(0, 9));
        }
        return res;
    }

    public int randomDay(int year, int month) {
        int r = (year % 400 == 0 || (year % 100 != 0 && year % 4 == 0)) ? 1 : 0;
        return randomInt(1, DAY[r][month - 1]);
    }

    public String randomDate(int start_year, int end_year) throws ParseException {
        int year = randomInt(start_year, end_year);
        int month = randomInt(1, 12);
        int day = randomDay(year, month);
        int hour = randomInt(0, 23);
        int minute = randomInt(0, 59);
        int second = randomInt(0, 59);
        return String.format("%04d-%02d-%02d %02d:%02d:%02d", year, month, day, hour, minute, second);
    }

    public String randomDate(String date, int hour) throws ParseException {
        Date next = new Date(SDF.parse(date).getTime() + hour * 3600L * 1000L);
        return SDF.format(next);
    }

    public String randomProvince() {
        return City.get(randomInt(0, City.size() - 1)).get(0);
    }

    public String randomCity() {
        List<String> tmp = City.get(randomInt(0, City.size() - 1));
        return tmp.get(randomInt(1, tmp.size() - 1));
    }

    public String randomUpper(int n) {
        return String.valueOf((char) ('A' + randomInt(0, n)));
    }

    public String getMZ(String mzdm) {
        return MZ[Integer.parseInt(mzdm) - 1];
    }

    public String getXL(String xldm) {
        return WHCD[Integer.parseInt(xldm) - 1];
    }

    public String getXB(String xbdm) {
        return xbdm.equals("1") ? "男" : "女";
    }

    public String[] randomPlace() {
        int cid = randomInt(0, City.size() - 1);
        List<String> citys = City.get(cid);
        String qh = citys.get(0) + citys.get(randomInt(1, citys.size() - 1));
        String dz = Ming.get(randomInt(0, Ming.size() - 1));
        return new String[]{qh, dz};
    }
}
