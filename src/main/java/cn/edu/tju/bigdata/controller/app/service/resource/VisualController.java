package cn.edu.tju.bigdata.controller.app.service.resource;

import cn.edu.tju.bigdata.annotation.SystemLog;
import cn.edu.tju.bigdata.controller.index.BaseController;
import cn.edu.tju.bigdata.entity.*;
import cn.edu.tju.bigdata.enums.EmDeletedMark;
import cn.edu.tju.bigdata.mapper.*;
import cn.edu.tju.bigdata.plugin.PageView;
import cn.edu.tju.bigdata.util.Common;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import sun.security.krb5.Config;

import javax.servlet.http.HttpServletRequest;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Date;

/**
 * Created by NING on 2016/10/9.
 */
@Controller
@RequestMapping("/visual")
public class VisualController extends BaseController {


    @Autowired
    VisualConfigMapper visualConfigMapper;
    @Autowired
    VisualMethodMapper visualMethodMapper;
    @Autowired
    VisualParameterMapper visualParameterMapper;
    @Autowired
    VisualTypeMapper visualTypeMapper;
    @Autowired
    DatasetMapper datasetMapper;
    @Autowired
    MetadataMapper metadataMapper;

    @RequestMapping("/create")
    public String create(Model model) throws Exception {
        model.addAttribute("res", findByRes());
        return Common.BACKGROUND_PATH + "/app/applicationtemplatemanage/visualuichoosedatasets";
    }
    @RequestMapping("/{datasetids}/choosetype")
    public String choosetype(@PathVariable String datasetids, Model model) throws Exception{
        model.addAttribute("datasetids",datasetids);
        return Common.BACKGROUND_PATH + "/app/applicationtemplatemanage/visualuichoosetype";
    }
    @RequestMapping("/{datasetids}/{typeid}/chooseoperator")
    public String chooseoperator(@PathVariable String datasetids,@PathVariable int typeid, Model model) throws Exception{

        //operator 相关


        model.addAttribute("typeid",typeid);
        model.addAttribute("datasetids",datasetids);
        return Common.BACKGROUND_PATH + "/app/applicationtemplatemanage/visualuichooseoperator";
    }


    @RequestMapping("/{configid}/showconfig")
    public String showconfig(@PathVariable String configid, Model model) throws Exception{
        model.addAttribute("configid",configid);
        VisualConfigFormMap tvisualConfigFormMap = new VisualConfigFormMap();
        tvisualConfigFormMap.put("id",configid);
        List<VisualConfigFormMap> visualConfigFormMaps = visualConfigMapper.findByNames(tvisualConfigFormMap);
        VisualConfigFormMap visualConfigFormMap = visualConfigFormMaps.get(0);

        model.addAttribute("info",visualConfigFormMap.get("info"));

        VisualMethodFormMap tvisualMethodFormMap = new VisualMethodFormMap();
        tvisualMethodFormMap.put("id",visualConfigFormMap.get("methodid"));
        List<VisualMethodFormMap> visualMethodFormMaps = visualMethodMapper.findByNames(tvisualMethodFormMap);
        VisualMethodFormMap visualMethodFormMap = visualMethodFormMaps.get(0);
        model.addAttribute("js",visualMethodFormMap.get("js"));

        VisualTypeFormMap tvisualTypeFormMap = new VisualTypeFormMap();
        tvisualTypeFormMap.put("id",visualConfigFormMap.get("typeid"));
        List<VisualTypeFormMap> visualTypeFormMaps = visualTypeMapper.findByNames(tvisualTypeFormMap);
        model.addAttribute("type", visualTypeFormMaps.get(0).get("name"));
        return Common.BACKGROUND_PATH + "/app/applicationtemplatemanage/visualuishow";
    }


    @ResponseBody
    @RequestMapping("/{configid}/getconfigdata")
    public Map getconfigdata(@PathVariable int configid) throws Exception{
        Map<String,List<String>> hs = new HashMap<>();
        try {
            VisualConfigFormMap tvisualConfigFormMap = new VisualConfigFormMap();
            tvisualConfigFormMap.put("id", configid);
            List<VisualConfigFormMap> visualConfigFormMaps = visualConfigMapper.findByNames(tvisualConfigFormMap);
            VisualConfigFormMap visualConfigFormMap = visualConfigFormMaps.get(0);
            String config = visualConfigFormMap.getStr("config");
            String[] confs = config.split(";");
            for(String conf:confs){
                String[] items = conf.split(":");
                String pid = items[0];
                String type = items[1];
                String mid = items[2];
                VisualParameterFormMap tvisualParameterFormMap = new VisualParameterFormMap();
                tvisualParameterFormMap.put("id",pid);
                List<VisualParameterFormMap> visualParameterFormMaps = visualParameterMapper.findByNames(tvisualParameterFormMap);
                String key = visualParameterFormMaps.get(0).getStr("name");
                List<String> value = new ArrayList<>();
                if(type.equals("meta")){
                    //获取datasetid和meta名
                    int datasetid = 0;
                    String metaname = "";
                    MetadataFormMap tmetadataFormMap = new MetadataFormMap();
                    tmetadataFormMap.put("id",mid);
                    List<MetadataFormMap> metadataFormMaps = metadataMapper.findByNames(tmetadataFormMap);
                    MetadataFormMap metadataFormMap = metadataFormMaps.get(0);
                    metaname = metadataFormMap.getStr("meta");
                    datasetid = metadataFormMap.getInt("datasetid");
                    //连接数据库
                    getMetadata(datasetid,metaname,value);
                }
                else if(type.equals("para")){

                }
                hs.put(key,value);
            }
        }
        catch (Exception e){}
        return hs;
    }

    @RequestMapping("/{datasetids}/{typeid}/{operatorid}/config")
    public String choosetype(@PathVariable String datasetids,@PathVariable int typeid,@PathVariable int operatorid, Model model) throws Exception{


        model.addAttribute("typeid",typeid);
        model.addAttribute("operatorid",operatorid);

        if(datasetids.charAt(datasetids.length()-1)==','){
            datasetids = datasetids.substring(0,datasetids.length()-1);
        }
        model.addAttribute("datasetids",datasetids);

        List<MetadataFormMap> metadataFormMaps = new ArrayList<>();
        try {
            for (String datasetid : datasetids.split(",")) {

                MetadataFormMap metadataFormMap = new MetadataFormMap();
                metadataFormMap.put("datasetid",datasetid);
                metadataFormMap.put("deleted_mark",EmDeletedMark.VALID.getCode());
                metadataFormMaps.addAll(metadataMapper.findByNames(metadataFormMap));
            }
        }
        catch (Exception e){}
        model.addAttribute("metadatas",metadataFormMaps);

        VisualParameterFormMap visualParameterFormMap = new VisualParameterFormMap();
        visualParameterFormMap.put("visualtypeid",typeid);
        visualParameterFormMap.put("deleted_mark",EmDeletedMark.VALID.getCode());
        List<VisualParameterFormMap> visualParameterFormMaps = visualParameterMapper.findByNames(visualParameterFormMap);
        model.addAttribute("visualparameters",visualParameterFormMaps);

        VisualMethodFormMap tvisualMethodFormMap = new VisualMethodFormMap();
        tvisualMethodFormMap.put("typeid",typeid);
        tvisualMethodFormMap.put("deleted_mark",EmDeletedMark.VALID.getCode());
        List<VisualMethodFormMap> visualMethodFormMaps = visualMethodMapper.findByNames(tvisualMethodFormMap);
        model.addAttribute("visualmethods",visualMethodFormMaps);

        if(operatorid!=0){

            //operator 相关
        }

        return Common.BACKGROUND_PATH + "/app/applicationtemplatemanage/visualuiconfig";
    }

    @ResponseBody
    @RequestMapping("/findvisualtypeByPage")
    public PageView findByPage(String pageNow, String pageSize) {
        VisualTypeFormMap visualTypeFormMap = getFormMap(VisualTypeFormMap.class);
        visualTypeFormMap = toFormMap(visualTypeFormMap, pageNow, pageSize, visualTypeFormMap.getStr("orderby"));
        visualTypeFormMap.set("deleted_mark", EmDeletedMark.VALID.getCode());
        pageView.setRecords(visualTypeMapper.findByPage(visualTypeFormMap));
        return pageView;
    }


    @ResponseBody
    @RequestMapping("/save")
    @Transactional(readOnly = false)
    @SystemLog(module = "资源管理", methods = "新增可视化配置")
    public String save(HttpServletRequest request, Model model){
        try {
            Date now = new Date();
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
            VisualConfigFormMap visualConfigFormMap = getFormMap(VisualConfigFormMap.class);
            visualConfigFormMap.set("deleted_mark", EmDeletedMark.VALID.getCode());
            visualConfigFormMap.set("meta_created", simpleDateFormat.format(now));
            visualConfigFormMap.set("meta_updated", simpleDateFormat.format(now));


            VisualParameterFormMap visualParameterFormMap = new VisualParameterFormMap();
            visualParameterFormMap.put("visualtypeid", request.getParameter("visualConfigFormMap.typeid"));
            visualParameterFormMap.put("deleted_mark", EmDeletedMark.VALID.getCode());
            List<VisualParameterFormMap> visualParameterFormMaps = visualParameterMapper.findByNames(visualParameterFormMap);
            TreeMap<String, String> con = new TreeMap<>();
            for (VisualParameterFormMap vic : visualParameterFormMaps) {
                String val = request.getParameter(vic.get("id").toString()).trim();
                if (!val.equals("")) {
                    con.put(vic.get("id").toString(), val);
                }
            }
            StringBuilder scon = new StringBuilder("");
            for (Map.Entry<String, String> entry : con.entrySet()) {
                scon.append(entry.getKey() + ":" + entry.getValue() + ";");
            }
            visualConfigFormMap.put("config", scon.toString());
            String userName = request.getParameter("userName");
            visualConfigMapper.addEntity(visualConfigFormMap);
            List<VisualConfigFormMap> ans = visualConfigMapper.findByNames(visualConfigFormMap);
            return ans.get(0).get("id").toString();

        }
        catch (Exception e){
            return "-1";
        }
    }


    private void getMetadata(int id,String meta,List<String> value) throws Exception{
        DatasetFormMap tdatasetFormMap = new DatasetFormMap();
        tdatasetFormMap.put("id",id);
        tdatasetFormMap.put("deleted_mark", EmDeletedMark.VALID.getCode());
        List<DatasetFormMap> datasetFormMaps = datasetMapper.findByNames(tdatasetFormMap);
        if(datasetFormMaps.size()<1) throw new Exception();
        DatasetFormMap datasetFormMap = datasetFormMaps.get(0);
        try {
            String type = datasetFormMap.getStr("dataset_type");
            String url = datasetFormMap.getStr("dataset_url");
            String name = datasetFormMap.getStr("title");
            String username = datasetFormMap.getStr("username");
            String psw = datasetFormMap.getStr("psw");
            String coded_format = datasetFormMap.getStr("coded_format");
            if(type.indexOf("mysql")!=-1){
                Connection conn = null;
                try{
                    Class.forName("com.mysql.jdbc.Driver");
                    conn = DriverManager.getConnection(url + "?useUnicode=true&characterEncoding=" + coded_format, username, psw);
                    if(!conn.isClosed()){
                        Statement stmt = conn.createStatement();
                        String sql = "select "+meta+" from  "+name;
                        ResultSet result = stmt.executeQuery(sql);
                        while (result.next()) {
                            value.add(result.getString(meta));

                        }
                    }
                    else{
                    }
                } catch (ClassNotFoundException e) {
                } catch(SQLException e) {
                } catch(Exception e) {
                }
                finally {
                    conn.close();
                }
            }

        }
        catch (Exception e){
        }

    }
}
