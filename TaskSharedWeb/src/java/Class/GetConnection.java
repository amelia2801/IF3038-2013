/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Class;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author ASUS
 */
public class GetConnection {

    Connection conn = null;
    String serverName;
    String dataBaseName;
    String userName;
    String password;

    public GetConnection() {
        this.serverName = "localhost";
        this.dataBaseName = "progin_405_13511601";
        this.userName = "root";
        this.password = "";
    }
    
    public Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://"+serverName+"/"+dataBaseName, userName, password);
        return conn;
    }
}
