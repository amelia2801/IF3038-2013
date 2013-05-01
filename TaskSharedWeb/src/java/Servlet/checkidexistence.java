/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import Class.*;
import java.net.HttpURLConnection;
import java.net.Proxy;
import java.net.URL;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import Class.*;
import java.io.*;
import org.apache.tomcat.util.http.fileupload.IOUtils;
/**
 *
 * @author ASUS
 */
public class checkidexistence extends HttpServlet {

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
            String username = request.getParameter("id");
            String pass = request.getParameter("pass");
            HttpURLConnection huc = (HttpURLConnection)new URL(ProxyUtil.CURCONNECTION+"/rest/user/"+username+"/"+pass).openConnection();
            huc.setRequestMethod("GET");
            
            if(huc.getResponseCode()!=200){
                throw(new Exception("Error "+huc.getResponseCode()));
            }
            BufferedReader br = new BufferedReader(new InputStreamReader(huc.getInputStream()));
            String result = "" + br.readLine().charAt(2);
            /*GetConnection connection = new GetConnection();
            Connection conn = connection.getConnection();
            Statement stmt = conn.createStatement();
            String query = "SELECT count(*) as JUMLAH FROM user WHERE username='"+username+"' AND password='"+pass+"'";
            ResultSet rs = stmt.executeQuery(query);
            rs.next();*/

            if(result.toString().equals("0")){
                out.print("false");
            }else if(result.toString().equals("1")){
                HttpSession session = request.getSession();
                session.setAttribute("userlistapp", username);
                session.setMaxInactiveInterval(30*24*60*60);
                //System.out.println("session : "+session.getAttribute("userlistapp"));
                out.print("true");
            }
            //conn.close();
        } catch(Exception exc){
            out.println("Error : "+exc.toString());
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
