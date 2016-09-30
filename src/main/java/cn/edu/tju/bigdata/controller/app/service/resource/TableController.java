package cn.edu.tju.bigdata.controller.app.service.resource;

import cn.edu.tju.bigdata.annotation.SystemLog;
import cn.edu.tju.bigdata.controller.index.BaseController;
import cn.edu.tju.bigdata.entity.Table;
import cn.edu.tju.bigdata.enums.EmDeletedMark;
import cn.edu.tju.bigdata.mapper.TableMapper;
import cn.edu.tju.bigdata.plugin.PagePlugin;
import cn.edu.tju.bigdata.plugin.PageView;
import cn.edu.tju.bigdata.util.Common;
import cn.edu.tju.bigdata.util.FormMap;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by Administrator on 2016/9/29.
 */
@Controller
@RequestMapping("/table")
public class TableController extends BaseController {

    @Value("${metadata.database:xmaster}")
    private String databaseName;

    @Value("${metadata.search}")
    private String searchJson;

    private Map<String, List<String>> searchMap;

    @PostConstruct
    private void init(){
        searchMap = JSON.parseObject(searchJson, new TypeReference<Map<String, List<String>>>(){});
    }

    @Autowired
    private TableMapper tableMapper;

    @RequestMapping("/{tableName}/list")
    public String list(@PathVariable String tableName, Model model) {
        model.addAttribute("res", findByRes());
        List<Table> tableList = tableMapper.selectTableByName(tableName, databaseName);
        model.addAttribute("tableName", tableName);
        model.addAttribute("tableList", tableList);
        List<String> searchColumns = searchMap.get(tableName);
        if (searchColumns == null){
            searchColumns = new ArrayList<String>();
            searchColumns.add("id");
        }
        List<Table> searchList = new ArrayList<Table>();
        for (Table table : tableList) {
            String column = table.getColumnName();
            if (searchColumns.contains(column))
                searchList.add(table);
        }
        model.addAttribute("searchList", searchList);
        return Common.BACKGROUND_PATH + "/app/resourceupload/tabledataupload";
    }

    @ResponseBody
    @RequestMapping("/{tableName}/{id}/delete")
    @Transactional(readOnly = false)
    @SystemLog(module = "资源管理", methods = "删除")
    public String delete(@PathVariable String tableName, @PathVariable Long id) throws Exception {
        String set = String.format("deleted_mark = %d", EmDeletedMark.INVALID.getCode());
        tableMapper.updateEntryById(databaseName, tableName, set, id);
        return "success";
    }

    @RequestMapping("/{tableName}/{id}/edit")
    public String edit(@PathVariable String tableName, @PathVariable Long id, Model model) throws Exception {
        List<Table> tableList = tableMapper.selectTableByName(tableName, databaseName);
        model.addAttribute("tableList", tableList);
        model.addAttribute("tableName", tableName);
        model.addAttribute("tabledata", tableMapper.selectDataById(databaseName, tableName, id));
        return Common.BACKGROUND_PATH + "/app/resourcemanage/tabledatamanage";
    }

    @RequestMapping("/{tableName}/add")
    public String add(@PathVariable String tableName, Model model) throws Exception {
        List<Table> tableList = tableMapper.selectTableByName(tableName, databaseName);
        model.addAttribute("tableList", tableList);
        model.addAttribute("tableName", tableName);
        return Common.BACKGROUND_PATH + "/app/resourcemanage/tabledatamanage";
    }


    @RequestMapping("/{tableName}/{id}/audit")
    public String audit(@PathVariable String tableName, @PathVariable Long id, Model model) throws Exception {
        List<Table> tableList = tableMapper.selectTableByName(tableName, databaseName);
        model.addAttribute("tableList", tableList);
        model.addAttribute("tableName", tableName);
        model.addAttribute("tabledata", tableMapper.selectDataById(databaseName, tableName, id));
        return Common.BACKGROUND_PATH + "/app/resourceupload/tabledataaudit";
    }

    @ResponseBody
    @RequestMapping("/{tableName}/{id}/check")
    public Boolean check(@PathVariable String tableName, @PathVariable Long id, Model model) throws Exception {
        FormMap formMap = tableMapper.selectDataById(databaseName, tableName, id);
        if (formMap != null && formMap.getInt("deleted_mark") == EmDeletedMark.TO_BE_AUDITED.getCode())
            return Boolean.TRUE;
        return Boolean.FALSE;
    }

    @ResponseBody
    @RequestMapping("/{tableName}/save")
    @Transactional(readOnly = false)
    @SystemLog(module = "资源管理", methods = "新增/修改")
    public String save(@PathVariable String tableName) throws Exception {
        Date now = new Date();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        FormMap<String, Object> formMap = getFormMap(tableName);
        List<Table> tableList = tableMapper.selectTableByName(tableName, databaseName);
        if (formMap.get("id") == null){ // save
            formMap.set("deleted_mark", EmDeletedMark.TO_BE_AUDITED.getCode());
            formMap.set("meta_created", simpleDateFormat.format(now));
            formMap.set("meta_updated", simpleDateFormat.format(now));
            StringBuilder columns = new StringBuilder();
            StringBuilder values = new StringBuilder();
            boolean first = true;
            for (Table table : tableList) {
                String columnName = table.getColumnName();
                if (columnName.equalsIgnoreCase("id"))
                    continue;
                if (formMap.containsKey(columnName)){
                    String val = formMap.get(columnName).toString();
                    if (first)
                        first = false;
                    else {
                        columns
                                .append(" , ");
                        values
                                .append(" , ");
                    }
                    columns.append(columnName);
                    switch (table.getDataType()) {
                        case "int":
                        case "bigint":
                            values
                                    .append(val);
                            break;
                        case "timestamp":
                        case "datetime":
                        default:
                            values
                                    .append("'")
                                    .append(val)
                                    .append("'")
                            ;
                    }
                }
            }
            tableMapper.insertEntity(databaseName, tableName, columns.toString(), values.toString());
        } else { // update
            formMap.set("meta_updated", simpleDateFormat.format(now));
            StringBuilder stringBuilder = new StringBuilder();
            boolean first = true;
            for (Table table : tableList) {
                String columnName = table.getColumnName();
                if (columnName.equalsIgnoreCase("id"))
                    continue;
                if (formMap.containsKey(columnName)){
                    String val = formMap.get(columnName).toString();
                    if (first)
                        first = false;
                    else
                        stringBuilder
                                .append(" , ");
                    stringBuilder
                            .append(columnName)
                            .append(" = ");
                    switch (table.getDataType()) {
                        case "int":
                        case "bigint":
                            stringBuilder
                                    .append(val);
                            break;
                        case "timestamp":
                        case "datetime":
                        default:
                            stringBuilder
                                    .append("'")
                                    .append(val)
                                    .append("'")
                            ;
                    }
                }
            }
            String set = stringBuilder.toString();
            tableMapper.updateEntryById(databaseName, tableName, set, Long.parseLong(formMap.get("id").toString()));
        }
        return "success";
    }

    @ResponseBody
    @RequestMapping("/{tableName}/findByPage")
    public PageView findByPage(@PathVariable String tableName, String pageNow, String pageSize) {
        // 获得传参，即where子句的参数
        FormMap<String, Object> formMap = getFormMap(tableName);
        formMap.set("deleted_mark", EmDeletedMark.VALID.getCode());
        formMap.put("paging", getPageView(pageNow, pageSize, formMap.getStr("orderby")));

        // 拼接sql语句
        List<Table> tableList = tableMapper.selectTableByName(tableName, databaseName);
        List<String> columnList = new ArrayList<String>();
        for (Table table : tableList) {
            columnList.add(table.getColumnName());
        }
        String columns = StringUtils.join(columnList, ", ");
        StringBuilder stringBuilder = new StringBuilder("1");
        for (Table table : tableList) {
            String columnName = table.getColumnName();
            if (formMap.containsKey(columnName)){
                String val = formMap.get(columnName).toString();
                switch (table.getDataType()) {
                    case "int":
                    case "bigint":
                        stringBuilder
                                .append(" and ")
                                .append(columnName)
                                .append(" = ")
                                .append(val);
                        break;
                    case "timestamp":
                    case "datetime":
                        stringBuilder
                                .append(" and ")
                                .append(columnName)
                                .append(" = ")
                                .append(val);
                        break;
                    default:
                        stringBuilder
                                .append(" and ")
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

        // 数据总条数
        Long rowCount = tableMapper.selectCountFromTable(databaseName, tableName, where);
        pageView.setRowCount(rowCount);

        // 该页内的数据
        where = PagePlugin.generatePagesSql(where, pageView);
        List<FormMap> dataList = tableMapper.selectDataFromTable(databaseName, tableName, columns, where);
        pageView.setRecords(dataList);
        return pageView;
    }

    private FormMap<String, Object> getFormMap(String tableName) {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        Enumeration<String> en = request.getParameterNames();
        FormMap<String, Object> map = new FormMap<String, Object>();
        try {
            String order = "", sort = "";
            while (en.hasMoreElements()) {
                String nms = en.nextElement().toString();
                if (nms.endsWith("[]")) {
                    String[] as = request.getParameterValues(nms);
                    if (as != null && as.length != 0 && as.toString() != "[]") {
                        String mname = tableName.toUpperCase();
                        if (nms.toUpperCase().startsWith(mname)) {
                            nms = nms.substring(nms.toUpperCase().indexOf(mname) + 1);
                            map.put(nms, as);
                        }
                    }
                } else {
                    String as = request.getParameter(nms);
                    if (!Common.isEmpty(as)) {
                        String mname = tableName.toUpperCase();
                        if (nms.toUpperCase().startsWith(mname)) {
                            nms = nms.substring(mname.length() + 1);
                            map.put(nms, as);
                        }
                        if (nms.toLowerCase().equals("column")) order = as;
                        if (nms.toLowerCase().equals("sort")) sort = as;
                    }
                }
            }
            if (!Common.isEmpty(order) && !Common.isEmpty(sort))
                map.put("orderby", " order by " + order + " " + sort);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }
}
