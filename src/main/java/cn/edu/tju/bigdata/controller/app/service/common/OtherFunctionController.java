package cn.edu.tju.bigdata.controller.app.service.common;

import cn.edu.tju.bigdata.controller.index.BaseController;
import cn.edu.tju.bigdata.entity.Table;
import cn.edu.tju.bigdata.mapper.TableMapper;
import cn.edu.tju.bigdata.util.Common;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Ethan on 2016/10/7.
 */
@Controller
@RequestMapping("/common")
public class OtherFunctionController extends BaseController {

    @Value("${metadata.database:xmaster}")
    private String databaseName;

    @Autowired
    private TableMapper tableMapper;

    @RequestMapping("/{accountName}/infoRetrieval")
    public String infoRetrieval(@PathVariable String accountName, HttpServletRequest request, Model model) {
        String tableName = request.getParameter("tableName");
        if (StringUtils.isBlank(tableName))
            tableName = "bd_meetup";
        List<Table> tableList = tableMapper.selectTableByName(tableName, databaseName);
        for (String key : request.getParameterMap().keySet()) {
            model.addAttribute(key, request.getParameter(key));
        }
        model.addAttribute("tableName", tableName);
        model.addAttribute("accountName", accountName);
        model.addAttribute("tableList", tableList);
        return Common.BACKGROUND_PATH + "/app/common/infoRetrieval";
    }


}