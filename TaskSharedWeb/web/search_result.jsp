<%-- 
    Document   : search_result
    Created on : Apr 6, 2013, 8:26:18 AM
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
        <title>Search Result</title>
        <%
	    String userAgent = request.getHeader("user-agent").toLowerCase();
	    if (userAgent.matches(".*(android|avantgo|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\\/|plucker|pocket|psp|symbian|treo|up\\.(browser|link)|vodafone|wap|windows (ce|phone)|xda|xiino).*") || userAgent.substring(0, 4).matches("1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\\-(n|u)|c55\\/|capi|ccwa|cdm\\-|cell|chtm|cldc|cmd\\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\\-s|devi|dica|dmob|do(c|p)o|ds(12|\\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\\-|_)|g1 u|g560|gene|gf\\-5|g\\-mo|go(\\.w|od)|gr(ad|un)|haie|hcit|hd\\-(m|p|t)|hei\\-|hi(pt|ta)|hp( i|ip)|hs\\-c|ht(c(\\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\\-(20|go|ma)|i230|iac( |\\-|\\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\\/)|klon|kpt |kwc\\-|kyo(c|k)|le(no|xi)|lg( g|\\/(k|l|u)|50|54|e\\-|e\\/|\\-[a-w])|libw|lynx|m1\\-w|m3ga|m50\\/|ma(te|ui|xo)|mc(01|21|ca)|m\\-cr|me(di|rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\\-2|po(ck|rt|se)|prox|psio|pt\\-g|qa\\-a|qc(07|12|21|32|60|\\-[2-7]|i\\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\\-|oo|p\\-)|sdk\\/|se(c(\\-|0|1)|47|mc|nd|ri)|sgh\\-|shar|sie(\\-|m)|sk\\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\\-|v\\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\\-|tdg\\-|tel(i|m)|tim\\-|t\\-mo|to(pl|sh)|ts(70|m\\-|m3|m5)|tx\\-9|up(\\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|xda(\\-|2|g)|yas\\-|your|zeto|zte\\-")) {
		out.println("<link href=\"css/style-mobile.css\" rel=\"stylesheet\" type=\"text/css\" />");
	    } else {
		out.println("<link href=\"css/style.css\" rel=\"stylesheet\" type=\"text/css\" />");
	    }
	%>
	<script type="text/javascript" src="javascript/search_result.js"></script>
    </head>
    <body>
        <%
        /*session management*/
        if(request.getSession().getAttribute("userlistapp")==null){
            response.sendRedirect("index.jsp");
        }
        %>
        <div id="main-body-general">
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
                <div id="search-result-body">
                    <%
                        int mode = Integer.parseInt(request.getParameter("modesearch"));
                        String text = request.getParameter("search_text");
                        
                        GetConnection getCon = new GetConnection();
                        Connection conn = getCon.getConnection();
                        Statement stt = conn.createStatement();
                        String query;
                        ResultSet rs;
                        switch(mode) {
                            case 1: 
                                out.print("<div id=\"task-search\"><div id=\"dashboard-title\"><i><b>USER<br /></b></i></div><br><div><hr id=\"border-search\"></div><br>");
                                query = "SELECT * FROM user WHERE username LIKE '%"+text+"%'";
                                rs = stt.executeQuery(query);
                                while(rs.next()){
                                    out.print("<div id=\"user-result\">"
                                            + " <div id=\"user-result-image\">"
                                            + "     <a href=\"profile.jsp?username="+rs.getString("username")+"\"><img alt=\"Avatar\" id=\"photo\" src=\"../avatar/"+rs.getString("avatar")+"\" width=\"100\" height=\"120\"/></a>"
                                            + " </div>"
                                            + " <div id=\"user-result-name\">"
                                            + "     <div id=\"dashboard-title\"><a href=\"profile.jsp?username="+rs.getString("username")+"\"><b>"+rs.getString("username")+"</b></a></div><br>"
                                            + "     Full Name : "+rs.getString("fullname")+"<br>"
                                            + "     Joined On : "+rs.getString("join")+""
                                            + " </div>"
                                            + "</div>");
                                }
                                out.print("<div><hr id=\"border-search\"></div><br>"
                                           + "<div id=\"dashboard-title\"><i><b>CATEGORY<br /></b></i></div><br>"
                                           + "<div><hr id=\"border-search\"></div><br>");
                                query = "SELECT * FROM category WHERE categoryname LIKE '%"+text+"%'";
                                rs = stt.executeQuery(query);
                                while(rs.next()){
                                    out.print("<div class=\"task-category-body\">"
                                            + " <br><div><div id=\"category-title\"><b>"+rs.getString("categoryname")+"</b></div></div>"
                                            + " <div class=\"kosong\">Created by : <i>"+rs.getString("username")+"</i>, at "+rs.getString("createddate")+"</div>"
                                            + " <ul>");
                                    Statement stt2 = conn.createStatement();
                                    String query2 = "SELECT * FROM task WHERE categoryid="+rs.getString("categoryid");
                                    ResultSet rs2 = stt2.executeQuery(query2);
                                    while(rs2.next()) {
                                        out.print("<li><a href = \"task_page.jsp?taskid="+rs2.getString("taskid")+"\">"+rs2.getString("taskname")+"</a></li>");
                                    }
                                    out.print(" </ul>"
                                            + "</div>");
                                }
                                out.print("<div><hr id=\"border-search\"></div><br>"
                                        + " <div id=\"dashboard-title\"><i><b>TASK<br /></b></i></div><br>"
                                        + " <div><hr id=\"border-search\"></div><br>");
                                query = "SELECT * FROM task WHERE taskname LIKE '%"+text+"%'";
                                rs = stt.executeQuery(query);
                                int i = 0;
                                while(rs.next()) {
                                    out.print("<div id=\"task-result\">"
                                            + " <ul>"
                                            + "     <li><a href = \"task_page.jsp?taskid="+rs.getString("taskid")+"\">"+rs.getString("taskname")+"</a><div class=\"task-tag\">submit by : <b><i>"+rs.getString("username")+"</i></b>, deadline : "+rs.getString("deadline")+", status : <b id=\"red-text\">"+rs.getString("status")+"</b></div>"
                                            + "     <br><div>"
                                            + "     <div class=\"task-tag\">Set as <a href=\"javascript:setCompleteStatus("+i+","+rs.getString("taskid")+")\">Change Status</a></div></div><br><br>"
                                            + "     <div id=\"task-tag\">"
                                            + "     Tag :<br>");
                                    Statement stt2 = conn.createStatement();
                                    String query2 = "SELECT * FROM task_tag WHERE taskid="+rs.getString("taskid");
                                    ResultSet rs2 = stt2.executeQuery(query2);
                                    while(rs2.next()) {
                                        HashMap<String, String> tag = func.GetTag(rs2.getString("tagid"));
                                        out.print("<u>"+tag.get("tagname")+"</u>");
                                    }
                                    out.print("     </div>"
                                            + "     </li><br><br>"
                                            + " </ul>"
                                            + "</div>");
                                    i++;
                                }
                                out.print("</div>");
                                break;
                            case 2:
                                out.print("<div class=\"task-category-body\">"
                                        + " <div id=\"dashboard-title\"><b>USER<br /></b><br /></div>"
                                        + " <div id=\"sort\">"
                                        + "     Sort by :"
                                        + "     <select name=\"Sort by\">"
                                        + "         <option value=\"Auto\">Auto</option>"
                                        + "         <option value=\"Name\">Name</option>"
                                        + "         <option value=\"Date\">Date</option>"
                                        + "     </select>&nbsp;"
                                        + " </div>");
                                int mode2 = Integer.parseInt(request.getParameter("filtering"));
                                query = "";
                                switch(mode2){
                                    case 1 :
                                        query = "SELECT * FROM user WHERE username LIKE '%"+text+"%'";
                                        break;
                                    case 2 :
                                        query = "SELECT * FROM user WHERE email LIKE '%"+text+"%'";
                                        break;
                                    case 3 :
                                        query = "SELECT * FROM user WHERE fullname LIKE '%"+text+"%'";
                                        break;
                                    case 4 :
                                        query = "SELECT * FROM user WHERE birthdate LIKE '%"+text+"%'";
                                        break;
                                }
                                rs = stt.executeQuery(query);
                                while (rs.next()) {
                                    out.print("<div id=\"user-result\">"
                                            + " <div id=\"user-result-image\">"
                                            + "     <a href=\"profile.jsp?username="+rs.getString("username")+"\"><img alt=\"Avatar\" id=\"photo\" src=\"../avatar/"+rs.getString("avatar")+"\" width=\"100\" height=\"120\"/></a>"
                                            + " </div>"
                                            + " <div id=\"user-result-name\">"
                                            + "     <div id=\"dashboard-title\"><a href=\"profile.jsp?username="+rs.getString("username")+"\"><b>"+rs.getString("username")+"</b></a></div><br>"
                                            + "     Full Name : "+rs.getString("fullname")+"<br>"
                                            + "     Joined On : "+rs.getString("join")+""
                                            + " </div>"
                                            + "</div>");
                                }
                                out.print("</div>");
                                break;
                            case 3:
                                out.print("<div class=\"task-category-body\">"
                                        + " <div id=\"dashboard-title\"><b>CATEGORY<br /></b><br /></div>"
                                        + " <div id=\"sort\">"
                                        + "     Sort by :"
                                        + "     <select name=\"Sort by\">"
                                        + "         <option value=\"Auto\">Auto</option>"
                                        + "         <option value=\"Name\">Name</option>"
                                        + "         <option value=\"Date\">Date</option>"
                                        + "     </select>&nbsp;"
                                        + " </div>");
                                query = "SELECT * FROM category WHERE categoryname LIKE '%"+text+"%'";
                                rs = stt.executeQuery(query);
                                while(rs.next()){
                                    out.print("<div class=\"task-category-body\">"
                                            + " <br><div><div id=\"category-title\"><b>"+rs.getString("categoryname")+"</b></div></div>"
                                            + " <div class=\"kosong\">Created by : <i>"+rs.getString("username")+"</i>, at "+rs.getString("createddate")+"</div>"
                                            + " <ul>");
                                    Statement stt2 = conn.createStatement();
                                    String query2 = "SELECT * FROM task WHERE categoryid="+rs.getString("categoryid");
                                    ResultSet rs2 = stt2.executeQuery(query2);
                                    while(rs2.next()) {
                                        out.print("<li><a href = \"task_page.jsp?taskid="+rs2.getString("taskid")+"\">"+rs2.getString("taskname")+"</a></li>");
                                    }
                                    out.print(" </ul>"
                                            + "</div>");
                                }
                                out.print("</div>");
                                break;
                            case 4:
                                out.print("<div id=\"task-search\">"
                                        + " <div id=\"dashboard-title\"><b>TASK<br /></b><br /></div>"
                                        + " <div id=\"sort\">"
                                        + "     Sort by :"
                                        + "     <select name=\"Sort by\">"
                                        + "         <option value=\"Auto\">Auto</option>"
                                        + "         <option value=\"Name\">Name</option>"
                                        + "         <option value=\"Date\">Date</option>"
                                        + "     </select>&nbsp;"
                                        + " </div>");
                                query = "SELECT * FROM task WHERE taskname LIKE '%"+text+"%'";
                                rs = stt.executeQuery(query);
                                int j = 0;
                                while(rs.next()) {
                                    out.print("<div id=\"task-result\">"
                                            + " <ul>"
                                            + "     <li><a href = \"task_page.jsp?taskid="+rs.getString("taskid")+"\">"+rs.getString("taskname")+"</a><div class=\"task-tag\">submit by : <b><i>"+rs.getString("username")+"</i></b>, deadline : "+rs.getString("deadline")+", status : <b id=\"red-text\">"+rs.getString("status")+"</b></div>"
                                            + "     <br><div>"
                                            + "     <div class=\"task-tag\">Set as <a href=\"javascript:setCompleteStatus("+j+","+rs.getString("taskid")+")\">Change Status</a></div></div><br><br>"
                                            + "     <div id=\"task-tag\">"
                                            + "     Tag :<br>");
                                    Statement stt2 = conn.createStatement();
                                    String query2 = "SELECT * FROM task_tag WHERE taskid="+rs.getString("taskid");
                                    ResultSet rs2 = stt2.executeQuery(query2);
                                    while(rs2.next()) {
                                        HashMap<String, String> tag = func.GetTag(rs2.getString("tagid"));
                                        out.print("<u>"+tag.get("tagname")+"</u>");
                                    }
                                    out.print("     </div>"
                                            + "     </li><br><br>"
                                            + " </ul>"
                                            + "</div>");
                                    j++;
                                }
                                out.print("</div>");
                                break;
                        }
                        conn.close();
                    %>
            </div>
        </div>
    </body>
</html>
