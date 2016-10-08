package cn.edu.tju.bigdata.entity;

import cn.edu.tju.bigdata.annotation.TableSeg;
import cn.edu.tju.bigdata.util.FormMap;

/**
 * Created by NING on 2016/10/8.
 */

@TableSeg(tableName = "bd_city", id="city_id")
public class CityFormMap extends FormMap<String, Object> {
}