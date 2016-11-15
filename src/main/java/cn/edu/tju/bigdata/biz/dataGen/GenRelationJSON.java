package cn.edu.tju.bigdata.biz.dataGen;

import cn.edu.tju.bigdata.entity.FZRYXXFormMap;
import cn.edu.tju.bigdata.entity.RKXXFormMap;
import cn.edu.tju.bigdata.entity.TIELUFormMap;
import cn.edu.tju.bigdata.entity.WBSWFormMap;
import cn.edu.tju.bigdata.util.plane.MySQLUtil;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by xliu on 2016/11/15.
 */
public class GenRelationJSON {

    List<RKXXFormMap> rkxxList;
    List<TIELUFormMap> tieluList;
    List<WBSWFormMap> wbswList;
    List<FZRYXXFormMap> fzryxxList;

    public GenRelationJSON() {
        rkxxList = new ArrayList<RKXXFormMap>();
        tieluList = new ArrayList<TIELUFormMap>();
        wbswList = new ArrayList<WBSWFormMap>();
        fzryxxList = new ArrayList<FZRYXXFormMap>();
    }

    public List<TIELUFormMap> findTieluByGMSFHM(String gmsfhm) throws SQLException {
        String sql = String.format("select * from bd_tielu where id_no=\'%s\'", gmsfhm);
        ResultSet rs = MySQLUtil.queryResult(sql);
        List<TIELUFormMap> list = new ArrayList<TIELUFormMap>();
        while (rs.next()) {
            TIELUFormMap tmp = new TIELUFormMap();
            tmp.put("board_train_code", rs.getString("board_train_code"));
            tmp.put("from_station_name", rs.getString("from_station_name"));
            tmp.put("end_station_name", rs.getString("end_station_name"));
            list.add(tmp);
        }
        return list;
    }

    public List<RKXXFormMap> findRKByGMSFHM(String gmsfhm) throws SQLException {
        String sql = String.format("select * from bd_rkxx where gmsfhm=\'%s\'", gmsfhm);
        ResultSet rs = MySQLUtil.queryResult(sql);
        List<RKXXFormMap> list = new ArrayList<RKXXFormMap>();
        while (rs.next()) {
            RKXXFormMap tmp = new RKXXFormMap();
            tmp.put("XM", rs.getString("XM"));
            tmp.put("CSRQ", rs.getString("CSRQ"));
            tmp.put("GMSFHM", rs.getString("GMSFHM"));
            tmp.put("XBDM", rs.getString("XBDM").equals("1") ? "男" : "女");
            list.add(tmp);
        }
        return list;
    }

    public List<WBSWFormMap> findWBByGMSFHM(String gmsfhm) throws SQLException {
        String sql = String.format("select * from bd_wbsw where zjhm=\'%s\'", gmsfhm);
        ResultSet rs = MySQLUtil.queryResult(sql);
        List<WBSWFormMap> list = new ArrayList<WBSWFormMap>();
        while (rs.next()) {
            WBSWFormMap tmp = new WBSWFormMap();
            tmp.put("id", rs.getString("id"));
            tmp.put("yycsmc", rs.getString("yycsmc"));
            tmp.put("dz", rs.getString("dz"));
            tmp.put("dzqh", rs.getString("dzqh"));
            list.add(tmp);
        }
        return list;
    }

    public List<FZRYXXFormMap> findFZByGMSFHM(String gmsfhm) throws SQLException {
        String sql = String.format("select * from bd_fzryxx where gmsfhm=\'%s\'", gmsfhm);
        ResultSet rs = MySQLUtil.queryResult(sql);
        List<FZRYXXFormMap> list = new ArrayList<FZRYXXFormMap>();
        while (rs.next()) {
            FZRYXXFormMap tmp = new FZRYXXFormMap();
            tmp.put("xb", rs.getString("xb"));
            tmp.put("whcd", rs.getString("whcd"));
            tmp.put("ajlb", rs.getString("ajlb"));
            list.add(tmp);
        }
        return list;
    }

}
