package cn.edu.tju.bigdata.controller.app.service.resource;

import cn.edu.tju.bigdata.annotation.SystemLog;
import cn.edu.tju.bigdata.controller.index.BaseController;
import cn.edu.tju.bigdata.entity.DatasetFormMap;
import cn.edu.tju.bigdata.entity.MeetupFormMap;
import cn.edu.tju.bigdata.entity.MetadataFormMap;
import cn.edu.tju.bigdata.enums.EmDeletedMark;
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
@RequestMapping("/metadata")
public class MetadataController extends BaseController {

    @Autowired
    MetadataMapper metadataMapper;

    @RequestMapping("/list")
    public String metadatamanage(Model model) throws Exception {
        model.addAttribute("res", findByRes());
        return Common.BACKGROUND_PATH + "/app/resourcemanage/metadatamanage";
    }


    @ResponseBody
    @RequestMapping("/findByPage")
    public PageView findByPage(String pageNow, String pageSize) {
        MetadataFormMap metadataFormMap = getFormMap(MetadataFormMap.class);
        metadataFormMap = toFormMap(metadataFormMap, pageNow, pageSize, metadataFormMap.getStr("orderby"));
        metadataFormMap.set("deleted_mark", EmDeletedMark.VALID.getCode());
        pageView.setRecords(metadataMapper.findByPage(metadataFormMap));
        return pageView;
    }

    @ResponseBody
    @RequestMapping("/{id}/delete")
    @Transactional(readOnly = false)
    @SystemLog(module = "资源管理", methods = "删除元数据")
    public String delete(@PathVariable Long id) throws Exception {
        MetadataFormMap metadataFormMap = new MetadataFormMap();
        metadataFormMap.set("id", id);
        metadataFormMap.set("deleted_mark", EmDeletedMark.INVALID.getCode());
        metadataMapper.editEntity(metadataFormMap);
        return "success";
    }

    @RequestMapping("/{id}/edit")
    public String edit(@PathVariable Long id, Model model) throws Exception {
        model.addAttribute("metadata", metadataMapper.findbyFrist("id", id.toString(), MetadataFormMap.class));
        return Common.BACKGROUND_PATH + "/app/resourcemanage/metadataedit";
    }
    @ResponseBody
    @RequestMapping("/save")
    @Transactional(readOnly = false)
    @SystemLog(module = "资源管理", methods = "新增/修改元数据")
    public String save() throws Exception {
        Date now = new Date();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        MetadataFormMap metadataFormMap = getFormMap(MetadataFormMap.class);
        if (metadataFormMap.get("id") == null){ // save
            metadataFormMap.set("deleted_mark", 2);
            metadataFormMap.set("meta_created", simpleDateFormat.format(now));
            metadataFormMap.set("meta_updated", simpleDateFormat.format(now));
            metadataMapper.addEntity(metadataFormMap);
        } else { // update么
            metadataFormMap.set("meta_updated", simpleDateFormat.format(now));
            metadataMapper.editEntity(metadataFormMap);
        }
        return "success";
    }

}
