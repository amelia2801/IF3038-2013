<?
	if ($_GET){
		if ($_GET["a"]==0){
			$temp = 'Full name not change \n';
		}else{
			$temp = 'Full name have changed \n';
		}
		
		if ($_GET["b"]==0){
			$temp = $temp.'Password not change \n';
		}else{
			$temp = $temp.'Password have changed \n';
		}
		
		if ($_GET["c"]==0){
			$temp = $temp.'Date of Birth not change \n';
		}else{
			$temp = $temp.'Date of Birth have changed \n';
		}
		
		if ($_GET["d"]==0){
			$temp = $temp.'Avatar not change \n';
		}else{
			$temp = $temp.'Avatar have changed \n';
		}
		
		?><script>alert("<?echo $temp?>")</script><?
	}else{
	}
?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title> Banana Board - Profile </title>
		<link rel="stylesheet" style="text/css" href="style.css">
		<script src="profile.js" type="text/javascript" language="javascript"> </script>
	</head>

<body onload="generateDate()">
	<div id="content">
		<?
			include("header.php");
		?>
    
		<!-- Foto profile -->
		<div id="isi">
			<?
				$result = mysqli_query($con,"SELECT * FROM user WHERE username='".$_SESSION['user']."'");
				$row = mysqli_fetch_array($result);
				
				$result2 = mysqli_query($con,"SELECT nama_tugas FROM `tugas` natural join `user` natural join `mengerjakan` WHERE `user`.username='".$_SESSION['user']."' AND `tugas`.status_tugas='done'");
				$done = mysqli_fetch_array($result2);
				
				$result3 = mysqli_query($con,"SELECT nama_tugas FROM `tugas` natural join `user` natural join `mengerjakan` WHERE `user`.username='".$_SESSION['user']."' AND status_tugas='in progress'");
				$progress = mysqli_fetch_array($result3);
			?>
		
			<div id="leftsidebar">
				<img class="foto" src="<?echo $row['avatar']?>" alt="Profile picture"/>
				<b>@<?echo $row['username']?></b>
				<div class="profbuttonwrap">
					<button class="profbutton" onClick="location.href='#join_form'" type="submit">Edit</button>
				</div>
			</div>
			
			<div id="rightsidebar">
				<ul class="prof">
					<h1 align="left">Profile</h1>
					<li>
						<label>Full Name:</label>
						<p class="prof1"><?echo $row['nama_lengkap']?></p>
					</li>
					<li>
						<label>Email:</label>
						<p class="prof1"><?echo $row['email']?></p>
					</li>
					<li>
						<label>Tanggal Lahir:</label>
						<p class="prof1"><?echo $row['tanggal_lahir']?></p>
					</li>
					<li>
						<label>On going tasks:</label>
						<p class="prof1">
							<?
								if (count($done['nama_tugas'])==0){
									echo "-";
								}else{
									while (count($done['nama_tugas'])!=0)
									{
										echo "- ".$done['nama_tugas']."<br>";
										$done = mysqli_fetch_array($result2);
									}
								}
							?>
						</p>
					</li>
					<li>
						<label>Tasks done:</label>
						<p class="prof1">
							<?
								if (count($progress['nama_tugas'])==0){
									echo "-";
								}else{										
									while (count($progress['nama_tugas'])!=0)
									{
										echo "- ".$progress['nama_tugas']."<br>";
										$progress = mysqli_fetch_array($result3);
									}
								}
							?>
						</p>
					</li>
				</ul>
			</div>
		</div>
		
		<?
			include("footer.php");
		?>
		
		
		<a href="#x" class="overlay" id="join_form" ></a>
		<form class="popup" name="regis" action="editprofile.php" method="post" enctype="multipart/form-data">
			<h1>Edit Profile</h1>
			<div>
				<label for="namalengkap">Full Name</label>
				<input type="text" id="namalengkap" name="namalengkap" value="" onChange="checkNamaLengkap()" />
				<br>
				<span>* minimal 2 kata (first name, last name)</span>
			</div>
			<div>
				<label for="avatar">Avatar</label>
				<input type="file" name="avatar" id="avatar" onchange="checkAvatar()"/>
				<br>
				<span>* jpg, jpeg</span>
			</div>
			<div>
				<label for="tgllahir">Tanggal Lahir:</label>
				<select id="tahunlist" name="tahun"></select>
				<select id="bulanlist" name="bulan"></select>
				<select id="tanggallist" name="tanggal"></select>
			</div>
			<div>
				<label for="password">Change Password</label>
				<input type="password" id="pass" name="pass" value=""  onchange="checkPassword()"/>
				<br>
				<span>* minimal 8 karakter</span>
			</div>
			<div>
				<label for="confirmpass">Confirm New Password</label>
				<input type="password" id="passconfirmed" name="passconfirmed" value="" onChange="checkConfirmedPass()"/>
			</div>
			<input class="profbutton" type="submit" value="Save Change" id="regButton" /><!--onclick="editProfile()"--> 
			<a class="close" href="#close"></a>
		</form>
		
	</div>
</body>
</html>
