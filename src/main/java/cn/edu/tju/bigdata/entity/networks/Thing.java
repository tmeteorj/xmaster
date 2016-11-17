package cn.edu.tju.bigdata.entity.networks;

/**
 * Created by NING on 2016/11/16.
 */
public class Thing {
    public String name;
    public String dataset;
    public String metadata;
    public Thing(String name,String dataset,String metadata){
        this.name = name;
        this.dataset =dataset;
        this.metadata =metadata;
    }
}
