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
public class TagDAO extends DataAccessObject{
    
    public HashMap<String, String> GetTag(String tagId){
        HashMap<String, String> tag = null;
        try {
            tag = new HashMap<String, String>();
            
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM tag WHERE tagid=?");            
            ResultSet rs = stmt.executeQuery();
            if(rs.next()){
                tag.put("tagid", rs.getString("tagid"));
                tag.put("tagname", rs.getString("tagname"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return tag;
    }
    
    public String getTagname(String tagid){
        String toOut ="";
        try{
            PreparedStatement stt = conn.prepareStatement("SELECT tagname FROM tag WHERE tagid =?");            
            ResultSet rs = stt.executeQuery();
            rs.next();
            toOut = rs.getString("tagname");
        }catch(Exception e){
            e.printStackTrace();
        }
        return toOut;
    }
    
    public String[] GetTagId(String tagname){
        String[] out = null;
        
        try {
            PreparedStatement st1 = conn.prepareStatement("SELECT tagid FROM tag WHERE tagname =?");
            ResultSet result1 = st1.executeQuery();
            result1.next();
            out[0] = result1.getString("tagid");
            
            PreparedStatement st2 = conn.prepareStatement("SELECT max(tagid) as maxid FROM tag");
            ResultSet result2 = st2.executeQuery();
            result2.next();
            out[1] = ""+(Integer.parseInt(result2.getString("maxid"))+1);
            
            PreparedStatement st3 = conn.prepareStatement("INSERT INTO tag values (?,?)");
            ResultSet result3 = st3.executeQuery();
            result3.next();
            out[2] = GetTagId(t agname);            
        } catch (Exception ex) {
            return "Error : "+ex.toString();
        }
        return out;
    }
}
