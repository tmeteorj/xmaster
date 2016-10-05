package cn.edu.tju.bigdata.controller.app.service.subject;

import cn.edu.tju.bigdata.annotation.SystemLog;
import cn.edu.tju.bigdata.controller.index.BaseController;
import cn.edu.tju.bigdata.entity.PlaneFormMap;
import cn.edu.tju.bigdata.biz.PlaneBiz;
import cn.edu.tju.bigdata.mapper.PlaneMapper;
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
public class VisualUICreateController extends BaseController {
    @Autowired
    private PlaneMapper planeMapper;

    @RequestMapping("/mapplaneuicreate")
    public String mapplaneuicreate() {
        return Common.BACKGROUND_PATH + "/app/visualuicreate/mapplaneuicreate";
    }

    @ResponseBody
    @RequestMapping("/{year}/{month}/{attr}/search-by-yma")
    @SystemLog(module = "可视化界面生成", methods = "可视化界面生成 - 地图属性展示")
    JSONObject searchByYMA(
            @PathVariable Integer year,
            @PathVariable Integer month,
            @PathVariable String attr){
        PlaneFormMap planeFormMap=getFormMap(PlaneFormMap.class);
        planeFormMap.set("year",year);
        planeFormMap.set("month",month);
        List<PlaneFormMap> list=planeMapper.selectYMA(planeFormMap);
        JSONObject result=PlaneBiz.searchByYMA(list,attr);
        return result;
    }

    @ResponseBody
    @RequestMapping("/{planeid}/{attr}/search-by-pa")
    @SystemLog(module = "可视化界面生成", methods = "可视化界面生成 - 地块属性变化")
    JSONObject searchByPA(
            @PathVariable Integer planeid,
            @PathVariable String attr){
        PlaneFormMap planeFormMap=getFormMap(PlaneFormMap.class);
        planeFormMap.set("plane_id",planeid);
        List<PlaneFormMap> list=planeMapper.selectPA(planeFormMap);
        JSONObject result=PlaneBiz.searchByPA(list,attr);
        return result;
    }
}
