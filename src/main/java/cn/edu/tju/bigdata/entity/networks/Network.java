package cn.edu.tju.bigdata.entity.networks;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by NING on 2016/11/16.
 */
public class Network {

    public String type = "force";
    public List<Categorie> categories = new ArrayList<>();
    public List<Node> nodes = new ArrayList<>();
    public List<Link> links = new ArrayList<>();
}
