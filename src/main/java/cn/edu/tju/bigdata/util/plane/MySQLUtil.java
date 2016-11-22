package cn.edu.tju.bigdata.util.plane;

import java.io.IOException;
import java.sql.*;
import java.util.Properties;

/**
 * Created by xliu on 2016/10/5.
 */
public class MySQLUtil {

    private static final ThreadLocal<Connection> xmasterConn = new ThreadLocal<Connection>();
    private static final ThreadLocal<Connection> smartcityConn = new ThreadLocal<Connection>();
    private static Connection getConnection(String prop) {
        ThreadLocal<Connection> connectionThreadLocal = null;
        if ("jdbc".equals(prop)) {
            connectionThreadLocal = xmasterConn;
        } else {
            connectionThreadLocal = smartcityConn;
        }
        try {
            Connection conn = connectionThreadLocal.get();
            if (conn == null || !conn.isValid(100)) {
                conn = connect(prop);
                connectionThreadLocal.set(conn);
            }
            return conn;
        } catch (IOException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return null;
    }

    private static Connection connect(String prop) throws IOException, ClassNotFoundException, SQLException {
        Properties pro=new Properties();
        pro.load(MySQLUtil.class.getResourceAsStream("/" + prop + ".properties"));
        String driver = pro.getProperty(prop + ".driverClass");
        String url = pro.getProperty(prop + ".url");
        String user = pro.getProperty(prop + ".username");
        String password = pro.getProperty(prop + ".password");
        Class.forName(driver);
        Connection conn= DriverManager.getConnection(url,user,password);
        return conn;
    }
    public static void updateResult(String sql) throws SQLException {
        updateResult("jdbc", sql);
    }

    public static void updateResult(String prop, String sql) throws SQLException {
        Connection conn = getConnection(prop);
        Statement stat=conn.createStatement();
        stat.executeUpdate(sql);
    }

    public static ResultSet queryResult(String sql) throws SQLException {
        return queryResult("jdbc", sql);
    }

    public static ResultSet queryResult(String prop, String sql) throws SQLException {
        Connection conn = getConnection(prop);
        Statement stat = conn.createStatement();
        return stat.executeQuery(sql);
    }
}
