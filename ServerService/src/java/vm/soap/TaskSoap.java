/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package vm.soap;

import vm.dao.TaskDAO;
import java.sql.Date;
import javax.jws.WebService;
import javax.jws.WebMethod;
import javax.jws.WebParam;

/**
 *
 * @author Rian
 */
@WebService(serviceName = "TaskSoap")
public class TaskSoap {
    
    @WebMethod(operationName = "addAssignee")
        public int addAssignee(@WebParam(name = "taskid") int idTask, @WebParam(name = "username") String username) {
        TaskDAO taskDao = new TaskDAO();
        return taskDao.addAssignee(idTask, username);
    }
    
    @WebMethod(operationName = "addTag")
        public int addTag(@WebParam(name = "tagid") int idtag, @WebParam(name = "tagname") String nametag){
        TaskDAO taskDao = new TaskDAO();
        return taskDao.addTag(idtag,nametag);
    }
    
    @WebMethod(operationName = "addTask")
        public int addTask(@WebParam(name = "taskid") int idtask, @WebParam(name = "taskname") String nametask, @WebParam(name = "username") String nameuser, @WebParam(name = "createddate") Date datecreated, @WebParam(name = "deadline") Date linedead, @WebParam(name = "status") String status, @WebParam(name = "categoryid") int idcategory ){
        TaskDAO taskDao = new TaskDAO();
        return taskDao.addTask(idtask,nametask,nameuser,datecreated,linedead,status,idcategory);
    }
    
    @WebMethod(operationName = "addTagtoTask")
        public int addTagtoTask(@WebParam(name = "taskid") int idtask, @WebParam(name = "tagid") int idtag){
        TaskDAO taskDao = new TaskDAO();
        return taskDao.addTagtoTask(idtask,idtag);
    }
    
    @WebMethod(operationName = "addAttachment")
        public int addAttachment(@WebParam(name = "filename") String namefile, @WebParam(name = "taskid") int idtask){
        TaskDAO taskDao = new TaskDAO();
        return taskDao.addAttachment(namefile,idtask);
    }
}
