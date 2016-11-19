package cn.edu.tju.bigdata.entity.networks.netWorkforJson;

/**
 * Created by NING on 2016/11/17.
 */
public class Link {
    public Long source;
    public Long target;
    public String name;
    public Link(Long source,Long target,String name){
        this.source=source;
        this.target=target;
        this.name=name;
    }
}
