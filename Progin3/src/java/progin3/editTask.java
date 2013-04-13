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
public class editTask extends HttpServlet {

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
        int ri;
        System.out.println("masuk");
        try {
            /* TODO output your page here. You may use following sample code. */
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/progin_405_13510093","progin","progin");
            stmt1 = con.createStatement();
            stmt2 = con.createStatement();
            stmt3 = con.createStatement();

//            int idtugas = Integer.parseInt(request.getParameter("idtugas"));
            int idtugas = 22;
            String namatugas = request.getParameter("namatugas");
            String tanggal = request.getParameter("date");
            String assignees = request.getParameter("assignee");
            String tags = request.getParameter("tag");
            String status = request.getParameter("status");
            
            String idcreator = request.getParameter("idcreator");
            
            rs3 = stmt3.executeQuery("SELECT username FROM user WHERE id_user='" + idcreator + "'");
            rs3.next();
            assignees = assignees + "," + rs3.getString(1);
            
            System.out.println("nih"+assignees);
            
            String assignee[] = assignees.split(",");
            String tag[] = tags.split(",");
            
//            System.out.println(tanggal);
            
            ri = stmt1.executeUpdate("UPDATE tugas SET nama_tugas = '" + namatugas + "', status_tugas = '" + status + "', deadline = date('" + tanggal + "') WHERE id_tugas = '" + idtugas + "'");
            
            ri = stmt1.executeUpdate("DELETE FROM tag WHERE id_tugas = '" + idtugas + "'");
            
            ri = stmt1.executeUpdate("DELETE FROM mengerjakan WHERE id_tugas = '" + idtugas + "'");
            
            for(int i=0;i<assignee.length;i++) {
                rs2 = stmt2.executeQuery("SELECT id_user FROM user WHERE username = '" + assignee[i] + "'");
                rs2.next();
                String iduser = rs2.getString(1);
                ri = stmt1.executeUpdate("INSERT INTO mengerjakan (id_user,id_tugas) VALUES ('" + iduser + "','" + idtugas + "')");
            }
            
            for(int i=0;i<tag.length;i++) {
                ri = stmt1.executeUpdate("INSERT INTO tag (id_tugas,label) VALUES ('" + idtugas + "','" + tag[i] + "')");
            }
            
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
                if(stmt1 != null) {
                    stmt1.close();
                    stmt1 = null;
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
