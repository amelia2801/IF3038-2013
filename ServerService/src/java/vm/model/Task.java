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
        /*jObject.put("idAttachment", idAttachment);
        jObject.put("idTugas", idTugas);
        jObject.put("name", name);
        jObject.put("filename", filename);
        jObject.put("type", type);*/

        return jObject;
    }
}
