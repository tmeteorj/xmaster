package cn.edu.tju.bigdata.controller.app.service.resource;

import cn.edu.tju.bigdata.annotation.SystemLog;
import cn.edu.tju.bigdata.controller.index.BaseController;
import cn.edu.tju.bigdata.entity.DatasetFormMap;
import cn.edu.tju.bigdata.enums.EmDeletedMark;
import cn.edu.tju.bigdata.mapper.DatasetMapper;
import cn.edu.tju.bigdata.plugin.PageView;
import cn.edu.tju.bigdata.util.Common;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by NING on 2016/9/28.
 */
@Controller
@RequestMapping("/dataset")
public class DatasetController extends BaseController {

    @Autowired
    DatasetMapper datasetMapper;
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
}
