package cn.edu.tju.bigdata.controller.app.service.common;

import cn.edu.tju.bigdata.controller.index.BaseController;
import cn.edu.tju.bigdata.entity.Table;
import cn.edu.tju.bigdata.mapper.TableMapper;
import cn.edu.tju.bigdata.plugin.PagePlugin;
import cn.edu.tju.bigdata.plugin.PageView;
import cn.edu.tju.bigdata.util.Common;
import cn.edu.tju.bigdata.util.FormMap;
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
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

/**
 * Created by Ethan on 2016/10/7.
 */
@Controller
@RequestMapping("/common")
public class InfoRetrievalController extends BaseController {

    private static final String LY = "ly_";
    String columnName;
    @Value("#{'${metadata.database}'.split(',')}")
    private List<String> databaseNameList;

    private String databaseName;
    @Autowired
    private TableMapper tableMapper;

    @RequestMapping("/{accountName}/infoRetrieval")
    public String infoRetrieval(@PathVariable String accountName, HttpServletRequest request, Model model) {
        String tableName = request.getParameter("tableName");
        String displayType = request.getParameter("displayType");
        databaseName = request.getParameter("databaseName");
        if (StringUtils.isBlank(tableName))
            tableName = "bd_normal_event";
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
//        return Common.BACKGROUND_PATH + "/app/common/infoRetrieval";
//        Session session = SecurityUtils.getSubject().getSession();
//        if (session.getAttribute("tableName") != null) {
//            if (session.getAttribute("tableName").equals("bd_plane"))
//                return Common.BACKGROUND_PATH + "/app/plane/infoRetrievalPlane";
//            else if (session.getAttribute("tableName").toString().startsWith("bd_location")) {
//                return Common.BACKGROUND_PATH + "/app/visualuicreate/locationFramework";
//            }
//        }
        return Common.BACKGROUND_PATH + "/app/common/infoRetrievalFramework";
    }

    @RequestMapping("/{tableName}/placeStat")
    public String placeStat(@PathVariable String tableName, Model model) {
        model.addAttribute("tableName", tableName);
        return Common.BACKGROUND_PATH + "/app/common/placeStat";
    }

    @RequestMapping("/{tableName}/timeStat")
    public String timeStat(@PathVariable String tableName, HttpServletRequest request, Model model) {
        model.addAttribute("tableName", tableName);
        columnName = request.getParameter("columnName");
        return Common.BACKGROUND_PATH + "/app/common/timeStat";
    }

    @ResponseBody
    @RequestMapping("timeStatData/{tableName}")
    public JSONObject getTimeStatData(@PathVariable String tableName) {
        JSONObject data = new JSONObject();
        String columns = String.format("date_format(%s, '%%Y') as name, count(date_format(%s, '%%Y')) as count", columnName, columnName);
        String where = String.format(" 1 group by date_format(%s, '%%Y')", columnName);
        List<FormMap> formMapList = tableMapper.selectDataFromTable(databaseName, tableName, columns, where);
        List<String> xList = new ArrayList<String>();
        List<Long> yList = new ArrayList<Long>();
        for (FormMap formMap : formMapList) {
            xList.add(formMap.getStr("name"));
            yList.add(formMap.getLong("count"));
        }
        List<String> legend = new ArrayList<String>(Arrays.asList("数量"));
        data.put("xAxis", xList);
        data.put("yAxis", yList);
        data.put("legend", legend);
        return data;
    }

    @ResponseBody
    @RequestMapping("/{tableName}/{id}/detail")
    public FormMap getDetailById(@PathVariable String tableName, @PathVariable Long id) {
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

    @RequestMapping("/{tableName}/advancedConfig")
    public String advancedConfig(@PathVariable String tableName, HttpServletRequest request, Model model) {
        getTableNameList(model);
        if (tableName.equals("bd_plane"))
            return Common.BACKGROUND_PATH + "/app/plane/advancedConfigPlane";
        return Common.BACKGROUND_PATH + "/app/common/advancedConfig";
    }

    @ResponseBody
    @RequestMapping("/configSave")
    public String configSave(HttpServletRequest request, Model model) {
        Session session = SecurityUtils.getSubject().getSession();
        for (String key : request.getParameterMap().keySet()) {
            session.setAttribute(key, request.getParameter(key));
        }
        return "success";
    }

    @ResponseBody
    @RequestMapping("/{tableName}/findByPage/{deletedMark}")
    public PageView findByPage(@PathVariable String tableName, @PathVariable Integer deletedMark, String pageNow, String pageSize) {
        // 获得传参，即where子句的参数
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        String keyword = request.getParameter("keyword");
        getPageView(pageNow, pageSize, "");

        // 拼接sql语句
        List<Table> tableList = tableMapper.selectTableByName(tableName, databaseName);
        List<String> columnList = new ArrayList<String>();
        for (Table table : tableList) {
            columnList.add(table.getColumnName());
        }
        String columns = StringUtils.join(columnList, ", ");
        StringBuilder stringBuilder = new StringBuilder("1");
        if (StringUtils.isNotBlank(keyword)) {
            for (Table table : tableList) {
                String columnName = table.getColumnName();
                String val = keyword;
                switch (table.getDataType()) {
                    case "int":
                    case "bigint":
//                        stringBuilder
//                                .append(" or ")
//                                .append(columnName)
//                                .append(" = ")
//                                .append(val);
                        break;
                    case "timestamp":
                    case "datetime":
//                        stringBuilder
//                                .append(" or ")
//                                .append(columnName)
//                                .append(" = ")
//                                .append(val);
                        break;
                    default:
                        stringBuilder
                                .append(" or ")
                                .append(columnName)
                                .append(" like '%")
                                .append(val)
                                .append("%'")
                        ;
                        break;
                }
            }
        }
        String where = stringBuilder.append(" ").toString();
        if (where.length() > 2) {
            where = where.substring(4);
        }

        // 数据总条数
        Long rowCount = tableMapper.selectCountFromTable(databaseName, tableName, where);
        pageView.setRowCount(rowCount);

        // 该页内的数据
        where = PagePlugin.generatePagesSql(where, pageView);
        List<FormMap> dataList = tableMapper.selectDataFromTable(databaseName, tableName, columns, where);
        pageView.setRecords(dataList);
        return pageView;
    }
}