<!DOCTYPE html>
<html>	
    <head>
        <title> Banana Board - Home </title>
        <link rel="stylesheet" type="text/css" href="style.css">
        <script src="dashboard.js" type="text/javascript" language="javascript"> </script>

        <script type="text/javascript">
                    function getXmlHttpRequestObject() {
                            if (window.XMLHttpRequest) {// Mozilla/Safari
                                    return new XMLHttpRequest();
                            } else if(window.ActiveXObject) {// IE
                                    return new ActiveXObject("Microsoft.XMLHTTP");
                            } else {
                                    alert("Your Browser Sucks!");
                            }
                    }
                    var xmlHttpReq = getXmlHttpRequestObject();
                    var ids = null;
                    //Starts the AJAX request.
                    function changevalues(id) {
                            ids = id;
                            if (xmlHttpReq.readyState == 4 || xmlHttpReq.readyState == 0){
                                    var str = document.getElementById('statustugas'+id).value;
                                    var isCheck = document.getElementById('checklist'+id).checked;
                                    xmlHttpReq.open("GET", 'ChangeTaskStatus.php?id='+id+'&ischeck='+isCheck, true);
                                    xmlHttpReq.onreadystatechange = handleStatusChange; 
                                    xmlHttpReq.send(null);
                            }		
                    }

                    //Called when the AJAX response is returned.
                    function handleStatusChange() {
                            if (xmlHttpReq.readyState == 4) {
                                    var str =xmlHttpReq.responseText;
                                    id = "statustugas"+ids;
                                    if(document.getElementById(id).innerHTML == "in progress"){
                                            document.getElementById(id).innerHTML = "done";
                                    }else{
                                            document.getElementById(id).innerHTML = "in progress";
                                    }
                            }
                    }
            </script>
    </head>
    <body>

        <div id="content">
            <div id="popup">
        </div>
        <div id="popupform">
            <form class="centerV">
                <ul>
                    <li>
                        <label>Nama Kategori</label>
                        :<input id="namakategori" type="text" name="namakategori" id="namakategori"/><br/>
                    </li>
                    <li>
                        <label>Daftar Pengguna</label>
                        :<input type="text" name="daftarpengguna"id="daftarpengguna"/><br/>
                    </li>
                    <li>
                        <button id="add" onClick="AddKategori()"><b>Add</b></button>
                        <button id="cancel" onClick="DelPopUp()"><b>Cancel</b></button>
                    </li>						
                </ul>
            </form>
        </div>					

        <%@include file="header.jsp" %>
        
        <% 
            String f = request.getParameter("filter");
            String key = request.getParameter("keyword");
            ResultSet rs = null;
            ResultSet rs_cat = null;
            ResultSet rs_task = null;
            ResultSet rs_user = null;
            ResultSet tag = null;
            Connection con = DbUtil.getConnection();
            Statement statement = con.createStatement();
            Statement statement1 = con.createStatement();
            Statement statement2 = con.createStatement();
            Statement statement3 = con.createStatement();
            Statement statement4 = con.createStatement();
            if("all".equals(f)){
                if("".equals(key) || "Enter search query".equals(key)){
                    rs_cat = statement1.executeQuery("SELECT nama_kategori FROM `kategori` ORDER BY `nama_kategori`;");
                    rs_task = statement2.executeQuery("SELECT nama_tugas FROM `tugas` ORDER BY `nama_tugas`;");
                    rs_user = statement3.executeQuery("SELECT username FROM `user` ORDER BY `username`;");
                }else{
                    rs_cat = statement1.executeQuery("SELECT nama_kategori FROM `kategori` WHERE nama_kategori LIKE '%"+key+"%' ORDER BY `nama_kategori`;");
                    rs_task = statement2.executeQuery("SELECT nama_tugas FROM `tugas` WHERE nama_tugas LIKE '%"+key+"%' ORDER BY `nama_tugas`;");
                    rs_user = statement3.executeQuery("SELECT username FROM `user` WHERE username LIKE '%"+key+"%' ORDER BY `username`;");
                }
            }else if ("category".equals(f)){
                if("".equals(key) || "Enter search query".equals(key)){
                    rs = statement.executeQuery("SELECT nama_kategori FROM `kategori`;");
                }else{
                    rs = statement.executeQuery("SELECT nama_kategori FROM `kategori` WHERE nama_kategori LIKE '%" + key + "%';");
                }
            }else if("username".equals(f)){
                if("".equals(key) || "Enter search query".equals(key)){
                    rs = statement.executeQuery("SELECT username, nama_lengkap, avatar FROM `user`;");
                }else{
                    rs = statement.executeQuery("SELECT username, nama_lengkap, avatar FROM `user` WHERE username LIKE '%" + key + "%';");
                }
            }else if("task".equals(f)){
                if("".equals(key) || "Enter search query".equals(key)){
                    rs = statement.executeQuery("SELECT distinct a.id_tugas, a.nama_tugas, a.deadline, a.status_tugas FROM  `tugas` AS a NATURAL JOIN  `tag` AS b;");
                }else{
                    rs = statement.executeQuery("SELECT distinct a.id_tugas, a.nama_tugas, a.deadline, a.status_tugas FROM  `tugas` AS a NATURAL JOIN  `tag` AS b where a.nama_tugas LIKE '%"+key+"%' OR b.label LIKE '%"+key+"%';");
                }
            }
        %>
        
        <div id="isi">
            <div id="leftsidebar">
                <ul>
                    <li>
                        <a id="searchresultleft">SEARCH RESULT</a>
                    </li>	
                </ul>
                <img src="./assets/leftmenu.png"/>
            </div>

            <div id="rightsidebar">
                <%
                    if("all".equals(f)){
                %>
                        <div class="byallwrap">
                            <div class="byall">
                                <p>results by category</p>
                            </div>
                            <div class="byall">
                                <ul>
                                    <% while(rs_cat.next()){ %>
                                    <li>
                                        <a><%out.print(rs_cat.getString("nama_kategori"));%></a>
                                    </li>
                                    <%}%>
                                </ul>
                            </div>
                        </div>
                        <div class="byallwrap">
                            <div class="byall">
                                <p>results by task</p>
                            </div>
                            <div class="byall">
                                <ul>
                                    <%while(rs_task.next()){%>
                                <li>
                                    <a><%out.print(rs_task.getString("nama_tugas"));%></a>
                                </li>
                                    <%}%>
                                </ul>
                            </div>
                        </div>
                                
                        <div class="byallwrap">
                            <div class="byall"> 
                                    <p>results by username</p>
                            </div>
                            <div class="byall">
                                <ul>
                                    <% while(rs_user.next()){%>
                                <li>
                                    <a><%out.print(rs_user.getString("username"));%></a>
                                </li>
                                    <%}%>
                                </ul>
                            </div>
                        </div>
                <%
                    }else if ("category".equals(f)){
                        while(rs.next()){
                %>
                        <div class="searchcat">
                            <ul>
                                <li id="Task1" >
                                    <a><%out.print(rs.getString("nama_kategori"));%></a>								
                                </li>
                            </ul>
                        </div>
                <%                            
                        }
                    }else if("username".equals(f)){
                        while(rs.next()){
                %>
                        <div id="byusername">
                        <div id="thumb">
                            <img src="<%out.print(rs.getString("avatar"));%>" />
                        </div>
                        <div id="userdetail">
                            <ul>
                                <li id="Task1" >
                                    <a href="searchProfile.jsp?user=<%out.print(rs.getString("username"));%>"><%out.print(rs.getString("username"));%></a>						
                                </li>
                            </ul>
                            <ul>
                                <li>
                                    <b><%out.print(rs.getString("nama_lengkap"));%></b>
                            </li>
                            </ul>
                        </div>
                        </div>
                <%
                        }
                    }else if("task".equals(f)){
                %>
                        <div id="judultabel">
                            <ul>
                                <li>
                                    <b>Task Name</b>
                                </li>
                            </ul>
                            <ul class="judul">
                                <li class="judul">
                                    <b>Deadline</b>
                                </li>
                            </ul>
                            <ul class="judul">
                                <li class="judul">
                                    <b >Tag</b>
                                </li>
                            </ul>
                            <ul class="judul">
                                <li class="judul">
                                    <b >Status</b>
                                </li>
                            </ul>
                        </div>
                <%
                        while(rs.next()){
                            int id = rs.getInt("id_tugas");
                %>
                            <div id="search" onload="changecheckboxvalue()">
                                <input type="checkbox" id="checklist<%out.print(id);%>" name="checkbox" onclick="changevalues('<%out.print(id);%>');" <% if ("done".equals(rs.getString("status_tugas"))){ out.print("checked");}%>/>
                                <ul>
                                    <li id="Task1" >
                                        <a id="namatugas" href="taskdetails.jsp?kateg=<%out.print(rs.getString("nama_tugas"));%>"><%out.print(rs.getString("nama_tugas"));%></a>
                                    </li>
                                </ul>
                                <ul>
                                    <li>
                                        <a><%out.print(rs.getString("deadline"));%></a>
                                    </li>
                                </ul>
                                <ul>
                                    <li>
                                        <%
                                            tag = statement4.executeQuery("SELECT label FROM `tag` WHERE id_tugas = '"+id+"';");
                                        %>
                                        <a>
                                        <%
                                            while(tag.next()){
                                                out.print(tag.getString("label"));
                                                out.print(",");
                                            }
                                        %>
                                        </a>
                                    </li>
                                </ul>
                                <ul>
                                    <li>
                                        <a id="statustugas<%out.print(id);%>"><%out.print(rs.getString("status_tugas"));%></a>
                                    </li> 
                                </ul>								
                            </div>
                <%
                        }
                    }
                %>
            </div>
        </div>

        <div id="footer" class="home">
            <p>&copy Copyright 2013. All rights reserved<br>
            Chalkz Team<br>
            Yulianti - Adriel - Amelia</p>			
        </div>
</div>

    </body>
</html>
