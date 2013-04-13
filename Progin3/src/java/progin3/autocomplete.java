    /*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package progin3;

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
@WebServlet(urlPatterns = {"/autocomplete"})
public class autocomplete extends HttpServlet {

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
        String input = request.getParameter("str");
        String filterby = request.getParameter("filter");
        String suggestion = "";
        try {
            /* TODO output your page here. You may use following sample code. */
            ResultSet s = null;
            if("category".equals(filterby)){
                if(input.length() > 0){
                    Connection con = DbUtil.getConnection();
                    Statement query = con.createStatement();                    
                    s = query.executeQuery("SELECT nama_kategori FROM `kategori`;");
                    while(s.next()){
                        if(input.regionMatches(0, s.getString(1), 0, input.length())){
                            suggestion = suggestion + s.getString(1) + "<br>";
                            if(input.length() == s.getString(1).length()){
                                suggestion = "complete";
                            }
                        }
                    }
                }
                if ("".equals(suggestion)){
                    out.print("empty");
                }else{
                    out.print(suggestion);
                }
            }else if("username".equals(filterby)){
                if(input.length() > 0){
                    Connection con = DbUtil.getConnection();
                    Statement query = con.createStatement();                    
                    s = query.executeQuery("SELECT username FROM `user`;");
                    while(s.next()){
                        if(input.regionMatches(0, s.getString(1), 0, input.length())){
                            suggestion = suggestion + s.getString(1) + "<br>";
                            if(input.length() == s.getString(1).length()){
                                suggestion = "complete";
                            }
                        }
                    }
                }
                if ("".equals(suggestion)){
                    out.print("empty");
                }else{
                    out.print(suggestion);
                }
            }else if("task".equals(filterby)){
                if(input.length() > 0){
                    Connection con = DbUtil.getConnection();
                    Statement query = con.createStatement();                    
                    s = query.executeQuery("SELECT nama_tugas FROM `tugas`;");
                    while(s.next()){
                        if(input.regionMatches(0, s.getString(1), 0, input.length())){
                            suggestion = suggestion + s.getString(1) + "<br>";
                            if(input.length() == s.getString(1).length()){
                                suggestion = "complete";
                            }
                        }
                    }
                }
                if ("".equals(suggestion)){
                    out.print("empty");
                }else{
                    out.print(suggestion);
                }
            }else if("all".equals(filterby)){
                if(input.length() > 0){
                    Connection con = DbUtil.getConnection();
                    Statement query = con.createStatement();                    
                    s = query.executeQuery("(SELECT distinct username from `user`) union (SELECT distinct nama_tugas from `tugas`) union (SELECT distinct nama_kategori from `kategori`);");
                    while(s.next()){
                        if(input.regionMatches(0, s.getString(1), 0, input.length())){
                            suggestion = suggestion + s.getString(1) + "<br>";
                            if(input.length() == s.getString(1).length()){
                                suggestion = "complete";
                            }
                        }
                    }
                }
                if ("".equals(suggestion)){
                    out.print("empty");
                }else{
                    out.print(suggestion);
                }
            }
            
        } catch(SQLException ex){
            throw new ServletException("Servlet could not display any records.", ex);
        } finally {            
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
