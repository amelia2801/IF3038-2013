/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package vm.model;

import org.json.JSONModel;
import org.json.JSONObject;

/**
 *
 * @author Anasthasia
 */
public class Category extends JSONModel {
    private int categoryid;
    private String categoryname;
    private String username;
    private String createddate;
    
    public Category(){
    }
    
    public Category(int categoryid, String categoryname, String username, String createddate){
        this.categoryid = categoryid;
        this.categoryname = categoryname;
        this.username = username;
    }
    
    public int getCategoryID(){
        return categoryid;
    }
    
    public void setCategoryID(int categoryid){
        this.categoryid = categoryid;
    }
    
    public String getCategoryName(){
        return categoryname;
    }
    
    public void setCategoryName(String categoryname){
        this.categoryname = categoryname;
    }
    
    public String getUsername(){
        return username;
    }
    
    public void setUsername(String username){
        this.username = username;
    }
    
    public String getCreateddate(){
        return createddate;
    }
    
    public void setCreateddate(String createddate){
        this.createddate = createddate;
    }
    
    @Override
    public JSONObject toJsonObject() {
        JSONObject jObject = new JSONObject();

        jObject.put("categoryid", categoryid);
        jObject.put("categoryname", categoryname);
        jObject.put("username", username);
        jObject.put("createddate", createddate);

        return jObject;
    }
    
    @Override
        public void fromJsonObject(JSONObject jObject) {
        this.categoryid = jObject.getInt("categoryid");
        this.categoryname = jObject.getString("categoryname");
        this.username = jObject.getString("username");
        this.createddate = jObject.getString("createddate");
    }
}
