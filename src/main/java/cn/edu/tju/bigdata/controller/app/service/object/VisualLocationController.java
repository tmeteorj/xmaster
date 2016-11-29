package cn.edu.tju.bigdata.controller.app.service.object;

import cn.edu.tju.bigdata.annotation.SystemLog;
import cn.edu.tju.bigdata.biz.location.LocatBiz;
import cn.edu.tju.bigdata.controller.index.BaseController;
import cn.edu.tju.bigdata.entity.Table;
import cn.edu.tju.bigdata.entity.siteselection.LocationAtm;
import cn.edu.tju.bigdata.entity.siteselection.LocationScore;
import cn.edu.tju.bigdata.entity.siteselection.LocationRelitu;
import cn.edu.tju.bigdata.enums.EmDeletedMark;
import cn.edu.tju.bigdata.mapper.DatasetMapper;
import cn.edu.tju.bigdata.mapper.LocationMapper;
import cn.edu.tju.bigdata.mapper.PlaneMapper;
import cn.edu.tju.bigdata.mapper.TableMapper;
import cn.edu.tju.bigdata.plugin.PageView;
import cn.edu.tju.bigdata.util.Common;
import com.alibaba.fastjson.JSONObject;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

/**
 * Created by Administrator on 2016/9/28.
 */
@Controller
@RequestMapping("/visualuicreate")
public class VisualLocationController extends BaseController {
    private static final String LY = "ly_";
    private static final String BD = "bd_";
    String columnName;
    @Value("${metadata.database:xmaster}")
    private String databaseName;
    @Autowired
    private TableMapper tableMapper;
    @Autowired
    DatasetMapper datasetMapper;
    @Autowired
    LocationMapper planeMapper;
    @Value("#{'${metadata.database}'.split(',')}")
    private List<String> databaseNameList;

    @ResponseBody
    @RequestMapping("/showtables")
    public PageView findByPage(String pageNow, String pageSize) {
        LocationScore datasetFormMap = getFormMap(LocationScore.class);
        datasetFormMap = toFormMap(datasetFormMap, pageNow, pageSize, datasetFormMap.getStr("orderby"));
        datasetFormMap.set("deleted_mark", EmDeletedMark.VALID.getCode());
        pageView.setRecords(datasetMapper.findByPage(datasetFormMap));
        return pageView;
    }

    @ResponseBody
    @RequestMapping("/datarelitu")
    public JSONObject searchByYMA(){
        LocationRelitu planeFormMap=getFormMap(LocationRelitu.class);
        List<LocationRelitu> list=planeMapper.selectAll(planeFormMap);
        String attr="Relitu";
        JSONObject result=LocatBiz.searchByYMA(list,attr);
        return result;
    }

    @ResponseBody
    @RequestMapping("/showatm")
    public PageView findByPage1(String pageNow, String pageSize) {
        LocationAtm datasetFormMap = getFormMap(LocationAtm.class);
        datasetFormMap = toFormMap(datasetFormMap, pageNow, pageSize, datasetFormMap.getStr("orderby"));
        datasetFormMap.set("deleted_mark", EmDeletedMark.VALID.getCode());
        pageView.setRecords(datasetMapper.findByPage(datasetFormMap));
        return pageView;
    }


    @RequestMapping("/locationuicreate")
    public String mapplaneuicreate(Model model) {

        return Common.BACKGROUND_PATH + "/app/visualuicreate/locationuicreate";
    }

    @RequestMapping("/locationatm")
    public String locationatm(Model model) {

        return Common.BACKGROUND_PATH + "/app/visualuicreate/locationatm";
    }

    @RequestMapping("/atmbusiness")
    public String atmbusiness(Model model) {

        return Common.BACKGROUND_PATH + "/app/visualuicreate/atmbusiness";
    }

    @RequestMapping("/pinglv")
    public String pinglv(Model model) {

        return Common.BACKGROUND_PATH + "/app/visualuicreate/pinglv";
    }

    @RequestMapping("/chengben")
    public String chengben(Model model) {

        return Common.BACKGROUND_PATH + "/app/visualuicreate/chengben";
    }

    @RequestMapping("/zijin")
    public String zijin(Model model) {

        return Common.BACKGROUND_PATH + "/app/visualuicreate/zijin";
    }

    @RequestMapping("/jigoufenxi")
    public String jigoufenxi(Model model) {

        return Common.BACKGROUND_PATH + "/app/visualuicreate/jigoufenxi";
    }

    @RequestMapping("/application")
    public String locationApplication(Model model) {
        List<Table> tableList = tableMapper.selectTableByName("bd_location_branch", "xmaster");
        model.addAttribute("tableName", "bd_plane");
        model.addAttribute("accountName", "lx1");
        model.addAttribute("tableList", tableList);
        return Common.BACKGROUND_PATH + "/app/visualuicreate/locationsearch";
    }
    @RequestMapping("/{accountName}/location")
    public String location(@PathVariable String accountName, HttpServletRequest request, Model model) {
        String tableName = request.getParameter("tableName");
        String displayType = request.getParameter("displayType");
        databaseName = request.getParameter("databaseName");
        if (StringUtils.isBlank(tableName))
            tableName = "bd_location_atm_bus";
        if (StringUtils.isBlank(displayType))
            displayType = "1";
        if (StringUtils.isBlank(databaseName))
            databaseName = "xmaster";
        List<Table> tableList = tableMapper.selectTableByName(tableName, databaseName);
        getTableNameList(model);
        for (String key : request.getParameterMap().keySet()) {
            model.addAttribute(key, request.getParameter(key));
        }
        model.addAttribute("tableName", tableName);
        model.addAttribute("accountName", accountName);
        model.addAttribute("tableList", tableList);
        model.addAttribute("displayType", displayType);
        return Common.BACKGROUND_PATH + "/app/visualuicreate/locationFramework";
//        String tableName = request.getParameter("tableName");
//        String displayType = request.getParameter("displayType");
//        if (StringUtils.isBlank(tableName))
//            tableName = "bd_location_atm_bus";
//        if (StringUtils.isBlank(displayType))
//            displayType = "1";
//        List<Table> tableList = tableMapper.selectTableByName(tableName, databaseName);
//        List<HashMap<String, String>> tableNameList = tableMapper.selectTableNameByDatabase(databaseName);
//        List<HashMap<String, String>> tableNameListBD = new ArrayList<HashMap<String, String>>();
//        for (HashMap<String, String> map : tableNameList) {
//            if (map.get("tableName").startsWith(BD)) {
//                if (StringUtils.isBlank(map.get("tableComment"))) {
//                    map.put("tableComment", map.get("tableName"));
//                }
//                tableNameListBD.add(map);
//            }
//        }
//        for (String key : request.getParameterMap().keySet()) {
//            model.addAttribute(key, request.getParameter(key));
//        }
//        model.addAttribute("tableName", tableName);
//        model.addAttribute("accountName", accountName);
//        model.addAttribute("tableList", tableList);
//        model.addAttribute("tableNameList", tableNameListBD);
//        model.addAttribute("displayType", displayType);
////        return Common.BACKGROUND_PATH + "/app/common/infoRetrieval";
//        return Common.BACKGROUND_PATH + "/app/visualuicreate/locationFramework";
    }

    private void getTableNameList(Model model) {
        List<String> excluded = new ArrayList<String>( // 需要排除的表，或者是系统表，或是其他不需要展示的表
                Arrays.asList("bd_city", "bd_dataset", "bd_decisionui", "bd_district", "bd_layout", "bd_location"
                        , "bd_metadata", "bd_operator", "bd_operatorconfig", "bd_operatorinput", "bd_operatoroutput"
                        , "bd_province", "bd_visualconfig", "bd_visualmethod", "bd_visualparameter", "bd_visualtype"
                        , "bd_normal_people_copy")
        );
        List<HashMap<String, String>> tableNameList = new ArrayList<HashMap<String, String>>();
        for (String dbName : databaseNameList) {
            List<HashMap<String, String>> tableNameListTmp = tableMapper.selectTableNameByDatabase(dbName);
            tableNameList.addAll(tableNameListTmp);
        }
        List<HashMap<String, String>> tableNameListBD = new ArrayList<HashMap<String, String>>();
        for (HashMap<String, String> map : tableNameList) {
            if (!map.get("tableName").startsWith(LY) && !excluded.contains(map.get("tableName"))) {
                if (StringUtils.isBlank(map.get("tableComment"))) {
                    map.put("tableComment", map.get("tableName"));
                }
                tableNameListBD.add(map);
            }
        }
        model.addAttribute("tableNameList", tableNameListBD);
    }



}
