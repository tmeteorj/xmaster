package cn.edu.tju.bigdata.controller.app.service.resource;

import cn.edu.tju.bigdata.annotation.SystemLog;
import cn.edu.tju.bigdata.controller.index.BaseController;
import cn.edu.tju.bigdata.entity.*;
import cn.edu.tju.bigdata.enums.EmDeletedMark;
import cn.edu.tju.bigdata.mapper.*;
import cn.edu.tju.bigdata.plugin.PageView;
import cn.edu.tju.bigdata.util.Common;
import cn.edu.tju.bigdata.util.JsonUtils;
import com.alibaba.fastjson.JSON;
import org.apache.commons.lang.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.expression.spel.ast.Operator;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.ujmp.core.util.JsonUtil;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Method;
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
    @Autowired
    OperatorConfigMapper operatorConfigMapper;
    @Autowired
    OperatorMapper operatorMapper;
    @Autowired
    TableMapper tableMapper;
    @Autowired
    OperatorInputMapper operatorInputMapper;
    @Autowired
    OperatorOutputMapper operatorOutputMapper;
    @Autowired
    LayoutMapper layoutMapper;
    @Autowired
    DecisionUiMapper decisionUiMapper;
    @Autowired
    UserMapper userMapper;
    @Autowired
    ResourcesMapper resourcesMapper;
    @RequestMapping("/create")
    public String create(Model model) throws Exception {
        model.addAttribute("res", findByRes());
        return Common.BACKGROUND_PATH + "/app/applicationtemplatemanage/visualuichoosedatasets";
    }
    @RequestMapping("/list")
    public String manage(Model model) throws Exception {
        model.addAttribute("res", findByRes());
        return Common.BACKGROUND_PATH + "/app/applicationtemplatemanage/visualuimanage";
    }

    //可视化类型管理主界面对应controller
    @RequestMapping("/typelist")
    public String typemanage(Model model) throws Exception {
        model.addAttribute("res", findByRes());
        return Common.BACKGROUND_PATH + "/app/applicationtemplatemanage/visualtypemanage";
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

        model.addAttribute("data", JsonUtils.mapToJson(getconfigdata(Integer.valueOf(configid))));
        return Common.BACKGROUND_PATH + "/app/applicationtemplatemanage/visualuishow";
    }
    private Map invokeStaticMethod(String className, String methodName,
                              Object[] args) throws Exception {
        Class ownerClass = Class.forName("cn.edu.tju.bigdata.util.operator."+className);

        Class[] argsClass = new Class[args.length];
        for (int i = 0, j = args.length; i < j; i++) {
            if (args[i] instanceof List){
                argsClass[i] = List.class;
            }
            else {
                argsClass[i] = args[i].getClass();
            }
        }

        Method method = ownerClass.getMethod(methodName,argsClass);

        return (Map)method.invoke(null, args);
    }

//    @ResponseBody
//    @RequestMapping("/{configid}/getconfigdata")
    public Map getconfigdata(int configid) throws Exception{
        Map hs = new HashMap<>();
        try {
            VisualConfigFormMap tvisualConfigFormMap = new VisualConfigFormMap();
            Map operatorMap = new HashMap();
            tvisualConfigFormMap.put("id", configid);
            List<VisualConfigFormMap> visualConfigFormMaps = visualConfigMapper.findByNames(tvisualConfigFormMap);
            VisualConfigFormMap visualConfigFormMap = visualConfigFormMaps.get(0);
            List<OperatorOutputFromMap> operatorOutputFromMaps;
            String operatorConfigid = visualConfigFormMap.get("operatorconfigid").toString();
            if(!operatorConfigid.equals("0")) {
                try {
                    OperatorConfigFromMap operatorConfigFromMap = operatorConfigMapper.findbyFrist("id",operatorConfigid,OperatorConfigFromMap.class);
                    OperatorInputFromMap toperatorInputFromMap = new OperatorInputFromMap();
                    toperatorInputFromMap.set("operatorid",operatorConfigFromMap.get("operatorid"));
                    toperatorInputFromMap.set("deleted_mark",EmDeletedMark.VALID.getCode());
                    toperatorInputFromMap.put("$orderby","order by orders asc");
                    List<OperatorInputFromMap> operatorInputFromMaps = operatorInputMapper.findByNames(toperatorInputFromMap);
                    OperatorOutputFromMap toperatorOutputFromMap = new OperatorOutputFromMap();
                    toperatorOutputFromMap.set("operatorid",operatorConfigFromMap.get("operatorid"));
                    toperatorOutputFromMap.set("deleted_mark",EmDeletedMark.VALID.getCode());
                    operatorOutputFromMaps = operatorOutputMapper.findByNames(toperatorOutputFromMap);
                    OperatorFromMap operatorFromMap = operatorMapper.findbyFrist("id",operatorConfigFromMap.get("operatorid").toString(),OperatorFromMap.class);
                    String className = operatorFromMap.getStr("class");
                    String methodName = operatorFromMap.getStr("method");
                    Object[] args = new Object[operatorInputFromMaps.size()];
                    int i = 0;
                    String operatorconfig = operatorConfigFromMap.getStr("config");
                    String[] config = operatorconfig.split(";");
                    for(OperatorInputFromMap operatorInputFromMap:operatorInputFromMaps){
                        if(operatorInputFromMap.getInt("ismetadata")==0){
                            args[i] = config[i].split(":")[1];
                        }
                        else{
                            List<String> list = new ArrayList<>();
                            MetadataFormMap metadataFormMap = metadataMapper.findbyFrist("id",config[i].split(":")[1],MetadataFormMap.class);
                            getMetadata(metadataFormMap.getInt("datasetid"),metadataFormMap.getStr("meta"), list);
                            args[i] = (List)list;
                        }
                        i++;
                    }
                    Map operatorOutput = invokeStaticMethod(className,methodName,args);
                    for(OperatorOutputFromMap op:operatorOutputFromMaps){
                        if(operatorOutput.containsKey(op.getStr("name"))){
                            operatorMap.put(String.valueOf(op.get("id")),operatorOutput.get(op.getStr("name")));
                        }
                    }
                } catch (Exception e){}
            }
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
                else if(type.equals("opte")){
                    if(operatorMap.containsKey(mid)){
                        value = (List<String>)operatorMap.get(mid);
                    }
                }
                hs.put(key,value);
            }
        }
        catch (Exception e){}
        return hs;
    }

    @RequestMapping("/{datasetids}/{typeid}/{operatorconfigid}/config")
    public String config(@PathVariable String datasetids,@PathVariable int typeid,@PathVariable int operatorconfigid, Model model) throws Exception{


        model.addAttribute("typeid",typeid);
        model.addAttribute("operatorconfigid",operatorconfigid);

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

        if(operatorconfigid!=0){
            OperatorConfigFromMap operatorConfigFromMap = operatorConfigMapper.findbyFrist("id", String.valueOf(operatorconfigid), OperatorConfigFromMap.class);
            OperatorOutputFromMap toperatorOutputFromMap = new OperatorOutputFromMap();
            toperatorOutputFromMap.set("operatorid",operatorConfigFromMap.get("operatorid"));
            toperatorOutputFromMap.set("deleted_mark",EmDeletedMark.VALID.getCode());
            List<OperatorOutputFromMap> operatorOutputFromMaps = operatorOutputMapper.findByNames(toperatorOutputFromMap);
            model.addAttribute("operatorOutputFromMaps",operatorOutputFromMaps);

        }

        return Common.BACKGROUND_PATH + "/app/applicationtemplatemanage/visualuiconfig";
    }

    @RequestMapping("/{datasetids}/{typeid}/{operatorid}/operatorconfig")
    public String operatorconfig(@PathVariable String datasetids,@PathVariable int typeid,@PathVariable int operatorid, Model model) throws Exception{


        model.addAttribute("typeid",typeid);
        model.addAttribute("operatorid",operatorid);
        OperatorInputFromMap toperatorInputFromMap = new OperatorInputFromMap();
        toperatorInputFromMap.set("operatorid",operatorid);
        toperatorInputFromMap.set("deleted_mark",EmDeletedMark.VALID.getCode());
        toperatorInputFromMap.put("$orderby","order by orders asc");
        List<OperatorInputFromMap> operatorInputFromMaps = operatorInputMapper.findByNames(toperatorInputFromMap);
        model.addAttribute("operatorInputFromMaps",operatorInputFromMaps);
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



        return Common.BACKGROUND_PATH + "/app/applicationtemplatemanage/visualuiconfigoperator";
    }




    @ResponseBody
    @RequestMapping("/findvisualtypeByPage")
    public PageView findvisualtypeByPage(String pageNow, String pageSize) {
        VisualTypeFormMap visualTypeFormMap = getFormMap(VisualTypeFormMap.class);
        visualTypeFormMap = toFormMap(visualTypeFormMap, pageNow, pageSize, visualTypeFormMap.getStr("orderby"));
        visualTypeFormMap.set("deleted_mark", EmDeletedMark.VALID.getCode());
        pageView.setRecords(visualTypeMapper.findByPage(visualTypeFormMap));
        return pageView;
    }



    @ResponseBody
    @RequestMapping("/findvisualuiByPage")
    public PageView findvisualuiByPage(String pageNow, String pageSize) {
        VisualConfigFormMap visualConfigFormMap = getFormMap(VisualConfigFormMap.class);
        visualConfigFormMap = toFormMap(visualConfigFormMap, pageNow, pageSize, visualConfigFormMap.getStr("orderby"));
        visualConfigFormMap.set("deleted_mark", EmDeletedMark.VALID.getCode());
        pageView.setRecords(visualConfigMapper.findByPage(visualConfigFormMap));
        return pageView;
    }

    @ResponseBody
    @RequestMapping("/findoperatorByPage")
    public PageView findoperatorByPage(String pageNow, String pageSize) {
        OperatorFromMap operatorFromMap = getFormMap(OperatorFromMap.class);
        operatorFromMap = toFormMap(operatorFromMap, pageNow, pageSize, operatorFromMap.getStr("orderby"));
        operatorFromMap.set("deleted_mark", EmDeletedMark.VALID.getCode());
        pageView.setRecords(operatorMapper.findByPage(operatorFromMap));
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


    @ResponseBody
    @RequestMapping("/saveoperator")
    @Transactional(readOnly = false)
    @SystemLog(module = "资源管理", methods = "新增算子配置")
    public String saveoperator(HttpServletRequest request, Model model){
        try {
            Date now = new Date();
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
            OperatorConfigFromMap operatorConfigFromMap = getFormMap(OperatorConfigFromMap.class);
            operatorConfigFromMap.set("deleted_mark", EmDeletedMark.VALID.getCode());
            operatorConfigFromMap.set("meta_created", simpleDateFormat.format(now));
            operatorConfigFromMap.set("meta_updated", simpleDateFormat.format(now));

            OperatorInputFromMap toperatorInputFromMap = new OperatorInputFromMap();
            toperatorInputFromMap.set("operatorid",request.getParameter("operatorConfigFromMap.operatorid"));
            toperatorInputFromMap.set("deleted_mark",EmDeletedMark.VALID.getCode());
            toperatorInputFromMap.put("$orderby","order by orders asc");
            List<OperatorInputFromMap> operatorInputFromMaps = operatorInputMapper.findByNames(toperatorInputFromMap);
            TreeMap<String, String> con = new TreeMap<>();
            for (OperatorInputFromMap vic : operatorInputFromMaps) {
                String val = request.getParameter(vic.get("id").toString()).trim();
                if (!val.equals("")) {
                    con.put(vic.get("id").toString(), val);
                }
            }
            StringBuilder scon = new StringBuilder("");
            for (Map.Entry<String, String> entry : con.entrySet()) {
                scon.append(entry.getKey() + ":" + entry.getValue() + ";");
            }

            operatorConfigFromMap.put("config", scon.toString());
            operatorConfigMapper.addEntity(operatorConfigFromMap);
            List<OperatorConfigFromMap> ans = operatorConfigMapper.findByNames(operatorConfigFromMap);
            return ans.get(0).get("id").toString();

        }
        catch (Exception e){
            return "-1";
        }
    }
    @RequestMapping("/createdecisionui")
    public String createdecisionui(Model model) throws Exception {
        model.addAttribute("res", findByRes());
        List<UserFormMap> userFormMaps = userMapper.findByNames(getFormMap(UserFormMap.class));
        LayoutFormMap tlayoutFormMap = getFormMap(LayoutFormMap.class);
        tlayoutFormMap.set("deleted_mark", EmDeletedMark.VALID.getCode());
        List<LayoutFormMap> layoutFormMaps = layoutMapper.findByNames(tlayoutFormMap);
        VisualConfigFormMap visualConfigFormMap = getFormMap(VisualConfigFormMap.class);
        visualConfigFormMap.set("deleted_mark", EmDeletedMark.VALID.getCode());
        List<VisualConfigFormMap> visualConfigFormMaps = visualConfigMapper.findByNames(visualConfigFormMap);
        model.addAttribute("users",userFormMaps);
        model.addAttribute("vis",visualConfigFormMaps);
        model.addAttribute("layouts",layoutFormMaps);
        return Common.BACKGROUND_PATH + "/app/applicationtemplatemanage/decisionuicreate";
    }
    @RequestMapping("/{configid}/showdecisionui")
    public String showdecisionui(@PathVariable String configid, Model model) throws Exception{
//        model.addAttribute("configid",configid);
//        VisualConfigFormMap tvisualConfigFormMap = new VisualConfigFormMap();
//        tvisualConfigFormMap.put("id",configid);
//        List<VisualConfigFormMap> visualConfigFormMaps = visualConfigMapper.findByNames(tvisualConfigFormMap);
//        VisualConfigFormMap visualConfigFormMap = visualConfigFormMaps.get(0);
//
//        model.addAttribute("info",visualConfigFormMap.get("info"));
//
//        VisualMethodFormMap tvisualMethodFormMap = new VisualMethodFormMap();
//        tvisualMethodFormMap.put("id",visualConfigFormMap.get("methodid"));
//        List<VisualMethodFormMap> visualMethodFormMaps = visualMethodMapper.findByNames(tvisualMethodFormMap);
//        VisualMethodFormMap visualMethodFormMap = visualMethodFormMaps.get(0);
//        model.addAttribute("js",visualMethodFormMap.get("js"));
//
//        VisualTypeFormMap tvisualTypeFormMap = new VisualTypeFormMap();
//        tvisualTypeFormMap.put("id",visualConfigFormMap.get("typeid"));
//        List<VisualTypeFormMap> visualTypeFormMaps = visualTypeMapper.findByNames(tvisualTypeFormMap);
//        model.addAttribute("type", visualTypeFormMaps.get(0).get("name"));
        DecisionUiFormMap tdecisionUiFormMap = getFormMap(DecisionUiFormMap.class);
        tdecisionUiFormMap.set("id", configid);
        DecisionUiFormMap decisionUiFormMap = decisionUiMapper.findByNames(tdecisionUiFormMap).get(0);
        String config = decisionUiFormMap.getStr("config");
        String name = decisionUiFormMap.getStr("name");
        String info = decisionUiFormMap.getStr("info");
        int layoutid = decisionUiFormMap.getInt("layoutid");
        LayoutFormMap tlayoutFormMap = getFormMap(LayoutFormMap.class);
        tlayoutFormMap.set("id",layoutid);
        LayoutFormMap layoutFormMap = layoutMapper.findByNames(tlayoutFormMap).get(0);
        String js= layoutFormMap.getStr("js");
        List<String> vis = new ArrayList<>();
        String[] cons = config.split(";");
        for(String con:cons){
            vis.add(con.split(":")[1]);
        }
        model.addAttribute("count",cons.length);
        model.addAttribute("con",vis);
        model.addAttribute("name",name);
        model.addAttribute("info",info);
        model.addAttribute("js",js);
        return Common.BACKGROUND_PATH + "/app/applicationtemplatemanage/decisionuishow";
    }
    @ResponseBody
    @RequestMapping("/savedecisionui")
    @Transactional(readOnly = false)
    @SystemLog(module = "资源管理", methods = "新增决策可视化界面")
    public String savedecisionui(HttpServletRequest request, Model model){
        try {
            Date now = new Date();
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
            DecisionUiFormMap decisionUiFormMap = getFormMap(DecisionUiFormMap.class);
            decisionUiFormMap.set("deleted_mark", EmDeletedMark.VALID.getCode());
            decisionUiFormMap.set("meta_created", simpleDateFormat.format(now));
            decisionUiFormMap.set("meta_updated", simpleDateFormat.format(now));

            int count = Integer.valueOf(request.getParameter("count"));
            String config = "";
            for(int i = 1 ;i <= count; i++){
                config += String.valueOf(i)+":"+request.getParameter("co"+String.valueOf(i))+";";
            }

            decisionUiFormMap.put("config", config);
            decisionUiMapper.addEntity(decisionUiFormMap);
            List<DecisionUiFormMap> ans = decisionUiMapper.findByNames(decisionUiFormMap);
            String mid = ans.get(0).get("id").toString();
            ResFormMap resFormMap = new ResFormMap();
            resFormMap.set("name",request.getParameter("decisionUiFormMap.name"));
            resFormMap.set("parentId","1000");
            resFormMap.set("resKey","decisionui_"+mid);
            resFormMap.set("type","1");
            resFormMap.set("ishide","1");
            resFormMap.set("resUrl","/visual/"+mid+"/showdecisionui.shtml");
            resFormMap.set("description",request.getParameter("decisionUiFormMap.info"));
            resourcesMapper.addEntity(resFormMap);
            List<ResFormMap> ans1 = resourcesMapper.findByNames(resFormMap);
            String rid = ans1.get(0).get("id").toString();
            ResUserFormMap resUserFormMap = new ResUserFormMap();
            resUserFormMap.put("resId", rid);
            resUserFormMap.put("userId", request.getParameter("decisionUiFormMap.userid"));
            resourcesMapper.addEntity(resUserFormMap);
            return mid;

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
                        String sql = "select "+meta+" from  `"+name+"`";
                        ResultSet result = stmt.executeQuery(sql);
                        while (result.next()) {
                            value.add(String.valueOf(result.getObject(meta)));

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


    @RequestMapping("/{id}/showdecisionbank")
    public String showdecisionbank(@PathVariable int id,Model model,HttpServletRequest request) throws Exception{
        if(id==1) {
            Session session = SecurityUtils.getSubject().getSession();
            NavFormMap tnavFormMap = new NavFormMap();
            //System.out.println(accountName);
            //System.out.println(request.getParameter("layerType"));
            String tableID = request.getParameter("tableName");
            String parameter = request.getParameter("layerType");
            int layerType = 0;
            tableID = "24";
            String tableName = null;
            DatasetFormMap tdatasetFormMap = new DatasetFormMap();
            tdatasetFormMap.set("id",tableID);
            tdatasetFormMap.put("deleted_mark", 1);
            List<DatasetFormMap> datasetFormMaps = datasetMapper.findByNames(tdatasetFormMap);
            DatasetFormMap datasetFormMap = datasetFormMaps.get(0);
            String[] temda  = datasetFormMap.getStr("dataset_url").split("/");
            String databaseName = temda[temda.length - 1];
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
            model.addAttribute("accountName", session.getAttribute("userSessionId"));
            model.addAttribute("tableList", tableList);
            model.addAttribute("tableNameList", tableNameListBD);
            return Common.BACKGROUND_PATH + "/app/decisionui/showdecisionbank";
        }
        return null;
    }

}
