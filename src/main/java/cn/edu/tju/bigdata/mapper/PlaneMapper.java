package cn.edu.tju.bigdata.mapper;

import cn.edu.tju.bigdata.entity.PlaneFormMap;
import cn.edu.tju.bigdata.mapper.base.BaseMapper;

import java.util.List;

/**
 * Created by Administrator on 2016/9/28.
 */
public interface PlaneMapper extends BaseMapper {
    public List<PlaneFormMap> selectYMA(PlaneFormMap map);
    public List<PlaneFormMap> selectPA(PlaneFormMap map);
    public List<PlaneFormMap> selectAll(PlaneFormMap map);
}
