package cn.edu.tju.bigdata.controller.app.service.object;

import cn.edu.tju.bigdata.annotation.SystemLog;
import cn.edu.tju.bigdata.biz.location.LocatBiz;
import cn.edu.tju.bigdata.controller.index.BaseController;
import cn.edu.tju.bigdata.entity.siteselection.LocationAtm;
import cn.edu.tju.bigdata.entity.siteselection.LocationScore;
import cn.edu.tju.bigdata.entity.siteselection.LocationRelitu;
import cn.edu.tju.bigdata.enums.EmDeletedMark;
import cn.edu.tju.bigdata.mapper.DatasetMapper;
import cn.edu.tju.bigdata.mapper.LocationMapper;
import cn.edu.tju.bigdata.mapper.PlaneMapper;
import cn.edu.tju.bigdata.plugin.PageView;
import cn.edu.tju.bigdata.util.Common;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * Created by Administrator on 2016/9/28.
 */
@Controller
@RequestMapping("/visualuicreate")
public class VisualLocationController extends BaseController {
    @Autowired
    DatasetMapper datasetMapper;
    @Autowired
    LocationMapper planeMapper;

    @ResponseBody
    @RequestMapping("/showtables")
    public PageView findByPage(String pageNow, String pageSize) {
        LocationScore datasetFormMap = getFormMap(LocationScore.class);
        datasetFormMap = toFormMap(datasetFormMap, pageNow, pageSize, datasetFormMap.getStr("orderby"));
        datasetFormMap.set("deleted_mark", EmDeletedMark.VALID.getCode());
        pageView.setRecords(datasetMapper.findByPage(datasetFormMap));
        return pageView;
    }

//    @ResponseBody
//    @RequestMapping("/datarelitu")
//    public PageView datarelitu(String pageNow, String pageSize) {
//        LocationRelitu datasetFormMap = getFormMap(LocationRelitu.class);
//        datasetFormMap = toFormMap(datasetFormMap, pageNow, pageSize, datasetFormMap.getStr("orderby"));
//        datasetFormMap.set("deleted_mark", EmDeletedMark.VALID.getCode());
//        pageView.setRecords(datasetMapper.findByPage(datasetFormMap));
//        return pageView;
//    }
//
//    @ResponseBody
//    @RequestMapping("/datarelitu")
//    JSONObject showRelitu(){
//        LocationRelitu planeFormMap=getFormMap(LocationRelitu.class);
//        List<LocationRelitu> list=planeMapper.selectAll(planeFormMap);
//        System.out.println("==============================");
//        System.out.println(list.size());
////        JSONObject result= PlaneBiz.searchByYMA(list, attr);
////        return result;
//        return new JSONObject();
//    }

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

}
