package cn.edu.tju.bigdata.mapper;

import java.util.List;

import cn.edu.tju.bigdata.entity.RoleFormMap;
import cn.edu.tju.bigdata.mapper.base.BaseMapper;

public interface RoleMapper extends BaseMapper {
	public List<RoleFormMap> seletUserRole(RoleFormMap map);
	
	public void deleteById(RoleFormMap map);
}
