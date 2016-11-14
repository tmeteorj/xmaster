package cn.edu.tju.bigdata.controller.app.service.resource;

import cn.edu.tju.bigdata.controller.index.BaseController;
import cn.edu.tju.bigdata.entity.FZRYXXFormMap;
import cn.edu.tju.bigdata.mapper.FZRYXXMapper;
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
@RequestMapping("/fzryxx")
public class FZRYXXController extends BaseController {

    @Autowired
    private FZRYXXMapper fzryxxMapper;

    @RequestMapping("/list")
    public String list(Model model) {
        model.addAttribute("res", findByRes());
        return Common.BACKGROUND_PATH + "/app/crime/fzryxxlist";
    }

    @ResponseBody
    @RequestMapping("/findByPage")
    public PageView findByPage(String pageNow, String pageSize) {
        FZRYXXFormMap fzryxxFormMap = getFormMap(FZRYXXFormMap.class);
        fzryxxFormMap = toFormMap(fzryxxFormMap, pageNow, pageSize, fzryxxFormMap.getStr("orderby"));
        pageView.setRecords(fzryxxMapper.findByPage(fzryxxFormMap));
        return pageView;
    }

}
