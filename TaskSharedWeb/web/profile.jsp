<%-- 
    Document   : profile
    Created on : Apr 6, 2013, 8:18:32 AM
    Author     : VAIO
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Class.*"%>
<%@page import="java.util.HashMap"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile</title>
        <%
	    String userAgent = request.getHeader("user-agent").toLowerCase();
	    if (userAgent.matches(".*(android|avantgo|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\\/|plucker|pocket|psp|symbian|treo|up\\.(browser|link)|vodafone|wap|windows (ce|phone)|xda|xiino).*") || userAgent.substring(0, 4).matches("1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\\-(n|u)|c55\\/|capi|ccwa|cdm\\-|cell|chtm|cldc|cmd\\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\\-s|devi|dica|dmob|do(c|p)o|ds(12|\\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\\-|_)|g1 u|g560|gene|gf\\-5|g\\-mo|go(\\.w|od)|gr(ad|un)|haie|hcit|hd\\-(m|p|t)|hei\\-|hi(pt|ta)|hp( i|ip)|hs\\-c|ht(c(\\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\\-(20|go|ma)|i230|iac( |\\-|\\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\\/)|klon|kpt |kwc\\-|kyo(c|k)|le(no|xi)|lg( g|\\/(k|l|u)|50|54|e\\-|e\\/|\\-[a-w])|libw|lynx|m1\\-w|m3ga|m50\\/|ma(te|ui|xo)|mc(01|21|ca)|m\\-cr|me(di|rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\\-2|po(ck|rt|se)|prox|psio|pt\\-g|qa\\-a|qc(07|12|21|32|60|\\-[2-7]|i\\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\\-|oo|p\\-)|sdk\\/|se(c(\\-|0|1)|47|mc|nd|ri)|sgh\\-|shar|sie(\\-|m)|sk\\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\\-|v\\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\\-|tdg\\-|tel(i|m)|tim\\-|t\\-mo|to(pl|sh)|ts(70|m\\-|m3|m5)|tx\\-9|up(\\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|xda(\\-|2|g)|yas\\-|your|zeto|zte\\-")) {
		out.println("<link href=\"css/style-mobile.css\" rel=\"stylesheet\" type=\"text/css\" />");
	    } else {
		out.println("<link href=\"css/style.css\" rel=\"stylesheet\" type=\"text/css\" />");
	    }
	%>
        <script type="text/javascript" src="javascript/profile.js"></script>
        <script src="javascript/calendar.js"></script>
        <link href="css/calendar.css" rel="stylesheet">
    </head>
    <body onLoad="hidden_update_box()">
        <%
        /*session management*/
        String userActive = "";
        if(request.getSession().getAttribute("userlistapp")==null){
            response.sendRedirect("index.jsp");
        }else{
            userActive = request.getSession().getAttribute("userlistapp").toString();
        }
        %>
        <div id="main-body-general">
                <!--Header-->
                <div id="header">
                <jsp:include page="header.jsp" />
                <%
                    Function func = new Function();
                    String usernameToShow = request.getParameter("username");
                    HashMap<String, String> userShow = func.GetUser(usernameToShow);
                %>
                </div>
                <div><hr id="border"></div>
                <!--Body-->
        <div id="profile-page-body">
                <div id="profile-header">
                        <div id="left-profile-header">
                                <img alt="Photo profile" id="photo" src="avatar/<% out.print(userShow.get("avatar"));%>" width="250" height="325"/>
                        </div>
                        <div id="right-profile-header">
                            <h2><% out.print(userShow.get("username")); %></h2>
                <%
                    if(userActive.equals(usernameToShow)){
                        out.print("<div id=\"upload_button\"><a href=\"#\" onClick=\"edit_avatar('"+usernameToShow+"')\">Upload New Avatar</a></div>");
                        out.print("<div id=\"uploader\">");
                        out.print("<form enctype=\"multipart/form-data\" method=\"post\" action=\"getavatar\">");
                        out.print("	<input type=\"file\" name=\"changeAvatar\" id=\"inputfileid\">");
                        out.print("	<input type=\"submit\">");
                        out.print("</form>");
                        out.print("</div>");
                        
                        out.print("<div id=\"change_password\"><a href=\"#\" onClick=\"edit_password('"+usernameToShow+"')\">Change Password</a></div>");
                        out.print("<div id=\"password_form\">");
                        out.print("<div id=\"newpassword\">");
                        out.print("<div id=\"left-profile-body\">New Password</div><div id=\"right-profile-body\"> : <input type=\"text\" name=\"newPass\" id=\"newpasstext\" onKeyUp=\"check_password('"+usernameToShow+"')\"></div>");
                        out.print("</div>");
                        out.print("<div id=\"warning-message\"></div>");
                        out.print("<br>");
                        out.print("</div>");
                    }
                %>
                <p>Joined on : <% out.print(userShow.get("join"));%></p>
                                <div>
                                        <div id="left-main-body"><p>About Me :</p></div>
                                        <div id="right-main-body">
                        <% 
                            if(userActive.equals(usernameToShow)){
                                out.print("<a href=\"#\" onClick=\"edit_aboutme('"+userActive+"')\"><u><p>edit</p></u></a>");
                            }else{
                                out.print("<br />");	
                            }
                        %>
                </div>
                                </div>
                                <div id="about">
                                        <div id="aboutme_show"><% out.print(userShow.get("aboutme"));%></div>
                                <div id="aboutme_edit"><input type="text" id="aboutme_to_edit" size=80></div>
                                </div>
                        </div>
                </div>
                <br><br>
                <div><hr id="border"></div>
                <div id="biodata">
                        <div>
                                <div id="left-profile-name"><p>Full Name : <% out.print(userShow.get("fullname"));%></p></div>
                                <div id="left-profile-newname"><p>Full Name : <input type="text" id="newname"></p></div>
                                <div id="right-profile-editname">
                                <% 
                                    if(userActive.equals(usernameToShow)){
                                        out.print("<a href=\"#\" onclick=\"edit_fullname('"+userActive+"')\"><u><p>edit</p></u></a>");
                                    }
                                %>
            </div>
                        </div>
                        <br><br><br>
                        <div>
                                <div id="left-profile-birthday"><p>Birth Date : <% out.print(userShow.get("birthday"));%></p></div>
                                <div id="left-profile-newbirthday"><p>Birth Date : <input type="text" id="newbirthday" class="calendarSelectDate" name="textDeadline"/><div id="calendarDiv"></div></p></div>
                                <div id="right-profile-editbirthday">
                                <% 
                                    if(userActive.equals(usernameToShow)){
                                        out.print("<a href=\"#\" onClick=\"edit_birthday('"+usernameToShow+"')\"><u><p>edit</p></u></a>");
                                    }
                                %>
            </div>
                        </div>
                        <br><br><br>
                        <div>
                                <div id="left-profile-email"><p>Email : <i><% out.print(userShow.get("email"));%></i></p></div>
                                <div id="left-profile-newemail"><p>Email : <input type="text" id="newemail"></i></p></div>
                                <div id="right-profile-editemail">
                <% 
                    if(userActive.equals(usernameToShow)){ 
                        out.print("<a href=\"#\" onClick=\"edit_email('"+usernameToShow+"')\"><u><p>edit</p></u></a>");
                    }
                %>
            </div>
                        </div>
                </div>
                <br><br><br>
                <div id="unfinished-task">
                        <div>
                                <div id="left-profile-unfinished"><h3>Unfinished Task</h3></div>
                                <div id="right-profile-body">
                                </div>	
                        </div>

                        <div>
                                <ul>
                                <% 
                                    GetConnection getCon = new GetConnection();
                                    Connection conn = getCon.getConnection();
                                    Statement stt = conn.createStatement();
                                    String query = "SELECT distinct taskid FROM assignee WHERE username='"+usernameToShow+"'";
                                    ResultSet rs = stt.executeQuery(query);
                                    while(rs.next()){
                                        HashMap<String,String> task = func.GetTask(rs.getString("taskid"));
                                        if (task != null){
                                            if(task.get("status").equals("UNCOMPLETE")){
                                                    out.print("<li><a href=\"task_page.jsp?taskid="+task.get("taskid") +"\">"+task.get("taskname")+"</a></li>");
                                            }
                                        }
                                    }
                                %>
                                </ul>
                        </div>
                </div>

                <div id="finished-task">
                        <div>
                                <div id="left-profile-finished"><h3>Finished Task</h3></div>
                                <div id="right-profile-body"><p></p>
                                </div>	
                        </div>

                        <div>
                                <ul>
                                <% 
                                    query = "SELECT distinct taskid FROM assignee WHERE username='"+usernameToShow+"'";
                                    rs = stt.executeQuery(query);
                                    while(rs.next()){
                                        HashMap<String,String> task = func.GetTask(rs.getString("taskid"));
                                        if (task != null){
                                            if(task.get("status").equals("COMPLETE")){
                                                    out.print("<li><a href=\"task_page.jsp?taskid="+task.get("taskid") +"\">"+task.get("taskname")+"</a></li>");
                                            }
                                        }
                                    }
                                    conn.close();
                                %>
                                </ul>
                        </div>
                </div>
                <br>
        </div>
    </body>
</html>
