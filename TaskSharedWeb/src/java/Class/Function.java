/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Class;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.*;
import org.json.simple.JSONValue;

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
            HttpURLConnection huc = (HttpURLConnection)new URL(ProxyUtil.CURCONNECTION+"/rest/user/"+username).openConnection();
            huc.setRequestMethod("GET");
            
            if(huc.getResponseCode()!=200){
                throw(new Exception("Error "+huc.getResponseCode()));
            }
            
            org.json.simple.JSONObject jObject = (org.json.simple.JSONObject)JSONValue.parse(new InputStreamReader(huc.getInputStream()));
            user.put("username", (String)jObject.get("username"));
            user.put("password", (String)jObject.get("password"));
            user.put("fullname", (String)jObject.get("fullname"));
            user.put("birthday", (String)jObject.get("birthday"));
            user.put("email", (String)jObject.get("email"));
            user.put("join", (String)jObject.get("join"));
            user.put("aboutme", (String)jObject.get("aboutme"));
            user.put("avatar", (String)jObject.get("avatar"));
            
            return user;
        } catch (Exception e) {
            System.out.println(e.toString());
            return null;
        }
    }
    
    public HashMap<String, String> GetTask(String taskId){
        try {
            HashMap<String, String> task = new HashMap<String, String>();
            HttpURLConnection huc = (HttpURLConnection)new URL(ProxyUtil.CURCONNECTION+"/rest/task/"+taskId).openConnection();
            huc.setRequestMethod("GET");
            
            if(huc.getResponseCode()!=200){
                throw(new Exception("Error "+huc.getResponseCode()));
            }

            org.json.simple.JSONObject jObject = (org.json.simple.JSONObject)JSONValue.parse(new InputStreamReader(huc.getInputStream()));
            task.put("taskid", (String)jObject.get("taskid"));
            task.put("taskname", (String)jObject.get("taskname"));
            task.put("username", (String)jObject.get("username"));
            task.put("createddate", (String)jObject.get("createddate"));
            task.put("deadline", (String)jObject.get("deadline"));
            task.put("status", (String)jObject.get("status"));
            task.put("categoryid", (String)jObject.get("categoryid"));
            return task;
        } catch (Exception e) {
            System.out.println(e.toString());
            return null;
        }
    }
    
    public HashMap<String, String> GetTag(String tagId){
        try {
            HashMap<String, String> tag = new HashMap<String, String>();
            HttpURLConnection huc = (HttpURLConnection)new URL(ProxyUtil.CURCONNECTION+"/rest/tag/"+tagId).openConnection();
            huc.setRequestMethod("GET");
            
            if(huc.getResponseCode()!=200){
                throw(new Exception("Error "+huc.getResponseCode()));
            }

            org.json.simple.JSONObject jObject = (org.json.simple.JSONObject)JSONValue.parse(new InputStreamReader(huc.getInputStream()));
            tag.put("tagid", (String)jObject.get("tagid"));
            tag.put("tagname", (String)jObject.get("tagname"));
            
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
            HttpURLConnection huc = (HttpURLConnection)new URL(ProxyUtil.CURCONNECTION+"/rest/comment/"+taskId).openConnection();
            huc.setRequestMethod("GET");
            
            if(huc.getResponseCode()!=200){
                throw(new Exception("Error "+huc.getResponseCode()));
            }
            BufferedReader br = new BufferedReader(new InputStreamReader(huc.getInputStream()));
            return br.readLine();
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