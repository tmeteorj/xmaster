package cn.edu.tju.bigdata.util;

import java.util.HashSet;

/**
 * Created by xliu on 2016/11/28.
 */
public class ParameterUtils {
    public static HashSet<String> actionSet;
    public static HashSet<String> peopleSet;
    public static HashSet<String> orgSet;
    public static HashSet<String> planeSet;
    public static HashSet<String> eventSet;

    static {
        actionSet = new HashSet<String>() {
            {
                add("bd_gsmrecord");
                add("bd_normal_action");
                add("bd_tielu");
                add("bd_wbsw");
                add("ly_userlogin");
            }

            ;
        };
        peopleSet = new HashSet<String>() {
            {
                add("bd_event_attendee");
                add("bd_fzryxx");
                add("bd_member");
                add("bd_normal_people");
                add("bd_researcher");
                add("bd_rkxx");
                add("ly_user");
            }
        };
        orgSet = new HashSet<String>() {
            {
                add("bd_meetup");
                add("bd_normal_org");
            }
        };
        planeSet = new HashSet<String>() {
            {
                add("bd_city");
                add("bd_district");
                add("bd_normal_people");
                add("bd_normal_plane");
                add("bd_plane");
                add("bd_province");
            }
        };
        eventSet = new HashSet<String>() {
            {
                add("bd_event");
                add("bd_normal_event");
                add("bd_location");
                add("bd_location_atm");
                add("bd_location_relitu");
                add("bd_location_score");
            }
        };
    }

    public static String changeToNormal(String tableName, String layerName) {
        HashSet<String> set = null;
        if ("bd_normal_action".equals(layerName)) {
            set = actionSet;
        } else if ("bd_normal_people".equals(layerName)) {
            set = peopleSet;
        } else if ("bd_normal_org".equals(layerName)) {
            set = orgSet;
        } else if ("bd_normal_plane".equals(layerName)) {
            set = planeSet;
        } else if ("bd_normal_event".equals(layerName)) {
            set = eventSet;
        } else {
            return layerName;
        }
        if (tableName != null && set.contains(tableName)) return tableName;
        else return layerName;
    }
}
