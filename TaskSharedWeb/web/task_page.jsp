<%-- 
    Document   : task_page
    Created on : Apr 6, 2013, 8:26:09 AM
    Author     : VAIO
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="Class.GetConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.HashMap"%>
<%@page import="Class.Function"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Task</title>
        <%
	    String userAgent = request.getHeader("user-agent").toLowerCase();
	    if (userAgent.matches(".*(android|avantgo|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\\/|plucker|pocket|psp|symbian|treo|up\\.(browser|link)|vodafone|wap|windows (ce|phone)|xda|xiino).*") || userAgent.substring(0, 4).matches("1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\\-(n|u)|c55\\/|capi|ccwa|cdm\\-|cell|chtm|cldc|cmd\\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\\-s|devi|dica|dmob|do(c|p)o|ds(12|\\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\\-|_)|g1 u|g560|gene|gf\\-5|g\\-mo|go(\\.w|od)|gr(ad|un)|haie|hcit|hd\\-(m|p|t)|hei\\-|hi(pt|ta)|hp( i|ip)|hs\\-c|ht(c(\\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\\-(20|go|ma)|i230|iac( |\\-|\\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\\/)|klon|kpt |kwc\\-|kyo(c|k)|le(no|xi)|lg( g|\\/(k|l|u)|50|54|e\\-|e\\/|\\-[a-w])|libw|lynx|m1\\-w|m3ga|m50\\/|ma(te|ui|xo)|mc(01|21|ca)|m\\-cr|me(di|rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\\-2|po(ck|rt|se)|prox|psio|pt\\-g|qa\\-a|qc(07|12|21|32|60|\\-[2-7]|i\\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\\-|oo|p\\-)|sdk\\/|se(c(\\-|0|1)|47|mc|nd|ri)|sgh\\-|shar|sie(\\-|m)|sk\\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\\-|v\\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\\-|tdg\\-|tel(i|m)|tim\\-|t\\-mo|to(pl|sh)|ts(70|m\\-|m3|m5)|tx\\-9|up(\\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|xda(\\-|2|g)|yas\\-|your|zeto|zte\\-")) {
		out.println("<link href=\"css/style-mobile.css\" rel=\"stylesheet\" type=\"text/css\" />");
	    } else {
		out.println("<link href=\"css/style.css\" rel=\"stylesheet\" type=\"text/css\" />");
	    }
	%>
        <script type="text/javascript" src="javascript/task_page.js"></script>
        <script src="javascript/calendar.js"></script>
        <link href="css/calendar.css" rel="stylesheet">
    </head>
    <body onLoad="check_html5()">
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
                            HashMap<String,String> task = new HashMap<String, String>();
                            String idtaskToShow = request.getParameter("taskid");
                            HashMap<String, String> taskShow = func.GetTask(idtaskToShow);
                        %>
                </div>

                <div id="nomargin"><hr id="border"></div>

                <!--Body-->
                <div id="task-page-body">
                        <div id="task-page-title">
                                <div>
                                    <h1><% out.print(taskShow.get("taskname"));%></h1>
                                        <i><div id="delete-task">
                                        <% 
                                            String creator = taskShow.get("username");
                                            if(creator.equals(userActive)){
                                                    out.print("<a href=\"deletetask?taskid="+idtaskToShow +"\" onClick=\"confirmTask()\"><i>Delete This Task</i></a>");
                                            }
                                        %>
                <br><br></div></i>
                                        Submit by <b><i><% out.print(taskShow.get("username"));%></i></b> at. <% out.print(taskShow.get("createddate"));%>
                                </div>
                                <br>
                                <div id="deadline_done">
                                        <div id="left-main-body">Deadline : <% out.print(taskShow.get("deadline"));%></div>
                                        <% 
                                                if((new Function()).isAssignee(userActive, idtaskToShow)){
                                                        out.print("<div id=\"right-main-body\"><a href=\"#\" onCLick=\"edit_deadline()\" id=\"editDeadline\"><u>edit</u></a></div>");
                                                }
                                        %>
                                </div>
                                <div id="deadline_edit">
                                        <div id="left-main-body"><div id="label">Deadline : </div>
                                                <div id="date_html">
                                                        <input id="datedeadlineinput" type="text" class="calendarSelectDate" name="textDeadlineDate" placeholder="YYYY-MM-DD"/><div id="calendarDiv"></div><br />
                                                        <input id="timedeadlineinput" type="text" name="textDeadlineTime" placeholder="HH:MM"/>
                                                </div>              
                                        </div>
                                        <div id="right-main-body"><a href="#" onCLick="finish_deadline(<% out.print(taskShow.get("taskid"));%>)"><u>done</u></a></div>
                                </div>
                                <br><br><br>
            <div>
                                        <div id="left-main-body4">Status : <% out.print(taskShow.get("status"));%></div> 
                                        <div id="right-main-body">
                                        <% 
                                                if((new Function()).isAssignee(userActive, idtaskToShow)){
                                                        out.print("<input name=\"changeStatus\" type=\"button\" value=\"Change Status\" onClick=\"setCompleteStatus("+taskShow.get("taskid")+")\" id=\"editStatus\">");
                                                }
                                        %>                   
                </div>
                                </div>
                        </div>
                        <br><br><br><br>
                        <div id="attachment">
                                <div id="image-attachment">
                                        <div>
                                        <br>
                                        <br>
                                                <% 
                                                    GetConnection getCon = new GetConnection();
                                                    Connection con = getCon.getConnection();
                                                    String query = "SELECT filename FROM attachment WHERE taskid = "+idtaskToShow;
                                                    Statement stt = con.createStatement();
                                                    ResultSet result = stt.executeQuery(query);
                                                    while(result.next()){
                                                            String filename = result.getString("filename");
                                                            if(func.GetTypeFile(filename) == 0){
                                                                    out.print("<img id=\"screenshots\" src=\"attachment/"+filename+"\" alt=\""+filename+"\" title=\"$filename\"\">");
                                                            }
                                                    }
                                                %>
                                        </div>
                                </div>
            <div id="video-attachment">
                                        <% 
                                            query = "SELECT filename FROM attachment WHERE taskid = "+idtaskToShow;
                                            result = stt.executeQuery(query);
                                            while(result.next()){
                                                String filename = result.getString("filename");
                                                if(func.GetTypeFile(filename) == 1){
                                                    out.print("<video width=\"320\" height=\"240\" controls>");
                                                    out.print("<source src=\"attachment/"+filename+"\" type=\"video/mp4\">");
                                                    out.print("</video>");
                                                }
                                            }
                                        %>
                                </div>
                                <div id="other-attachment">
                                        <p>External File:</p>
                                        <ul>
                                                <% 
                                                    query = "SELECT filename FROM attachment WHERE taskid = "+idtaskToShow;
                                                    result = stt.executeQuery(query);
                                                    while(result.next()){
                                                        String filename = result.getString("filename");
                                                        if(func.GetTypeFile(filename) == 2){
                                                            out.print("<li><a href=\"attachment/"+filename+"\">"+filename+"</a></li>");
                                                        }
                                                    }
                                                %>
                                        <ul>
                                </div>
                        </div>
                        <div>
                                <div id="task-nomargin" name="1"><div id="assignee_done">
                                        <div id="left-main-body2">Shared with : <i>
                                        <%
                                            query = "SELECT username FROM assignee WHERE taskid = "+idtaskToShow;
                                            result = stt.executeQuery(query);
                                            while(result.next()){
                                                out.print("<a href=\"profile.jsp?username="+result.getString("username") +"\"> <u>"+result.getString("username")+"</u> </a>");
                                            }
                                        %>
                </i></div>
                                        <div id="right-main-body">
                    <% 
                        if((new Function()).isAssignee(userActive, idtaskToShow)){
                                        out.print("<a href=\"#2\" onClick=\"edit_assignee()\"  id=\"editAssignee\"><u>edit</u></a>");
                        }
                    %>
                </div>
                                </div></div>
                                <div id="assignee_edit" name="2">
                                        <div id="left-main-body">Shared with : <input id="task-assignee" type="text" name="textAssignee" list="assignee-task" onKeyUp="autoCompleteAsignee()" placeholder="Assignee1,Assignee2,Assignee3"/>
                                        <div id="shared-with"></div>
                                        </div>
                                        <div id="right-main-body"><a href="#1" onClick="finish_assignee(<% out.print(idtaskToShow); %>)"><u>done</u></a></div>
                                </div>
                                <br>
                                <br>
                                <div id="task-nomargin" name="3"><div id="tag_done">
                                        <div id="left-main-body3">Tag : <i>
                        <% 
                            query = "SELECT tagid FROM task_tag WHERE taskid = "+idtaskToShow;
                            result = stt.executeQuery(query);
                            while(result.next())
                            {
                                HashMap<String,String> tag = func.GetTag(result.getString("tagid"));
                                out.print(" <u>"+tag.get("tagname")+"</u> ");
                            }
                        %>
                </i></div>
                                        <div id="right-main-body">
                <% 
                    if((new Function()).isAssignee(userActive, idtaskToShow)){
                        out.print("<a href=\"#3\" onClick=\"edit_tag()\" id=\"editTag\"><u>edit</u></a>");
                    }
                %>
                </div>
                                </div></div>
                                <div id="tag_edit" name="4">
                                        <div id="left-main-body">Tag : <input id="tag-edit" type="text" placeholder="tag1,tag2,tag3"/></div>
                                        <div id="right-main-body"><a href="#4" onClick="finish_tag(<% out.print(idtaskToShow);%>)"><u>done</u></a></div>
                                </div>
                        </div>
                </div>

                <div id="nomargin"><hr id="border"></div>
             
                <!--Comment-->
                <div id="task-comment">
                        <br>
                        <div id="user-comment">
                            <p id="nComment"><b><% out.print(func.GetNComment(idtaskToShow));%> Comment</b></p>
                                <div name="cmnt" id="comment-list">
                        <%
                        int numpage;
                        if (Integer.parseInt(func.GetNComment(idtaskToShow))%5 == 0) {
                            numpage = (Integer.parseInt(func.GetNComment(idtaskToShow))/5);
                        }
                        else {
                            numpage = (Integer.parseInt(func.GetNComment(idtaskToShow))/5)+1;
                        }
                        int index = 0;
                        query = "SELECT * FROM comment WHERE taskid ="+idtaskToShow+" limit "+index+",5";
                        ResultSet rs = stt.executeQuery(query);
                        while(rs.next()){
                                out.print(" <div id=\"comment\">");
                                out.print(" 	<div id=\"user-info\">");
                                out.print(" 		<div id=\"left-comment-body\">");
                                out.print(" 			<img src=\"avatar/"+func.GetUser(rs.getString("username")).get("avatar") +"\" width=\"50px\" height=\"50px\"/>");
                                out.print(" 		</div>");
                                out.print(" 		<div id=\"right-comment-body\">");
                                out.print(" 			<b id=\"komentator\">"+rs.getString("username") +"</b>");
                                out.print(" 			<br>");
                                out.print(" 			<b id=\"post-date\">Post at "+rs.getString("createdate") +"</b>");
                                out.print(" 		</div>");
                                out.print(" 		<div id=\"delete-comment\">");
                                        if(rs.getString("username").equals(userActive)){
                                            out.print("<a href=\"#cmnt\" onClick=\"deleteComment("+rs.getString("commentid") +","+idtaskToShow+","+index+")\"><i>Delete Comment</i></a>");
                                        }
                                out.print(" 		</div>");
                                out.print(" 	</div>");
                                out.print(" 	<div id=\"comment-box\">");
                                out.print(" 		<p>");
                                out.print(rs.getString("message"));
                                out.print(" 		</p>");
                                out.print(" 	</div>");
                                out.print(" </div>");
                            }
                            out.print("</div>");
                            if (numpage > 1) {
                                out.print("<a href=\"#cmnt\" onClick=\"nextPage("+idtaskToShow+","+index+")\"><i>Next</i></a>");
                            }
                            con.close();
                        %>      
                        </div>
                        <div id="add-comment">
                                <p><b>Leave a comment</b></p>
                                <form>
                                        <textarea id="textarea-comment" rows="8" cols="92" placeholder="Comment about this task..."></textarea>
                                </form>
                                <div><button id="submit-comment" onClick="addComment(<% out.print("'"+idtaskToShow+"','"+index+"'"); %>)">Submit</button>&nbsp;</div>
                        </div>
                        <br>
                </div>

        </div>
    </body>
</html>
