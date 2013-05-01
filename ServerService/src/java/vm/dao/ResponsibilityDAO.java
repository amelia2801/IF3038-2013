/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package vm.dao;

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
public class ResponsibilityDAO extends DataAccessObject{
    public String isResponsibility(String categoryid, String useractive){       
        String out = null;
        try{
            PreparedStatement stt = conn.prepareStatement("SELECT count(*) as responsibility FROM responsibility WHERE categoryid=? and username=?");            
            System.out.println("asdasdadasd");
            stt.setString(1, categoryid);
            stt.setString(2, useractive);            
            ResultSet rs = stt.executeQuery();
            rs.next();
            out = rs.getString("responsibility");
        }catch(Exception e){
            e.printStackTrace();
        }
        return out;
    }
}
