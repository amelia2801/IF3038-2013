<%@page import="java.util.Enumeration"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="progin3.DbUtil" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title> Banana Board - Profile </title>
		<link rel="stylesheet" type="text/css" href="style.css">
		<script src="profile.js" type="text/javascript" language="javascript"> </script>
	</head>

<body>
	<div id="content">
            
		<jsp:include page="header.jsp" />
    
		<!-- Foto profile -->
		<div id="isi">
			<%
                            Connection con = DbUtil.getConnection();
                            ResultSet r = null;
                            Statement st = con.createStatement();
                            String s_user = request.getParameter("user");
                            r= st.executeQuery("SELECT * FROM user WHERE username='"+s_user+"'");
                            r.next();
                            
                            Statement st2 = con.createStatement();
                            ResultSet r2= st2.executeQuery("SELECT nama_tugas FROM `tugas` natural join `user` natural join `mengerjakan` WHERE `user`.username='"+s_user+"' AND `tugas`.status_tugas='done'");
                            
                            Statement st3 = con.createStatement();
                            ResultSet r3= st3.executeQuery("SELECT nama_tugas FROM `tugas` natural join `user` natural join `mengerjakan` WHERE `user`.username='"+s_user+"' AND status_tugas='in progress'");
			
			%>
		
			<div id="leftsidebar">
                            <img class="foto" src="<%out.print("./"+r.getString("avatar"));%>" alt="Profile picture"/>
                            <b>@<% out.print(r.getString("username")); %></b>
			</div>
			
			<div id="rightsidebar">
				<ul class="prof">
					<h1 align="left">Profile</h1>
					<li>
						<label>Full Name:</label>
                                                <p class="prof1"><% out.print(r.getString("nama_lengkap"));%></p>
					</li>
					<li>
						<label>Email:</label>
						<p class="prof1"><% out.print(r.getString("email"));%></p>
					</li>
					<li>
						<label>Tanggal Lahir:</label>
						<p class="prof1"><% out.print(r.getString("tanggal_lahir"));%></p>
					</li>
					<li>
						<label>On going tasks:</label>
						<p class="prof1">
							<%
                                                            if (r2.next()){
                                                                out.print("- "+r2.getString("nama_tugas"));
                                                                
                                                                while(r2.next()){
                                                                    out.print("- "+r2.getString("nama_tugas"));
                                                                }
                                                            }else{
                                                                out.print("-");
                                                            }
							%>
						</p>
					</li>
					<li>
						<label>Tasks done:</label>
						<p class="prof1">
                                                    <%
                                                        if (r3.next()){
                                                            out.print("- "+r3.getString("nama_tugas"));
                                                            
                                                            while(r3.next()){
                                                                out.print("- "+r3.getString("nama_tugas"));
                                                            }
                                                        }else{
                                                            out.print("-");
                                                        }
                                                    %>
						</p>
					</li>
				</ul>
			</div>
		</div>
		
		<jsp:include page="footer.jsp" />
	</div>
</body>
</html>
