<?
	if ($_GET){
		if ($_GET["cat"]==0){
			$temp = 'Full name not change \n';
		}else{
			$temp = 'Full name have changed \n';
		}
	}else{
	}
?>
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
					var isCheck = document.getElementById('checklist'+id).checked;
					xmlHttpReq.open("GET", 'ChangeTaskStatus.php?id='+id+'&ischeck='+isCheck, true);
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
						xmlhttp.open("GET","suggestion.php?str="+str,true);
						xmlhttp.send();
					}
				}
			}
		</script>
	
	</head>
	<body onload=showkategori(0)>
	
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
			
			<?
				include("header.php");
			?>
			
			<div id="isi">
				<div id="leftsidebar">
					<ul>
						<a class="addcateg" onClick="location.href='#join_form'" ><i class="addcateg">Add new category...</i></a>
						
						<?php
							
							$result2 = mysqli_query($con,"SELECT nama_kategori FROM `kategori` natural join `user` natural join `anggota` WHERE `user`.username='".$_SESSION['user']."'");
							$cat = mysqli_fetch_array($result2);
							
							if (count($cat['nama_kategori'])==0){
							}else{
								$i=1;
								while (count($cat['nama_kategori'])!=0)
								{
									?>
										<li><a onClick="showkategori(<?echo $i?>)"><?echo $cat['nama_kategori']?></a></li>
									<?
									$cat = mysqli_fetch_array($result2);
									$i++;
								}
							}
						 ?>	
					</ul>
					<img src="../leftmenu.png"/>
				</div>
				
				<div id="rightsidebar">
					<ul id="kegiatan">
					</ul>
				</div>
			</div>
		</div>

		<?
			include("footer.php");
		?>
		
		
		<a href="#x" class="overlay" id="join_form" ></a>
		<form class="popup" name="regis" action="addCategory.php" method="post" enctype="multipart/form-data">
			<h1>Add Category</h1>
			<div>
				<label for="catName">Category Name</label>
				<input type="text" id="namalengkap" name="catName" value=""/>
				<br>
			</div>
			<div>
				<label for="confirmpass">Asignee</label>
				<input type="text" name="assname" value="" onkeyup="checkSuggestion(this.value)"/>
				<div id="suggestion"></div>
				<span>*dipisahkan dengan ","</span>
			</div>
			<input class="profbutton" type="submit" value="Add Category" id="regButton" /><!--onclick="editProfile()"--> 
			<a class="close" href="#close"></a>
		</form>
		
		
		
	</body>
</html>
