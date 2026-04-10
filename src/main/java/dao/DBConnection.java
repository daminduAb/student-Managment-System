package dao;
import java.sql.*;
//db connection
public class DBConnection {

   
    private static final String URL =
        "jdbc:mysql://mysql-18875c94-damindu.d.aivencloud.com:27759/defaultdb" +
        "?useSSL=true&requireSSL=true&serverTimezone=Asia/Colombo";
    private static final String USER = "avnadmin";
    private static final String PASS = "AVNS_kWAM8-45nWaQmfhIYVQ";

    public static Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(URL, USER, PASS);
    }
}