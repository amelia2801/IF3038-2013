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
public class CategoryDAO extends DataAccessObject{
    public String getCategoryName(String categoryid){
        String toOut ="";
        try{
            PreparedStatement stt = conn.prepareStatement("SELECT categoryname FROM category WHERE categoryid =?");
            ResultSet rs = stt.executeQuery();
            rs.next();
            toOut = rs.getString("categoryname");
        }catch(Exception e){
            e.printStackTrace(); 
        }
        return toOut;
    }
}
