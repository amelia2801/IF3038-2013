/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package vm.dao;

import vm.model.Task;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author User
 */
public class TaskDAO extends DataAccessObject {
    
    public Task getTask(int idtask){
        Task task = null;
        try {
            PreparedStatement preparedstatement = conn.prepareStatement("SELECT * FROM `task` WHERE taskid=?;");
            preparedstatement.setInt(1, idtask);
            ResultSet rs = preparedstatement.executeQuery();
            
            if(rs.next()){
                task = new Task();
                task.setTaskID(rs.getInt("taskid"));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        
        return task;
    }
    
}
