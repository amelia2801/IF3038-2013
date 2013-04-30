package vm.util;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Anasthasia
 */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import org.json.JSONObject;

public class DbUtil {

    public DbUtil(){ //default Ctor
    }
    
    private static Connection connection = null;

    public static Connection getConnection() {
        if (connection != null) {
            return connection;
        }
        else {
            try {
                String VCAP_SERVICES = "{\"mysql-5.1\":[{\"name\":\"bananaboarddb\",\"label\":\"mysql-5.1\",\"plan\":\"free\",\"tags\":[\"mysql\",\"mysql-5.1\",\"relational\",\"mysql-5.1\",\"mysql\"],\"credentials\":{\"name\":\"progin_405_13510093\",\"hostname\":\"localhost\",\"host\":\"localhost\",\"port\":3306,\"user\":\"progin\",\"username\":\"progin\",\"password\":\"progin\"}}]}";
                JSONObject mysqlConfig = (new JSONObject(VCAP_SERVICES)).getJSONArray("mysql-5.1").getJSONObject(0).getJSONObject("credentials");
                String driver = "com.mysql.jdbc.Driver";
                String username = mysqlConfig.getString("username");
                String password = mysqlConfig.getString("password");
                String hostname = mysqlConfig.getString("hostname");
                Integer port = mysqlConfig.getInt("port");
                String dbname = mysqlConfig.getString("name");
                
                String url = "jdbc:mysql://" + hostname + ":" + port + "/" + dbname;
                
                Class.forName(driver);
                connection = DriverManager.getConnection(url, username, password);
            } catch (ClassNotFoundException e) {
            } catch (SQLException e) {
            }
            return connection;
        }

    }
}
