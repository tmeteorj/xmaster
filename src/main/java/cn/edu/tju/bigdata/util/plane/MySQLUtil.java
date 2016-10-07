package cn.edu.tju.bigdata.util.plane;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.*;
import java.util.Properties;

/**
 * Created by xliu on 2016/10/5.
 */
public class MySQLUtil {
    private static final ThreadLocal<Connection> planeConn=new ThreadLocal<Connection>();
    private static Connection getConnection(String source) {
        ThreadLocal<Connection> connectionThreadLocal = null;
        if(source.equals("plane")){
            connectionThreadLocal=planeConn;
        }else{
            return null;
        }
        try {
            Connection conn = connectionThreadLocal.get();
            if (conn == null || !conn.isValid(100)) {
                conn = connect();
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

    private static Connection connect() throws IOException, ClassNotFoundException, SQLException {
        Properties pro=new Properties();
        pro.load(MySQLUtil.class.getResourceAsStream("/jdbc.properties"));
        String driver=pro.getProperty("jdbc.driverClass");
        String url=pro.getProperty("jdbc.url");
        String user=pro.getProperty("jdbc.username");
        String password=pro.getProperty("jdbc.password");
        Class.forName(driver);
        Connection conn= DriverManager.getConnection(url,user,password);
        return conn;
    }

    public static void updateResult(String source,String sql) throws SQLException {
        Connection conn=getConnection(source);
        Statement stat=conn.createStatement();
        stat.executeUpdate(sql);
    }
}
