package cn.edu.tju.bigdata.controller.app.service.common;

import cn.edu.tju.bigdata.controller.index.BaseController;
import cn.edu.tju.bigdata.entity.*;
import cn.edu.tju.bigdata.entity.networks.Communities;
import cn.edu.tju.bigdata.entity.networks.Things;
import cn.edu.tju.bigdata.enums.EmDeletedMark;
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
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.ujmp.core.graphmatrix.GraphMatrix;
import sun.awt.ModalityListener;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
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
    @RequestMapping("/{accountName}/infoNav")
    public String locationNav(@PathVariable String accountName, HttpServletRequest request,Model model){
        String tableName = request.getParameter("tableName");
        if (StringUtils.isBlank(tableName))
            tableName = "bd_meetup";
        List<Table> tableList = tableMapper.selectTableByName(tableName, databaseName);
        List<HashMap<String, String>> tableNameList = tableMapper.selectTableNameByDatabase(databaseName);
        List<HashMap<String, String>> tableNameListBD = new ArrayList<HashMap<String, String>>();
        for (HashMap<String, String> map : tableNameList) {
            if (map.get("tableName").startsWith(BD)) {
                if (StringUtils.isBlank(map.get("tableComment"))) {
                    map.put("tableComment", map.get("tableName"));
                }
                tableNameListBD.add(map);
            }
        }
        for (String key : request.getParameterMap().keySet()) {
            model.addAttribute(key, request.getParameter(key));
        }
        model.addAttribute("tableName", tableName);
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