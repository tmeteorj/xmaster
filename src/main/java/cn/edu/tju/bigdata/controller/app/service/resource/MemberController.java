package cn.edu.tju.bigdata.controller.app.service.resource;

import cn.edu.tju.bigdata.controller.index.BaseController;
import cn.edu.tju.bigdata.entity.MemberFormMap;
import cn.edu.tju.bigdata.enums.EmDeletedMark;
import cn.edu.tju.bigdata.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * Created by Ethan on 2016/10/7.
 */
@Controller
@RequestMapping("/member")
public class MemberController extends BaseController {

    @Autowired
    private MemberMapper memberMapper;

    @ResponseBody
    @RequestMapping("/{number}/list")
    public List<MemberFormMap> getMemberByNumber (@PathVariable String number) {
        List<MemberFormMap> list = null;
        MemberFormMap formMap = new MemberFormMap();
        formMap.put("where", String.format("where deleted_mark = %d and number = '%s'", EmDeletedMark.VALID.getCode(), number));
        list = memberMapper.findByWhere(formMap);
        return list;
    }
}
