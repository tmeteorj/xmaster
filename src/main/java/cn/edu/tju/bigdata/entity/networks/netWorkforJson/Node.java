package cn.edu.tju.bigdata.entity.networks.netWorkforJson;

/**
 * Created by NING on 2016/11/17.
 */
public class Node {
    public String name;
    public Long category = 0L;
    public String value;
    public String dataset;
    public String metadata;
    public String remark;
    public String symbolSize;
    public Node(String name,Long category,String dataset,String metadata,String value, String remark){
        this.name = name;
        this.category = category;
        this.value =value;
        this.dataset = dataset;
        this.metadata = metadata;
        this.remark = remark;
    }

    public Node() {
    }
}

