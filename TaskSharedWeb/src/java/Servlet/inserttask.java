/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import Class.Function;
import Class.GetConnection;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.FileItemFactory;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author User
 */
public class inserttask extends HttpServlet {

    /**
     * Processes requests for both HTTP
     * <code>GET</code> and
     * <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            Boolean isMultipartContent = ServletFileUpload.isMultipartContent(request);
            if(!isMultipartContent){
                out.print("you not gona upload file!!");
            }else{
                out.print("you try to upload file!!");
            }
            
            String taskName = "";
            String deadline = "";
            String timeDeadline = "";
            String listAssignee = "";
            String listTag = "";
            String taskId = (new Function()).GetNextTaskId();
            String userActive = "";
            String categoryId = request.getParameter("categoryid");
            
            if(request.getSession().getAttribute("userlistapp")!=null){
                userActive = request.getSession().getAttribute("userlistapp").toString();
            }
            
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Date date = new Date();
            String createdDateTime = dateFormat.format(date);
            
            
            GetConnection getCon = new GetConnection();
            Connection conn = getCon.getConnection();
            String query = "INSERT INTO `task` " +
            "(`taskid`, `taskname`, `username`, `createddate`, `deadline`, `status`, `categoryid`) VALUES "+
            "("+taskId+", 'aaa', '"+userActive+"', '1111-11-11 11:11:11', '1111-11-11 11:11:11', 'UNCOMPLETE', "+categoryId+")";
            Statement stt = conn.createStatement();
            stt.execute(query);
            
            FileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(factory);
            List<FileItem> fields = upload.parseRequest(request);
            out.println("Number of fields: " + fields.size());
            Iterator<FileItem> it = fields.iterator();
            if (!it.hasNext()) {
                    out.println("No fields found");
                    return;
            }
            while (it.hasNext()) {
                    FileItem fileItem = it.next();
                    boolean isFormField = fileItem.isFormField();
                    if (isFormField) {
                            out.print("<br />"+fileItem.getFieldName()+" : "+fileItem.getString());
                            if(fileItem.getFieldName().toString().equals("textTaskName"))
                                taskName = fileItem.getString();
                            else if(fileItem.getFieldName().toString().equals("textDeadline"))
                                deadline = fileItem.getString();
                            else if(fileItem.getFieldName().toString().equals("textTimeDeadline"))
                                timeDeadline = fileItem.getString();
                            else if(fileItem.getFieldName().toString().equals("textAssignee"))
                                listAssignee = fileItem.getString();
                            else if(fileItem.getFieldName().toString().equals("textTag"))
                                listTag = fileItem.getString();
                    } else {
                            String fileName = fileItem.getName().toString();
                            if(!fileName.equals("")){
                                out.print("<br />"+fileName);
                                int index = fileName.lastIndexOf('.') + 1;
                                String extension = fileName.substring(index);

                                byte [] arByte = fileItem.get();
                                String dir = request.getRealPath("attachment");
                                FileOutputStream fileOutStream = new FileOutputStream(dir+"/"+taskId+"-"+fileName);
                                fileOutStream.write(arByte);
                                fileOutStream.close();
                                
                                getCon = new GetConnection();
                                conn = getCon.getConnection();
                                query = "INSERT INTO `attachment` " +
                                " VALUES "+
                                    "('"+taskId+"-"+fileName+"',"+taskId+")";
                                stt = conn.createStatement();
                                stt.execute(query);
                            }
                    }
            }
            
            deadline = deadline+" "+timeDeadline+":00";
            getCon = new GetConnection();
            conn = getCon.getConnection();
            query = "UPDATE `task` SET" +
                    " taskname='"+taskName+"'"+
                    ",createddate='"+createdDateTime+"'"+
                    ",deadline='"+deadline+"'"+
                    " WHERE taskid="+taskId;
            System.out.println(query);
            stt = conn.createStatement();
            stt.execute(query);
            
            query = "INSERT INTO `assignee` (`username`, `taskid`) VALUES ('"+userActive+"', "+taskId+")";
            stt.execute(query);
            String [] assignee = listAssignee.split(",");
            for(int i = 0; i < assignee.length ; i++){
                query = "INSERT INTO `assignee` (`username`, `taskid`) VALUES ('"+assignee[i]+"', "+taskId+")";
                stt.execute(query);
            }
            
            String [] tag = listTag.split(",");
            for(int i = 0; i < tag.length ; i++){
                String tagid = (new Function()).GetTagId(tag[i]);
                query = "INSERT INTO `task_tag` (`taskid`, `tagid`) VALUES ("+taskId+", "+tagid+");";
                stt.execute(query);
            }
            
            response.sendRedirect("dashboard.jsp");
            conn.close();
        } catch(Exception exc){
            System.out.println("Error : "+exc.toString());
        }finally {            
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
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
        processRequest(request, response);
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
        processRequest(request, response);
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
