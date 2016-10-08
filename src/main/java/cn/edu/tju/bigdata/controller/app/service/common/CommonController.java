package cn.edu.tju.bigdata.controller.app.service.common;

import cn.edu.tju.bigdata.controller.index.BaseController;
import cn.edu.tju.bigdata.entity.CityFormMap;
import cn.edu.tju.bigdata.entity.DistrictFormMap;
import cn.edu.tju.bigdata.entity.ProvinceFormMap;
import cn.edu.tju.bigdata.mapper.CityMapper;
import cn.edu.tju.bigdata.mapper.DistrictMapper;
import cn.edu.tju.bigdata.mapper.ProvinceMapper;
import cn.edu.tju.bigdata.util.Common;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

/**
 * Created by Administrator on 2016/10/7.
 */
@Controller
@RequestMapping("/common")
public class CommonController extends BaseController {

    @Autowired
    ProvinceMapper provinceMapper;
    @Autowired
    CityMapper cityMapper;
    @Autowired
    DistrictMapper districtMapper;
    @RequestMapping("/{accountName}/locationNav")
    public String locationNav(Model model){
        List<ProvinceFormMap> ps = provinceMapper.findByWhere(new ProvinceFormMap());
        List<CityFormMap> cs = cityMapper.findByWhere(new CityFormMap());
        List<DistrictFormMap> ds = districtMapper.findByWhere(new DistrictFormMap());
        model.addAttribute("provinces",ps);
        model.addAttribute("provinces_size",ps.size()+10);
        model.addAttribute("citys",cs);
        model.addAttribute("citys_size",cs.size()+10);
        model.addAttribute("districts",ds);
        model.addAttribute("districts_size",ds.size()+10);
        return Common.BACKGROUND_PATH + "/app/common/locationNav";
    }
}
