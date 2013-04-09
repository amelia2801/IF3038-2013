<!DOCTYPE html>
<html>	
    <head>
        <title> Banana Board - Home </title>
        <link rel="stylesheet" style="text/css" href="style.css">
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

        <div id="isi">
            <div id="leftsidebar">
                <ul>
                    <li>
                        <a id="searchresultleft">SEARCH RESULT</a>
                    </li>	
                </ul>
                <img src="../leftmenu.png"/>
            </div>

                <div id="rightsidebar">
                    <% if (f.equals("all")){%>
                        <div class="byallwrap">
                            <div class="byall">
                                <p>results by category</p>
                            </div>
                            <div class="byall">
                                <ul>
                                    <%
                                        while(rs_cat.next()){
                                    %>
                                        <li>
                                            <a><% out.print(rs_cat.getString("nama_kategori")); %></a>
                                        </li>
                                    <%
                                        }
                                    %>
                                </ul>
                            </div>
                        </div>
                        <div class="byallwrap">
                            <div class="byall">
                                <p>results by task</p>
                            </div>
                            <div class="byall">
                                <ul>
                                    <%
                                        while(rs_task.next()){
                                    %>
                                        <li>
                                            <a><% out.print(rs_task.getString("nama_tugas"));%></a>
                                        </li>
                                    <%
                                        }
                                    %>
                                </ul>
                            </div>
                        </div>
                        <div class="byallwrap">
                            <div class="byall"> 
                                    <p>results by username</p>
                            </div>
                            <div class="byall">
                                <ul>
                                    <%
                                        while(rs_user.next()){
                                    %>
                                        <li>
                                            <a><% out.print(rs_user.getString("username"));%></a>
                                        </li>
                                    <%
                                        }
                                    %>
                                </ul>
                            </div>
                        </div>
                    <%
                        }else if(f.equals("category")){
                            while(rs.next()){
                    %>
                            <div class="searchcat">
                                <ul>
                                    <li id="Task1" >
                                        <a href="searchresult.php?kateg=<?php echo $kategori_item[0] ?>"><% out.print(rs.getString("nama_kategori"));%></a>								
                                    </li>
                                </ul>
                            </div>
                    <%
                            }
                        }else if(f.equals("username")){
                            while(rs.next()){
                    %>
                                <div id="byusername">
                                    <div id="thumb">
                                        <img src="<?php echo $kategori_item['avatar']?>"/>
                                    </div>
                                    <div id="userdetail">
                                        <ul>
                                            <li id="Task1" >
                                                <a href="searchProfile.php?user=<?php echo $kategori_item['username'] ?>"><% out.print(rs.getString("username"));%></a>
                                            </li>
                                        </ul>
                                        <ul>
                                            <li>
                                                <b><% out.print(rs.getString("nama_lengkap"));%></b>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                    <%
                             }
                        }else if(f.equals("task")){
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
                                    <input type="checkbox" id="checklist<?php echo $id?>" name="checkbox" onclick="changevalues('<?php echo $id?>');" <% if (rs.getString("status_tugas") == "done"){ out.print("checked")}%> />
                                    <ul>
                                        <li id="Task1" >
                                            <a id="namatugas" href="taskdetails.php?kateg=<?php echo $kategori_item['nama_tugas'] ?>"><%= rs.getString("nama_tugas");%></a>
                                        </li>
                                    </ul>
                                    <ul>
                                        <li>
                                            <a href="searchresult.php?kateg=<?php echo $kategori_item['deadline'] ?>"> <%= rs.getString("deadline");%> </a>
                                        </li>
                                    </ul>
                                    <ul>
                                        <li>
                                            <%
                                                Statement statement_tag = connection.createSatement();
                                                ResultSet tag = statement_tag.executeQuery('SELECT label FROM `tag` WHERE id_tugas = "' + id + '";');
                                            %>
                                            <a href="searchresult.php?kateg=<?php echo $kategori_item['label'] ?>">
                                                
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
                                            <a id="statustugas<?php echo $id?>" href="searchresult.php?kateg=<?php echo $kategori_item['status_tugas'] ?>"><%= rs.getString("status_tugas");%></a>
                                        </li>
                                    </ul>								
                                </div>
                            }
                        }
                    %>
                    <%
                        connection.close();
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
