<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="progin3.DbUtil" %>

<%
    Connection con = DbUtil.getConnection();
    ResultSet r = null;
    Statement st = con.createStatement();
    String s_user = (String) session.getAttribute("user");

    String name = request.getParameter("catName");
    String assignees = request.getParameter("assname");
    
     
            List<String> assignee = new ArrayList<String>();
            if(assignees.length() > 0) {
                String tempassignee2[] = assignees.split(",");
                assignee.addAll(Arrays.asList(tempassignee2));
            }

           st.executeUpdate("INSERT INTO kategori (id_kategori,nama_kategori) VALUES (NULL,'"+name+"')");

        Statement st2 = con.createStatement();
        r = st2.executeQuery("SELECT id_kategori FROM kategori WHERE nama_kategori='"+name+"'");
	r.next();
        String id_cat = r.getString("id_kategori");
	
	Statement st3 = con.createStatement();
	ResultSet r2 = st3.executeQuery("SELECT id_user FROM user WHERE username='"+s_user+"'");
        r2.next();
        
        String id_user = r2.getString("id_user");
        
        Statement st4 = con.createStatement();
        st4.executeUpdate("INSERT INTO anggota (id_user,id_kategori,status) VALUES ('"+id_user+"','"+id_cat+"','ongoing')");
	
        for (int i=0;i<assignee.size();i++){
            Statement st5 = con.createStatement();
            ResultSet r5 = st5.executeQuery("SELECT id_user FROM user WHERE username='"+assignee.get(i)+"'");
            r5.next();
            
            String temp_id = r5.getString("id_user");
            
            Statement st6 = con.createStatement();
            st6.executeUpdate("INSERT INTO anggota (id_user,id_kategori,status) VALUES ('"+temp_id+"','"+id_cat+"','ongoing')");
        }
	
        response.sendRedirect("./home.jsp");
%>