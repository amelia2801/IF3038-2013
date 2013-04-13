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
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author PATRICKLT
 */
public class getTaskTags extends HttpServlet {

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
        ResultSet rs1 = null;
        try {
            /* TODO output your page here. You may use following sample code. */
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/progin_405_13510093","progin","progin");
            stmt = con.createStatement();

            int idtugas = Integer.parseInt(request.getParameter("id"));
//            int idtugas = 22;
            
            rs1 = stmt.executeQuery("SELECT label FROM tag WHERE id_tugas = '" + idtugas + "';");
            
            String temp = "";
            
            while(rs1.next()) {
                if(temp.length() > 0) {
                    temp = temp + "," + rs1.getString(1);
		} else {
                    temp = rs1.getString(1);
		}
            }
            
            out.print(temp);
            
        } catch (ClassNotFoundException ex) {
            throw new ServletException("JDBC Driver not found.", ex);
        } catch (SQLException ex) {
            throw new ServletException("Servlet could not display any records.", ex);
        } finally {   
            try {
                if(rs1 != null) {
                    rs1.close();
                    rs1 = null;
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
