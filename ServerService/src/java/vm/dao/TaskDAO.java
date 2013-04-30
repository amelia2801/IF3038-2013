/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package vm.dao;

import java.sql.Connection;
import vm.model.Task;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author User
 */
public class TaskDAO extends DataAccessObject {
    
    public HashMap<String, String> getTask(int idtask){
        HashMap<String, String> task = null;
        try {
            task = new HashMap<String, String>();
            
            PreparedStatement preparedstatement = conn.prepareStatement("SELECT * FROM `task` WHERE taskid=?;");
            preparedstatement.setInt(1, idtask);
            ResultSet rs = preparedstatement.executeQuery();
            
            if(rs.next()){
                task.put("taskid", rs.getString("taskid"));
                task.put("taskname", rs.getString("taskname"));
                task.put("username", rs.getString("username"));
                task.put("createddate", rs.getString("createddate"));
                task.put("deadline", rs.getString("deadline"));
                task.put("status", rs.getString("status"));
                task.put("categoryid", rs.getString("categoryid"));
                //task.setTaskID(rs.getInt("taskid"));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return task;
    }
    
    public String getTaskId(String taskname,String categoryid){
        String toOut ="";
        try{
            PreparedStatement stt = conn.prepareStatement("SELECT taskid FROM task WHERE taskname =? AND categoryid=?");
            
            ResultSet rs = stt.executeQuery();
            rs.next();
            toOut = rs.getString("taskid");
        }catch(Exception e){
            e.printStackTrace();
        }
        return toOut;
    }
}
