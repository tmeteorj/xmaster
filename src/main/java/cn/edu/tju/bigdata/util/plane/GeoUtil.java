package cn.edu.tju.bigdata.util.plane;

import cn.edu.tju.bigdata.entity.plane.Point;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

/**
 * Created by xliu on 2016/10/5.
 */
public class GeoUtil {
    private static final double EARTH_RADIUS=6378137;
    private static final double EPS=1e-8;
    public static double rad(double d){
        return d * Math.PI / 180.0;
    }
    public static double distance(double lat1, double lng1, double lat2, double lng2){
        double radLat1 = rad(lat1);
        double radLat2 = rad(lat2);
        double a = radLat1 - radLat2;
        double b = rad(lng1) - rad(lng2);
        double s = 2 * Math.asin(Math.sqrt(Math.pow(Math.sin(a/2),2) +Math.cos(radLat1)*Math.cos(radLat2)*Math.pow(Math.sin(b/2),2)));
        return s * EARTH_RADIUS;
    }

    public static double xmult(double x1,double y1,double x2,double y2){
        return x1*y2-x2*y1;
    }
    public static double xmult(Point a, Point b){
        return a.lng*b.lat-a.lat*b.lng;
    }

    public static double xmult(Point o,Point a,Point b){
        return (a.lng-o.lng)*(b.lat-o.lat)-(b.lng-o.lng)*(a.lat-o.lat);
    }

    public static double getarea(Point pg[], int n) {
        double area=0; pg[n]=pg[0];
        for(int i=0; i<n; i++)
            area+=xmult(pg[i].lng,pg[i].lat,pg[i+1].lng,pg[i+1].lat);
        return Math.abs(area)/2.0;
    }

    public static List<Point> convexHull(List<Point> p) {
        Collections.sort(p, new Comparator<Point>() {
            @Override
            public int compare(Point a, Point b) {
                return a.lng!=b.lng?(a.lng<b.lng?-1:1):((a.lat!=b.lat?(a.lat<b.lat?-1:1):0));
            }
        });
        List<Point> ans=new ArrayList<Point>();
        int i,j,top;
        for(i=top=0; i<p.size(); i++) {
            while(top>1&&xmult(ans.get(top-2),ans.get(top-1),p.get(i))<EPS) {
                top--;
                ans.remove(top);
            }
            ans.add(p.get(i));
            top++;
        }
        j=top;
        for(i=p.size()-2; i>=0; i--) {
            while(top>j&&xmult(ans.get(top-2),ans.get(top-1),p.get(i))<EPS) {
                top--;
                ans.remove(top);
            }
            ans.add(p.get(i));
            top++;
        }
        ans.remove(top-1);
        return ans;
    }
}
