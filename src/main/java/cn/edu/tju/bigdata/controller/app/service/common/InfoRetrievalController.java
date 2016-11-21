package cn.edu.tju.bigdata.controller.app.service.common;

import cn.edu.tju.bigdata.controller.index.BaseController;
import cn.edu.tju.bigdata.entity.Table;
import cn.edu.tju.bigdata.mapper.TableMapper;
import cn.edu.tju.bigdata.plugin.PagePlugin;
import cn.edu.tju.bigdata.plugin.PageView;
import cn.edu.tju.bigdata.util.Common;
import cn.edu.tju.bigdata.util.FormMap;
import org.apache.commons.lang.StringUtils;
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
import java.util.HashMap;
import java.util.List;

/**
 * Created by Ethan on 2016/10/7.
 */
@Controller
@RequestMapping("/common")
public class InfoRetrievalController extends BaseController {

    private static final String BD = "bd_";
    @Value("${metadata.database:xmaster}")
    private String databaseName;

    @Autowired
    private TableMapper tableMapper;

    @RequestMapping("/{accountName}/infoRetrieval")
    public String infoRetrieval(@PathVariable String accountName, HttpServletRequest request, Model model) {
        String tableName = request.getParameter("tableName");
        String parameter = request.getParameter("layerType");
        int layerType = 0;
        if (StringUtils.isBlank(tableName))
            tableName = "bd_meetup";
        if (StringUtils.isNotBlank(parameter)) {
            layerType = Integer.parseInt(parameter);
        }
//        List<FormMap> tableNameListLayer = tableMapper.selectDataFromTable(databaseName, "")
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
//        return Common.BACKGROUND_PATH + "/app/common/infoRetrieval";
        return Common.BACKGROUND_PATH + "/app/common/infoRetrievalFramework";
    }

    @ResponseBody
    @RequestMapping("/{tableName}/{id}/detail")
    public FormMap getDetailById(@PathVariable String tableName, @PathVariable Long id) {
        if (!tableName.startsWith(BD)) {
            tableName = BD + tableName;
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

    @RequestMapping("/advancedConfig")
    public String advancedConfig() {
        return Common.BACKGROUND_PATH + "/app/common/advancedConfig";
    }

    @ResponseBody
    @RequestMapping("/{tableName}/findByPage/{deletedMark}")
    public PageView findByPage(@PathVariable String tableName, @PathVariable Integer deletedMark, String pageNow, String pageSize) {
        if (!tableName.startsWith(BD)) {
            tableName = BD + tableName;
        }
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