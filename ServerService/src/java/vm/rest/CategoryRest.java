/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package vm.rest;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONObject;
import vm.dao.CategoryDAO;

/**
 *
 * @author Anasthasia
 */
public class CategoryRest extends HttpServlet {
    
    private Pattern regexCategoryName = Pattern.compile("^/([0-9]{1,})$");
    private Pattern regexNextCategoryID = Pattern.compile("^/getnextcatID");
    
    public CategoryRest(){
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
        
        matcher = regexCategoryName.matcher(pathInfo);
        if(matcher.find()){
            CategoryDAO category = new CategoryDAO();
            out.print(category.getCategoryName(matcher.group(1)));            
        }
        
        matcher = regexNextCategoryID.matcher(pathInfo);
        if(matcher.find()){
            CategoryDAO category = new CategoryDAO();
            try {    
                out.print(category.GetNextCategoryId());
            } catch (Exception ex) {
                Logger.getLogger(CategoryRest.class.getName()).log(Level.SEVERE, null, ex);
            }
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
