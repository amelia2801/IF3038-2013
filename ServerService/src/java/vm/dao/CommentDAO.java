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
public class CommentDAO extends DataAccessObject{
    
    public String getJumlahComment(String taskId){
        try {            
            PreparedStatement stmt = conn.prepareStatement("SELECT count(*) as jumlah FROM comment WHERE taskid=?");
            stmt.setString(1, taskId);
            ResultSet rs = stmt.executeQuery();
            
            rs.next();
            return rs.getString("jumlah");
        } catch (Exception exc) {
            System.out.println(exc.toString());
            return "Error : "+exc.toString();
        }
    }
    
    public String getNextCommentId(){
         try {
            PreparedStatement stmt = conn.prepareStatement("SELECT max(commentid) as max FROM comment");            
            ResultSet rs = stmt.executeQuery();            
            rs.next();
            int max = Integer.parseInt(rs.getString("max"));
            return ""+(max+1);
        } catch (Exception exc) {
            System.out.println(exc.toString());
            return ""+0;
        }
     }
}
