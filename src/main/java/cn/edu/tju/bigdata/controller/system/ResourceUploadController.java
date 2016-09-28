package cn.edu.tju.bigdata.controller.system;

import cn.edu.tju.bigdata.controller.index.BaseController;
import cn.edu.tju.bigdata.util.Common;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by NING on 2016/9/28.
 */
@Controller
@RequestMapping("/resourceupload/")
public class ResourceUploadController  extends BaseController {

    @RequestMapping("datasetupload")
    public String datasetupload(Model model) throws Exception {
        return Common.BACKGROUND_PATH + "/system/resourceupload/datasetupload";
    }
}
