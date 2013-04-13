<%@page import="java.util.Enumeration"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="progin3.DbUtil" %>

<%
    if (session.getAttribute("user")==null){
        response.sendRedirect("../index.jsp");
    }else {
    	String temp = null;
        if (request.getParameterNames().hasMoreElements()){
            if (request.getParameter("a").equals("0")){
                temp = "Full name not change \\n";
            }else{
                temp = "Full name have changed \\n";
            }
            
            if (request.getParameter("b").equals("0")){
		temp = temp+"Password not change \\n";
            }else{
               temp = temp+"Password have changed \\n";
            }
            
            if (request.getParameter("c").equals("0")){
                temp = temp+"Date of Birth not change \\n";
            }else{
                temp = temp+"Date of Birth have changed \\n";
            }

            if (request.getParameter("d").equals("0")){
                temp = temp+"Avatar not change \\n";
            }else{
                temp = temp+"Avatar have changed \\n";
            }
            
            %><script>alert("<% out.print(temp.trim());%>")</script><%
        }
        %>

        <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
        <html xmlns="http://www.w3.org/1999/xhtml">
                <head>
                        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
                        <title> Banana Board - Profile </title>
                        <link rel="stylesheet" type="text/css" href="style.css">
                        <script src="profile.js" type="text/javascript" language="javascript"> </script>
                </head>

        <body onload="generateDate()">
                <div id="content">

                        <jsp:include page="header.jsp" />

                        <!-- Foto profile -->
                        <div id="isi">
                                <%
                                    Connection con = DbUtil.getConnection();
                                    ResultSet r = null;
                                    Statement st = con.createStatement();
                                    String s_user = (String) session.getAttribute("user");
                                    r= st.executeQuery("SELECT * FROM user WHERE username='"+s_user+"'");
                                    r.next();

                                    Statement st2 = con.createStatement();
                                    ResultSet r2= st2.executeQuery("SELECT nama_tugas FROM `tugas` natural join `user` natural join `mengerjakan` WHERE `user`.username='"+s_user+"' AND `tugas`.status_tugas='done'");

                                    Statement st3 = con.createStatement();
                                    ResultSet r3= st3.executeQuery("SELECT nama_tugas FROM `tugas` natural join `user` natural join `mengerjakan` WHERE `user`.username='"+s_user+"' AND `tugas`.status_tugas='in progress'");

                                %>

                                <div id="leftsidebar">
                                    <img class="foto" src="<%out.print("./"+r.getString("avatar"));%>" alt="Profile picture"/>
                                    <b>@<% out.print(r.getString("username")); %></b>
                                        <div class="profbuttonwrap">
                                                <button class="profbutton" onClick="location.href='#join_form'" type="submit">Edit</button>
                                        </div>
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
                                                                        out.print("- "+r2.getString("nama_tugas")+"<br>");

                                                                        while(r2.next()){
                                                                            out.print("- "+r2.getString("nama_tugas")+"<br>");
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
                                                                    out.print("- "+r3.getString("nama_tugas")+"<br>");

                                                                    while(r3.next()){
                                                                        out.print("- "+r3.getString("nama_tugas")+"<br>");
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


                        <a href="#x" class="overlay" id="join_form" ></a>
                        <form class="popup" name="regis" action="../editprofile" method="post" enctype="multipart/form-data">
                                <h1>Edit Profile</h1>
                                <div>
                                        <label for="namalengkap">Full Name</label>
                                        <input type="text" id="namalengkap" name="namalengkap" value="" onChange="checkNamaLengkap()" />
                                        <br>
                                        <span>* minimal 2 kata (first name, last name)</span>
                                </div>
                                <div>
                                        <label for="avatar">Avatar</label>
                                        <input type="file" name="avatar" id="avatar" onchange="checkAvatar()"/>
                                        <br>
                                        <span>* jpg, jpeg</span>
                                </div>
                                <div>
                                        <label for="tgllahir">Tanggal Lahir:</label>
                                        <select id="tahunlist" name="tahun"></select>
                                        <select id="bulanlist" name="bulan"></select>
                                        <select id="tanggallist" name="tanggal"></select>
                                </div>
                                <div>
                                        <label for="password">Change Password</label>
                                        <input type="password" id="pass" name="pass" value=""  onchange="checkPassword()"/>
                                        <br>
                                        <span>* minimal 8 karakter</span>
                                </div>
                                <div>
                                        <label for="confirmpass">Confirm New Password</label>
                                        <input type="password" id="passconfirmed" name="passconfirmed" value="" onChange="checkConfirmedPass()"/>
                                </div>
                                <input class="profbutton" type="submit" value="Save Change" id="regButton" /><!--onclick="editProfile()"--> 
                                <a class="close" href="#close"></a>
                        </form>

                </div>
        </body>
        </html>
        <%
       }
%>
