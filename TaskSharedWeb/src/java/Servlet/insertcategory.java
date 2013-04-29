/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import Class.Function;
import Class.GetConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author User
 */
public class insertcategory extends HttpServlet {

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
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws IOException
    {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            String username = "";
            if(request.getSession().getAttribute("userlistapp")!=null){
                username = request.getSession().getAttribute("userlistapp").toString();
            }
            String namecategory = request.getParameter("newCategory");//$_POST['newCategory'];
            String listAssignee = request.getParameter("listAssignee");//$_POST['listAssignee'];
 
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Date date = new Date();
            String datetime = dateFormat.format(date);
            
            String nextCategoryId = (new Function()).GetNextCategoryId();
            String [] Assignee = listAssignee.split(",");

            GetConnection connection = new GetConnection();
            Connection conn = connection.getConnection();
            Statement stmt = conn.createStatement();
            // insert categori
            String query = "INSERT INTO category VALUES ('"+nextCategoryId+"', '"+namecategory+"', '"+username+"','"+datetime+"')";
            stmt.execute(query);
            
            query = "INSERT INTO responsibility VALUES ('"+username+"','"+nextCategoryId+"')";
            stmt.execute(query);
            // insert assigne
            for(int i = 0; i < Assignee.length ; i++){
                System.out.println(Assignee[i]);
                query = "INSERT INTO responsibility VALUES ('"+Assignee[i]+"','"+nextCategoryId+"')";
                stmt.execute(query);
            }
            
            response.sendRedirect("dashboard.jsp");
            conn.close();
        } catch(Exception exc){
            System.out.println(exc.toString());
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
