package cn.edu.tju.bigdata.controller.app.service.resource;

import cn.edu.tju.bigdata.annotation.SystemLog;
import cn.edu.tju.bigdata.controller.index.BaseController;
import cn.edu.tju.bigdata.entity.MeetupFormMap;
import cn.edu.tju.bigdata.enums.EmDeletedMark;
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

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by Ethan on 2016/9/28.
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
        meetupFormMap.set("deleted_mark", EmDeletedMark.VALID.getCode());
        pageView.setRecords(meetupMapper.findByPage(meetupFormMap));
        return pageView;
    }

    @ResponseBody
    @RequestMapping("/{id}/delete")
    @Transactional(readOnly = false)
    @SystemLog(module = "资源管理", methods = "生物黑客组织管理 - 删除组织")
    public String delete(@PathVariable Long id) throws Exception {
        MeetupFormMap meetupFormMap = new MeetupFormMap();
        meetupFormMap.set("id", id);
        meetupFormMap.set("deleted_mark", EmDeletedMark.INVALID.getCode());
        meetupMapper.editEntity(meetupFormMap);
        return "success";
    }

    @RequestMapping("/{id}/edit")
    public String edit(@PathVariable Long id, Model model) throws Exception {
        model.addAttribute("meetup", meetupMapper.findbyFrist("id", id.toString(), MeetupFormMap.class));
        return Common.BACKGROUND_PATH + "/app/meetup/edit";
    }

    @RequestMapping("/add")
    public String add(Model model) throws Exception {
        return Common.BACKGROUND_PATH + "/app/meetup/edit";
    }


    @RequestMapping("/{id}/audit")
    public String audit(@PathVariable Long id, Model model) throws Exception {
        model.addAttribute("meetup", meetupMapper.findbyFrist("id", id.toString(), MeetupFormMap.class));
        return Common.BACKGROUND_PATH + "/app/meetup/audit";
    }

    @ResponseBody
    @RequestMapping("/{id}/check")
    public Boolean check(@PathVariable Long id, Model model) throws Exception {
        MeetupFormMap meetupFormMap = meetupMapper.findbyFrist("id", id.toString(), MeetupFormMap.class);
        if (meetupFormMap != null && meetupFormMap.getInt("deleted_mark") == EmDeletedMark.TO_BE_AUDITED.getCode())
            return Boolean.TRUE;
        return Boolean.FALSE;
    }

    @ResponseBody
    @RequestMapping("/save")
    @Transactional(readOnly = false)
    @SystemLog(module = "资源管理", methods = "生物黑客组织管理 - 新增/修改组织")
    public String save() throws Exception {
        Date now = new Date();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        MeetupFormMap meetupFormMap = getFormMap(MeetupFormMap.class);
        if (meetupFormMap.get("id") == null){ // save
            meetupFormMap.set("deleted_mark", 2);
            meetupFormMap.set("meta_created", simpleDateFormat.format(now));
            meetupFormMap.set("meta_updated", simpleDateFormat.format(now));
            meetupMapper.addEntity(meetupFormMap);
        } else { // update
            meetupFormMap.set("meta_updated", simpleDateFormat.format(now));
            meetupMapper.editEntity(meetupFormMap);
        }
        return "success";
    }
}
