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
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Enumeration;
import java.util.List;
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
public class addTask extends HttpServlet {

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
        Statement stmt1 = null;
        ResultSet rs = null;
        ResultSet rs1 = null;
        int ri;
        try {
            /* TODO output your page here. You may use following sample code. */
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/progin_405_13510093","progin","progin");
            stmt = con.createStatement();

            String taskname = request.getParameter("namatugas");
            String date = request.getParameter("date");
            //int idcat = Integer.parseInt(request.getParameter("idcat"));
            int idcat = 1;
            //int iduser = Integer.parseInt(request.getParameter("iduser"));
            int iduser = 1;
            
            rs1 = stmt.executeQuery("SELECT username FROM user WHERE id_user = '" + iduser + "'");
            rs1.next();
            String maker = rs1.getString(1);
//            System.out.println("nih" + maker);
            String tempassignee = request.getParameter("assignee");
            String temptag = request.getParameter("tag");
            String tempattach = request.getParameter("attach");
//            System.out.println("tes" + tempassignee);
            List<String> assignee = new ArrayList<String>();
            if(tempassignee.length() > 0) {
                String tempassignee2[] = tempassignee.split(",");
                assignee.addAll(Arrays.asList(tempassignee2));
            }
//            System.out.println(assignee.size());
            int idx=0;
            boolean flag = false;
            while(idx < assignee.size() && !flag) {
                if(maker.equals(assignee.get(idx))) flag = true;
                idx++;
            }
            if(flag == false) {
                assignee.add(maker);
//                System.out.println("maker:" + maker);
//                System.out.println("assignee" + assignee);
                flag = true;
            }
            String tag[] = temptag.split(",");
            String attach[] = tempattach.split(";");

            ri = stmt.executeUpdate("INSERT INTO tugas (id_tugas,id_user,nama_tugas,deadline,id_kategori,status_tugas) VALUES (NULL,'" + iduser + "','" + taskname + "',DATE('" + date + "'),'" + idcat + "','in progress');");
                    
            rs = stmt.executeQuery("SELECT id_tugas FROM tugas WHERE nama_tugas = '" + taskname + "';");
            rs.next();
            String idtugas = rs.getString(1);
            
            for(int i=0;i<assignee.size();i++) {
                rs = stmt.executeQuery("SELECT id_user FROM user WHERE username='" + assignee.get(i) + "';");
                rs.next();
                String tempiduser = rs.getString(1);
                ri = stmt.executeUpdate("INSERT INTO mengerjakan (id_user,id_tugas) VALUES ('" + tempiduser + "','" + idtugas + "');");
            }
            
            for(int i=0;i<tag.length;i++) {
                ri = stmt.executeUpdate("INSERT INTO tag (id_tugas,label) VALUES ('" + idtugas + "','" + tag[i] + "');");
            }
            
            for(int i=0;i<attach.length;i++) {
//                System.out.println(attach[i]);
                System.out.println(attach[i]);
                ri = stmt.executeUpdate("INSERT INTO attachment (id_tugas,nama_file) VALUES ('" + idtugas + "','" + attach[i] + "');");
            }
            
        } catch (ClassNotFoundException ex) {
            throw new ServletException("JDBC Driver not found.", ex);
        } catch (SQLException ex) {
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
        System.out.println("keluar");
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
