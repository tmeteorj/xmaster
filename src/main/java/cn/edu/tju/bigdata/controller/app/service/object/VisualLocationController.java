package cn.edu.tju.bigdata.controller.app.service.object;

import cn.edu.tju.bigdata.controller.index.BaseController;
import cn.edu.tju.bigdata.mapper.PlaneMapper;
import cn.edu.tju.bigdata.util.Common;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by Administrator on 2016/9/28.
 */
@Controller
@RequestMapping("/visualuicreate")
public class VisualLocationController extends BaseController {
    @Autowired
    private PlaneMapper planeMapper;

    @RequestMapping("/locationuicreate")
    public String mapplaneuicreate() {
        return Common.BACKGROUND_PATH + "/app/visualuicreate/locationuicreate";
    }

}
