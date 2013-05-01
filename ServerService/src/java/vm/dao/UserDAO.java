package vm.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

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
    
    public String countValidIDPass(String username, String pass){
        String out = null;
        PreparedStatement preparedstatement;
        try {
             preparedstatement = conn.prepareStatement("SELECT count(*) as JUMLAH FROM user WHERE username=? AND password=?;");
             preparedstatement.setString(1, username);
             preparedstatement.setString(2, pass);
             ResultSet rs = preparedstatement.executeQuery();
             if(rs.next()){
                 out = rs.getString(1);
             }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return out;
       
    }
    
    public int addUser(User user) {
        vm.soap.user.UserSoap_Service service = new vm.soap.user.UserSoap_Service();
        vm.soap.user.UserSoap port = service.getUserSoapPort();
        return port.addUser(user.toJsonObject().toString());
    }
}