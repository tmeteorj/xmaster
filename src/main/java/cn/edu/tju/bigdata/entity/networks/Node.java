package cn.edu.tju.bigdata.entity.networks;

/**
 * Created by NING on 2016/11/16.
 */
public class Node {
    public String name;
    public Long category;
    public Long value;
    public Node(String name,Long category,Long value){
        this.name = name;
        this.category = category;
        this.value =value;
    }
}
