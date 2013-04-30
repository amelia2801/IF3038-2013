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
    
    public String GetTagId1(String tagname){
        String out = null;
        
        try {
            PreparedStatement st = conn.prepareStatement("SELECT tagid FROM tag WHERE tagname =?");
            ResultSet result = st.executeQuery();
            result.next();
            out = result.getString("tagid");
        } catch (Exception ex) {
            return "Error : "+ex.toString();
        }
        return out;
    }
    
       public String GetTagId2(){
        String out = null;
        
        try {
            PreparedStatement st = conn.prepareStatement("SELECT max(tagid) as maxid FROM tag");
            ResultSet result = st.executeQuery();
            result.next();
            out = ""+(Integer.parseInt(result.getString("maxid"))+1);           
        } catch (Exception ex) {
            return "Error : "+ex.toString();
        }
        return out;
    }
       
    public String GetTagId3(String nextid, String tagname){
        String out = null;
        
        try {
            PreparedStatement st = conn.prepareStatement("INSERT INTO tag values (?,?)");
            ResultSet result = st.executeQuery();
            result.next();           
            // INI KEMBALIANNYA APA YAAA???
        } catch (Exception ex) {
            return "Error : "+ex.toString();
        }
        return out;
    }
    
    public String IsTagExist(String tagname){
        String out = null;
        try {
            PreparedStatement stmt = conn.prepareStatement("SELECT count(*) as count FROM tag WHERE tagname =?");            
            ResultSet result = stmt.executeQuery();
            result.next();
            out = result.getString("count");
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return out;
    }
}

