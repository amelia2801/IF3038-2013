<%-- 
    Document   : tes
    Created on : Apr 10, 2013, 3:28:10 PM
    Author     : Anasthasia
--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="progin3.DbUtil" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" type="text/css" href="style.css">
    </head>
    <body>
        <h1>Hello World!</h1>
        <p>lalala</p>
        
        <div id="logo">
            <a href="./home.php"><img src="./logo.png" /></a>
    </div>
    <div id="headerright">
        <div id="usernamelogo">						
            <a href="profile.php"><!--<?echo $_SESSION['user']?>--></a>
            <a href="profile.html"><img src="./upload/foto.jpg" /></a>
        </div>
        <div id="menu">
            <ul>
                <li> <a href="home.php"> DASHBOARD </a> </li>
                <li> <a href="profile.php"> PROFILE </a> </li>
                <li> <a href="logout.php" onclick=localStorage.removeItem("userlogin");> LOGOUT </a> </li>
            </ul>
            <form method="POST" action="tes.jsp">
                <select id="filterbox" name="filter">						
                    <option>all</option>				
                    <option>username</option>
                    <option>category</option>
                    <option>task</option>							
                </select>
                <input class="box" type="text" name="keyword" onclick="this.value='';" onfocus="this.select()" onblur="this.value=!this.value?'Enter search query':this.value;" placeholder="Enter search query">
                <input class="headerbutton" name="search" type="submit" value="">                
            </form>
            filter: <% out.print(request.getParameter("filter"));  %>
            <br>
            key: <% out.print(request.getParameter("keyword")); %>
            </div>
    </div>
       <div> 
           <%
                Connection con = DbUtil.getConnection(); 
                ResultSet r = null;
                Statement st = con.createStatement();
                r= st.executeQuery("SELECT nama_tugas from tugas");
                while (r.next()){
                    out.write("<ul>");
                    out.write("<li>");
                    out.print(r.getString("nama_tugas"));
                    out.write("</li>");
                    out.write("</ul>");
                }
           %>
       </div>
    </body>
</html>
