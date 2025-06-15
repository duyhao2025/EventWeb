
package com.uef.until;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author Admin
 */
public class DBConnection {
    // Thông tin kết nối: đổi theo cấu hình thực tế của bạn
    private static final String JDBC_URL = "jdbc:sqlserver://localhost:1433;databaseName=WEB_EVENT;encrypt=true;trustServerCertificate=true";
    private static final String DB_USER = "sa";
    private static final String DB_PASSWORD = "zxc";

    static {
        try {
            // Load driver SQL Server; với Java 6+ thường không bắt buộc gọi Class.forName
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            // Nếu driver không tìm thấy, dừng ứng dụng
            throw new RuntimeException("Không tìm thấy SQLServer JDBC Driver", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD);
    }
}
