/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dbConnection;

/**
 *
 * @author SAQIB
 */
import java.sql.*;

public class DBConnection {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/uk_tourism";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "123456";

    // Method to get a connection
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }
}
