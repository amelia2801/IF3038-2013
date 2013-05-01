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
public class AssigneeDAO extends DataAccessObject{
    
    public String isAssignee(String useractive,String taskid){
        String out = null;
        try{
            PreparedStatement stt = conn.prepareStatement("SELECT count(*) as isexist FROM assignee WHERE username=? AND taskid=?");
            stt.setString(1, useractive);
            stt.setString(2, taskid);
            ResultSet rs = stt.executeQuery();
            rs.next();
            out = rs.getString("isexist");
        }catch(Exception e){
            e.printStackTrace();
        }
        return out;
    }
    
}
