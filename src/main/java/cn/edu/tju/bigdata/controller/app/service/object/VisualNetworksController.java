package cn.edu.tju.bigdata.controller.app.service.object;

import cn.edu.tju.bigdata.entity.CommunityResFormMap;
import cn.edu.tju.bigdata.entity.networks.Communities;
import cn.edu.tju.bigdata.mapper.CommunityResultMapper;
import cn.edu.tju.bigdata.util.Common;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.ujmp.core.graphmatrix.DefaultGraphMatrix;
import org.ujmp.core.graphmatrix.GraphMatrix;

import java.util.*;

/**
 * Created by Ethan on 2016/10/10.
 */
@Controller
@RequestMapping("/visualuicreate")
public class VisualNetworksController {

    private Communities<String> communities;

    @Autowired
    private CommunityResultMapper communityResultMapper;

    @RequestMapping("/networks")
    public String networks() {
        return Common.BACKGROUND_PATH + "/app/visualuicreate/networksuicreate";
    }

    @RequestMapping("/getGraph")
    @ResponseBody
    public String getGraph() throws Exception {
        CommunityResFormMap communityResFormMap = new CommunityResFormMap();
        communityResFormMap.put("where", String.format("where id = %d", 3));
        List<CommunityResFormMap> communityResFormMapList = communityResultMapper.findByWhere(communityResFormMap);
        if (communityResFormMapList != null && communityResFormMapList.size() > 0) {
            communityResFormMap = communityResFormMapList.get(0);
            restoreCommunityInfo(communityResFormMap.getStr("result")); // restore
            return communityResFormMap.getStr("result");
        }
        return null;
    }

    @RequestMapping("/{number}/connectivity")
    @ResponseBody
    public String getConnectivity(@PathVariable String number) throws Exception {
        Map<Integer, Integer> mapOfDisCnt = bfs(number);
        int max = 10;
        int[] data = new int[max + 1];
        int[] xAxis = new int[max + 1];
        for (int i = 1; i <= max; i++) {
            xAxis[i] = i;
            Integer cnt = mapOfDisCnt.get(i);
            if (cnt == null) cnt = 0;
            data[i] = cnt;
            if (i > 1) {
                data[i] += data[i - 1];
            }
        }
        JSONObject object = new JSONObject();
        object.put("xAxis", xAxis);
        object.put("data", data);
        return object.toJSONString();
    }

    @RequestMapping("/network/attributes")
    @ResponseBody
    public String getNetworkAttributes() throws Exception {
        GraphMatrix<String, Double> graphMatrix = communities.getGraphMatrix();
        List<Integer> list = new ArrayList<Integer>();
        for (int i = 0; i < graphMatrix.getNodeCount(); i++) {
            list.add(graphMatrix.getDegree(i));
        }
        return computeLogLogData(list).toJSONString();
    }

    private JSONObject computeLogLogData(List<Integer> list) {
        Map<Integer, Integer> mapOfValCnt = new HashMap<Integer, Integer>();
        for (Integer val : list) {
            Integer cnt = mapOfValCnt.get(val);
            if (cnt == null)
                cnt = 0;
            cnt += 1;
            mapOfValCnt.put(val, cnt);
        }
        Map<Integer, Double> mapOfValPercentage = new HashMap<Integer, Double>();
        int total = list.size();
        for (Integer val : mapOfValCnt.keySet()) {
            mapOfValPercentage.put(val, mapOfValCnt.get(val) * 1.0 / total);
        }
        List<Integer> xAxis = new ArrayList<Integer>(new TreeSet<Integer>(mapOfValPercentage.keySet()));
        List<Double> yData = new ArrayList<Double>();
        for (int x : xAxis) {
            yData.add(mapOfValPercentage.get(x));
        }

        /**
         * highCharts
         */
        List<Double> yLog = new ArrayList<Double>();
        int i = 0;
        for (double xlog = 0, e = 0.1; xlog <= xAxis.get(xAxis.size() - 1); e += 0.1, xlog = Math.pow(10, e)) {

            double ylog = 0;
            while (i < yData.size() && xAxis.get(i) <= xlog) {
                ylog += yData.get(i);
                i++;
            }
            yLog.add(ylog);
        }

        JSONObject object = new JSONObject();
        object.put("xAxis", xAxis);
        object.put("data", yData);
        return object;
    }

    private void restoreCommunityInfo(String jsonString) {
        GraphMatrix<String, Double> graphMatrix = new DefaultGraphMatrix<String, Double>();
        communities = new Communities<String>(graphMatrix);
        JSONObject object = JSON.parseObject(jsonString);
        JSONArray nodes = object.getJSONArray("nodes");
        for (int i = 0; i < nodes.size(); i++) {
            JSONObject node = nodes.getJSONObject(i);
            graphMatrix.addNode(node.getString("value"));
            communities.setCommunity(i, node.getIntValue("community"));
        }
        JSONArray links = object.getJSONArray("links");
        for (int i = 0; i < links.size(); i++) {
            JSONObject link = links.getJSONObject(i);
            graphMatrix.setEdge(1.0, link.getString("sourceValue"), link.getString("targetValue"));
        }
    }

    private Map<Integer, Integer> bfs(String number) {
        class Step {
            private long index;
            private int step;

            public Step(long index, int step) {
                this.index = index;
                this.step = step;
            }
        }
        Map<Integer, Integer> mapOfDisCnt = new HashMap<Integer, Integer>();
        GraphMatrix<String, Double> graphMatrix = communities.getGraphMatrix();
        Queue<Step> queue = new LinkedList<Step>();
        long sourceIndex = graphMatrix.getIndexOfNode(number);
        Step start = new Step(sourceIndex, 0);
        queue.offer(start);
        Set<Long> visited = new HashSet<Long>();
        visited.add(sourceIndex);
        while (!queue.isEmpty()) {
            Step cur = queue.poll();
            Integer cnt = mapOfDisCnt.get(cur.step);
            if (cnt == null)
                cnt = 0;
            cnt += 1;
            mapOfDisCnt.put(cur.step, cnt);
            for (long child : graphMatrix.getChildIndices(cur.index)) {
                if (visited.contains(child)) {
                    continue;
                }
                visited.add(child);
                Step step = new Step(child, cur.step + 1);
                queue.offer(step);
            }
        }
        return mapOfDisCnt;
    }
}
