/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package progin3;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Scanner;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
/**
 *
 * @author asus
 */
@WebServlet(name = "editprofile", urlPatterns = {"/editprofile"})
@MultipartConfig                            // specifies servlet takes multipart/form-data
public class editprofile extends HttpServlet {

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
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet editprofile</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet editprofile at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        } finally {            
            out.close();
        }
    }
    
    private String getFileName(Part part) {
        for (String cd : part.getHeader("content-disposition").split(";")) {
            if (cd.trim().startsWith("filename")) {
                return cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
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
        doPost(request, response);
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
		response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            
                Connection con = DbUtil.getConnection();
                ResultSet r = null;
                Statement st = con.createStatement();
                HttpSession session = request.getSession();
                String s_user = (String) session.getAttribute("user");
                
                Scanner s;
                Part p;
                
                p = request.getPart("namalengkap");
                s = new Scanner(p.getInputStream());
                String nama;
                if (s.hasNext()){
                    nama = s.nextLine();
                }else{
                    nama = "null";
                }
                s.close();
                
                p = request.getPart("pass");
                s = new Scanner(p.getInputStream());
                String pass;
                if (s.hasNext()){
                    pass = s.nextLine();
                }else{
                    pass = "null";
                }
                s.close();
                
                p = request.getPart("tahun");
                s = new Scanner(p.getInputStream());
                String tanggal = s.nextLine();
                s.close();
                
                p = request.getPart("bulan");
                s = new Scanner(p.getInputStream());
                String bulan = s.nextLine();
                s.close();
                
                p = request.getPart("tanggal");
                s = new Scanner(p.getInputStream());
                String hari = s.nextLine();
                s.close();
                
                if (Integer.parseInt(bulan)>=10){
                    tanggal = tanggal+"-"+bulan;
                }else{
                    tanggal = tanggal+"-0"+bulan;
                }
                if (Integer.parseInt(hari)>=10){
                    tanggal = tanggal+"-"+hari;
                }else{
                    tanggal = tanggal+"-0"+hari;
                }
                
                // Ambil data avatar
                p = request.getPart("avatar");
                InputStream is = null;
                String filename = null;
                s = new Scanner(p.getInputStream());
                if (!s.hasNext()){
                    filename = "null";
                }else{
                     is = p.getInputStream();
                    //Ambil file name
                    filename = "./upload/"+getFileName(p);
                }
                r = st.executeQuery("SELECT * FROM user WHERE username='"+s_user+"'");
               if (r.next()){   
                    int a,b,c,d;
                    if (nama.equals("null") || nama.equals(r.getString("nama_lengkap"))){
                        a = 0;
                    }else{
                        Statement stemp = con.createStatement();
                        stemp.executeUpdate("UPDATE user SET nama_lengkap='"+nama+"'WHERE username='"+s_user+"'");
                        a = 1;
                    }

                    if (pass.equals("null") || pass.equals(r.getString("password"))){
                        b = 0;
                    }else{
                        Statement stemp = con.createStatement();
                        stemp.executeUpdate("UPDATE user SET password='"+pass+"'WHERE username='"+s_user+"'");

                        b = 1;
                    }

                    if (tanggal.equals(r.getString("tanggal_lahir"))){
                        c = 0;
                    }else{
                        Statement stemp = con.createStatement();
                        stemp.executeUpdate("UPDATE user SET tanggal_lahir='"+tanggal+"'WHERE username='"+s_user+"'");
                        c = 1;
                    }

                    if (filename.equals("null") || filename.equals(r.getString("avatar"))){
                        d = 0;
                    }else{
                        out.print("waoww3");
                        Statement stemp = con.createStatement();
                        stemp.executeUpdate("UPDATE user SET avatar='"+filename+"'WHERE username='"+s_user+"'");
                        
                        // get filename to use on the server
                        String outputfile = this.getServletContext().getRealPath("./src"+filename);  // get path on the server
                        FileOutputStream os = new FileOutputStream (outputfile);

                        // write bytes taken from uploaded file to target file
                        int ch = is.read();
                        while (ch != -1) {
                             os.write(ch);
                             ch = is.read();
                        }
                        os.close();
                        out.println("<h3>File uploaded successfully!</h3>");

                        d=1;
                    }
                    response.sendRedirect("./src/profile.jsp?a="+a+"&b="+b+"&c="+c+"&d="+d+"");

                }else{
                    out.print("false");
                }

        }
        catch(Exception ex) {
           out.println("Exception -->" + ex.getMessage());
        }
        finally { 
            out.close();
        }
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
