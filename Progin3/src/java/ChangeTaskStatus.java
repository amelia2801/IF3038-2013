/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import progin3.DbUtil;

/**
 *
 * @author Anasthasia
 */
@WebServlet(urlPatterns = {"/ChangeTaskStatus"})
public class ChangeTaskStatus extends HttpServlet {

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
        ResultSet change = null;
        ResultSet change1 = null;
        try {
            /* TODO output your page here. You may use following sample code. */
            String getid = request.getParameter("id");
            String getcheck = request.getParameter("ischeck");
            Connection conn = DbUtil.getConnection();
            Statement st = conn.createStatement();
            Statement st1 = conn.createStatement(); 
            if("true".equals(getcheck)){
                change = st.executeQuery("UPDATE `progin_405_13510093`.`tugas` SET `status_tugas` = 'done' WHERE `tugas`.`id_tugas` = '"+getid+"';");
                change = st1.executeQuery("SELECT a.status_tugas FROM `tugas` as a natural join `tag` as b WHERE a.`id_tugas` = '"+getid+"';");
            }else{
                change = st.executeQuery("UPDATE `progin_405_13510093`.`tugas` SET `status_tugas` = 'in progress' WHERE `tugas`.`id_tugas` = '"+getid+"';");
                change = st1.executeQuery("SELECT a.status_tugas FROM `tugas` as a natural join `tag` as b WHERE a.`id_tugas` = '"+getid+"';");
            }
            conn.close();
        }catch(SQLException ex){
            throw new ServletException("Servlet could not display any records.", ex);
        } 
        finally {           
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
