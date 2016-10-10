package cn.edu.tju.bigdata.controller.app.service.object;

import cn.edu.tju.bigdata.entity.MeetupFormMap;
import cn.edu.tju.bigdata.entity.MemberFormMap;
import cn.edu.tju.bigdata.enums.EmDeletedMark;
import cn.edu.tju.bigdata.mapper.MeetupMapper;
import cn.edu.tju.bigdata.mapper.MemberMapper;
import cn.edu.tju.bigdata.util.Common;
import cn.edu.tju.bigdata.util.visualization.VisualUtils;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;

/**
 * Created by Ethan on 2016/10/9.
 */
@Controller
@RequestMapping("/visualuicreate")
public class VisualBioBasicController {

    @Autowired
    private MemberMapper memberMapper;

    @Autowired
    private MeetupMapper meetupMapper;

    @RequestMapping("/geoDistribution")
    public String geoDistribution() {
        return Common.BACKGROUND_PATH + "/app/visualuicreate/geoDistribution";
    }

    @RequestMapping("/geoData/{tableName}/{year}")
    @ResponseBody
    public String getGeoData(@PathVariable String tableName, @PathVariable Integer year) {
        HashMap<String, Integer> map = new HashMap<String, Integer>();
        JSONArray jsonArray = new JSONArray();
        if (tableName.equals("bd_member")) {
            MemberFormMap params = new MemberFormMap();
            String where = String.format("where deleted_mark = %d", EmDeletedMark.VALID.getCode());
            if (year != 0) {
                where += String.format(" and date_format(member_since, '%%Y') = %d", year);
            }
            params.put("where", where);
            List<MemberFormMap> list = memberMapper.findByWhere(params);
            for (MemberFormMap memberFormMap : list) {
                String country = memberFormMap.getStr("country");
                Integer cnt = map.get(country);
                if (cnt == null)
                    cnt = 0;
                cnt += 1;
                map.put(country, cnt);
            }
            for (String country : map.keySet()) {
                JSONObject object = VisualUtils.getJsonByCountryNameForECharts(country, map.get(country));
                if (object != null) {
                    jsonArray.add(object);
                }
            }
        } else if (tableName.equals("bd_meetup")) {
            MeetupFormMap params = new MeetupFormMap();
            String where = String.format("where deleted_mark = %d", EmDeletedMark.VALID.getCode());
            if (year != 0) {
                where += String.format(" and date_format(time_founded, '%%Y') <= %d", year);
            }
            params.put("where", where);
            List<MeetupFormMap> list = meetupMapper.findByWhere(params);
            for (MeetupFormMap formMap : list) {
                String country = formMap.getStr("country");
                Integer cnt = map.get(country);
                if (cnt == null)
                    cnt = 0;
                cnt += 1;
                map.put(country, cnt);
            }
            for (String country : map.keySet()) {
                JSONObject object = VisualUtils.getJsonByCountryCodeForECharts(country, map.get(country));
                if (object != null) {
                    jsonArray.add(object);
                }
            }
        }
        return jsonArray.toJSONString();
    }
}
