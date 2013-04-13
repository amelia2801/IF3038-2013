<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="progin3.DbUtil" %>

<%
    Connection con = DbUtil.getConnection();
    Statement st = con.createStatement();
    String s_user = (String) session.getAttribute("user");
    String idcat = request.getParameter("idcat");
    st.executeUpdate("DELETE FROM kategori WHERE id_kategori='"+idcat+"'");

    response.sendRedirect("./home.jsp");
%>