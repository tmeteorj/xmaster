package cn.edu.tju.bigdata.controller.app;

import cn.edu.tju.bigdata.annotation.SystemLog;
import cn.edu.tju.bigdata.controller.index.BaseController;
import cn.edu.tju.bigdata.entity.MeetupFormMap;
import cn.edu.tju.bigdata.mapper.MeetupMapper;
import cn.edu.tju.bigdata.plugin.PageView;
import cn.edu.tju.bigdata.util.Common;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Created by Administrator on 2016/9/28.
 */
@Controller
@RequestMapping("/meetup")
public class MeetupController extends BaseController {

    @Autowired
    private MeetupMapper meetupMapper;

    @RequestMapping("/list")
    public String list(Model model) {
        model.addAttribute("res", findByRes());
        return Common.BACKGROUND_PATH + "/app/meetup/list";
    }

    @ResponseBody
    @RequestMapping("/findByPage")
    public PageView findByPage(String pageNow, String pageSize) {
        MeetupFormMap meetupFormMap = getFormMap(MeetupFormMap.class);
        meetupFormMap = toFormMap(meetupFormMap, pageNow, pageSize, meetupFormMap.getStr("orderby"));
        meetupFormMap.set("deleted_mark", 1);
        pageView.setRecords(meetupMapper.findByPage(meetupFormMap));
        return pageView;
    }

    @ResponseBody
    @RequestMapping("/{id}/delete")
    @Transactional(readOnly = false)
    @SystemLog(module = "资源管理", methods = "生物黑客组织管理 - 删除组织")
    public String delete(@PathVariable Long id) {
        MeetupFormMap meetupFormMap = new MeetupFormMap();
        return "success";
    }

    @RequestMapping("/{id}/edit")
    public String edit(@PathVariable Long id, Model model) throws Exception {
        model.addAttribute("meetup", meetupMapper.findbyFrist("id", id.toString(), MeetupFormMap.class));
        return Common.BACKGROUND_PATH + "/app/meetup/edit";
    }
}
