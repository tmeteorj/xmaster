package cn.edu.tju.bigdata.controller.app.service.resource;

import cn.edu.tju.bigdata.controller.index.BaseController;
import cn.edu.tju.bigdata.entity.TIELUFormMap;
import cn.edu.tju.bigdata.mapper.TIELUMapper;
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
@RequestMapping("/tielu")
public class TIELUController extends BaseController {

    @Autowired
    private TIELUMapper tieluMapper;

    @RequestMapping("/list")
    public String list(Model model) {
        model.addAttribute("res", findByRes());
        return Common.BACKGROUND_PATH + "/app/crime/tielulist";
    }

    @ResponseBody
    @RequestMapping("/findByPage")
    public PageView findByPage(String pageNow, String pageSize) {
        TIELUFormMap tieluFormMap = getFormMap(TIELUFormMap.class);
        tieluFormMap = toFormMap(tieluFormMap, pageNow, pageSize, tieluFormMap.getStr("orderby"));
        pageView.setRecords(tieluMapper.findByPage(tieluFormMap));
        return pageView;
    }

}
