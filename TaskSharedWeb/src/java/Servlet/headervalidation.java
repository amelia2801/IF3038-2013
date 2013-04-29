/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import Class.GetConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author User
 */
public class headervalidation extends HttpServlet {

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
            GetConnection connection = new GetConnection();
            Connection conn = connection.getConnection();
            Statement stmt = conn.createStatement();

            String content = request.getParameter("content");
            int mode = Integer.parseInt(request.getParameter("idx"));
            int filter = Integer.parseInt(request.getParameter("filter"));
                    
            ResultSet rs1;
            ResultSet rs2;
            ResultSet rs3;
            String query;
            switch(mode) {
                case 1:
                    String result = "";
                    query = "SELECT username FROM user WHERE username LIKE '%"+content+"%'";
                    rs1 = stmt.executeQuery(query);
                    while(rs1.next()){
                        result += rs1.getString("username")+"|";
                    }
                    query = "SELECT categoryname FROM category WHERE categoryname LIKE '%"+content+"%'";
                    rs2 = stmt.executeQuery(query);
                    while(rs2.next()){
                        result += rs2.getString("categoryname")+"|";
                    }
                    query = "SELECT taskname FROM task WHERE taskname LIKE '%"+content+"%'";
                    rs3 = stmt.executeQuery(query);
                    while(rs3.next()){
                        result += rs3.getString("taskname")+"|";
                    }
                    System.out.println(result);
                    out.print(result);
                    break;
                case 2:
                    switch (filter) {
                        case 1:
                            query = "SELECT username FROM user WHERE username LIKE '%"+content+"%'";
                            rs1 = stmt.executeQuery(query);
                            while(rs1.next()){
                                out.print(rs1.getString("username")+"|");
                            }
                            break;
                        case 2:
                            query = "SELECT email FROM user WHERE email LIKE '%"+content+"%'";
                            rs1 = stmt.executeQuery(query);
                            while(rs1.next()){
                                out.print(rs1.getString("email")+"|");
                            }
                            break;
                        case 3:
                            query = "SELECT fullname FROM user WHERE fullname LIKE '%"+content+"%'";
                            rs1 = stmt.executeQuery(query);
                            while(rs1.next()){
                                out.print(rs1.getString("fullname")+"|");
                            }
                            break;
                        case 4:
                            query = "SELECT birthday FROM user WHERE birthday LIKE '%"+content+"%'";
                            rs1 = stmt.executeQuery(query);
                            while(rs1.next()){
                                out.print(rs1.getString("birthday")+"|");
                            }
                            break;    
                    }
                    break;
                case 3:
                    query = "SELECT categoryname FROM category WHERE categoryname LIKE '%"+content+"%'";
                    rs2 = stmt.executeQuery(query);
                    while(rs2.next()){
                        out.print(rs2.getString("categoryname")+"|");
                    }
                    break;
                case 4:
                    query = "SELECT taskname FROM task WHERE taskname LIKE '%"+content+"%'";
                    rs3 = stmt.executeQuery(query);
                    while(rs3.next()){
                        out.print(rs3.getString("taskname")+"|");
                    }
                    break;    
            }
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
