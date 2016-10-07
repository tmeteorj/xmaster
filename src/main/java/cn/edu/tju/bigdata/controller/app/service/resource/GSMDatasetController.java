package cn.edu.tju.bigdata.controller.app.service.resource;

import cn.edu.tju.bigdata.annotation.SystemLog;
import cn.edu.tju.bigdata.controller.index.BaseController;
import cn.edu.tju.bigdata.entity.GSMDatasetFormMap;
import cn.edu.tju.bigdata.entity.GSMRecordFormMap;
import cn.edu.tju.bigdata.enums.EmDeletedMark;
import cn.edu.tju.bigdata.mapper.GSMDatasetMapper;
import cn.edu.tju.bigdata.mapper.GSMRecordMapper;
import cn.edu.tju.bigdata.plugin.PageView;
import cn.edu.tju.bigdata.util.Common;
import cn.edu.tju.bigdata.util.ExcelDataMapper;
import cn.edu.tju.bigdata.util.plane.Const;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by xliu on 2016/10/7.
 */
@Controller
@RequestMapping("/gsmdataset")
public class GSMDatasetController extends BaseController {

    @Autowired
    private GSMDatasetMapper gsmDatasetMapper;

    @Autowired
    private GSMRecordMapper gsmRecordMapper;

    @RequestMapping("/list")
    public String manage(Model model) throws Exception {
        model.addAttribute("res", findByRes());
        return Common.BACKGROUND_PATH + "/app/gsm/gsmdatasetlist";
    }
    @RequestMapping("/listckb")
    public String manageaudit(Model model) throws Exception {
        model.addAttribute("res", findByRes());
        return Common.BACKGROUND_PATH + "/app/gsm/gsmdatasetlistckb";
    }

    @ResponseBody
    @RequestMapping("/findByPage")
    public PageView findByPage(String pageNow, String pageSize) {
        GSMDatasetFormMap gsmDatasetFormMap = getFormMap(GSMDatasetFormMap.class);
        gsmDatasetFormMap = toFormMap(gsmDatasetFormMap, pageNow, pageSize, gsmDatasetFormMap.getStr("orderby"));
        //gsmDatasetFormMap.set("deleted_mark", EmDeletedMark.VALID.getCode());
        pageView.setRecords(gsmDatasetMapper.findByPage(gsmDatasetFormMap));
        return pageView;
    }

//    @RequestMapping("/upload")
//    public String upload(Model model) throws Exception {
//        return Common.BACKGROUND_PATH + "/app/resourcemanage/datasetedit";
//    }

//    @ResponseBody
//    @RequestMapping("/{id}/delete")
//    @Transactional(readOnly = false)
//    @SystemLog(module = "资源管理", methods = "删除数据集")
//    public String delete(@PathVariable Long id) throws Exception {
//        GSMDatasetFormMap gsmDatasetFormMap = new GSMDatasetFormMap();
//        gsmDatasetFormMap.set("id", id);
//        gsmDatasetFormMap.set("deleted_mark", EmDeletedMark.INVALID.getCode());
//        gsmDatasetMapper.editEntity(gsmDatasetFormMap);
//        return "success";
//    }

//    @RequestMapping("/{id}/edit")
//    public String edit(@PathVariable Long id, Model model) throws Exception {
//        model.addAttribute("gsmdataset", gsmDatasetMapper.findbyFrist("id", id.toString(), GSMDatasetFormMap.class));
//        return Common.BACKGROUND_PATH + "/app/gsm/gsmdatasetedit";
//    }

    @RequestMapping("/add")
    public String add(Model model) throws Exception {
        return Common.BACKGROUND_PATH + "/app/gsm/gsmdatasetadd";
    }


    @RequestMapping("/{id}/audit")
    public String audit(@PathVariable Long id, Model model) throws Exception {
        model.addAttribute("gsmdataset", gsmDatasetMapper.findbyFrist("id", id.toString(), GSMDatasetFormMap.class));
        return Common.BACKGROUND_PATH + "/app/gsm/gsmdatasetaudit";
    }

    @ResponseBody
    @RequestMapping("/{id}/check")
    public Boolean check(@PathVariable Long id, Model model) throws Exception {
        GSMDatasetFormMap gsmDatasetFormMap = gsmDatasetMapper.findbyFrist("id", id.toString(), GSMDatasetFormMap.class);
        if (gsmDatasetFormMap != null && gsmDatasetFormMap.getInt("deleted_mark") == EmDeletedMark.TO_BE_AUDITED.getCode())
            return Boolean.TRUE;
        return Boolean.FALSE;
    }
    @ResponseBody
    @RequestMapping("/{id}/checkload")
    public Boolean checkload(@PathVariable Long id, Model model) throws Exception {
        GSMRecordFormMap gsmRecordFormMap=gsmRecordMapper.findbyFrist("dataset_id",id.toString(),GSMRecordFormMap.class);
        if (gsmRecordFormMap != null)
            return Boolean.TRUE;
        return Boolean.FALSE;
    }

    @ResponseBody
    @RequestMapping(value="/adddataset",method= RequestMethod.POST)
    @Transactional(readOnly = false)
    @SystemLog(module = "资源管理", methods = "新增")
    public String adddataset(@RequestParam("upload_user_id") int upload_user_id,
                       @RequestParam("upload_username") String upload_username,
                       @RequestParam("description") String description,
                       @RequestParam("file") MultipartFile file) throws Exception {
        String path=file.getOriginalFilename();
        if(file!=null){
            try {
                byte[] bytes = file.getBytes();
                BufferedOutputStream stream =
                        new BufferedOutputStream(new FileOutputStream(new File(Const.UPLOAD_DATA_PATH+file.getOriginalFilename())));
                stream.write(bytes);
                stream.close();
            } catch (Exception e) {
                return "error";
            }
        }
        Date now = new Date();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        GSMDatasetFormMap gsmDatasetFormMap = getFormMap(GSMDatasetFormMap.class);
        gsmDatasetFormMap.set("upload_user_id",upload_user_id);
        gsmDatasetFormMap.set("upload_username",upload_username);
        gsmDatasetFormMap.set("description",description);
        gsmDatasetFormMap.set("path",path);
        gsmDatasetFormMap.set("deleted_mark", EmDeletedMark.TO_BE_AUDITED.getCode());
        gsmDatasetFormMap.set("meta_created", simpleDateFormat.format(now));
        gsmDatasetFormMap.set("meta_updated", simpleDateFormat.format(now));
        gsmDatasetMapper.addEntity(gsmDatasetFormMap);
        return "success";
    }

    @ResponseBody
    @RequestMapping("/save")
    @Transactional(readOnly = false)
    @SystemLog(module = "资源管理", methods = "修改数据集")
    public String save() throws Exception {
        Date now = new Date();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        GSMDatasetFormMap gsmDatasetFormMap = getFormMap(GSMDatasetFormMap.class);
        if (gsmDatasetFormMap.get("id") == null){ // save
            gsmDatasetFormMap.set("deleted_mark", EmDeletedMark.TO_BE_AUDITED.getCode());
            gsmDatasetFormMap.set("meta_created", simpleDateFormat.format(now));
            gsmDatasetFormMap.set("meta_updated", simpleDateFormat.format(now));
            gsmDatasetMapper.addEntity(gsmDatasetFormMap);
        } else { // update
            gsmDatasetFormMap.set("meta_updated", simpleDateFormat.format(now));
            gsmDatasetMapper.editEntity(gsmDatasetFormMap);
        }
        return "success";
    }


    @ResponseBody
    @RequestMapping("/{id}/load")
    @Transactional(readOnly = false)
    @SystemLog(module = "应用管理", methods = "应用管理 - 加载手机信令数据")
    public String load(@PathVariable Long id)  {
        GSMDatasetFormMap gsmDatasetFormMap=gsmDatasetMapper.findbyFrist("id", id.toString(), GSMDatasetFormMap.class);
        String path=gsmDatasetFormMap.getStr("path");
        String remark=gsmDatasetFormMap.getStr("description");
        int cnt=0;
        try {
            BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(new File(Const.UPLOAD_DATA_PATH + path))));
            String line;
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
            while((line=br.readLine())!=null){
                try {
                    String info[] = line.split(",");
                    //type,time,subject,object,lng,lat
                    if (info.length == 6) {
                        GSMRecordFormMap gsmRecordFormMap = new GSMRecordFormMap();
                        gsmRecordFormMap.set("type", Integer.parseInt(info[0]));
                        simpleDateFormat.parse(info[1]);
                        gsmRecordFormMap.set("time", info[1]);
                        gsmRecordFormMap.set("subject", Integer.parseInt(info[2]));
                        gsmRecordFormMap.set("object", Integer.parseInt(info[3]));
                        gsmRecordFormMap.set("lng", Double.parseDouble(info[4]));
                        gsmRecordFormMap.set("lat", Double.parseDouble(info[5]));
                        gsmRecordFormMap.set("dataset_id", id);
                        gsmRecordFormMap.set("remark", remark);
                        gsmRecordMapper.addEntity(gsmRecordFormMap);
                        cnt++;
                    }
                } catch (ParseException e) {
                    e.printStackTrace();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        } catch (FileNotFoundException e) {
            return "FileNotFoundException";
        } catch (IOException e) {
            return "IOException";
        }
        return String.valueOf(cnt);
    }
}
