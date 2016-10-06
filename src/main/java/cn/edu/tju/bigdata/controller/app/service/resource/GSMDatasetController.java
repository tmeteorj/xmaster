package cn.edu.tju.bigdata.controller.app.service.resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

import cn.edu.tju.bigdata.annotation.SystemLog;
import cn.edu.tju.bigdata.controller.index.BaseController;
import cn.edu.tju.bigdata.entity.DatasetFormMap;
import cn.edu.tju.bigdata.entity.GSMDatasetFormMap;
import cn.edu.tju.bigdata.enums.EmDeletedMark;
import cn.edu.tju.bigdata.mapper.DatasetMapper;
import cn.edu.tju.bigdata.mapper.GSMDatasetMapper;
import cn.edu.tju.bigdata.plugin.PageView;
import cn.edu.tju.bigdata.util.Common;

/**
 * Created by NING on 2016/9/28.
 */
@Controller
@RequestMapping("/gsmdataset")
public class GSMDatasetController extends BaseController {

    @Autowired
    private GSMDatasetMapper gsmDatasetMapper;

    @RequestMapping("/list")
    public String manage(Model model) throws Exception {
        model.addAttribute("res", findByRes());
        return Common.BACKGROUND_PATH + "/app/gsm/gsmdatasetlist";
    }

    @ResponseBody
    @RequestMapping("/findByPage")
    public PageView findByPage(String pageNow, String pageSize) {
        GSMDatasetFormMap gsmDatasetFormMap = getFormMap(GSMDatasetFormMap.class);
        gsmDatasetFormMap = toFormMap(gsmDatasetFormMap, pageNow, pageSize, gsmDatasetFormMap.getStr("orderby"));
        gsmDatasetFormMap.set("deleted_mark", EmDeletedMark.VALID.getCode());
        pageView.setRecords(gsmDatasetMapper.findByPage(gsmDatasetFormMap));
        return pageView;
    }

//    @RequestMapping("/upload")
//    public String upload(Model model) throws Exception {
//        return Common.BACKGROUND_PATH + "/app/resourcemanage/datasetedit";
//    }

    @ResponseBody
    @RequestMapping("/{id}/delete")
    @Transactional(readOnly = false)
    @SystemLog(module = "资源管理", methods = "删除数据集")
    public String delete(@PathVariable Long id) throws Exception {
        GSMDatasetFormMap gsmDatasetFormMap = new GSMDatasetFormMap();
        gsmDatasetFormMap.set("id", id);
        gsmDatasetFormMap.set("deleted_mark", EmDeletedMark.INVALID.getCode());
        gsmDatasetMapper.editEntity(gsmDatasetFormMap);
        return "success";
    }

    @RequestMapping("/{id}/edit")
    public String edit(@PathVariable Long id, Model model) throws Exception {
        model.addAttribute("gsmdataset", gsmDatasetMapper.findbyFrist("id", id.toString(), GSMDatasetFormMap.class));
        return Common.BACKGROUND_PATH + "/app/gsm/gsmdatasetedit";
    }

    @RequestMapping("/add")
    public String add(Model model) throws Exception {
        return Common.BACKGROUND_PATH + "/app/gsm/gsmdatasetedit";
    }


    @RequestMapping("/{id}/audit")
    public String audit(@PathVariable Long id, Model model) throws Exception {
        model.addAttribute("gsmdataset", gsmDatasetMapper.findbyFrist("id", id.toString(), DatasetFormMap.class));
        return Common.BACKGROUND_PATH + "/app/gsm/audit";
    }

    @ResponseBody
    @RequestMapping("/{id}/check")
    public Boolean check(@PathVariable Long id, Model model) throws Exception {
        GSMDatasetFormMap gsmDatasetFormMap = gsmDatasetMapper.findbyFrist("id", id.toString(), GSMDatasetFormMap.class);
        if (gsmDatasetFormMap != null && gsmDatasetFormMap.getInt("deleted_mark") == EmDeletedMark.TO_BE_AUDITED.getCode())
            return Boolean.TRUE;
        return Boolean.FALSE;
    }

    @ResponseBody
    @RequestMapping("/save")
    @Transactional(readOnly = false)
    @SystemLog(module = "资源管理", methods = "新增/修改数据集")
    public String save() throws Exception {
        Date now = new Date();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        GSMDatasetFormMap gsmDatasetFormMap = getFormMap(GSMDatasetFormMap.class);
        if (gsmDatasetFormMap.get("id") == null){ // save
            gsmDatasetFormMap.set("deleted_mark", EmDeletedMark.VALID.getCode());
            gsmDatasetFormMap.set("meta_created", simpleDateFormat.format(now));
            gsmDatasetFormMap.set("meta_updated", simpleDateFormat.format(now));
            gsmDatasetMapper.addEntity(gsmDatasetFormMap);
        } else { // update
            gsmDatasetFormMap.set("meta_updated", simpleDateFormat.format(now));
            gsmDatasetMapper.editEntity(gsmDatasetFormMap);
        }
        return "success";
    }
}
