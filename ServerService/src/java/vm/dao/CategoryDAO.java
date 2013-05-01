package vm.dao;
import vm.model.Category;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CategoryDAO extends DataAccessObject{
    public String getCategoryName(String categoryid){
        String toOut ="";
        try{
            PreparedStatement stt = conn.prepareStatement("SELECT categoryname FROM category WHERE categoryid =?");
            stt.setString(1, categoryid);
            ResultSet rs = stt.executeQuery();
            rs.next();
            toOut = rs.getString("categoryname");
        }catch(Exception e){
            e.printStackTrace(); 
        }
        return toOut;
    }
	
    public int addCategory(int idcategory, String namecategory, String username, Date datecreated) {
        try {
            PreparedStatement preparedStatement = conn.prepareStatement("INSERT INTO 'category'('categoryid','categoryname','username','createddate') VALUES (?,?,?,?);");
            preparedStatement.setInt(1, idcategory);
            preparedStatement.setString(2, namecategory);
            preparedStatement.setString(3, username);
            preparedStatement.setDate(4, datecreated);
            return preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        }
    }
        
    public String GetNextCategoryId() throws Exception{
        String nextId = null; 
        try{            
            PreparedStatement stmt = conn.prepareStatement("SELECT max(categoryid) as maxid FROM category");        
            ResultSet result = stmt.executeQuery();
            result.next();
            nextId = ""+(Integer.parseInt(result.getString("maxid"))+1);            
        }catch(SQLException e) {
            e.printStackTrace();
        }
        return nextId;
    }
}