/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package tubes5server;

import java.sql.*;
import java.util.*;
/**
 *
 * @author M.ECKY.RABANI
 */
public class Tubes5Protocol {
    public String processInput(String input) {
        String output = null;
        
        if (input.equalsIgnoreCase("list")) {
            try {
                Connection conn = DBConnect.getConnection();
                Statement stt = conn.createStatement();
                String query = "select taskname,status from task";
                ResultSet rs = stt.executeQuery(query);
                
                String out = "";
                while (rs.next()) {
                    out += rs.getString("taskname") + ":" + rs.getString("status") + "-";
                }
                output = out;
                conn.close();
            } catch (SQLException e) {
                System.out.println("Fail getting task list");
                output = "Fail to get list task";
            } catch (NullPointerException e) {
                System.out.println("Fail getting task list");
                output = "Fail to get list task";
            }
        }
        else {
            HashMap<String,String> listuser = new HashMap<String,String>();
            try {
                Connection conn = DBConnect.getConnection();
                Statement stt = conn.createStatement();
                String query = "select username,password from user";
                ResultSet rs = stt.executeQuery(query);
                
                while (rs.next()) {
                    listuser.put(rs.getString("username"), rs.getString("password"));
                }
                
                String[] user = input.split("-");
                
                output = "fail";
                for (String s : listuser.keySet()) {
                    if (s.equals(user[0])) {
                        if (user[1].equals(listuser.get(s))) {
                            output = "success";
                        }
                    }
                }
                
                conn.close();
            } catch (SQLException e) {
                System.out.println("Fail validating user");
                output = "Fail to validate";
            } catch (NullPointerException e) {
                System.out.println("Fail validating user");
                output = "Fail to validate";
            }
        }
        
        return output;
    }
}
