package cn.edu.tju.bigdata.util.visualization;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

import java.util.HashMap;

/**
 * Created by Ethan on 2016/10/9.
 */
public class VisualUtils {

    private static HashMap<String, JSONObject> mapOfNameJson = new HashMap<String, JSONObject>();
    private static HashMap<String, JSONObject> mapOfCodeJson = new HashMap<String, JSONObject>();
    private static String mapData = "[\n" +
            "{'code':'AF' , 'name':'Afghanistan', 'value':32358260, 'color':'#eea638'},\n" +
            "{'code':'AL' , 'name':'Albania', 'value':3215988, 'color':'#d8854f'},\n" +
            "{'code':'DZ' , 'name':'Algeria', 'value':35980193, 'color':'#de4c4f'},\n" +
            "{'code':'AO' , 'name':'Angola', 'value':19618432, 'color':'#de4c4f'},\n" +
            "{'code':'AR' , 'name':'Argentina', 'value':40764561, 'color':'#86a965'},\n" +
            "{'code':'AM' , 'name':'Armenia', 'value':3100236, 'color':'#d8854f'},\n" +
            "{'code':'AU' , 'name':'Australia', 'value':22605732, 'color':'#8aabb0'},\n" +
            "{'code':'AT' , 'name':'Austria', 'value':8413429, 'color':'#d8854f'},\n" +
            "{'code':'AZ' , 'name':'Azerbaijan', 'value':9306023, 'color':'#d8854f'},\n" +
            "{'code':'BH' , 'name':'Bahrain', 'value':1323535, 'color':'#eea638'},\n" +
            "{'code':'BD' , 'name':'Bangladesh', 'value':150493658, 'color':'#eea638'},\n" +
            "{'code':'BY' , 'name':'Belarus', 'value':9559441, 'color':'#d8854f'},\n" +
            "{'code':'BE' , 'name':'Belgium', 'value':10754056, 'color':'#d8854f'},\n" +
            "{'code':'BJ' , 'name':'Benin', 'value':9099922, 'color':'#de4c4f'},\n" +
            "{'code':'BT' , 'name':'Bhutan', 'value':738267, 'color':'#eea638'},\n" +
            "{'code':'BO' , 'name':'Bolivia', 'value':10088108, 'color':'#86a965'},\n" +
            "{'code':'BA' , 'name':'Bosnia and Herzegovina', 'value':3752228, 'color':'#d8854f'},\n" +
            "{'code':'BW' , 'name':'Botswana', 'value':2030738, 'color':'#de4c4f'},\n" +
            "{'code':'BR' , 'name':'Brazil', 'value':196655014, 'color':'#86a965'},\n" +
            "{'code':'BN' , 'name':'Brunei', 'value':405938, 'color':'#eea638'},\n" +
            "{'code':'BG' , 'name':'Bulgaria', 'value':7446135, 'color':'#d8854f'},\n" +
            "{'code':'BF' , 'name':'Burkina Faso', 'value':16967845, 'color':'#de4c4f'},\n" +
            "{'code':'BI' , 'name':'Burundi', 'value':8575172, 'color':'#de4c4f'},\n" +
            "{'code':'KH' , 'name':'Cambodia', 'value':14305183, 'color':'#eea638'},\n" +
            "{'code':'CM' , 'name':'Cameroon', 'value':20030362, 'color':'#de4c4f'},\n" +
            "{'code':'CA' , 'name':'Canada', 'value':34349561, 'color':'#a7a737'},\n" +
            "{'code':'CV' , 'name':'Cape Verde', 'value':500585, 'color':'#de4c4f'},\n" +
            "{'code':'CF' , 'name':'Central African Rep.', 'value':4486837, 'color':'#de4c4f'},\n" +
            "{'code':'TD' , 'name':'Chad', 'value':11525496, 'color':'#de4c4f'},\n" +
            "{'code':'CL' , 'name':'Chile', 'value':17269525, 'color':'#86a965'},\n" +
            "{'code':'CN' , 'name':'China', 'value':1347565324, 'color':'#eea638'},\n" +
            "{'code':'CO' , 'name':'Colombia', 'value':46927125, 'color':'#86a965'},\n" +
            "{'code':'KM' , 'name':'Comoros', 'value':753943, 'color':'#de4c4f'},\n" +
            "{'code':'CD' , 'name':'Congo, Dem. Rep.', 'value':67757577, 'color':'#de4c4f'},\n" +
            "{'code':'CG' , 'name':'Congo, Rep.', 'value':4139748, 'color':'#de4c4f'},\n" +
            "{'code':'CR' , 'name':'Costa Rica', 'value':4726575, 'color':'#a7a737'},\n" +
            "{'code':'CI' , 'name':'Cote d\\'Ivoire', 'value':20152894, 'color':'#de4c4f'},\n" +
            "{'code':'HR' , 'name':'Croatia', 'value':4395560, 'color':'#d8854f'},\n" +
            "{'code':'CU' , 'name':'Cuba', 'value':11253665, 'color':'#a7a737'},\n" +
            "{'code':'CY' , 'name':'Cyprus', 'value':1116564, 'color':'#d8854f'},\n" +
            "{'code':'CZ' , 'name':'Czech Rep.', 'value':10534293, 'color':'#d8854f'},\n" +
            "{'code':'DK' , 'name':'Denmark', 'value':5572594, 'color':'#d8854f'},\n" +
            "{'code':'DJ' , 'name':'Djibouti', 'value':905564, 'color':'#de4c4f'},\n" +
            "{'code':'DO' , 'name':'Dominican Rep.', 'value':10056181, 'color':'#a7a737'},\n" +
            "{'code':'EC' , 'name':'Ecuador', 'value':14666055, 'color':'#86a965'},\n" +
            "{'code':'EG' , 'name':'Egypt', 'value':82536770, 'color':'#de4c4f'},\n" +
            "{'code':'SV' , 'name':'El Salvador', 'value':6227491, 'color':'#a7a737'},\n" +
            "{'code':'GQ' , 'name':'Equatorial Guinea', 'value':720213, 'color':'#de4c4f'},\n" +
            "{'code':'ER' , 'name':'Eritrea', 'value':5415280, 'color':'#de4c4f'},\n" +
            "{'code':'EE' , 'name':'Estonia', 'value':1340537, 'color':'#d8854f'},\n" +
            "{'code':'ET' , 'name':'Ethiopia', 'value':84734262, 'color':'#de4c4f'},\n" +
            "{'code':'FJ' , 'name':'Fiji', 'value':868406, 'color':'#8aabb0'},\n" +
            "{'code':'FI' , 'name':'Finland', 'value':5384770, 'color':'#d8854f'},\n" +
            "{'code':'FR' , 'name':'France', 'value':63125894, 'color':'#d8854f'},\n" +
            "{'code':'GA' , 'name':'Gabon', 'value':1534262, 'color':'#de4c4f'},\n" +
            "{'code':'GM' , 'name':'Gambia', 'value':1776103, 'color':'#de4c4f'},\n" +
            "{'code':'GE' , 'name':'Georgia', 'value':4329026, 'color':'#d8854f'},\n" +
            "{'code':'DE' , 'name':'Germany', 'value':82162512, 'color':'#d8854f'},\n" +
            "{'code':'GH' , 'name':'Ghana', 'value':24965816, 'color':'#de4c4f'},\n" +
            "{'code':'GR' , 'name':'Greece', 'value':11390031, 'color':'#d8854f'},\n" +
            "{'code':'GT' , 'name':'Guatemala', 'value':14757316, 'color':'#a7a737'},\n" +
            "{'code':'GN' , 'name':'Guinea', 'value':10221808, 'color':'#de4c4f'},\n" +
            "{'code':'GW' , 'name':'Guinea-Bissau', 'value':1547061, 'color':'#de4c4f'},\n" +
            "{'code':'GY' , 'name':'Guyana', 'value':756040, 'color':'#86a965'},\n" +
            "{'code':'HT' , 'name':'Haiti', 'value':10123787, 'color':'#a7a737'},\n" +
            "{'code':'HN' , 'name':'Honduras', 'value':7754687, 'color':'#a7a737'},\n" +
            "{'code':'HK' , 'name':'Hong Kong, China', 'value':7122187, 'color':'#eea638'},\n" +
            "{'code':'HU' , 'name':'Hungary', 'value':9966116, 'color':'#d8854f'},\n" +
            "{'code':'IS' , 'name':'Iceland', 'value':324366, 'color':'#d8854f'},\n" +
            "{'code':'IN' , 'name':'India', 'value':1241491960, 'color':'#eea638'},\n" +
            "{'code':'ID' , 'name':'Indonesia', 'value':242325638, 'color':'#eea638'},\n" +
            "{'code':'IR' , 'name':'Iran', 'value':74798599, 'color':'#eea638'},\n" +
            "{'code':'IQ' , 'name':'Iraq', 'value':32664942, 'color':'#eea638'},\n" +
            "{'code':'IE' , 'name':'Ireland', 'value':4525802, 'color':'#d8854f'},\n" +
            "{'code':'IL' , 'name':'Israel', 'value':7562194, 'color':'#eea638'},\n" +
            "{'code':'IT' , 'name':'Italy', 'value':60788694, 'color':'#d8854f'},\n" +
            "{'code':'JM' , 'name':'Jamaica', 'value':2751273, 'color':'#a7a737'},\n" +
            "{'code':'JP' , 'name':'Japan', 'value':126497241, 'color':'#eea638'},\n" +
            "{'code':'JO' , 'name':'Jordan', 'value':6330169, 'color':'#eea638'},\n" +
            "{'code':'KZ' , 'name':'Kazakhstan', 'value':16206750, 'color':'#eea638'},\n" +
            "{'code':'KE' , 'name':'Kenya', 'value':41609728, 'color':'#de4c4f'},\n" +
            "{'code':'KP' , 'name':'Korea, Dem. Rep.', 'value':24451285, 'color':'#eea638'},\n" +
            "{'code':'KR' , 'name':'Korea, Rep.', 'value':48391343, 'color':'#eea638'},\n" +
            "{'code':'KW' , 'name':'Kuwait', 'value':2818042, 'color':'#eea638'},\n" +
            "{'code':'KG' , 'name':'Kyrgyzstan', 'value':5392580, 'color':'#eea638'},\n" +
            "{'code':'LA' , 'name':'Laos', 'value':6288037, 'color':'#eea638'},\n" +
            "{'code':'LV' , 'name':'Latvia', 'value':2243142, 'color':'#d8854f'},\n" +
            "{'code':'LB' , 'name':'Lebanon', 'value':4259405, 'color':'#eea638'},\n" +
            "{'code':'LS' , 'name':'Lesotho', 'value':2193843, 'color':'#de4c4f'},\n" +
            "{'code':'LR' , 'name':'Liberia', 'value':4128572, 'color':'#de4c4f'},\n" +
            "{'code':'LY' , 'name':'Libya', 'value':6422772, 'color':'#de4c4f'},\n" +
            "{'code':'LT' , 'name':'Lithuania', 'value':3307481, 'color':'#d8854f'},\n" +
            "{'code':'LU' , 'name':'Luxembourg', 'value':515941, 'color':'#d8854f'},\n" +
            "{'code':'MK' , 'name':'Macedonia, FYR', 'value':2063893, 'color':'#d8854f'},\n" +
            "{'code':'MG' , 'name':'Madagascar', 'value':21315135, 'color':'#de4c4f'},\n" +
            "{'code':'MW' , 'name':'Malawi', 'value':15380888, 'color':'#de4c4f'},\n" +
            "{'code':'MY' , 'name':'Malaysia', 'value':28859154, 'color':'#eea638'},\n" +
            "{'code':'ML' , 'name':'Mali', 'value':15839538, 'color':'#de4c4f'},\n" +
            "{'code':'MR' , 'name':'Mauritania', 'value':3541540, 'color':'#de4c4f'},\n" +
            "{'code':'MU' , 'name':'Mauritius', 'value':1306593, 'color':'#de4c4f'},\n" +
            "{'code':'MX' , 'name':'Mexico', 'value':114793341, 'color':'#a7a737'},\n" +
            "{'code':'MD' , 'name':'Moldova', 'value':3544864, 'color':'#d8854f'},\n" +
            "{'code':'MN' , 'name':'Mongolia', 'value':2800114, 'color':'#eea638'},\n" +
            "{'code':'ME' , 'name':'Montenegro', 'value':632261, 'color':'#d8854f'},\n" +
            "{'code':'MA' , 'name':'Morocco', 'value':32272974, 'color':'#de4c4f'},\n" +
            "{'code':'MZ' , 'name':'Mozambique', 'value':23929708, 'color':'#de4c4f'},\n" +
            "{'code':'MM' , 'name':'Myanmar', 'value':48336763, 'color':'#eea638'},\n" +
            "{'code':'NA' , 'name':'Namibia', 'value':2324004, 'color':'#de4c4f'},\n" +
            "{'code':'NP' , 'name':'Nepal', 'value':30485798, 'color':'#eea638'},\n" +
            "{'code':'NL' , 'name':'Netherlands', 'value':16664746, 'color':'#d8854f'},\n" +
            "{'code':'NZ' , 'name':'New Zealand', 'value':4414509, 'color':'#8aabb0'},\n" +
            "{'code':'NI' , 'name':'Nicaragua', 'value':5869859, 'color':'#a7a737'},\n" +
            "{'code':'NE' , 'name':'Niger', 'value':16068994, 'color':'#de4c4f'},\n" +
            "{'code':'NG' , 'name':'Nigeria', 'value':162470737, 'color':'#de4c4f'},\n" +
            "{'code':'NO' , 'name':'Norway', 'value':4924848, 'color':'#d8854f'},\n" +
            "{'code':'OM' , 'name':'Oman', 'value':2846145, 'color':'#eea638'},\n" +
            "{'code':'PK' , 'name':'Pakistan', 'value':176745364, 'color':'#eea638'},\n" +
            "{'code':'PA' , 'name':'Panama', 'value':3571185, 'color':'#a7a737'},\n" +
            "{'code':'PG' , 'name':'Papua New Guinea', 'value':7013829, 'color':'#8aabb0'},\n" +
            "{'code':'PY' , 'name':'Paraguay', 'value':6568290, 'color':'#86a965'},\n" +
            "{'code':'PE' , 'name':'Peru', 'value':29399817, 'color':'#86a965'},\n" +
            "{'code':'PH' , 'name':'Philippines', 'value':94852030, 'color':'#eea638'},\n" +
            "{'code':'PL' , 'name':'Poland', 'value':38298949, 'color':'#d8854f'},\n" +
            "{'code':'PT' , 'name':'Portugal', 'value':10689663, 'color':'#d8854f'},\n" +
            "{'code':'PR' , 'name':'Puerto Rico', 'value':3745526, 'color':'#a7a737'},\n" +
            "{'code':'QA' , 'name':'Qatar', 'value':1870041, 'color':'#eea638'},\n" +
            "{'code':'RO' , 'name':'Romania', 'value':21436495, 'color':'#d8854f'},\n" +
            "{'code':'RU' , 'name':'Russia', 'value':142835555, 'color':'#d8854f'},\n" +
            "{'code':'RW' , 'name':'Rwanda', 'value':10942950, 'color':'#de4c4f'},\n" +
            "{'code':'SA' , 'name':'Saudi Arabia', 'value':28082541, 'color':'#eea638'},\n" +
            "{'code':'SN' , 'name':'Senegal', 'value':12767556, 'color':'#de4c4f'},\n" +
            "{'code':'RS' , 'name':'Serbia', 'value':9853969, 'color':'#d8854f'},\n" +
            "{'code':'SL' , 'name':'Sierra Leone', 'value':5997486, 'color':'#de4c4f'},\n" +
            "{'code':'SG' , 'name':'Singapore', 'value':5187933, 'color':'#eea638'},\n" +
            "{'code':'SK' , 'name':'Slovak Republic', 'value':5471502, 'color':'#d8854f'},\n" +
            "{'code':'SI' , 'name':'Slovenia', 'value':2035012, 'color':'#d8854f'},\n" +
            "{'code':'SB' , 'name':'Solomon Islands', 'value':552267, 'color':'#8aabb0'},\n" +
            "{'code':'SO' , 'name':'Somalia', 'value':9556873, 'color':'#de4c4f'},\n" +
            "{'code':'ZA' , 'name':'South Africa', 'value':50459978, 'color':'#de4c4f'},\n" +
            "{'code':'ES' , 'name':'Spain', 'value':46454895, 'color':'#d8854f'},\n" +
            "{'code':'LK' , 'name':'Sri Lanka', 'value':21045394, 'color':'#eea638'},\n" +
            "{'code':'SD' , 'name':'Sudan', 'value':34735288, 'color':'#de4c4f'},\n" +
            "{'code':'SR' , 'name':'Suriname', 'value':529419, 'color':'#86a965'},\n" +
            "{'code':'SZ' , 'name':'Swaziland', 'value':1203330, 'color':'#de4c4f'},\n" +
            "{'code':'SE' , 'name':'Sweden', 'value':9440747, 'color':'#d8854f'},\n" +
            "{'code':'CH' , 'name':'Switzerland', 'value':7701690, 'color':'#d8854f'},\n" +
            "{'code':'SY' , 'name':'Syria', 'value':20766037, 'color':'#eea638'},\n" +
            "{'code':'TW' , 'name':'Taiwan', 'value':23072000, 'color':'#eea638'},\n" +
            "{'code':'TJ' , 'name':'Tajikistan', 'value':6976958, 'color':'#eea638'},\n" +
            "{'code':'TZ' , 'name':'Tanzania', 'value':46218486, 'color':'#de4c4f'},\n" +
            "{'code':'TH' , 'name':'Thailand', 'value':69518555, 'color':'#eea638'},\n" +
            "{'code':'TG' , 'name':'Togo', 'value':6154813, 'color':'#de4c4f'},\n" +
            "{'code':'TT' , 'name':'Trinidad and Tobago', 'value':1346350, 'color':'#a7a737'},\n" +
            "{'code':'TN' , 'name':'Tunisia', 'value':10594057, 'color':'#de4c4f'},\n" +
            "{'code':'TR' , 'name':'Turkey', 'value':73639596, 'color':'#d8854f'},\n" +
            "{'code':'TM' , 'name':'Turkmenistan', 'value':5105301, 'color':'#eea638'},\n" +
            "{'code':'UG' , 'name':'Uganda', 'value':34509205, 'color':'#de4c4f'},\n" +
            "{'code':'UA' , 'name':'Ukraine', 'value':45190180, 'color':'#d8854f'},\n" +
            "{'code':'AE' , 'name':'United Arab Emirates', 'value':7890924, 'color':'#eea638'},\n" +
            "{'code':'GB' , 'name':'United Kingdom', 'value':62417431, 'color':'#d8854f'},\n" +
            "{'code':'US' , 'name':'United States', 'value':313085380, 'color':'#a7a737'},\n" +
            "{'code':'UY' , 'name':'Uruguay', 'value':3380008, 'color':'#86a965'},\n" +
            "{'code':'UZ' , 'name':'Uzbekistan', 'value':27760267, 'color':'#eea638'},\n" +
            "{'code':'VE' , 'name':'Venezuela', 'value':29436891, 'color':'#86a965'},\n" +
            "{'code':'PS' , 'name':'West Bank and Gaza', 'value':4152369, 'color':'#eea638'},\n" +
            "{'code':'VN' , 'name':'Vietnam', 'value':88791996, 'color':'#eea638'},\n" +
            "{'code':'YE' , 'name':'Yemen, Rep.', 'value':24799880, 'color':'#eea638'},\n" +
            "{'code':'ZM' , 'name':'Zambia', 'value':13474959, 'color':'#de4c4f'},\n" +
            "{'code':'ZW' , 'name':'Zimbabwe', 'value':12754378, 'color':'#de4c4f'}]";

    public static void main(String... a) {
        int value = -1;
        String name = "Korea (South)";
        System.out.println(getJsonByCountryNameForECharts(name, value).toJSONString());
        String code = "HK";
        System.out.println(getJsonByCountryCodeForECharts(code, value));
    }

    public static JSONObject getJsonByCountryNameForECharts(String name, int value) {
        if (name.equalsIgnoreCase("USA")) {
            name = "United States";
        } else if (name.equalsIgnoreCase("Korea (South)")) {
            name = "Korea, Rep.";
        }
        JSONObject object = mapOfNameJson.get(name);
        if (object == null || object.isEmpty()) {
            JSONArray mapDataJsonArray = JSON.parseArray(mapData);
            for (int i = 0; i < mapDataJsonArray.size(); i++) {
                JSONObject item = mapDataJsonArray.getJSONObject(i);
                if (name.equalsIgnoreCase(item.getString("name"))) {
                    object = item;
                    mapOfNameJson.put(name, object);
                    break;
                }
            }
        }
        if (object == null || object.isEmpty()) {
            return null;
        }
        object.put("value", value);
        return object;
    }

    public static JSONObject getJsonByCountryCodeForECharts(String code, int value) {
        if (mapOfCodeJson.isEmpty()) {
            JSONArray mapDataJsonArray = JSON.parseArray(mapData);
            for (int i = 0; i < mapDataJsonArray.size(); i++) {
                JSONObject item = mapDataJsonArray.getJSONObject(i);
                mapOfCodeJson.put(item.getString("code"), item);
            }
        }
        JSONObject object = mapOfCodeJson.get(code);
        if (object == null || object.isEmpty()) {
            return null;
        }
        object.put("value", value);
        return object;
    }
}