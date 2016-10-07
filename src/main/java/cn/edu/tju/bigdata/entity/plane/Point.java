package cn.edu.tju.bigdata.entity.plane;

/**
 * Created by xliu on 2016/10/5.
 */
public class Point{
    public double lng;
    public double lat;
    public Point(){
    }
    public Point(String lng, String lat){
        this(Double.parseDouble(lng),Double.parseDouble(lat));
    }
    public Point(double lng, double lat) {
        this.lng = lng;
        this.lat = lat;
    }
}
