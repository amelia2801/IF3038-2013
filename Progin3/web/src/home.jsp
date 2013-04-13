<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="progin3.DbUtil" %>
<%
        if (session.getAttribute("user")==null){
            response.sendRedirect("../index.jsp");
        }else {
            %>
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
					var isCheck = document.getElementById('checklist'+id).checked;
					xmlHttpReq.open("GET", '../ChangeTaskStatus?id='+id+'&ischeck='+isCheck, true);
					xmlHttpReq.send(null);
				}		
			}
			
			function checkSuggestion(str) {
				var obj = document.getElementById("suggestion");
				if(str.length == 0) {
					obj.innerHTML = "";
					obj.style.visibility = "hidden";
					obj.style.border = "0px";
				} else {
					var idx = str.lastIndexOf(",");
					if(idx != -1) {
						str = str.substr(str.lastIndexOf(",")+1);
					}
					if(str.length > 0) {
						var xmlhttp;
						if(window.XMLHttpRequest) {	// code for IE7+, Firefox, Chrome, Opera, Safari
							xmlhttp = new XMLHttpRequest();
						} else {	// code for IE6, IE5
							xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
						}
						xmlhttp.onreadystatechange = function() {
							if(xmlhttp.readyState == 4 && xmlhttp.status == 200) {
								if(xmlhttp.responseText != "empty" && xmlhttp.responseText != "complete") {
									obj.innerHTML = xmlhttp.responseText;
									obj.style.visibility = "visible";
									obj.style.border = "3px ridge #A5ACB2";
									obj.style.left = "202px";
									obj.style.width = "200px";
									obj.style.position = "relative";
									obj.style.background = "white";
									obj.style.color = "black";
								} else {	
									obj.innerHTML = "";
									obj.style.visibility = "hidden";
									obj.style.border = "0px";
								}
							}
						}
						xmlhttp.open("GET","../suggestion?str="+str,true);
						xmlhttp.send();
					}
				}
			}
		</script>
	
	</head>
	<body onload=showkategori(0);>
	
		<div id="content">
			<div id="popup">
	       	</div>
    	    <div id="popupform">
        	    <form class="centerV">
					<ul>
						<li>
							<label>Nama Kategori</label>
							:<input id="namakategori" type="text" name="namakategori"/><br/>
						</li>
						<li>
							<label>Daftar Pengguna</label>
							:<input type="text" name="daftarpengguna" id="daftarpengguna"/><br/>
						</li>
						<li>
							<button id="add" onClick="AddKategori();"><b>Add</b></button>
							<button id="cancel" onClick="DelPopUp();"><b>Cancel</b></button>
						</li>						
					</ul>
				</form>
            </div>
			
			<jsp:include page="header.jsp" />
                        
			<div id="isi">
				<div id="leftsidebar">
					<ul>
						<a class="addcateg" onClick="location.href='#join_form'">
                                                    <i class="addcateg">Add new category...</i>
                                                </a>
						<%
                                                        Connection con = DbUtil.getConnection();
							ResultSet result2 = null;
                                                        Statement st = con.createStatement();
                                                        String s_user = (String) session.getAttribute("user");
                                                        result2 = st.executeQuery("SELECT nama_kategori FROM `kategori` natural join `user` natural join `anggota` WHERE `user`.username='"+s_user+"'");
							int i=1;
                                                        while(result2.next()){
                                                %>
                                                    <li>
                                                        <a onClick="showkategori(<%out.print(i);%>)"><% out.print(result2.getString("nama_kategori"));%></a>
                                                    </li>
                                                <%
                                                            i++;
                                                        }
						 %>	
					</ul>
					<img src="../assets/leftmenu.png"/>
				</div>
				
				<div id="rightsidebar">
					<ul id="kegiatan">
					</ul>
				</div>
			</div>
		</div>

		<jsp:include page="footer.jsp" />
		
		
		<a href="#x" class="overlay" id="join_form" ></a>
		<form class="popup" name="regis" action="addCategory.jsp" method="post">
			<h1>Add Category</h1>
			<div>
				<label for="catName">Category Name</label>
				<input type="text" id="namalengkap" name="catName" value=""/>
				<br>
			</div>
			<div>
				<label for="confirmpass">Asignee</label>
				<input type="text" name="assname" value="" onkeyup="checkSuggestion(this.value);"/>
				<div id="suggestion"></div>
				<span>*dipisahkan dengan ","</span>
			</div>
			<input class="profbutton" type="submit" value="Add Category" id="regButton" /><!--onclick="editProfile()"--> 
			<a class="close" href="#close"></a>
		</form>
		
		
		
	</body>
</html>

            
            <%
        }
%>