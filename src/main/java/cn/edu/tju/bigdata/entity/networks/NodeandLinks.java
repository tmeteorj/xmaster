package cn.edu.tju.bigdata.entity.networks;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by NING on 2016/11/17.
 */
public class NodeandLinks {
    public String name;
    public Long category;
    public String value;
    public String dataset;
    public String metadata;
    public String remark;
    public List<NodeandLinks> link = new ArrayList<>();
    public List<String> linkName = new ArrayList<>();
    public int myid;
    public NodeandLinks(String name,Long category,String dataset,String metadata,String value, String remark,int myid) {
        this.name = name;
        this.category = category;
        this.value = value;
        this.dataset = dataset;
        this.metadata = metadata;
        this.remark = remark;
        this.myid = myid;
    }
    public cn.edu.tju.bigdata.entity.networks.netWorkforJson.Node getNodeforJson(){
        return new cn.edu.tju.bigdata.entity.networks.netWorkforJson.Node(name,category,dataset,metadata,value,remark);

    }
}
