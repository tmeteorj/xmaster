package cn.edu.tju.bigdata.mapper;

import java.util.List;

import cn.edu.tju.bigdata.mapper.base.BaseMapper;
import cn.edu.tju.bigdata.entity.ResFormMap;

public interface ResourcesMapper extends BaseMapper {
	public List<ResFormMap> findChildlists(ResFormMap map);

	public List<ResFormMap> findRes(ResFormMap map);

	public void updateSortOrder(List<ResFormMap> map);
	
	public List<ResFormMap> findUserResourcess(String userId);
	
}
