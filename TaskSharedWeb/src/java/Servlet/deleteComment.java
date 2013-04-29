/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import Class.*;
import java.sql.Connection;
import java.sql.Statement;
import java.sql.ResultSet;
/**
 *
 * @author User
 */
public class deleteComment extends HttpServlet {

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
            Function func = new Function();
            String userActive = "";
            if(request.getSession().getAttribute("userlistapp")!=null){
                userActive = request.getSession().getAttribute("userlistapp").toString();
            }
            
            String commentid = request.getParameter("commentid");
            String taskid = request.getParameter("taskid");
            int index = Integer.parseInt(request.getParameter("index"));
            
            GetConnection getCon = new GetConnection();
            Connection conn = getCon.getConnection();
            Statement stt = conn.createStatement();
            ResultSet rs = null;
            
            String query = "DELETE FROM comment WHERE commentid="+commentid;
            stt.execute(query);
            
            int numpage;
            if (Integer.parseInt(func.GetNComment(taskid))%5 == 0) {
                numpage = (Integer.parseInt(func.GetNComment(taskid))/5);
            }
            else {
                numpage = (Integer.parseInt(func.GetNComment(taskid))/5)+1;
            }

            query = "SELECT * FROM comment WHERE taskid ="+taskid+" limit "+index+",5";
            rs = stt.executeQuery(query);
            
            out.print("<p><b>"+func.GetNComment(taskid) +" Comment</b></p>");
            out.print("<div name=\"cmnt\" id=\"comment-list\">");
            
            while(rs.next()){
                out.print(" <div id=\"comment\">");
                out.print(" 	<div id=\"user-info\">");
                out.print(" 		<div id=\"left-comment-body\">");
                out.print(" 			<img src=\"avatar/"+func.GetUser(rs.getString("username")).get("avatar") +"\" width=\"50px\" height=\"50px\"/>");
                out.print(" 		</div>");
                out.print(" 		<div id=\"right-comment-body\">");
                out.print(" 			<b id=\"komentator\">"+rs.getString("username") +"</b>");
                out.print(" 			<br>");
                out.print(" 			<b id=\"post-date\">Post at "+rs.getString("createdate") +"</b>");
                out.print(" 		</div>");
                out.print(" 		<div id=\"delete-comment\">");
                        if(rs.getString("username").equals(userActive)){
                            out.print("<a href=\"#cmnt\" onClick=\"deleteComment("+rs.getString("commentid") +","+taskid+","+index+")\"><i>Delete Comment</i></a>");
                        }
                out.print(" 		</div>");
                out.print(" 	</div>");
                out.print(" 	<div id=\"comment-box\">");
                out.print(" 		<p>");
                out.print(rs.getString("message"));
                out.print(" 		</p>");
                out.print(" 	</div>");
                out.print(" </div>");
            }
            out.print(" </div>");
            if (index == 0) {
                if (numpage > 1) {
                    out.print(" <a href=\"#cmnt\" onClick=\"nextPage("+taskid+","+index+")\"><i>Next</i></a>");
                }
            }
            else if (index == (numpage*5)-5) {
                out.print(" <a href=\"#cmnt\" onClick=\"prevPage("+taskid+","+index+")\"><i>Prev</i></a>");
            }
            else {
                out.print(" <a href=\"#cmnt\" onClick=\"prevPage("+taskid+","+index+")\"><i>Prev</i></a>");
                out.print(" -- ");
                out.print(" <a href=\"#cmnt\" onClick=\"nextPage("+taskid+","+index+")\"><i>Next</i></a>");
            }
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
