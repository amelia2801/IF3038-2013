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
public class getTaskComments extends HttpServlet {

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
        Statement stmt1 = null;
        Statement stmt2 = null;
        Statement stmt3 = null;
        ResultSet rs1 = null;
        ResultSet rs2 = null;
        ResultSet rs3 = null;
        try {
            /* TODO output your page here. You may use following sample code. */
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/progin_405_13510093","progin","progin");
            stmt1 = con.createStatement();
            stmt2 = con.createStatement();
            stmt3 = con.createStatement();

//            int idtugas = Integer.parseInt(request.getParameter("id"));
            int idtugas = 2;
            int state = Integer.parseInt(request.getParameter("state"));
            
            int start = (state * 10) - 10;
            int count = state * 10;
            
            rs1 = stmt1.executeQuery("SELECT * FROM komentar WHERE id_tugas = '" + idtugas + "' ORDER BY tanggal_komentar DESC LIMIT " + start + "," + count + ";");
            
            String temp = "";
            
            while(rs1.next()) {
                String iduser = rs1.getString("id_user");
//                System.out.println("nih" + iduser);
                rs2 = stmt2.executeQuery("SELECT avatar FROM user WHERE id_user = '" + iduser + "'");
                rs2.next();
//                System.out.println("masuk" + rs2.getString(1));
                rs3 = stmt3.executeQuery("SELECT username FROM user WHERE id_user = '"+ iduser + "'");
                rs3.next();
//                System.out.println("blee" + rs3.getString(1));
                String temp2 = rs1.getString("isi_komentar") + "*" + rs1.getString("tanggal_komentar") + "*" + rs3.getString("username") + "*" + iduser + "*" + rs1.getString("id_komentar") + "*" + rs2.getString("avatar");
//                System.out.println(temp2);
                if(temp.length() > 0) {
                    temp = temp + ";" + temp2;
                } else {
                    temp = temp2;
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
                if(rs2 != null) {
                    rs2.close();
                    rs2 = null;
                }
                if(rs3 != null) {
                    rs3.close();
                    rs3 = null;
                }
                if(stmt1 != null) {
                    stmt1.close();
                    stmt1 = null;
                }
                if(stmt2 != null) {
                    stmt2.close();
                    stmt2 = null;
                }
                if(stmt3 != null) {
                    stmt3.close();
                    stmt3 = null;
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
