package cn.edu.tju.bigdata.controller.app.service.object;

import cn.edu.tju.bigdata.annotation.SystemLog;
import cn.edu.tju.bigdata.controller.index.BaseController;
import cn.edu.tju.bigdata.entity.PlaneFormMap;
import cn.edu.tju.bigdata.entity.Table;
import cn.edu.tju.bigdata.mapper.PlaneMapper;
import cn.edu.tju.bigdata.mapper.TableMapper;
import cn.edu.tju.bigdata.util.Common;
import cn.edu.tju.bigdata.util.ConstMap;
import com.alibaba.fastjson.JSONObject;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
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
@RequestMapping("/plane")
public class PlaneApplicationController extends BaseController {
    @Autowired
    private PlaneMapper planeMapper;
    @Autowired
    private TableMapper tableMapper;

    @RequestMapping("/application")
    public String mapplaneapplication(Model model) {
        List<Table> tableList = tableMapper.selectTableByName("bd_plane", "xmaster");
        model.addAttribute("tableName", "bd_plane");
        model.addAttribute("accountName", "lx1");
        model.addAttribute("tableList", tableList);
        return Common.BACKGROUND_PATH + "/app/plane/mapplaneapplication";
    }

    @ResponseBody
    @RequestMapping("/{year}/{month}/{attr}/compute-by-yma")
    @SystemLog(module = "地块应用管理", methods = "地块应用管理 - 地块属性计算")
    String computeByYMA(
            @PathVariable Integer year,
            @PathVariable Integer month,
            @PathVariable String attr) throws Exception {
        if(attr.equals("Area"))return "success";
        PlaneFormMap planeFormMap=getFormMap(PlaneFormMap.class);
        planeFormMap.set("year",year);
        planeFormMap.set("month",month);
        List<PlaneFormMap> list=planeMapper.selectYMA(planeFormMap);
        for(PlaneFormMap plane:list){
            JSONObject js=JSONObject.parseObject(plane.getStr("attr"));
            if(attr.equals("CallMessNMI")||attr.contains("Entropy")){
                js.put(attr,Math.random());
            }else{
                js.put(attr,Math.random()*10000);
            }
            plane.set("attr",js.toJSONString());
            planeMapper.editEntity(plane);
        }
        return "success";
    }

    @ResponseBody
    @RequestMapping("/{year}/{month}/{attr}/session-set")
    @SystemLog(module = "地块应用管理", methods = "地块应用管理 - 地块属性计算")
    String sessionSet(
            @PathVariable Integer year,
            @PathVariable Integer month,
            @PathVariable String attr) throws Exception {
        Session session = SecurityUtils.getSubject().getSession();
        session.setAttribute("sel_year", year);
        session.setAttribute("sel_month", month);
        session.setAttribute("sel_attr", attr);
        for (String[] items : ConstMap.attrMap) {
            if (items[0].equals(attr)) {
                session.setAttribute("sel_attr_chs", items[1]);
            }
        }
        return "success";
    }
}
