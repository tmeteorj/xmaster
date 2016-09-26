package cn.edu.tju.bigdata.mapper;

import java.util.List;

import cn.edu.tju.bigdata.entity.UserFormMap;
import cn.edu.tju.bigdata.mapper.base.BaseMapper;


public interface UserMapper extends BaseMapper {

	public List<UserFormMap> findUserPage(UserFormMap userFormMap);
	
}
