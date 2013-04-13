<%@page import="java.util.Enumeration"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="progin3.DbUtil" %>


<%
	Connection con = DbUtil.getConnection();
        ResultSet r = null;
        Statement st = con.createStatement();
	String user = request.getParameter("user");
	String email = request.getParameter("email");
	
        r = st.executeQuery("SELECT * FROM user WHERE username='"+user+"' OR email='"+email+"'");
	
	if (!r.next())
	{
            out.print("true");
	}
	else
	{
            out.print("false");
	}

%>