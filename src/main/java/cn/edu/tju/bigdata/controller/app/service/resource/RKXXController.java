package cn.edu.tju.bigdata.controller.app.service.resource;

import cn.edu.tju.bigdata.controller.index.BaseController;
import cn.edu.tju.bigdata.entity.RKXXFormMap;
import cn.edu.tju.bigdata.mapper.RKXXMapper;
import cn.edu.tju.bigdata.plugin.PageView;
import cn.edu.tju.bigdata.util.Common;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Created by Administrator on 2016/9/28.
 */
@Controller
@RequestMapping("/rkxx")
public class RKXXController extends BaseController {

    @Autowired
    private RKXXMapper rkxxMapper;

    @RequestMapping("/list")
    public String list(Model model) {
        model.addAttribute("res", findByRes());
        return Common.BACKGROUND_PATH + "/app/crime/rkxxlist";
    }

    @ResponseBody
    @RequestMapping("/findByPage")
    public PageView findByPage(String pageNow, String pageSize) {
        RKXXFormMap rkxxFormMap = getFormMap(RKXXFormMap.class);
        rkxxFormMap = toFormMap(rkxxFormMap, pageNow, pageSize, rkxxFormMap.getStr("orderby"));
        pageView.setRecords(rkxxMapper.findByPage(rkxxFormMap));
        return pageView;
    }

}
