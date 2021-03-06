/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package vm.rest;

import vm.dao.TaskDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;
import org.json.JSONObject;



/**
 *
 * @author User
 */
public class TaskRest extends HttpServlet {

    private Pattern regexTaskID = Pattern.compile("^/([\\w._%].*)/([0-9]{1,})$");
    private Pattern regexTask = Pattern.compile("^/([0-9]{1,})$");
    private Pattern regexNextTaskID = Pattern.compile("^/nexttaskid$");
    
    
    public TaskRest(){
        super();
    }
    
    /**
     * Handles the HTTP
     * <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        String pathInfo = request.getPathInfo();
        Matcher matcher;
        
        matcher = regexTask.matcher(pathInfo);
        if(matcher.find()){
            TaskDAO task = new TaskDAO();
            out.print(new JSONObject(task.getTask(Integer.parseInt(matcher.group(1)))));
        }
        
        matcher = regexTaskID.matcher(pathInfo);
        if(matcher.find()){
            TaskDAO task = new TaskDAO();
            out.print(task.getTaskId(matcher.group(1), matcher.group(2)));
        }
        
        matcher = regexNextTaskID.matcher(pathInfo);
        if(matcher.find()){
            TaskDAO task = new TaskDAO();
            try {
                out.print(task.GetNextTaskId());
            } catch (Exception ex) {
                Logger.getLogger(TaskRest.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    /**
     * Handles the HTTP
     * <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
