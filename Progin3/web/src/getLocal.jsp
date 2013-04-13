<%
	session.setAttribute("user", request.getParameter("local"));
	if (session.getAttribute("user").equals(null)){
            out.print("false");
        }else{
            out.print("true");
        }
%>