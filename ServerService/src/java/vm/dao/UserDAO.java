/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package vm.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;


/**
 *
 * @author Anasthasia
 */
public class UserDAO extends DataAccessObject{
    
    public HashMap<String, String> getUser(String username){
        HashMap<String, String> user = null;
        try {
            user = new HashMap<String, String>();
            
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM user WHERE username=?");
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()){
                user.put("username", rs.getString(1));
                user.put("password", rs.getString(2));
                user.put("fullname", rs.getString(3));
                user.put("birthday", rs.getString(4));
                user.put("email", rs.getString(5));
                user.put("join", rs.getString(6));
                user.put("aboutme", rs.getString(7));
                user.put("avatar", rs.getString(8));
            }            
        } catch (Exception e) {
            e.printStackTrace();            
        }
        return user;
    }
    
}
