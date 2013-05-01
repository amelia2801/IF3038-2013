/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package vm.rest;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONObject;
import vm.dao.TagDAO;

/**
 *
 * @author Anasthasia
 */
public class TagRest extends HttpServlet {

    private Pattern regexTag = Pattern.compile("^/([0-9]{1,})$");
    private Pattern regexTagName = Pattern.compile("^/tagname/([0-9]{1,})$");
    private Pattern regexTagID1 = Pattern.compile("^/([\\w._%].*)$");
    private Pattern regexTagID2 = Pattern.compile("^/maxid$");
    private Pattern regexInsertIntoTag = Pattern.compile("^/([0-9]{1,})/([\\w._%].*)$");
    private Pattern regexIsExist = Pattern.compile("^/([\\w._%].*)$");
    
    public TagRest(){
        super();
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
        PrintWriter out = response.getWriter();
        String pathInfo = request.getPathInfo();
        Matcher matcher;
        
        matcher = regexTag.matcher(pathInfo);
        if(matcher.find()){
            TagDAO tag = new TagDAO();
            out.print(new JSONObject(tag.GetTag(matcher.group(1))));
        }
        
        matcher = regexTagName.matcher(pathInfo);
        if(matcher.find()){
            TagDAO tag = new TagDAO();
            out.print(tag.GetTag(matcher.group(1)));
        }
        
        matcher = regexTagID1.matcher(pathInfo);
        if(matcher.find()){
            TagDAO tag = new TagDAO();
            out.print(tag.GetTagId1(matcher.group(1)));
        }
        
        matcher = regexTagID2.matcher(pathInfo);
        if(matcher.find()){
            TagDAO tag = new TagDAO();
            out.print(tag.GetTagId2());
        }
        
        matcher = regexInsertIntoTag.matcher(pathInfo);
        if(matcher.find()){
            TagDAO tag = new TagDAO();
            out.print(tag.GetTagId3(matcher.group(1), matcher.group(2)));
        }
        
        matcher = regexIsExist.matcher(pathInfo);
        if(matcher.find()){
            TagDAO tag = new TagDAO();
            out.print(tag.IsTagExist(matcher.group(1)));
        }
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
