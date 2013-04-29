/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Class;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ASUS
 */
public class Function {

    public Function() {
    }
    
    public HashMap<String, String> GetUser(String username){
        try {
            HashMap<String, String> user = new HashMap<String, String>();
            GetConnection connection = new GetConnection();
            Connection conn = connection.getConnection();
            Statement stmt = conn.createStatement();
            String query = "SELECT * FROM user WHERE username='"+username+"'";
            ResultSet rs = stmt.executeQuery(query);
            rs.next();
            user.put("username", rs.getString(1));
            user.put("password", rs.getString(2));
            user.put("fullname", rs.getString(3));
            user.put("birthday", rs.getString(4));
            user.put("email", rs.getString(5));
            user.put("join", rs.getString(6));
            user.put("aboutme", rs.getString(7));
            user.put("avatar", rs.getString(8));
            return user;
        } catch (Exception e) {
            System.out.println(e.toString());
            return null;
        }
    }
    
    public HashMap<String, String> GetTask(String taskId){
        try {
            HashMap<String, String> task = new HashMap<String, String>();
            GetConnection connection = new GetConnection();
            Connection conn = connection.getConnection();
            Statement stmt = conn.createStatement();
            String query = "SELECT * FROM task WHERE taskid='"+taskId+"'";
            ResultSet rs = stmt.executeQuery(query);
            rs.next();
            task.put("taskid", rs.getString(1));
            task.put("taskname", rs.getString(2));
            task.put("username", rs.getString(3));
            task.put("createddate", rs.getString(4));
            task.put("deadline", rs.getString(5));
            task.put("status", rs.getString(6));
            task.put("categoryid", rs.getString(7));
            return task;
        } catch (Exception e) {
            System.out.println(e.toString());
            return null;
        }
    }
    
    public HashMap<String, String> GetTag(String tagId){
        try {
            HashMap<String, String> tag = new HashMap<String, String>();
            GetConnection connection = new GetConnection();
            Connection conn = connection.getConnection();
            Statement stmt = conn.createStatement();
            String query = "SELECT * FROM tag WHERE tagid='"+tagId+"'";
            ResultSet rs = stmt.executeQuery(query);
            rs.next();
            tag.put("tagid", rs.getString("tagid"));
            tag.put("tagname", rs.getString("tagname"));
            
            return tag;
        } catch (Exception e) {
            System.out.println(e.toString());
            return null;
        }
    }
    
    public int GetTypeFile(String fileName){
        int beginIndex = fileName.length() - 3;
        String extension = fileName.substring(beginIndex).toLowerCase();
        System.out.println(fileName);
        System.out.println(extension);
        if(extension.equals("jpg") || extension.equals("png")){
            return 0;
        }else if(extension.equals("mp4")){
            return 1;
        }else{
            return 2;
        }
    }
    
     public String GetNComment(String taskId){
        try {
            GetConnection connection = new GetConnection();
            Connection conn = connection.getConnection();
            Statement stmt = conn.createStatement();
            String query = "SELECT count(*) as jumlah FROM comment WHERE taskid= '"+taskId+"'";
            ResultSet rs = stmt.executeQuery(query);
            rs.next();
            return rs.getString("jumlah");
        } catch (Exception exc) {
            System.out.println(exc.toString());
            return "Error : "+exc.toString();
        }
    }
    
    public String getCategoryName(String categoryid) 
    {
        String toOut ="";
        try{
            GetConnection getCon = new GetConnection();
            Connection conn = getCon.getConnection();
            Statement stt = conn.createStatement();
            String query = "SELECT categoryname FROM category WHERE categoryid ='"+ categoryid + "'";
            ResultSet rs = stt.executeQuery(query);
            rs.next();
            toOut = rs.getString("categoryname");
        }catch(Exception e){
        }
        return toOut;
    }
     
    public String getTaskId(String taskname,String categoryid){
        String toOut ="";
        try{
            GetConnection getCon = new GetConnection();
            Connection conn = getCon.getConnection();
            Statement stt = conn.createStatement();
            String query = "SELECT taskid FROM task WHERE taskname ='"+ taskname+"' AND categoryid='"+categoryid+"'";
            ResultSet rs = stt.executeQuery(query);
            rs.next();
            toOut = rs.getString("taskid");
        }catch(Exception e){
        }
        return toOut;
    }
    
    public boolean isAssignee(String useractive,String taskid){
        boolean result = false;
        try{
            GetConnection getCon = new GetConnection();
            Connection conn = getCon.getConnection();
            Statement stt = conn.createStatement();
            String query = "SELECT count(*) as isexist FROM assignee WHERE username='"+useractive+ "' AND taskid='"+taskid+"'";
            ResultSet rs = stt.executeQuery(query);
            rs.next();
            if(!rs.getString("isexist").equals("0")){
                result = true;
            }
        }catch(Exception e){
            
        }
        return result;
    }
    
    public String getTagname(String tagid){
        String toOut ="";
        try{
            GetConnection getCon = new GetConnection();
            Connection conn = getCon.getConnection();
            Statement stt = conn.createStatement();
            String query = "SELECT tagname FROM tag WHERE tagid = '"+tagid+"'";
            ResultSet rs = stt.executeQuery(query);
            rs.next();
            toOut = rs.getString("tagname");
        }catch(Exception e){
        }
        return toOut;
    }
    
    public boolean isResponsibility(String categoryid, String useractive){
        boolean result = false;
        try{
            GetConnection getCon = new GetConnection();
            Connection conn = getCon.getConnection();
            Statement stt = conn.createStatement();
            String query = "SELECT count(*) as responsibility FROM responsibility WHERE categoryid='"+categoryid+ "' and username='"+useractive+"'";
            ResultSet rs = stt.executeQuery(query);
            rs.next();
            if(!rs.getString("responsibility").equals("0")){
                result = true;
            }
        }catch(Exception e){
        }
        return result;
    }
    
    public String getNextCommentId(){
         try {
            GetConnection connection = new GetConnection();
            Connection conn = connection.getConnection();
            Statement stmt = conn.createStatement();
            String query = "SELECT max(commentid) as max FROM comment";
            ResultSet rs = stmt.executeQuery(query);
            rs.next();
            int max = Integer.parseInt(rs.getString("max"));
            return ""+(max+1);
        } catch (Exception exc) {
            System.out.println(exc.toString());
            return ""+0;
        }
     }

     
        public String GetTagId(String tagname){
            try {
                GetConnection connection = new GetConnection();
                Connection conn = connection.getConnection();
                Statement stmt = conn.createStatement();
                if (IsTagExist(tagname)){
                        String query = "SELECT tagid FROM tag WHERE tagname = '"+tagname+"'";
                        ResultSet result = stmt.executeQuery(query);
                        result.next();
                        return result.getString("tagid");
                }else{ 
                        String nextId = "SELECT max(tagid) as maxid FROM tag";
                        ResultSet result = stmt.executeQuery(nextId);
                        result.next();
                        nextId = ""+(Integer.parseInt(result.getString("maxid"))+1);
                        
                        String query = "INSERT INTO tag values ("+nextId+",'"+tagname+"')";
                        stmt.execute(query);
                        return GetTagId(tagname);
                }
            } catch (Exception ex) {
                return "Error : "+ex.toString();
            }
	}
        
public boolean IsTagExist(String tagname){
            try {
                GetConnection connection = new GetConnection();
                Connection conn = connection.getConnection();
                Statement stmt = conn.createStatement();
                String query = "SELECT count(*) as count FROM tag WHERE tagname = '"+tagname+"'";
                ResultSet result = stmt.executeQuery(query);
                result.next();
                if (result.getString("count").equals("0"))
                        return false;
                else
                        return true;
            } catch (Exception ex) {
                return false;
            }
	}

    public String GetNextCategoryId() throws Exception{
        GetConnection connection = new GetConnection();
        Connection conn = connection.getConnection();
        Statement stmt = conn.createStatement();
        String nextId = "SELECT max(categoryid) as maxid FROM category";
        ResultSet result = stmt.executeQuery(nextId);
        result.next();
        nextId = ""+(Integer.parseInt(result.getString("maxid"))+1);
        return nextId;
    }
    public String GetNextTaskId() throws Exception{
        GetConnection connection = new GetConnection();
        Connection conn = connection.getConnection();
        Statement stmt = conn.createStatement();
        String nextId = "SELECT max(taskid) as maxid FROM task";
        ResultSet result = stmt.executeQuery(nextId);
        result.next();
        nextId = ""+(Integer.parseInt(result.getString("maxid"))+1);
        return nextId;
    }
}