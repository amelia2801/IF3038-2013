<%-- 
    Document   : listCategory
    Created on : Apr 9, 2013, 7:09:16 PM
    Author     : User
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
        <title>JSP Page</title>
    </head>
    <body>
        <%
        /*session management*/
        String userActive = "";
        if(request.getSession().getAttribute("userlistapp")==null){
            response.sendRedirect("index.jsp");
        }else{
            userActive = request.getSession().getAttribute("userlistapp").toString();
        }
        
        GetConnection getCon = new GetConnection();
        Connection conn = getCon.getConnection();
        Statement stt = conn.createStatement();
        String query = "SELECT * FROM category";
        ResultSet rs = stt.executeQuery(query);
        
        out.print("<div id=\"category-list\">");
        out.print("<div><hr id=\"border\"></div>");
        
        int i = 0;
        
        Function FuncClass = new Function();
        
        while(rs.next()){
            out.print("<div class=\"task-category-body\">");
            out.print("<div><div class=\"category-title\"><b>"+rs.getString("categoryname") +"</b></div><div class=\"delete-category\" align=\"right\">");
            
            if(userActive.equals(rs.getString("username"))){
                out.print("<a href=\"deletecategory?id="+rs.getString("categoryid")+"\"><input name=\"delete\" type=\"button\" value=\"Delete Category\"/></a>");
                out.print("</div>");
                out.print("</div>");
                out.print("<div class=\"category-title-secondary\">Created by : <i>"+rs.getString("username")+"</i>, at "+rs.getString("createddate")+"</div><br>");
            }
            else {
                out.print("</div>");
                out.print("</div>");
                out.print("<div class=\"kosong\">Created by : <i>"+rs.getString("username")+"</i>, at "+rs.getString("createddate")+"</div><br>");
            }
            
            out.print("<ul>");
            
            Statement stt2 = conn.createStatement();
            String query2 = "SELECT * FROM task WHERE categoryid = '"+rs.getString("categoryid")+"'";
            ResultSet rs2 = stt2.executeQuery(query2);
            
            while(rs2.next()){
                String taskid = FuncClass.getTaskId(rs2.getString("taskname"), rs2.getString("categoryid"));
                out.print("<br><li><a href = \"task_page.jsp?taskid="+taskid+"\">"+rs2.getString("taskname")+"</a><div class=\"task-tag\">submit by : <b><i>"+rs2.getString("username")+"</i></b>, deadline : "+rs2.getString("deadline")+", status : <b id=\"red-text"+(i++)+"\">"+rs2.getString("status")+"</b></div>");
		out.print("<br><div><div id=\"task-tag-delete\">");
                
                if(userActive.equals(rs2.getString("username"))){
                    out.print("<a href=\"deletetask?taskid="+rs2.getString("taskid")+"\" onClick=\"confirmTask()\"><i>Delete Task</i></a>");
                }
                
                if(FuncClass.isAssignee(userActive, taskid)){
                    out.print("<div class=\"task-tag\"><a href=\"javascript:setCompleteStatus("+(i-1)+","+taskid+")\"><i>Change Status</i></a></div>");
                }
                
                out.print("</div><br><br>");
		out.print("<div id=\"task-tag\">Tag :<br>");
                
                Statement stt3 = conn.createStatement();
                String query3 = "SELECT tagid FROM task_tag WHERE taskid = '"+taskid+"'";
                ResultSet rs3 = stt3.executeQuery(query3);
                
                while(rs3.next()){
                    String tagname = FuncClass.getTagname(rs3.getString("tagid"));
                    out.print("<u>"+tagname+"</u>");
                }
                out.print("</div>");
                out.print("</li><br>");
            }
            out.print("<br><br><br>");
            if(FuncClass.isResponsibility(rs.getString("categoryid"), userActive)){
        	out.print("<div class = \"add-task\"><a href = \"add_task.jsp?categoryid="+rs.getString("categoryid")+"\"><button>+New Task</button></a></div>");
            }
            out.print("</ul>");
            out.print("</div>");
            out.print("<div><hr id=\"border\"></div>");
        }
        out.print("</div>");
        conn.close();
        %>
    </body>
</html>
