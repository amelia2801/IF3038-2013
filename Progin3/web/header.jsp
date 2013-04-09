<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="progin3.DbUtil" %>
<div id="header" <!--onload="isAlreadylogin()" -->>
    <div id="logo">
            <img src="../logo.png" href="./home.php"/>
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
            <form method="post" action="searchresult.php">
                <select id="filterbox" name="filter">						
                    <option>all</option>							
                    <option>username</option>
                    <option>category</option>
                    <option>task</option>							
                <select/>
                <input class="box" type="text" name="keyword" onclick="this.value='';" onfocus="this.select()" onblur="this.value=!this.value?'Enter search query':this.value;" placeholder="Enter search query">
                <input class="headerbutton" name="search" type="submit" value="">
                
                <%                
                    String f = request.getParameter("filter");
                    String key = request.getParameter("keyword");
                    Connection connection = DbUtil.getConnection();
                    if(f.equals("all")){
                        Statement statement = connection.createStatement();
                        if (key.equals("") || key.equals("Enter search query")) {
                            ResultSet rs_cat = statement.executeQuery("SELECT nama_kategori FROM `kategori` ORDER BY `nama_kategori`;");
                            ResultSet rs_task = statement.executeQuery("SELECT nama_tugas FROM `tugas` ORDER BY `nama_tugas`;");
                            ResultSet rs_user = statement.executeQuery("SELECT username FROM `user` ORDER BY `username`;");
                        }else{
                            ResultSet rs_cat = statement.executeQuery("SELECT nama_kategori FROM `kategori` WHERE nama_kategori LIKE '%$keyword%' ORDER BY `nama_kategori`;");
                            ResultSet rs_task = statement.executeQuery("SELECT nama_tugas FROM `tugas` WHERE nama_tugas LIKE '%$keyword%' ORDER BY `nama_tugas`;");
                            ResultSet rs_user = statement.executeQuery("SELECT username FROM `user` WHERE username LIKE '%$keyword%' ORDER BY `username`;");
                        }
                    }else if(f.equals("category")){
                        Statement statement = connection.createStatement();
                        if (key.equals("") || key.equals("Enter search query")) {
                            ResultSet rs = statement.executeQuery("SELECT nama_kategori FROM `kategori`;");
                        }else{
                            ResultSet rs = statement.executeQuery("SELECT nama_kategori FROM `kategori` WHERE nama_kategori LIKE '%$keyword%';");
                        }
                    }else if(f.equals("username")){
                        Statement statement = connection.createStatement();
                        if (key.equals("") || key.equals("Enter search query")) {
                                ResultSet rs = statement.executeQuery("SELECT username, nama_lengkap, avatar FROM `user`;");
                        }else{
                                ResultSet rs = statement.executeQuery("SELECT username, nama_lengkap, avatar FROM `user` WHERE username LIKE '%$keyword%';");
                        }
                    }else if(f.equals("task")){
                        Statement statement = connection.createStatement();
                        if (key.equals("") || key.equals("Enter search query")) {
                                ResultSet rs = statement.executeQuery("SELECT distinct a.id_tugas, a.nama_tugas, a.deadline, a.status_tugas FROM  `tugas` AS a NATURAL JOIN  `tag` AS b;");
                        }else{
                                ResultSet rs = statement.executeQuery("SELECT distinct a.id_tugas, a.nama_tugas, a.deadline, a.status_tugas FROM  `tugas` AS a NATURAL JOIN  `tag` AS b where a.nama_tugas LIKE '%$keyword%' OR b.label LIKE '%$keyword%';");
                        }
                    }
                %>			
            </form>
        </div>
    </div>
</div>
