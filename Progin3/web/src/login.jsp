<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="progin3.DbUtil" %>

<%
        Connection con = DbUtil.getConnection();
        ResultSet r = null;
        Statement st = con.createStatement();
	String user = request.getParameter("username");
	String pass = request.getParameter("password");
	
	r = st.executeQuery("SELECT password FROM user WHERE username='"+user+"'");
	// $result = mysqli_query($con,"SELECT password FROM user WHERE username='".$user."'");
	// $row = mysqli_fetch_array($result);
        if (!r.next())
	{
            out.print("false");
	}
	else
	{
            if (r.getString("password").equals(pass)){
                    out.print("true");
                    session.setAttribute("user",user);
            }else{
                    out.print("false");
            }
	}

	
%>