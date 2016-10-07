package cn.edu.tju.bigdata.controller.app.service.resource;

import cn.edu.tju.bigdata.annotation.SystemLog;
import cn.edu.tju.bigdata.controller.index.BaseController;
import cn.edu.tju.bigdata.entity.DatasetFormMap;
import cn.edu.tju.bigdata.entity.MetadataFormMap;
import cn.edu.tju.bigdata.enums.EmDeletedMark;
import cn.edu.tju.bigdata.mapper.DatasetMapper;
import cn.edu.tju.bigdata.mapper.MetadataMapper;
import cn.edu.tju.bigdata.plugin.PageView;
import cn.edu.tju.bigdata.util.Common;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by NING on 2016/9/28.
 */
@Controller
@RequestMapping("/dataset")
public class DatasetController extends BaseController {

    @Autowired
    DatasetMapper datasetMapper;

    @Autowired
    MetadataMapper metadataMapper;
    @RequestMapping("/list")
    public String manage(Model model) throws Exception {
        model.addAttribute("res", findByRes());
        return Common.BACKGROUND_PATH + "/app/resourcemanage/datasetmanage";
    }

    @ResponseBody
    @RequestMapping("/findByPage")
    public PageView findByPage(String pageNow, String pageSize) {
        DatasetFormMap datasetFormMap = getFormMap(DatasetFormMap.class);
        datasetFormMap = toFormMap(datasetFormMap, pageNow, pageSize, datasetFormMap.getStr("orderby"));
        datasetFormMap.set("deleted_mark", EmDeletedMark.VALID.getCode());
        pageView.setRecords(datasetMapper.findByPage(datasetFormMap));
        return pageView;
    }

    @RequestMapping("/upload")
    public String upload(Model model) throws Exception {
        return Common.BACKGROUND_PATH + "/app/resourcemanage/datasetedit";
    }

    @ResponseBody
    @RequestMapping("/{id}/delete")
    @Transactional(readOnly = false)
    @SystemLog(module = "资源管理", methods = "删除数据集")
    public String delete(@PathVariable Long id) throws Exception {
        DatasetFormMap datasetFormMap = new DatasetFormMap();
        datasetFormMap.set("id", id);
        datasetFormMap.set("deleted_mark", EmDeletedMark.INVALID.getCode());
        datasetMapper.editEntity(datasetFormMap);
        return "success";
    }

    @RequestMapping("/{id}/edit")
    public String edit(@PathVariable Long id, Model model) throws Exception {
        model.addAttribute("dataset", datasetMapper.findbyFrist("id", id.toString(), DatasetFormMap.class));
        return Common.BACKGROUND_PATH + "/app/resourcemanage/datasetedit";
    }

    @RequestMapping("/add")
    public String add(Model model) throws Exception {
        return Common.BACKGROUND_PATH + "/app/resourcemanage/datasetedit";
    }


    @RequestMapping("/{id}/audit")
    public String audit(@PathVariable Long id, Model model) throws Exception {
        model.addAttribute("dataset", datasetMapper.findbyFrist("id", id.toString(), DatasetFormMap.class));
        return Common.BACKGROUND_PATH + "/app/resourcemanage/audit";
    }

    @ResponseBody
    @RequestMapping("/{id}/check")
    public Boolean check(@PathVariable Long id, Model model) throws Exception {
        DatasetFormMap datasetFormMap = datasetMapper.findbyFrist("id", id.toString(), DatasetFormMap.class);
        if (datasetFormMap != null && datasetFormMap.getInt("deleted_mark") == EmDeletedMark.TO_BE_AUDITED.getCode())
            return Boolean.TRUE;
        return Boolean.FALSE;
    }

    @ResponseBody
    @RequestMapping("/{id}/link")
    public String link(@PathVariable Long id) throws Exception {
        DatasetFormMap datasetFormMap = datasetMapper.findbyFrist("id", id.toString(), DatasetFormMap.class);
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
                    conn = DriverManager.getConnection(url+"?useUnicode=true&characterEncoding="+coded_format, username, psw);
                    if(!conn.isClosed()){
                        return "success";
                    }
                    else{
                        return "failed";
                    }
                } catch (ClassNotFoundException e) {
                    return "failed";
                } catch(SQLException e) {
                    return "failed";
                } catch(Exception e) {
                    return "failed";
                }
                finally {
                    conn.close();
                }
            }
            return "failed";

        }
        catch (Exception e){
            return "failed";
        }
    }

    @ResponseBody
    @RequestMapping("/save")
    @Transactional(readOnly = false)
    @SystemLog(module = "资源管理", methods = "新增/修改数据集")
    public String save() throws Exception {
        Date now = new Date();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        DatasetFormMap datasetFormMap = getFormMap(DatasetFormMap.class);
        if (datasetFormMap.get("id") == null){ // save
            datasetFormMap.set("deleted_mark", EmDeletedMark.VALID.getCode());
            datasetFormMap.set("meta_created", simpleDateFormat.format(now));
            datasetFormMap.set("meta_updated", simpleDateFormat.format(now));
            datasetMapper.addEntity(datasetFormMap);
        } else { // update
            datasetFormMap.set("meta_updated", simpleDateFormat.format(now));
            datasetMapper.editEntity(datasetFormMap);
        }
        return "success";
    }

    @ResponseBody
    @RequestMapping("/{id}/createmetadata")
    @Transactional(readOnly = false)
    @SystemLog(module = "资源管理", methods = "新增/修改元数据")
    public String addmetadata(@PathVariable Long id) throws Exception {
        DatasetFormMap datasetFormMap = datasetMapper.findbyFrist("id", id.toString(), DatasetFormMap.class);
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
                    conn = DriverManager.getConnection(url+"?useUnicode=true&characterEncoding="+coded_format, username, psw);
                    if(!conn.isClosed()){
                        Statement stmt = conn.createStatement();
                        String sql = "show full columns from  "+name;
                        ResultSet result = stmt.executeQuery(sql);
                        List<MetadataFormMap> metadataFormMaps = new ArrayList<>();
                        while (result.next()) {
                            Date now = new Date();
                            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
                            MetadataFormMap metadataFormMap = new MetadataFormMap();
                            metadataFormMap.put("datasetid", id.toString());
                            metadataFormMap.put("meta", result.getString("Field"));
                            metadataFormMap.put("type", result.getString("Type"));
                            metadataFormMap.put("isnull", result.getString("Null"));
                            metadataFormMap.put("remark", result.getString("Comment"));
                            metadataFormMap.put("deleted_mark", EmDeletedMark.VALID.getCode());
                            metadataFormMap.put("meta_created", simpleDateFormat.format(now));
                            metadataFormMap.put("meta_updated", simpleDateFormat.format(now));
                            metadataFormMaps.add(metadataFormMap);
                        }
                        MetadataFormMap deleFormMap = new MetadataFormMap();
                        deleFormMap.set("datasetid", id.toString());
                        metadataMapper.deleteByNames(deleFormMap);
                        metadataMapper.batchSave(metadataFormMaps);
                        return "success";
                    }
                    else{
                        return "failed";
                    }
                } catch (ClassNotFoundException e) {
                    return "failed";
                } catch(SQLException e) {
                    return "failed";
                } catch(Exception e) {
                    return "failed";
                }
                finally {
                    conn.close();
                }
            }
            return "failed";

        }
        catch (Exception e){
            return "failed";
        }

    }
    @RequestMapping("/{id}/view")
     public String view(@PathVariable Long id, Model model) throws Exception {
        MetadataFormMap mf = new MetadataFormMap();
        mf.put("datasetid",id);
        mf.put("deleted_mark",1);
        List<MetadataFormMap> lsm = metadataMapper.findByNames(mf);
        List<String> ls = new ArrayList<>();
        List<String> lsmeta = new ArrayList<>();
        for(MetadataFormMap me : lsm){
            String name1 = me.getStr("remark").trim();
            if(!name1.equals("")){
                ls.add(name1);
            }
            else {
                ls.add(me.getStr("meta"));
            }
            lsmeta.add(me.getStr("meta"));
        }
        model.addAttribute("meta",ls);
        List<List<String>> as = new ArrayList<>();
        DatasetFormMap datasetFormMap = datasetMapper.findbyFrist("id", id.toString(), DatasetFormMap.class);
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
                    conn = DriverManager.getConnection(url+"?useUnicode=true&characterEncoding="+coded_format, username, psw);
                    if(!conn.isClosed()){
                        Statement stmt = conn.createStatement();
                        String sql = "SELECT ";
                        for(String st:lsmeta){
                            sql += st;
                            sql += ",";
                        }
                        sql = sql.substring(0,sql.length()-1);
                        sql += " FROM "+ name +" LIMIT 20";
                        ResultSet result = stmt.executeQuery(sql);
                        while (result.next()) {
                            List<String> a = new ArrayList<>();
                            for(String st:lsmeta){
                                a.add(result.getString(st).substring(0,5));
                            }
                            as.add(a);
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

        model.addAttribute("data",as);
        return Common.BACKGROUND_PATH + "/app/resourcemanage/datasetview";
    }

}
