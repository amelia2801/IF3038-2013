/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package vm.dao;

import vm.model.Task;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.logging.Level;
import java.sql.Date;import java.util.logging.Level;
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

    public int addAssignee(int idtask, String username){
        try {
            PreparedStatement preparedStatement = conn.prepareStatement("INSERT INTO `assignee`(`username`, `taskid`) VALUES (?, ?);");
            preparedStatement.setString(1, username);
            preparedStatement.setInt(2, idtask);

            return preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
            return -1;
    }
    
    public int addTag(int idtag, String nametag){
        try {
            PreparedStatement preparedStatement = conn.prepareStatement("INSERT INTO `tag`(`tagid`, `tagname`) VALUES (?,?); ");
            preparedStatement.setInt(1, idtag);
            preparedStatement.setString(2, nametag);

            return preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
            return -1;
    }
    
    public int addTagtoTask(int idtask, int idtag){
        try {
            PreparedStatement preparedStatement = conn.prepareStatement("INSERT INTO `task_tag`(`taskid`, `tagid`) VALUES (?,?); ");
            preparedStatement.setInt(1, idtask);
            preparedStatement.setInt(2, idtag);

            return preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
            return -1;
    }
    
    public int addTask(int taskid, String taskname, String nameuser, Date datecreated, Date linedead, String status, int idcategory) {
        try {
            PreparedStatement preparedStatement = conn.prepareStatement("INSERT INTO 'task'('taskid','taskname','username','createddate','deadline','status','categoryid') VALUES (?,?,?,?,?,?,?);");
            preparedStatement.setInt(1, taskid);
            preparedStatement.setString(2, taskname);
            preparedStatement.setString(3, nameuser);
            preparedStatement.setDate(4, datecreated);
            preparedStatement.setDate(5, linedead);
            preparedStatement.setString(6, status);
            preparedStatement.setInt(7, idcategory);
            
            preparedStatement.executeUpdate();

            ResultSet rs = preparedStatement.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }
    
    public int addAttachment(String namefile, int idtask){
        try {
            PreparedStatement preparedStatement = conn.prepareStatement("INSERT INTO `attachment`(`filename`, `taskid`) VALUES (?,?); ");
            preparedStatement.setString(1, namefile);
            preparedStatement.setInt(2, idtask);

            return preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
            return -1;
    }
}
