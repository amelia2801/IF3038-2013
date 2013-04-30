/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package vm.bb;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import vm.attribute.*;

/**
 *
 * @author User
 */
public class TaskDAO extends DataAccessObject {
    
    public Task getTask(int idtask){
        Task task = null;
        try {
            PreparedStatement preparedstatement = conn.prepareStatement("SELECT * FROM TASK;");
            //preparedstatement.setInt(1, idtask);
            ResultSet rs = preparedstatement.executeQuery();
            
            if(rs.next()){
                task = new Task();
                task.setTaskID(rs.getInt("taskname"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(TaskDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return task;
    }
    
}
