<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="progin3.DbUtil" %>


<!DOCTYPE html>
<html>
	<head>
		<title>Banana Board - Your Online Do List</title>		
		<link rel="stylesheet" href="src/style.css" type="text/css">
		 <script src="src/index.js" type="text/javascript" language="javascript"> </script>
		<style type="text/css"></style>
	</head>
	
	<body onload="isAlreadyLogin()">
		<div id="indexheader">
			<img src="assets/logo.png">					
			<form id="loginform" class="login" method="post" name="loginform">		
				<ul>
					<h1 align="left">Login</h1>
					<li>
						<label for="username">Username:</label>
						<input class="loginbox" id="username" type="text" name="username" />
					</li>
					<li>
						<label for="password">Password:</label>
						<input class="loginbox" id="password" type="password" name="password" />
					</li>
					<li>
						<button class="loginbutton" type="submit"><b>Login</b></button>
					</li>
				</ul>
			</form>	
		</div>		
		
		<div id="register">			
			<form class="reg" action="register" method="post" enctype="multipart/form-data" name="registerform">
				<ul>
					<p><b>new to Banana Board?</b></p>
					<h1 align="left">Register now!</h1>
					<li>
						<label for="username">Username:</label>
						<input type="text" name="user"  id="user" onchange="checkUsername()" required/><br>
						<span>* minimal 5 karakter</span>
					</li>
					<li>
						<label for="password">Password:</label>
						<input type="password" name="pass" id="pass" onchange="checkPassword()" required/><br>
						<span>* minimal 8 karakter</span>
					</li>		
					<li>
						<label for="confirmpass">Confirmed Password:</label>
						<input type="password" name="passconfirmed" id="passconfirmed" onChange="checkConfirmedPass()" required/>
					</li>
					<li>
						<label for="namalengkap">Full Name:</label>
						<input type="text" name="namalengkap" id="namalengkap" required onChange="checkNamaLengkap()" /><br>
						<span>* minimal 2 kata (first name, last name)</span>
					</li>	
					<li>
						<label for="tgllahir">Birth Date:</label>
						<select id="tahunlist" name="tahun">
						</select>
						<select id="bulanlist" name="bulan">
						</select>
						<select id="tanggallist" name="tanggal">
						</select>
					</li>
					<li>
						<label for="email">Email:</label>
						<input type="email" name="email" id="email" required onchange="checkEmail()"/>
					</li>
					<li>
						<label for="avatar">Avatar:</label>
						<input class="file" type="file" name="avatar" id="avatar" onchange="checkAvatar()"/>
					</li>
					<li>
						<button type="submit" disabled id="registerbutton" onClick="localStorage.setItem('userlogin',document.getElementById('user').value);">Register</button>
					</li>
				</ul>
			</form>
		</div>
		
		<div id="featuresbar">
			<ul id="features">
				<li>
					<b>Banana is here to remind you of your tasks</b>
				</li>
				<li>
					<b>Banana lets you synchronize your tasks with members</b>
				</li>
			</ul>
		</div>
		
		<jsp:include page="/src/footer.jsp" />
		
		<script type="text/javascript">
			var temp = document.getElementById("loginform");
			temp.onsubmit = function()
			{
				var a = document.getElementById("username");
				var b = document.getElementById("password");
				var flag = false;
				
				var xmlhttp;
				if (window.XMLHttpRequest)
				{// code for IE7+, Firefox, Chrome, Opera, Safari
					xmlhttp=new XMLHttpRequest();
				}
				else
				{// code for IE6, IE5
					xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
				}
				
				xmlhttp.onreadystatechange=function()
				{
					if (xmlhttp.readyState==4 && xmlhttp.status==200)
					{
						if (xmlhttp.responseText.search("true") != -1)
						{
							alert("Login berhasil !");
							window.location="src/home.jsp";
							if(typeof(Storage)!="undefined")
							{
								localStorage.setItem('userlogin',a.value);
							}
							else
							{
								alert("Sorry, your browser does not support web storage...");
							}
							flag=true;
						}else{
							alert("Login gagal !");
						}
					}
				}
				xmlhttp.open("POST","src/login.jsp",true);
				xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
				xmlhttp.send("username="+a.value+"&password="+b.value);

				return flag;
			}
		</script>
	</body>
</html>