package cn.edu.tju.bigdata.mapper;

import cn.edu.tju.bigdata.entity.Table;
import cn.edu.tju.bigdata.util.FormMap;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by Administrator on 2016/9/29.
 */
public interface TableMapper {

    List<Table> selectTableByName(@Param("tableName") String tableName, @Param("databaseName") String databaseName);

    List<FormMap> selectDataFromTable(
            @Param("databaseName") String databaseName,
            @Param("tableName") String tableName,
            @Param("columns") String columns,
            @Param("where") String where
    );

    Long selectCountFromTable(
            @Param("databaseName") String databaseName,
            @Param("tableName") String tableName,
            @Param("where") String where
    );

    FormMap selectDataById(
            @Param("databaseName") String databaseName,
            @Param("tableName") String tableName,
            @Param("id") Long id
    );

    Integer insertEntity (
            @Param("databaseName") String databaseName,
            @Param("tableName") String tableName,
            @Param("columns") String columns,
            @Param("values") String values
    );

    Integer updateEntryById (
            @Param("databaseName") String databaseName,
            @Param("tableName") String tableName,
            @Param("set") String set,
            @Param("id") Long id
    );
}
