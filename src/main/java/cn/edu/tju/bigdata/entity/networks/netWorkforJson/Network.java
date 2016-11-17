package cn.edu.tju.bigdata.entity.networks.netWorkforJson;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by NING on 2016/11/17.
 */
public class Network {
    public String type = "force";
    public List<Category> categories = new ArrayList<>();
    public List<Node> nodes = new ArrayList<>();
    public List<Link> links = new ArrayList<>();
    public void setDefaultCategory(){
        categories.add(new Category("地块","地块"));
        categories.add(new Category("事件","事件"));
        categories.add(new Category("机构","机构"));
        categories.add(new Category("人","人"));
        categories.add(new Category("行为","行为"));
        categories.add(new Category("当前选择","当前选择"));

    }

}
