package cn.edu.tju.bigdata.controller.app.service.resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.SimpleDateFormat;
import java.util.Date;

import cn.edu.tju.bigdata.annotation.SystemLog;
import cn.edu.tju.bigdata.controller.index.BaseController;
import cn.edu.tju.bigdata.entity.GSMRecordFormMap;
import cn.edu.tju.bigdata.entity.GSMRecordFormMap;
import cn.edu.tju.bigdata.enums.EmDeletedMark;
import cn.edu.tju.bigdata.mapper.GSMRecordMapper;
import cn.edu.tju.bigdata.plugin.PageView;
import cn.edu.tju.bigdata.util.Common;

/**
 * Created by Administrator on 2016/9/28.
 */
@Controller
@RequestMapping("/gsmrecord")
public class GSMRecordController extends BaseController {

    @Autowired
    private GSMRecordMapper gsmRecordMapper;

    @RequestMapping("/list")
    public String list(Model model) {
        model.addAttribute("res", findByRes());
        return Common.BACKGROUND_PATH + "/app/gsm/gsmrecordlist";
    }

    @ResponseBody
    @RequestMapping("/findByPage")
    public PageView findByPage(String pageNow, String pageSize) {
        GSMRecordFormMap gsmrecordFormMap = getFormMap(GSMRecordFormMap.class);
        gsmrecordFormMap = toFormMap(gsmrecordFormMap, pageNow, pageSize, gsmrecordFormMap.getStr("orderby"));
        gsmrecordFormMap.set("deleted_mark", EmDeletedMark.VALID.getCode());
        pageView.setRecords(gsmRecordMapper.findByPage(gsmrecordFormMap));
        return pageView;
    }

}
