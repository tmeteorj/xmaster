package cn.edu.tju.bigdata.controller.app.service.object;

import cn.edu.tju.bigdata.controller.index.BaseController;
import cn.edu.tju.bigdata.entity.location.LocationScore;
import cn.edu.tju.bigdata.enums.EmDeletedMark;
import cn.edu.tju.bigdata.mapper.DatasetMapper;
import cn.edu.tju.bigdata.mapper.PlaneMapper;
import cn.edu.tju.bigdata.plugin.PageView;
import cn.edu.tju.bigdata.util.Common;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by Administrator on 2016/9/28.
 */
@Controller
@RequestMapping("/visualuicreate")
public class VisualLocationController extends BaseController {
    @Autowired
    DatasetMapper datasetMapper;
    private PlaneMapper planeMapper;


    @ResponseBody
    @RequestMapping("/showtables")
    public PageView findByPage(String pageNow, String pageSize) {
        LocationScore datasetFormMap = getFormMap(LocationScore.class);
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
