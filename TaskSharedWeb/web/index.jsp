<%-- 
    Document   : index
    Created on : Apr 3, 2013, 6:48:43 PM
    Author     : VAIO
--%>
<%-- Session
<?php 
	session_start();
	if (isset($_SESSION["userlistapp"]))
		header("Location: page/dashboard.php");
?>
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Shared To-do List</title>
        <%
	    String userAgent = request.getHeader("user-agent").toLowerCase();
	    if (userAgent.matches(".*(android|avantgo|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\\/|plucker|pocket|psp|symbian|treo|up\\.(browser|link)|vodafone|wap|windows (ce|phone)|xda|xiino).*") || userAgent.substring(0, 4).matches("1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\\-(n|u)|c55\\/|capi|ccwa|cdm\\-|cell|chtm|cldc|cmd\\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\\-s|devi|dica|dmob|do(c|p)o|ds(12|\\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\\-|_)|g1 u|g560|gene|gf\\-5|g\\-mo|go(\\.w|od)|gr(ad|un)|haie|hcit|hd\\-(m|p|t)|hei\\-|hi(pt|ta)|hp( i|ip)|hs\\-c|ht(c(\\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\\-(20|go|ma)|i230|iac( |\\-|\\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\\/)|klon|kpt |kwc\\-|kyo(c|k)|le(no|xi)|lg( g|\\/(k|l|u)|50|54|e\\-|e\\/|\\-[a-w])|libw|lynx|m1\\-w|m3ga|m50\\/|ma(te|ui|xo)|mc(01|21|ca)|m\\-cr|me(di|rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\\-2|po(ck|rt|se)|prox|psio|pt\\-g|qa\\-a|qc(07|12|21|32|60|\\-[2-7]|i\\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\\-|oo|p\\-)|sdk\\/|se(c(\\-|0|1)|47|mc|nd|ri)|sgh\\-|shar|sie(\\-|m)|sk\\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\\-|v\\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\\-|tdg\\-|tel(i|m)|tim\\-|t\\-mo|to(pl|sh)|ts(70|m\\-|m3|m5)|tx\\-9|up(\\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|xda(\\-|2|g)|yas\\-|your|zeto|zte\\-")) {
		out.println("<link href=\"css/style-mobile.css\" rel=\"stylesheet\" type=\"text/css\" />");
	    } else {
		out.println("<link href=\"css/style.css\" rel=\"stylesheet\" type=\"text/css\" />");
	    }
	%>
        <script type="text/javascript" src="javascript/index.js"></script>
        <script src="javascript/calendar.js"></script>
        <link href="css/calendar.css" rel="stylesheet">
    </head>
    <body onLoad="hide_submit_button();show_register_form();">
        <%
        /*session management*/
        if(request.getSession().getAttribute("userlistapp")!=null){
            response.sendRedirect("dashboard.jsp");
        }
        %>
        <div id="index-body">
        <div id="left-body">
                <!--Website logo + tagline-->
                <div id="header-title"><img src="image/title.png" width="250px" height="80px"/></div><br />
                <!--Site explanantion (image, video, etc)-->
                <div id="web-description">Browse, Manage and Share Your Task!<br /></div>
        </div>
        <div id="right-body">
                <div id="big-name">Get Started<br /></div>
                <!--Login form-->
                <div id="login-form">
                <div id="input-description">
                        Username: <br>
                        Password: <br>
                </div>
                <form>
                        <input type="text" id="login1" /><br />
                        <input type="password" id="login2" /><br />
                        <input type="button" value="Sign In" onClick="login()">
                </form>
                </div>
                <!--Register form-->
                <div id="register-form">
                <div id="input-description">
                        Username: <br>
                        Password: <br>
                        Confirm: <br>
                        Full name: <br>
                        BirthDate&nbsp; <br>
                        Email: <br>
                        Your Avatar: <br>
                </div>
                    <form method="post" action="registration" enctype="multipart/form-data">
                        <!--Username (min. 5 characters != password)-->
                        <input type="text" name="textUsername" id="username" onKeyUp="check_username()"/><br />
                        <!--Password (min. 8 characters) != username and email-->
                        <input type="password" name="textPassword" id="password" onKeyUp="check_password()"/><br />
                        <!--Confirm password == password-->
                        <input type="password" name="textPassword2" id="password2" onKeyUp="confirm_password()"/><br />
                        <!--Full name (min. 2 spaces between 2 characters)-->
                        <input type="text" name="textFullName" id="fullname" onKeyUp="check_full_name()"/><br />
                        <!--Birth date (drop down, year >= 1955)-->
                        <input type="text" name="textBirthday" class="calendarSelectDate" /><div id="calendarDiv"></div>
                        <br />
                        <!--email, validation:
                                min. 1 character before @
                                min. 1 character between @ and .
                                min. 2 characters after .
                                != password-->
                        <input type="text" name="textEmail" id="email" onKeyUp="check_email()"/><br />
                        <!--Avatar, input file, extension == .jpg or .jpeg-->
                        <input type="file" name="textAvatar" id="avatar" onChange="check_avatar()"/><br />
                        <!--Register button, disabled if invalid input exists-->
                        <input id="submit" type="submit" value="Sign Up"/>
                        <div id="warning-message"></div>
                </form><br /></div>
                <div id="login-bottom">Don't have an account? <a href="#" onCLick="show_register_form()">Register</a></div>
                <div id="register-bottom">Already have a account? <a href="#" onClick="show_login_form()">Sign in</a></div>
        </div>
        <div id="big-logo"><a href="dashboard.html"><img src="image/logo.png" width="400px" height="240px"/></a></div>
        </div>
    </body>
</html>
