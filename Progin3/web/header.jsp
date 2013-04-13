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
            <form method="GET" action="searchresult.jsp">
                <select id="filterbox" name="filter">						
                    <option>all</option>							
                    <option>username</option>
                    <option>category</option>
                    <option>task</option>							
                </select>
                <input class="box" type="text" name="keyword" onclick="this.value='';" onkeyup="checkAutoComplete(this.value);" onfocus="this.select();" onblur="this.value=!this.value?'Enter search query':this.value;" placeholder="Enter search query" autocomplete="off">
                <input class="headerbutton" name="search" type="submit" value="">			                
            </form>            
        </div>
        <div id="suggest"></div>
    </div>    
</div>
<script type="text/javascript">
    function checkAutoComplete(str){
        var obj = document.getElementById("suggest");
        var fil = document.getElementById("filterbox").value;
        if(str.length == 0){
            obj.innerHTML = "";
            obj.style.visibility = "hidden";
            obj.style.border = "0px";
        }else{
            var xmlhttp;
            if(window.XMLHttpRequest){
                xmlhttp = new XMLHttpRequest();                
            }else{
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            xmlhttp.onreadystatechange = function(){
                if(xmlhttp.readyState == 4 && xmlhttp.status == 200){
                    //alert(xmlhttp.responseText);
                    if(xmlhttp.responseText != "empty" && xmlhttp.responseText != "complete") {
                        obj.innerHTML = xmlhttp.responseText;                    
                        obj.style.visibility = "visible";
                        obj.style.border = "3px ridge #A5ACB2";
                        obj.style.left = "670px";
                        obj.style.width = "230px";
                        obj.style.position = "relative";
                        obj.style.background = "white";
                        obj.style.color = "black";
                    }else{
                        obj.innerHTML = "";
                        obj.style.visibility = "hidden";
                        obj.style.border = "0px";
                    }
                }
            }
            xmlhttp.open("GET","autocomplete?filter="+fil+"&str="+str,true);
            xmlhttp.send();
        }
    }
</script>