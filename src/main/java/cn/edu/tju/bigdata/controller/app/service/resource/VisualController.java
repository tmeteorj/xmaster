package cn.edu.tju.bigdata.controller.app.service.resource;

import cn.edu.tju.bigdata.annotation.SystemLog;
import cn.edu.tju.bigdata.controller.index.BaseController;
import cn.edu.tju.bigdata.entity.*;
import cn.edu.tju.bigdata.enums.EmDeletedMark;
import cn.edu.tju.bigdata.mapper.*;
import cn.edu.tju.bigdata.plugin.PageView;
import cn.edu.tju.bigdata.util.Common;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by NING on 2016/10/9.
 */
@Controller
@RequestMapping("/visual")
public class VisualController extends BaseController {


    @Autowired
    VisualConfigMapper visualConfigMapper;
    @Autowired
    VisualMethodMapper visualMethodMapper;
    @Autowired
    VisualParameterMapper visualParameterMapper;
    @Autowired
    VisualTypeMapper visualTypeMapper;
    @Autowired
    DatasetMapper datasetMapper;
    @Autowired
    MetadataMapper metadataMapper;

    @RequestMapping("/create")
    public String create(Model model) throws Exception {
        model.addAttribute("res", findByRes());
        return Common.BACKGROUND_PATH + "/app/applicationtemplatemanage/visualuichoosedatasets";
    }
    @RequestMapping("/{datasetids}/choosetype")
    public String choosetype(@PathVariable String datasetids, Model model) throws Exception{
        model.addAttribute("datasetids",datasetids);
        return Common.BACKGROUND_PATH + "/app/applicationtemplatemanage/visualuichoosetype";
    }

    @RequestMapping("/{datasetids}/{typeid}/config")
    public String choosetype(@PathVariable String datasetids,@PathVariable int typeid, Model model) throws Exception{


        model.addAttribute("typeid",typeid);

        if(datasetids.charAt(datasetids.length()-1)==','){
            datasetids = datasetids.substring(0,datasetids.length()-1);
        }
        model.addAttribute("datasetids",datasetids);

        List<MetadataFormMap> metadataFormMaps = new ArrayList<>();
        try {
            for (String datasetid : datasetids.split(",")) {

                MetadataFormMap metadataFormMap = new MetadataFormMap();
                metadataFormMap.put("datasetid",datasetid);
                metadataFormMap.put("deleted_mark",EmDeletedMark.VALID.getCode());
                metadataFormMaps.addAll(metadataMapper.findByNames(metadataFormMap));
            }
        }
        catch (Exception e){}
        model.addAttribute("metadatas",metadataFormMaps);

        VisualParameterFormMap visualParameterFormMap = new VisualParameterFormMap();
        visualParameterFormMap.put("visualtypeid",typeid);
        visualParameterFormMap.put("deleted_mark",EmDeletedMark.VALID.getCode());
        List<VisualParameterFormMap> visualParameterFormMaps = visualParameterMapper.findByNames(visualParameterFormMap);
        model.addAttribute("visualparameters",visualParameterFormMaps);

        VisualMethodFormMap tvisualMethodFormMap = new VisualMethodFormMap();
        tvisualMethodFormMap.put("typeid",typeid);
        tvisualMethodFormMap.put("deleted_mark",EmDeletedMark.VALID.getCode());
        List<VisualMethodFormMap> visualMethodFormMaps = visualMethodMapper.findByNames(tvisualMethodFormMap);
        model.addAttribute("visualmethods",visualMethodFormMaps);

        return Common.BACKGROUND_PATH + "/app/applicationtemplatemanage/visualuiconfig";
    }

    @ResponseBody
    @RequestMapping("/findvisualtypeByPage")
    public PageView findByPage(String pageNow, String pageSize) {
        VisualTypeFormMap visualTypeFormMap = getFormMap(VisualTypeFormMap.class);
        visualTypeFormMap = toFormMap(visualTypeFormMap, pageNow, pageSize, visualTypeFormMap.getStr("orderby"));
        visualTypeFormMap.set("deleted_mark", EmDeletedMark.VALID.getCode());
        pageView.setRecords(visualTypeMapper.findByPage(visualTypeFormMap));
        return pageView;
    }


    @ResponseBody
    @RequestMapping("/save")
    @Transactional(readOnly = false)
    @SystemLog(module = "资源管理", methods = "新增可视化配置")
    public String save(HttpServletRequest request) throws Exception {
        Date now = new Date();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        VisualConfigFormMap visualConfigFormMap = getFormMap(VisualConfigFormMap.class);
        visualConfigFormMap.set("deleted_mark", EmDeletedMark.VALID.getCode());
        visualConfigFormMap.set("meta_created", simpleDateFormat.format(now));
        visualConfigFormMap.set("meta_updated", simpleDateFormat.format(now));


        VisualParameterFormMap visualParameterFormMap = new VisualParameterFormMap();
        visualParameterFormMap.put("visualtypeid", request.getParameter("visualConfigFormMap.typeid"));
        visualParameterFormMap.put("deleted_mark",EmDeletedMark.VALID.getCode());
        List<VisualParameterFormMap> visualParameterFormMaps = visualParameterMapper.findByNames(visualParameterFormMap);
        TreeMap<String,String> con = new TreeMap<>();
        for(VisualParameterFormMap vic:visualParameterFormMaps){
            String val = request.getParameter(vic.get("id").toString()).trim();
            if(!val.equals("")){
                con.put(vic.get("id").toString(),val);
            }
        }
        StringBuilder scon = new StringBuilder("");
        for( Map.Entry<String,String> entry : con.entrySet()){
            scon.append(entry.getKey()+":"+entry.getValue()+";");
        }
        visualConfigFormMap.put("config", scon.toString());
        String userName = request.getParameter("userName");
        visualConfigMapper.addEntity(visualConfigFormMap);
        return "";
    }

}
