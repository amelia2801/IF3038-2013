/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import Class.Function;
import Class.GetConnection;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Statement;
import java.util.HashMap;
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
public class getavatar extends HttpServlet {

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
            /* TODO output your page here. You may use following sample code. */
            Boolean isMultipartContent = ServletFileUpload.isMultipartContent(request);
            if(!isMultipartContent){
                out.print("you not gona upload file!!");
                return;
            }else{
                out.print("you try to upload file!!");
            }
            
            String userActive = "";
            if(request.getSession().getAttribute("userlistapp")!=null){
                userActive = request.getSession().getAttribute("userlistapp").toString();
            }
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
                    if (!isFormField) {
                            String fileName = fileItem.getName().toString();
                            int index = fileName.lastIndexOf('.') + 1;
                            String extension = fileName.substring(index).toLowerCase();
                            String avatar = userActive+"."+extension;
                            
                            byte [] arByte = fileItem.get();
                            String dir = request.getRealPath("avatar");
                            HashMap<String,String> user = (new Function()).GetUser(userActive);
                            File fileAva = new File(dir+"/"+user.get("avatar"));
                            fileAva.delete();
                            
                            FileOutputStream fileOutStream = new FileOutputStream(dir+"/"+avatar);
                            fileOutStream.write(arByte);
                            fileOutStream.close();
                            
                            GetConnection connection = new GetConnection();
                            Connection conn = connection.getConnection();
                            Statement stmt = conn.createStatement();
                            String query = "update user set avatar='"+avatar+"' where username='"+userActive+"'";
                            stmt.execute(query);
                            conn.close();
                    }
            }
            
            response.sendRedirect("profile.jsp?username="+userActive);
        } catch(Exception exc){
            System.out.println("ERROR : "+exc.toString()+"<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
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
