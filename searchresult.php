<!DOCTYPE html>
<html>	
	<head>
		<title> Banana Board - Home </title>
		<link rel="stylesheet" style="text/css" href="style.css">
		<script src="Dashboard.js" type="text/javascript" language="javascript"> </script>
		
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
				if (xmlHttpReq.readyState == 4 || xmlHttpReq.readyState == 0) {
					
					var str = document.getElementById('statustugas'+id).value;
					xmlHttpReq.open("GET", 'ChangeTaskStatus.php?id='+id, true);
					xmlHttpReq.onreadystatechange = handleStatusChange; 
					xmlHttpReq.send(null);
				}		
			}
			
			//Called when the AJAX response is returned.
			function handleStatusChange() {
				if (xmlHttpReq.readyState == 4) {
					var str =xmlHttpReq.responseText;
					alert(document.getElementById('"statustugas'+ids+'"').innerHTML);
					document.getElementById('"statustugas'+ids+'"').innerHTML = "done";
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
			
			<div id="header">
				<div id="usernamelogo">						
					<a href="profile.html">username</a>
					<img src="foto.jpg" href="profile.html"/>
				</div>
				<div id="logo">
					<!-- <a href="index.html" class="header">board</a> -->
					<img src="logo.png"/>
				</div>
				<div id="menu">
					<ul>
						<li> <a href="home.php"> DASHBOARD </a> </li>
						<li> <a href="profile.html"> PROFILE </a> </li>
						<li> <a href="index.html"> LOGOUT </a> </li>
					</ul>
					
					<form method="post" action="searchresult.php">
						<input class="button" type="submit" name="search" value="">
						<select id="filterbox" name="filter">						
							<option>all</option>							
							<option>username</option>
							<option>category</option>
							<option>task</option>							
						<select/>						
						<input class="box" type="text" name="keyword" onclick="this.value='';" onfocus="this.select()" onblur="this.value=!this.value?'Enter search query':this.value;" value="Enter search query">
						<?php
							$filter=$_POST['filter'];
							$keyword=$_POST['keyword'];
							if(isset($_POST['search'])){ $notify = $_POST['search']; }
							$con = mysql_connect("localhost","root");
							if (!$con)
							{
								die('Could not connect: ' . mysql_error());
							}

							mysql_select_db("tubesprogin", $con);
							if($filter=='all')
							{
								if ($keyword=='') 
								{
								$result_cat = mysql_query("SELECT nama_kategori FROM `kategori` ORDER BY `nama_kategori`;");
								$result_task = mysql_query("SELECT nama_tugas FROM `tugas` ORDER BY `nama_tugas`;");
								$result_user = mysql_query("SELECT username FROM `user` ORDER BY `username`;");
								}
								else
								{$result_cat = mysql_query("SELECT nama_kategori FROM `kategori` WHERE nama_kategori LIKE '%$keyword%' ORDER BY `nama_kategori`;");
								$result_task = mysql_query("SELECT nama_tugas FROM `tugas` WHERE nama_tugas LIKE '%$keyword%' ORDER BY `nama_tugas`;");
								$result_user = mysql_query("SELECT username FROM `user` WHERE username LIKE '%$keyword%' ORDER BY `username`;");}
							}
							else if($filter=='category')
							{
								if ($keyword=='') 
								{
								$result = mysql_query("SELECT nama_kategori FROM `kategori`;");
								}
								else
								{$result = mysql_query("SELECT nama_kategori FROM `kategori` WHERE nama_kategori LIKE '%$keyword%';");}
							}
							else if($filter=='username')
							{
								if ($keyword=='') 
								{
								$result = mysql_query("SELECT username, nama_lengkap, avatar FROM `user`;");
								}
								else
								{$result = mysql_query("SELECT username, nama_lengkap, avatar FROM `user` WHERE username LIKE '%$keyword%';");}
							}
							else if($filter=='task')
							{
								if ($keyword=='') 
								{
								$result = mysql_query("SELECT a.nama_tugas,a.deadline,b.label,a.status_tugas FROM `tugas` as a natural join `tag` as b;");
								}
								else
								{$result = mysql_query("SELECT a.id_tugas, a.nama_tugas,a.deadline,a.status_tugas FROM `tugas` as a WHERE nama_tugas LIKE '%$keyword%';");}
							}
						?>				
					</form>
				</div>
			</div>
			
			<div id="isi">
				<div id="leftsidebar">
					<b>SEARCH RESULT</b>
					<img src="leftmenu.png"/>
				</div>

				<div id="rightsidebar">
						<?php
						if($filter=='all')
						{
						?>
							<div class="byall">
								<p>results by category</p>
							</div>
							<div class="byall">
								<ul>
							<?php
							while($kategori_item = mysql_fetch_array($result_cat))
							{
							?>
								<li>
									<a><?php echo $kategori_item[0]?></a>
								</li>
							<?php
							}
							?>
								</ul>
							</div>
							
							<div class="byall">
								<p>results by task</p>
							</div>
							<div class="byall">
								<ul>
							<?php
							while($kategori_item = mysql_fetch_array($result_task))
							{
							?>
								<li>
									<a><?php echo $kategori_item[0]?></a>
								</li>
							<?php
							}
							?>
								</ul>
							</div>
							
							<div class="byall"> 
								<p>results by username</p>
							</div>
							<div class="byall">
								<ul>
							<?php
							while($kategori_item = mysql_fetch_array($result_user))
							{
							?>
								<li>
									<a><?php echo $kategori_item[0]?></a>
								</li>
							<?php
							}
							?>
								</ul>
							</div>
						<?php
						}
						?>
						<?php
						if($filter=='category')
						{
							while($kategori_item = mysql_fetch_array($result))
							{
							?>
							<div id="userdetail">
								<ul>
									<li id="Task1" >
										<a href="searchresult.php?kateg=<?php echo $kategori_item[0] ?>"><?php echo $kategori_item[0]?></a>								
									</li>
								</ul>
							</div>
						<?php }
						}
						else if($filter=='username')
						{
							while($kategori_item = mysql_fetch_array($result))
							{
							?>
							<div id="byusername">
								<div id="thumb">
									<img src="<?php echo $kategori_item['avatar']?>" />
								</div>
								<div id="userdetail">
									<ul>
										<li id="Task1" >
											<a href="profile.php?username=<?php echo $kategori_item['username'] ?>"><?php echo $kategori_item['username']?></a>						
										</li>
									</ul>
									<ul>
										<li>
											<b><?php echo $kategori_item['nama_lengkap']?></b>
										</li>
									</ul>
								</div>
							</div>
						<?php }
						}else if($filter=='task')
						{
							?>
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
										<b >Label</b>
									</li>
								</ul>
								<ul class="judul">
									<li class="judul">
										<b >Status</b>
									</li>
								</ul>
							</div>
							<?php
							while($kategori_item = mysql_fetch_array($result))
							{
							$id = $kategori_item['id_tugas'];
							?>
							<div id="search" onload="changecheckboxvalue()">
								<input type="checkbox" id="checklist<?php echo $id?>" name="checkbox" onclick="changevalues('<?php echo $id?>');" <?php if ($kategori_item['status_tugas'] == "done"){
									echo 'checked';
								} ?> />
								<ul>
									<li id="Task1" >
										<a id="namatugas" href="taskdetails.php?kateg=<?php echo $kategori_item['nama_tugas'] ?>"><?php echo $kategori_item['nama_tugas']?></a>
									</li>
								</ul>
								<ul>
									<li>
										<a href="searchresult.php?kateg=<?php echo $kategori_item['deadline'] ?>"><?php echo $kategori_item['deadline']?></a>
									</li>
								</ul>
								<ul>
									<li>
										<a href="searchresult.php?kateg=<?php echo $kategori_item['label'] ?>"></a>
									</li>
								</ul>
								<ul>
									<li>
										<a id="statustugas<?php echo $id?>" href="searchresult.php?kateg=<?php echo $kategori_item['status_tugas'] ?>"><?php echo $kategori_item['status_tugas']?></a>
									</li>
								</ul>								
							</div>
						<?php }
						}?>
						
						<?php mysql_close($con) ?>
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
