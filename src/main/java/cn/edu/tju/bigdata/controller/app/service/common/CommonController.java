package cn.edu.tju.bigdata.controller.app.service.common;

import cn.edu.tju.bigdata.controller.index.BaseController;
import cn.edu.tju.bigdata.util.Common;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by Administrator on 2016/10/7.
 */
@Controller
@RequestMapping("/common")
public class CommonController extends BaseController {

    @RequestMapping("/{accountName}/locationNav")
    public String locationNav(){
        return Common.BACKGROUND_PATH + "/app/common/locationNav";
    }
}
