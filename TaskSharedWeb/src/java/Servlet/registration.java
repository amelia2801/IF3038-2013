/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import Class.GetConnection;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
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
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import javax.swing.filechooser.FileNameExtensionFilter;
import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.FileItemFactory;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author ASUS
 */
public class registration extends HttpServlet {

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
                return;
            }else{
                out.print("you try to upload file!!");
            }
            
            String username = "";
            String password = "";
            String fullname = "";
            String birthday = "";
            String email    = "";
            String avatar   = "";
            
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
                            out.print("<br />"+fileItem.getFieldName());
                            if(fileItem.getFieldName().toString().equals("textUsername"))
                                username = fileItem.getString();
                            else if(fileItem.getFieldName().toString().equals("textPassword"))
                                password = fileItem.getString();
                            else if(fileItem.getFieldName().toString().equals("textFullName"))
                                fullname = fileItem.getString();
                            else if(fileItem.getFieldName().toString().equals("textBirthday"))
                                birthday = fileItem.getString();
                            else if(fileItem.getFieldName().toString().equals("textEmail"))
                                email = fileItem.getString();
                            else if(fileItem.getFieldName().toString().equals("textAvatar"))
                                avatar = fileItem.getString();
                    } else {
                            String fileName = fileItem.getName().toString();
                            int index = fileName.lastIndexOf('.') + 1;
                            String extension = fileName.substring(index);
                            avatar = username+"."+extension;
                            
                            byte [] arByte = fileItem.get();
                            String dir = request.getRealPath("avatar");
                            FileOutputStream fileOutStream = new FileOutputStream(dir+"/"+avatar);
                            fileOutStream.write(arByte);
                            fileOutStream.close();
                    }
            }
       
            out.println("<br />"+username);
            out.println("<br />"+password);
            out.println("<br />"+fullname);
            out.println("<br />"+birthday);
            out.println("<br />"+email);
            out.println("<br />"+avatar);

            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date date = new Date();
            String join = dateFormat.format(date);
   
            GetConnection getCon = new GetConnection();
            Connection conn = getCon.getConnection();
            String query = "INSERT INTO user VALUES ('"+username+"', '"+password+"','"+fullname+"', '"+birthday+"','"+email+"','"+join+"','telling yourself in here','"+avatar+"')";
            Statement stt = conn.createStatement();
            stt.execute(query);
            
            HttpSession session = request.getSession();
            session.setAttribute("userlistapp", username);
            session.setMaxInactiveInterval(30*24*60*60);
                
            response.sendRedirect("dashboard.jsp");
            conn.close();
        } catch (Exception exc){
            out.print("Error : ");
            out.print(exc.toString());
        }finally {            
            out.close();
        }
    }
    
    private static String getFilename(Part part) {
        System.out.println("check beby check");
        for (String cd : part.getHeader("content-disposition").split(";")) {
            if (cd.trim().startsWith("filename")) {
                String filename = cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
                return filename.substring(filename.lastIndexOf('/') + 1).substring(filename.lastIndexOf('\\') + 1); // MSIE fix.
            }
        }
        return null;
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
