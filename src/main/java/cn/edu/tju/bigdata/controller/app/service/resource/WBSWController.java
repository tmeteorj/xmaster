package cn.edu.tju.bigdata.controller.app.service.resource;

import cn.edu.tju.bigdata.controller.index.BaseController;
import cn.edu.tju.bigdata.entity.WBSWFormMap;
import cn.edu.tju.bigdata.mapper.WBSWMapper;
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
@RequestMapping("/wbsw")
public class WBSWController extends BaseController {

    @Autowired
    private WBSWMapper wbswMapper;

    @RequestMapping("/list")
    public String list(Model model) {
        model.addAttribute("res", findByRes());
        return Common.BACKGROUND_PATH + "/app/crime/wbswlist";
    }

    @ResponseBody
    @RequestMapping("/findByPage")
    public PageView findByPage(String pageNow, String pageSize) {
        WBSWFormMap wbswFormMap = getFormMap(WBSWFormMap.class);
        wbswFormMap = toFormMap(wbswFormMap, pageNow, pageSize, wbswFormMap.getStr("orderby"));
        pageView.setRecords(wbswMapper.findByPage(wbswFormMap));
        return pageView;
    }

}
