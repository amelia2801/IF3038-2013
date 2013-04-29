<%-- 
    Document   : add_task
    Created on : Apr 6, 2013, 8:16:49 AM
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
        <title>Add New Task</title>
        <%
	    String userAgent = request.getHeader("user-agent").toLowerCase();
	    if (userAgent.matches(".*(android|avantgo|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\\/|plucker|pocket|psp|symbian|treo|up\\.(browser|link)|vodafone|wap|windows (ce|phone)|xda|xiino).*") || userAgent.substring(0, 4).matches("1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\\-(n|u)|c55\\/|capi|ccwa|cdm\\-|cell|chtm|cldc|cmd\\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\\-s|devi|dica|dmob|do(c|p)o|ds(12|\\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\\-|_)|g1 u|g560|gene|gf\\-5|g\\-mo|go(\\.w|od)|gr(ad|un)|haie|hcit|hd\\-(m|p|t)|hei\\-|hi(pt|ta)|hp( i|ip)|hs\\-c|ht(c(\\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\\-(20|go|ma)|i230|iac( |\\-|\\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\\/)|klon|kpt |kwc\\-|kyo(c|k)|le(no|xi)|lg( g|\\/(k|l|u)|50|54|e\\-|e\\/|\\-[a-w])|libw|lynx|m1\\-w|m3ga|m50\\/|ma(te|ui|xo)|mc(01|21|ca)|m\\-cr|me(di|rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\\-2|po(ck|rt|se)|prox|psio|pt\\-g|qa\\-a|qc(07|12|21|32|60|\\-[2-7]|i\\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\\-|oo|p\\-)|sdk\\/|se(c(\\-|0|1)|47|mc|nd|ri)|sgh\\-|shar|sie(\\-|m)|sk\\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\\-|v\\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\\-|tdg\\-|tel(i|m)|tim\\-|t\\-mo|to(pl|sh)|ts(70|m\\-|m3|m5)|tx\\-9|up(\\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|xda(\\-|2|g)|yas\\-|your|zeto|zte\\-")) {
		out.println("<link href=\"css/style-mobile.css\" rel=\"stylesheet\" type=\"text/css\" />");
	    } else {
		out.println("<link href=\"css/style.css\" rel=\"stylesheet\" type=\"text/css\" />");
	    }
	%>
        <script src="javascript/calendar.js"></script>
        <link href="css/calendar.css" rel="stylesheet">
        <script type="text/javascript" src="javascript/add_task.js"></script>
    </head>
    <body>
        <%
        /*session management*/
        if(request.getSession().getAttribute("userlistapp")==null){
            response.sendRedirect("index.jsp");
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
                <div id="task-page-body">
                        <h1>Category: 
                        <%
                            String categoryid = request.getParameter("categoryid");
                            out.print(func.getCategoryName(categoryid));
                        %>
                        
        </h1>
                        <div id="add-task">
                                Task name:<br><br>
                                Attach file:<br><br><br><br><br><br>
                                Deadline,<br>
                                Date:<br>
                                Time:<br><br>
                                Asignee:<br><br>
                                Tag:
                        </div>
                        <div id="add-task-form">
                            <form enctype="multipart/form-data" method="post" action="inserttask?categoryid=<%=categoryid %>">
                                <!--Name-->
                                <div id="spacing">
                                <input type="text" id="taskname" onKeyUp="check_task_name()" name="textTaskName"/>
                                </div>
                                <!--Attachment
            "
            -->
                                <div id="spacing-attach">
                                <input id="attached1" onChange="check_attachment1()" type="file" name="attachment1"/><br />
                                <input id="attached2" onChange="check_attachment2()" type="file" name="attachment2"/><br />
                                <input id="attached3" onChange="check_attachment3()" type="file" name="attachment3"/><br />
                                <input id="attached4" onChange="check_attachment4()" type="file" name="attachment4"/><br />
                                <input id="attached5" onChange="check_attachment5()" type="file" name="attachment5"/>
                                </div>					
                                <!--Deadline-->
                                <div id="spacing-deadline">
                                <input type="text" class="calendarSelectDate" name="textDeadline"/><div id="calendarDiv"></div><br />
                                <input type="text" onKeyUp="check_time()" id="time" name="textTimeDeadline" placeholder="HH:MM"/>
                                </div>
                                <!--Assignee-->
                                <div id="spacing">
                                <input type="text" id="task-assignee" onKeyUp="addAssignee()" name="textAssignee" list="assignee-task" value="" placeholder="Assignee1,Assignee2,Assignee3">
                                <div id="shared-with"></div>
                                </div>
                                <!--Tag (multivalue)-->
                                <div id="spacing">
                                <input type="text" id="tag" onKeyUp="check_tag()" name="textTag" placeholder="tag1,tag2,tag3"/>
                                </div>
                                <div id="warning-message"></div>
                                <button id="create">Add Task</button>
                        </form>
                        </div>
                </div>
        </div>
    </body>
</html>
