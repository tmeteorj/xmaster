package cn.edu.tju.bigdata.controller.app.service.object;

import cn.edu.tju.bigdata.biz.networks.CommunityDetector;
import cn.edu.tju.bigdata.biz.networks.GraphMatrixFactory;
import cn.edu.tju.bigdata.controller.index.BaseController;
import cn.edu.tju.bigdata.entity.AttendeeFromMap;
import cn.edu.tju.bigdata.entity.CommunityResFormMap;
import cn.edu.tju.bigdata.entity.networks.Communities;
import cn.edu.tju.bigdata.enums.EmDeletedMark;
import cn.edu.tju.bigdata.mapper.AttendeeMapper;
import cn.edu.tju.bigdata.mapper.CommunityResultMapper;
import cn.edu.tju.bigdata.util.Common;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.ujmp.core.graphmatrix.GraphMatrix;

import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by Administrator on 2016/10/6.
 */
@Controller
@RequestMapping("/visualuicreate")
public class VisualNetworksController extends BaseController {

    @Autowired
    private CommunityDetector nmf;

    @Autowired
    private GraphMatrixFactory<String> graphMatrixFactory;

    @Autowired
    private AttendeeMapper attendeeMapper;

    @Autowired
    private CommunityResultMapper communityResultMapper;

    @RequestMapping("/networks")
    public String networks (){
        return Common.BACKGROUND_PATH + "/app/visualuicreate/networksuicreate";
    }

    @RequestMapping("/getGraph")
    @ResponseBody
    public String getGraph() throws Exception {
        CommunityResFormMap communityResFormMap = new CommunityResFormMap();
        communityResFormMap.put("where", String.format("where id = %d", 1));
        List<CommunityResFormMap> communityResFormMapList = communityResultMapper.findByWhere(communityResFormMap);
        if (communityResFormMapList != null && communityResFormMapList.size()>0){
            communityResFormMap = communityResFormMapList.get(0);
            return communityResFormMap.getStr("result");
        }

        String tableName = "bd_event_attendee";

        AttendeeFromMap params = new AttendeeFromMap();
//        params.set("where", String.format("where deleted_mark = %d and held_time >= STR_TO_DATE('%s', '%%Y-%%m-%%d') and held_time < STR_TO_DATE('%s', '%%Y-%%m-%%d')", EmDeletedMark.VALID.getCode(), "2016-01-01", "2016-01-28"));
        params.set("where", String.format("where deleted_mark = %d and held_time < STR_TO_DATE('%s', '%%Y-%%m-%%d')", EmDeletedMark.VALID.getCode(), "2016-01-01"));
        List<AttendeeFromMap> attendeeList = attendeeMapper.findByWhere(params);

        Map<String, String> mapOfNumberName = new HashMap<String, String>();

        Map<String, Set<String>> mapOfEventAttendee = new HashMap<String, Set<String>>();
        Map<String, Set<String>> mapOfEventHost = new HashMap<String, Set<String>>();
        for ( AttendeeFromMap attendeeFromMap : attendeeList){
            String eventNumber = attendeeFromMap.getStr("event_number");
            String memberNumber = attendeeFromMap.getStr("member_number");
            mapOfNumberName.put(memberNumber, attendeeFromMap.getStr("member_name"));
            if (attendeeFromMap.getStr("title") != null){
                Set<String> set = mapOfEventHost.get(eventNumber);
                if (set == null){
                    set = new HashSet<String>();
                    mapOfEventHost.put(eventNumber, set);
                }
                set.add(memberNumber);
                continue;
            }
            Set<String> set = mapOfEventAttendee.get(eventNumber);
            if (set == null){
                set = new HashSet<String>();
                mapOfEventAttendee.put(eventNumber, set);
            }
            set.add(memberNumber);
        }

        graphMatrixFactory.clear();

        for (String eventNumber : mapOfEventAttendee.keySet()){
            Set<String> set = mapOfEventAttendee.get(eventNumber);
            Set<String> setHost = mapOfEventHost.get(eventNumber);
            if (set == null || setHost == null) continue;
            for (String n1 : setHost){
                for (String n2 : set){
                    graphMatrixFactory.setEdge(1.0, n1, n2);
                }
            }
        }

        /*
        Map<String, Set<String>> mapOfEventAttendee = new HashMap<String, Set<String>>();
        for ( AttendeeFromMap attendeeFromMap : attendeeList){
            String eventNumber = attendeeFromMap.getStr("event_number");
            String memberNumber = attendeeFromMap.getStr("member_number");
            Set<String> set = mapOfEventAttendee.get(eventNumber);
            if (set == null){
                set = new HashSet<String>();
                mapOfEventAttendee.put(eventNumber, set);
            }
            set.add(memberNumber);
        }

        graphMatrixFactory.clear();

        for (String eventNumber : mapOfEventAttendee.keySet()){
            Set<String> set = mapOfEventAttendee.get(eventNumber);
            if (set.size() <= 1 || set.size() > 10)
                continue;
            List<String> list = new ArrayList<String>(set);
            for (int i=0;i<list.size();i++){
                for (int j=i+1;j<list.size();j++){
                    graphMatrixFactory.setEdge(1.0, list.get(i), list.get(j));
                }
            }
        }
        */

        int k = 15;
        GraphMatrix<String, Double> graphMatrix = graphMatrixFactory.getMatrixByThreshold(2);
        Communities<String> communities = (Communities<String>) nmf.communityDetect(graphMatrix, k);

        JSONObject graph = new JSONObject();
        //categories
        int firstN = 4;
        Map<Integer, Integer> mapOfCindexUI = new HashMap<Integer, Integer>();
        JSONArray categories = new JSONArray();
        List<Integer> cIndices = communities.getCommunitiesOrderBySize();
        List<String> legends = new ArrayList<String>();
        for (int i = 0; i < firstN; i++){
            JSONObject cate = new JSONObject();
            String name = "category " + i;
            cate.put("name", name);
            cate.put("keyword", new JSONObject());
            cate.put("base", cIndices.get(i));
            categories.add(cate);
            mapOfCindexUI.put(cIndices.get(i), i);
            legends.add(name);
        }
        for (int i=firstN;i<cIndices.size();i++){
            mapOfCindexUI.put(cIndices.get(i), firstN);
            if (i == firstN){
                JSONObject cate = new JSONObject();
                String name = "other";
                cate.put("name", name);
                cate.put("keyword", new JSONObject());
                categories.add(cate);
                legends.add(name);
            }
        }
        graph.put("categories", categories);

        //legend
        JSONObject legend = new JSONObject();
        legend.put("data", legends);
        graph.put("legend", legend);

        //nodes
        JSONArray nodes = new JSONArray();
        for (int i=0;i<graphMatrix.getNodeCount();i++){
            JSONObject node = new JSONObject();
            //node.put("name", mapOfNumberName.getOrDefault(graphMatrix.getNode(i), "NaN"));
            node.put("value", graphMatrix.getNode(i));
            node.put("category", mapOfCindexUI.get(communities.getCommunityIndex(i)));
            nodes.add(node);
        }
        graph.put("nodes", nodes);

        //links
        JSONArray links = new JSONArray();
        Iterator<long[]> iterator = graphMatrix.availableCoordinates().iterator();
        while (iterator.hasNext()) {
            long[] coord = iterator.next();
            Assert.isTrue(coord.length == 2, "must be 2D!");
            JSONObject link = new JSONObject();
            link.put("source", coord[0]);
            link.put("target", coord[1]);
            links.add(link);
        }
        graph.put("links", links);
        graph.put("type", "force");

        // save result
        communityResFormMap.clear();
        communityResFormMap.put("table_name", tableName);
        String result = graph.toJSONString();
        result = result.replaceAll("\"", "\\\\\"").replaceAll("'", "\\\\'").replaceAll("\\?", "\\\\?");
        communityResFormMap.put("result", result);
        Date now = new Date();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        communityResFormMap.set("deleted_mark", EmDeletedMark.VALID.getCode());
        communityResFormMap.set("meta_created", simpleDateFormat.format(now));
        communityResFormMap.set("meta_updated", simpleDateFormat.format(now));
        communityResultMapper.addEntity(communityResFormMap);

        return result;
    }
}
