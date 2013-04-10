<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="progin3.DbUtil" %>
<link rel="stylesheet" type="text/css" href="style.css">
<div id="header">
    <div id="logo">
            <img src="./assets/logo.png" href="./home.php"/>
    </div>
    <div id="headerright">
        <div id="usernamelogo">						
            <a href="profile.php"><!--<?echo $_SESSION['user']?>--></a>
            <img src="<?echo $row['avatar']?>" href="profile.html"/>
        </div>
        <div id="menu">
            <ul>
                <li> <a href="home.php"> DASHBOARD </a> </li>
                <li> <a href="profile.php"> PROFILE </a> </li>
                <li> <a href="logout.php" onclick=localStorage.removeItem("userlogin");> LOGOUT </a> </li>
            </ul>
            <form method="post" action="searchresult.jsp">
                <select id="filterbox" name="filter">						
                    <option>all</option>							
                    <option>username</option>
                    <option>category</option>
                    <option>task</option>							
                </select>
                <input class="box" type="text" name="keyword" onclick="this.value='';" onfocus="this.select()" onblur="this.value=!this.value?'Enter search query':this.value;" placeholder="Enter search query">
                <input class="headerbutton" name="search" type="submit" value="">			
            </form>            
        </div>
    </div>    
</div>
