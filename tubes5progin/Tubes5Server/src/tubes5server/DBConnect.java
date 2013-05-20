/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package tubes5server;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.io.*;
import java.net.*;
import java.sql.*;
import java.util.*;

/**
 *
 * @author Anasthasia
 */
public class DBConnect {
    public DBConnect(){ 
    }
    
    public static Connection connection = null;

    public static Connection getConnection() {
        if (connection != null) {
            connection = null;
        }
        
        try {                                
            String driver = "com.mysql.jdbc.Driver";
            String port = "3306";
            String username = "root";
            String password = "";
            String hostname = "localhost";
            String dbname = "progin_405_13511601";                
            String url = "jdbc:mysql://" + hostname + ":" + port + "/" + dbname;

            Class.forName(driver);
            connection = DriverManager.getConnection(url, username, password);
        } catch (ClassNotFoundException e) {
            System.out.println("Can't find database");
        } catch (SQLException e) {
            System.out.println("Can't find database");
        }
        return connection;
        
    }
        
}
