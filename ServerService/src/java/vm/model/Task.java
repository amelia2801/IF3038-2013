/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package vm.model;

import org.json.JSONModel;
import org.json.JSONObject;

/**
 *
 * @author User
 */
public class Task extends JSONModel{
    private int taskid;
    
    public Task(){
    }
    
    public Task(int taskid){
        this.taskid = taskid;
    }
    
    public int getTaskID(){
        return taskid;
    }
    
    public void setTaskID(int taskid){
        this.taskid = taskid;
    }
    
    @Override
    public JSONObject toJsonObject() {
        JSONObject jObject = new JSONObject();

        jObject.put("taskid", taskid);
        return jObject;
    }
    
    @Override
        public void fromJsonObject(JSONObject jObject) {
        this.taskid = jObject.getInt("taskid");
    }
}
