package cn.edu.tju.bigdata.mapper;

import cn.edu.tju.bigdata.entity.siteselection.LocationRelitu;
import cn.edu.tju.bigdata.mapper.base.BaseMapper;

import java.util.List;

/**
 * Created by aloha on 2016/10/24.
 */

public interface LocationMapper extends BaseMapper {
    public List<LocationRelitu> selectAll(LocationRelitu map);
}