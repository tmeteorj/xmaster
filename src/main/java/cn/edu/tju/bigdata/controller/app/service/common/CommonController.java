package cn.edu.tju.bigdata.controller.app.service.common;

import cn.edu.tju.bigdata.controller.index.BaseController;
import cn.edu.tju.bigdata.entity.*;
import cn.edu.tju.bigdata.entity.networks.NodeandLinks;
import cn.edu.tju.bigdata.entity.networks.netWorkforJson.Link;
import cn.edu.tju.bigdata.entity.networks.netWorkforJson.Network;
import cn.edu.tju.bigdata.entity.networks.netWorkforJson.Node;
import cn.edu.tju.bigdata.mapper.*;
import cn.edu.tju.bigdata.plugin.PagePlugin;
import cn.edu.tju.bigdata.plugin.PageView;
import cn.edu.tju.bigdata.util.Common;
import cn.edu.tju.bigdata.util.FormMap;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import org.apache.commons.lang.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.*;

/**
 * Created by Administrator on 2016/10/7.
 */
@Controller
@RequestMapping("/common")
public class CommonController extends BaseController {
    private static final String BD = "bd_";
    @Value("${metadata.database:xmaster}")
    private String databaseName;

    @Autowired
    private TableMapper tableMapper;
    @Autowired
    ProvinceMapper provinceMapper;
    @Autowired
    CityMapper cityMapper;
    @Autowired
    DistrictMapper districtMapper;
    @Autowired
    private DatasetMapper datasetMapper;
    @Autowired
    private NavMapper navMapper;
    @Autowired
    MetadataMapper metadataMapper;


    @RequestMapping("/{accountName}/infoNavIndividual")
    public  String infoNavIndividual(@PathVariable String accountName,Model model, HttpServletRequest request){
        //System.out.println(accountName);
        //System.out.println(request.getParameter("layerType"));
        String tableID = request.getParameter("tableName");
        String parameter = request.getParameter("layerType");
        int layerType = 0;
        tableID = "242";
        String tableName = null;
        DatasetFormMap tdatasetFormMap = new DatasetFormMap();
        tdatasetFormMap.set("id",tableID);
        tdatasetFormMap.put("deleted_mark", 1);
        List<DatasetFormMap> datasetFormMaps = datasetMapper.findByNames(tdatasetFormMap);
        DatasetFormMap datasetFormMap = datasetFormMaps.get(0);
        String[] temda  = datasetFormMap.getStr("dataset_url").split("/");
        databaseName = temda[temda.length-1];
        tableName = datasetFormMap.getStr("title");
//        List<FormMap> tableNameListLayer = tableMapper.selectDataFromTable(databaseName, "")
        List<Table> tableList = tableMapper.selectTableByName(tableName, databaseName);
        List<HashMap<String, String>> tableNameList = tableMapper.selectTableNameByDatabase(databaseName);
        List<HashMap<String, String>> tableNameListBD = new ArrayList<HashMap<String, String>>();
        for (HashMap<String, String> map : tableNameList) {
            if (StringUtils.isBlank(map.get("tableComment"))) {
                map.put("tableComment", map.get("tableName"));
            }
            tableNameListBD.add(map);
        }
        for (String key : request.getParameterMap().keySet()) {
            model.addAttribute(key, request.getParameter(key));
        }
        model.addAttribute("tableName", tableID);
        model.addAttribute("accountName", accountName);
        model.addAttribute("tableList", tableList);
        model.addAttribute("tableNameList", tableNameListBD);
        return Common.BACKGROUND_PATH + "/app/common/infoNavIndividual";
    }


    @RequestMapping("/{accountName}/infoNav")
    public String locationNav(@PathVariable String accountName, HttpServletRequest request,Model model){
        String tableID = request.getParameter("tableName");
        String parameter = request.getParameter("layerType");
        int layerType = 0;
        tableID = "242";
        String tableName = null;
        DatasetFormMap tdatasetFormMap = new DatasetFormMap();
        tdatasetFormMap.set("id",tableID);
        tdatasetFormMap.put("deleted_mark", 1);
        List<DatasetFormMap> datasetFormMaps = datasetMapper.findByNames(tdatasetFormMap);
        DatasetFormMap datasetFormMap = datasetFormMaps.get(0);
        String[] temda  = datasetFormMap.getStr("dataset_url").split("/");
        databaseName = temda[temda.length-1];
        tableName = datasetFormMap.getStr("title");
//        List<FormMap> tableNameListLayer = tableMapper.selectDataFromTable(databaseName, "")
        List<Table> tableList = tableMapper.selectTableByName(tableName, databaseName);
        List<HashMap<String, String>> tableNameList = tableMapper.selectTableNameByDatabase(databaseName);
        List<HashMap<String, String>> tableNameListBD = new ArrayList<HashMap<String, String>>();
        for (HashMap<String, String> map : tableNameList) {
            if (StringUtils.isBlank(map.get("tableComment"))) {
                map.put("tableComment", map.get("tableName"));
            }
            tableNameListBD.add(map);
        }
        for (String key : request.getParameterMap().keySet()) {
            model.addAttribute(key, request.getParameter(key));
        }
        model.addAttribute("tableName", tableID);
        model.addAttribute("accountName", accountName);
        model.addAttribute("tableList", tableList);
        model.addAttribute("tableNameList", tableNameListBD);
        return Common.BACKGROUND_PATH + "/app/common/infoNav";
    }

    @ResponseBody
    @RequestMapping("/getGraph")
    public String getGraph() throws Exception {
        Session session = SecurityUtils.getSubject().getSession();
        NavFormMap tnavFormMap = new NavFormMap();
        tnavFormMap.set("userId", session.getAttribute("userSessionId"));

        NavFormMap navFormMap = new NavFormMap();
        try {
            navFormMap = navMapper.findByNames(tnavFormMap).get(0);
        }
        catch (Exception e){
            return null;
        }
        return navFormMap.getStr("network");
    }
    @ResponseBody
    @RequestMapping("/{datasetid}/{nodeId}/{n}/getGraphbyid")
    public String getGraphbyid(@PathVariable String datasetid,@PathVariable int nodeId,@PathVariable int n) throws Exception{
        Session session = SecurityUtils.getSubject().getSession();
        NavFormMap tnavFormMap = new NavFormMap();
        tnavFormMap.set("userId", session.getAttribute("userSessionId"));

        NavFormMap navFormMap = new NavFormMap();
        try {
            navFormMap = navMapper.findByNames(tnavFormMap).get(0);
        }
        catch (Exception e){
            return null;
        }
        JSONObject jNetwork= JSON.parseObject(navFormMap.getStr("network"));

        List<NodeandLinks> nls = new ArrayList<>();
        List<Boolean> flag = new ArrayList<>();
        JSONArray jnodes = JSONArray.parseArray(jNetwork.getString("nodes"));
        NodeandLinks st = null;
        for(int i = 0;i<jnodes.size();i++){
            JSONObject jnode = (JSONObject) jnodes.get(i);//String name,Long category,String dataset,String metadata,String value, String remark,int myid
            NodeandLinks nl= new NodeandLinks(jnode.getString("name"),jnode.getLong("category"),jnode.getString("dataset"),jnode.getString("metadata"),jnode.getString("value"),jnode.getString("remark"),i);
            nls.add(nl);
            flag.add(new Boolean(false));

        }
        JSONArray jlinks = JSONArray.parseArray(jNetwork.getString("links"));
        for(int i = 0;i<jlinks.size();i++){
            JSONObject jlink = (JSONObject) jlinks.get(i);
            NodeandLinks sou = nls.get(jlink.getInteger("source"));
            NodeandLinks tar = nls.get(jlink.getInteger("target"));
            sou.link.add(tar);
            sou.linkName.add(jlink.getString("name"));
        }
        for(int i = 0;i<nls.size();i++){
            if(nls.get(i).dataset.equals(datasetid)&&nls.get(i).value.equals(String.valueOf(nodeId))){
                st =nls.get(i);
                flag.set(i,new Boolean(true));
                break;
            }
        }
        List<Node> ns = new ArrayList<>();
        List<Link> ls = new ArrayList<>();
        Queue<NodeandLinks> qnls = new LinkedList<>();
        Queue<Integer> qis = new LinkedList<>();
        qnls.offer(st);
        Node stnode = st.getNodeforJson();
        stnode.symbolSize="20";
        ns.add(stnode);
        ns.get(0).category = 5L;
        qis.offer(new Integer(1));

        List<NodeandLinks> choosnl = new ArrayList<>();

        choosnl.add(st);
        while(!qnls.isEmpty()){
            NodeandLinks top = qnls.poll();
            int i = qis.poll();
            if(i>=n) continue;
            for(int j = 0;j<top.link.size();j++){
                NodeandLinks temnl = top.link.get(j);
                if(flag.get(temnl.myid).compareTo(Boolean.FALSE)==0){
                    qnls.offer(temnl);
                    qis.offer(i+1);
                    //此处保持两个list相同序号
                    choosnl.add(temnl);
                    ns.add(temnl.getNodeforJson());
                    flag.set(temnl.myid, new Boolean(true));
                }
            }

        }
        for(int i = 0;i<choosnl.size();i++){
            NodeandLinks temnl = choosnl.get(i);
            for(int j=0;j<temnl.link.size();j++){
                if(flag.get(temnl.link.get(j).myid).compareTo(Boolean.TRUE)==0){
                    for(int k=0;k<choosnl.size();k++){
                        if(temnl.link.get(j).myid==choosnl.get(k).myid){
                            ls.add(new Link(new Long(i),new Long(k),temnl.linkName.get(j)));
                        }
                    }
                }
            }
        }
        Network network = new Network();
        network.setDefaultCategory();
        network.nodes = ns;
        network.links = ls;
        return JSON.toJSONString(network);

    }


    @ResponseBody
    @RequestMapping("/{datasetid}/{Id}/{n}/getGraphbykey")
    public String getGraphbykey(@PathVariable String datasetid,@PathVariable int Id,@PathVariable int n) throws Exception{
        Session session = SecurityUtils.getSubject().getSession();
        NavFormMap tnavFormMap = new NavFormMap();
        tnavFormMap.set("userId", session.getAttribute("userSessionId"));

        NavFormMap navFormMap = new NavFormMap();
        try {
            navFormMap = navMapper.findByNames(tnavFormMap).get(0);
        }
        catch (Exception e){
            return null;
        }
        JSONObject jNetwork= JSON.parseObject(navFormMap.getStr("network"));

        List<NodeandLinks> nls = new ArrayList<>();
        List<Boolean> flag = new ArrayList<>();
        JSONArray jnodes = JSONArray.parseArray(jNetwork.getString("nodes"));
        NodeandLinks st = null;
        for(int i = 0;i<jnodes.size();i++){
            JSONObject jnode = (JSONObject) jnodes.get(i);//String name,Long category,String dataset,String metadata,String value, String remark,int myid
            NodeandLinks nl= new NodeandLinks(jnode.getString("name"),jnode.getLong("category"),jnode.getString("dataset"),jnode.getString("metadata"),jnode.getString("value"),jnode.getString("remark"),i);
            nls.add(nl);
            flag.add(new Boolean(false));

        }
        JSONArray jlinks = JSONArray.parseArray(jNetwork.getString("links"));
        for(int i = 0;i<jlinks.size();i++){
            JSONObject jlink = (JSONObject) jlinks.get(i);
            NodeandLinks sou = nls.get(jlink.getInteger("source"));
            NodeandLinks tar = nls.get(jlink.getInteger("target"));
            sou.link.add(tar);
            sou.linkName.add(jlink.getString("name"));
        }

        for(int i = 0;i<nls.size();i++){
            if(nls.get(i).dataset.equals(datasetid)&&nls.get(i).value.equals(String.valueOf(Id))){
                st =nls.get(i);
                flag.set(i,new Boolean(true));
                break;
            }
        }
        List<Node> ns = new ArrayList<>();
        List<Link> ls = new ArrayList<>();
        Queue<NodeandLinks> qnls = new LinkedList<>();
        Queue<Integer> qis = new LinkedList<>();
        qnls.offer(st);
        Node stnode = st.getNodeforJson();
        stnode.symbolSize="20";
        ns.add(stnode);
        ns.get(0).category = 5L;
        qis.offer(new Integer(1));

        List<NodeandLinks> choosnl = new ArrayList<>();

        choosnl.add(st);
        while(!qnls.isEmpty()){
            NodeandLinks top = qnls.poll();
            int i = qis.poll();
            if(i>=n) continue;
            for(int j = 0;j<top.link.size();j++){
                NodeandLinks temnl = top.link.get(j);
                if(flag.get(temnl.myid).compareTo(Boolean.FALSE)==0){
                    qnls.offer(temnl);
                    qis.offer(i+1);
                    //此处保持两个list相同序号
                    choosnl.add(temnl);
                    ns.add(temnl.getNodeforJson());
                    flag.set(temnl.myid, new Boolean(true));
                }
            }

        }
        for(int i = 0;i<choosnl.size();i++){
            NodeandLinks temnl = choosnl.get(i);
            for(int j=0;j<temnl.link.size();j++){
                if(flag.get(temnl.link.get(j).myid).compareTo(Boolean.TRUE)==0){
                    for(int k=0;k<choosnl.size();k++){
                        if(temnl.link.get(j).myid==choosnl.get(k).myid){
                            ls.add(new Link(new Long(i),new Long(k),temnl.linkName.get(j)));
                        }
                    }
                }
            }
        }
        Network network = new Network();
        network.setDefaultCategory();
        network.nodes = ns;
        network.links = ls;
        return JSON.toJSONString(network);

    }
    @RequestMapping("/{datasetid}/selectData")
    public String selectData(@PathVariable String datasetid,Model model) throws Exception {
        model.addAttribute("tableName",datasetid);
        DatasetFormMap tdatasetFormMap = new DatasetFormMap();
        tdatasetFormMap.set("id",datasetid);
        List<DatasetFormMap> datasetFormMaps = datasetMapper.findByNames(tdatasetFormMap);
        String databaseName="";
        String tableName="";
        List<Table> tableList = new ArrayList<>();
        if(datasetFormMaps.size()<1){
            //不确定 无验证
            databaseName = "xmaster";
            tableName = datasetid;
            if (!tableName.startsWith(BD)) {
                tableName = BD + tableName;
            }
            tableList = tableMapper.selectTableByName(datasetid, databaseName);
        }
        else{
            DatasetFormMap datasetFormMap = datasetFormMaps.get(0);
            String[] temda  = datasetFormMap.getStr("dataset_url").split("/");
            databaseName = temda[temda.length-1];
            tableName = datasetFormMap.getStr("title");
            MetadataFormMap mf = new MetadataFormMap();
            mf.put("datasetid",datasetid);
            mf.put("deleted_mark",1);
            List<MetadataFormMap> lsm = metadataMapper.findByNames(mf);
            List<String> ls = new ArrayList<>();
            List<String> lsmeta = new ArrayList<>();
            for(MetadataFormMap me : lsm){
                Table table = new Table();
                table.setColumnName(me.getStr("meta"));
                table.setColumnComment(me.getStr("meta"));
                table.setDataType(me.getStr("type"));
                table.setTableName(tableName);
                tableList.add(table);
            }
        }
        model.addAttribute("tableList",tableList);
        return  Common.BACKGROUND_PATH + "/app/common/dataTable";
    }
    @ResponseBody
    @RequestMapping("/{tableName}/{id}/getGps")
    public JSONArray getGps(@PathVariable String tableName, @PathVariable int id) {
        File filec=new File("D://gps");
        File[] files=filec.listFiles();
        File file = files[id%files.length];
        BufferedReader reader = null;
        JSONArray loc = new JSONArray();
        try {
            //System.out.println("以行为单位读取文件内容，一次读一整行：");
            reader = new BufferedReader(new FileReader(file));
            String tempString = null;
            //int line = 1;
            // 一次读入一行，直到读入null为文件结束
            while ((tempString = reader.readLine()) != null) {
                // 显示行号
                // System.out.println("line " + line + ": " + tempString);
                //line++;
                String[] sp = tempString.split(",");
                JSONArray lloc = new JSONArray();
                try {
                    lloc.add(Double.valueOf(sp[2]));
                    lloc.add(Double.valueOf(sp[3]));
                    loc.add(lloc);
                }
                catch (Exception e){}
            }
            reader.close();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (reader != null) {
                try {
                    reader.close();
                } catch (IOException e1) {
                }
            }
        }

        return loc;
    }
    @ResponseBody
    @RequestMapping("/{tableName}/{id}/detail1")
    public FormMap getDetailById(@PathVariable String tableName, @PathVariable Long id) {
        DatasetFormMap tdatasetFormMap = new DatasetFormMap();
        tdatasetFormMap.set("id",tableName);
        List<DatasetFormMap> datasetFormMaps = datasetMapper.findByNames(tdatasetFormMap);
        String databaseName="";
        if(datasetFormMaps.size()<1){
            //不确定 无验证
            databaseName = "xmaster";
            if (!tableName.startsWith(BD)) {
                tableName = BD + tableName;
            }
        }
        else{
            //不是mysql的自己解决把，如果你是2014级以后的，还看到了这一段注释，good luck
            DatasetFormMap datasetFormMap = datasetFormMaps.get(0);
            String[] temda  = datasetFormMap.getStr("dataset_url").split("/");
            databaseName = temda[temda.length-1];
            tableName = datasetFormMap.getStr("title");
        }
        List<Table> tableList = tableMapper.selectTableByName(tableName, databaseName);
        FormMap<String, Object> formMap = new FormMap<String, Object>();
        FormMap detailedData = tableMapper.selectDataById(databaseName, tableName, id);
        for (Table table : tableList) {
            String key = table.getColumnComment();
            String mid = table.getColumnName();
            if (StringUtils.isBlank(key)) {
                key = mid;
            }
            Object val = detailedData.get(mid);
            if (val != null) {
                formMap.put(key, val);
            }
        }
        return formMap;
    }
    @ResponseBody
    @RequestMapping("/{datasetid}/showData")
    public PageView showData(@PathVariable String datasetid, String pageNow, String pageSize) throws Exception{
        DatasetFormMap tdatasetFormMap = new DatasetFormMap();
        tdatasetFormMap.set("id",datasetid);
        List<DatasetFormMap> datasetFormMaps = datasetMapper.findByNames(tdatasetFormMap);
        String databaseName="";
        String tableName="";
        if(datasetFormMaps.size()<1){
            //不确定 无验证
            databaseName = "xmaster";
            tableName = datasetid;
            if (!tableName.startsWith(BD)) {
                tableName = BD + tableName;
            }
        }
        else{
            //不是mysql的自己解决把，如果你是2014级以后的，还看到了这一段注释，good luck
            DatasetFormMap datasetFormMap = datasetFormMaps.get(0);
            String[] temda  = datasetFormMap.getStr("dataset_url").split("/");
            databaseName = temda[temda.length-1];
            tableName = datasetFormMap.getStr("title");
        }
        // 数据总条数
        String where = "1";
        // 数据总条数
        getPageView(pageNow, pageSize, "");
        Long rowCount = tableMapper.selectCountFromTable(databaseName, tableName, where);
        pageView.setRowCount(rowCount);

        // 该页内的数据
        where = PagePlugin.generatePagesSql(where, pageView);
        List<FormMap> dataList = tableMapper.selectDataFromTable(databaseName, tableName, "*", where);
        pageView.setRecords(dataList);
        return pageView;
    }
    private String[] getDatasetInfo(String datasetName){
        DatasetFormMap tdatasetFormMap = new DatasetFormMap();
        tdatasetFormMap.put("id",datasetName);
        tdatasetFormMap.put("deleted_mark",1);
        List<DatasetFormMap> datasetFormMaps = datasetMapper.findByNames(tdatasetFormMap);
        if(datasetFormMaps.size()<1){
            return new String[]{"xmaster",datasetName};
        }
        else{
            DatasetFormMap datasetFormMap = datasetFormMaps.get(0);
            String[] temda  = datasetFormMap.getStr("dataset_url").split("/");
            return new String[]{temda[temda.length-1],datasetFormMap.getStr("title")};
        }
    }
}
//    public String locationNav(Model model){
//        List<ProvinceFormMap> ps = provinceMapper.findByWhere(new ProvinceFormMap());
//        List<CityFormMap> cs = cityMapper.findByWhere(new CityFormMap());
//        List<DistrictFormMap> ds = districtMapper.findByWhere(new DistrictFormMap());
//        model.addAttribute("provinces",ps);
//        model.addAttribute("provinces_size",ps.size()+10);
//        model.addAttribute("citys",cs);
//        model.addAttribute("citys_size",cs.size()+10);
//        model.addAttribute("districts",ds);
//        model.addAttribute("districts_size",ds.size()+10);
//        return Common.BACKGROUND_PATH + "/app/common/infoNav";
//    }