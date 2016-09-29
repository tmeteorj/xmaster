package cn.edu.tju.bigdata.controller.app.service.resource;

import cn.edu.tju.bigdata.controller.index.BaseController;
import cn.edu.tju.bigdata.util.Common;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by NING on 2016/9/28.
 */
@Controller
@RequestMapping("/dataset/")
public class DatasetController extends BaseController {

    @RequestMapping("manage")
    public String manage(Model model) throws Exception {
        return Common.BACKGROUND_PATH + "/app/resourcemanage/datasetmanage";
    }

    @RequestMapping("upload")
    public String upload(Model model) throws Exception {
        return Common.BACKGROUND_PATH + "/app/resourceupload/datasetupload";
    }

}
