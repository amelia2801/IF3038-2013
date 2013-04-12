/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package progin3;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author PATRICKLT
 */
public class suggestion extends HttpServlet {

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
        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;
        String s = request.getParameter("str");
        String temp = "";
        try {
            /* TODO output your page here. You may use following sample code. */
//            out.println("<!DOCTYPE html>");
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet suggestion</title>");            
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet suggestion at " + request.getContextPath() + "</h1>");
//            out.println("</body>");
//            out.println("</html>");
            //System.out.println("masuk nih1");
            Class.forName("com.mysql.jdbc.Driver");
//            System.out.println("masuk nih2");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/progin_405_13510093","progin","progin");
//            System.out.println(con);
//            System.out.println("masuk nih3");
            stmt = con.createStatement();
//            System.out.println("masuk nih4");
            rs = stmt.executeQuery("SELECT username FROM `user`");
//            System.out.println("masuk nih5");
            while(rs.next()) {
//                out.print(rs.getString(1));
                if(s.regionMatches(0, rs.getString(1).toString(), 0, s.length())) {
                    temp = rs.getString(1).toString() + "<br>";
                    if(s.length() == rs.getString(1).toString().length()) {
                        temp = "complete";
                    }
                }
            }
            if(temp.equals("")) {
                out.print("empty");
            } else {
                out.print(temp);
            }
        } catch (ClassNotFoundException ex) {
//            Logger.getLogger(suggestion.class.getName()).log(Level.SEVERE, null, ex);
            throw new ServletException("JDBC Driver not found.", ex);
        } catch (SQLException ex) {
//            Logger.getLogger(suggestion.class.getName()).log(Level.SEVERE, null, ex);
            throw new ServletException("Servlet could not display any records.", ex);
        } finally {    
            try {
                if(rs != null) {
                    rs.close();
                    rs = null;
                }
                if(stmt != null) {
                    stmt.close();
                    stmt = null;
                }
                if(con != null) {
                    con.close();
                    con = null;
                }
            } catch (SQLException e) {}
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
