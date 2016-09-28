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
@RequestMapping("/resourcemanage/")
public class ResourceManageController  extends BaseController {

    @RequestMapping("datasetmanage")
    public String datasetmanage(Model model) throws Exception {
        return Common.BACKGROUND_PATH + "/system/resourcemanage/datasetmanage";
    }


    @RequestMapping("metadatamanage")
     public String metadatamanage(Model model) throws Exception {
        return Common.BACKGROUND_PATH + "/system/resourcemanage/metadatamanage";
    }
}
