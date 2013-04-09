<?php
	session_start();
	$user=$_SESSION['user'];
	$nama=$_POST["namalengkap"];
	$pass=$_POST["pass"];
	$tanggal=$_POST["tahun"];
	$avatar=$_FILES["avatar"]["name"];
	
	if ($_POST["bulan"]>=10){
		$tanggal = $tanggal."-".$_POST["bulan"];
	}else{
		$tanggal = $tanggal."-0".$_POST["bulan"];
	}
	if ($_POST["tanggal"]>=10){
		$tanggal = $tanggal."-".$_POST["tanggal"];
	}else{
		$tanggal = $tanggal."-0".$_POST["tanggal"];
	}
	
	$con = mysqli_connect('localhost', 'progin', 'progin',"progin_405_13510093");	
	
	if (!$con)
	{
		echo "Failed to connect to MySQL: " . mysqli_connect_error();
	}

	$result = mysqli_query($con,"SELECT * FROM user WHERE username='".$user."'");

	$row = mysqli_fetch_array($result);
	
	if ($row==NULL)
	{
		echo 'false';
	}
	else
	{
		if ($nama==null || $nama==$row['nama_lengkap']){
			// echo "Full name does not change \n";
			$a=0;
		}else{
			mysqli_query($con,"UPDATE user SET nama_lengkap='".$nama."'WHERE username='".$user."'");
			// echo "Full name have changed \n";
			$a=1;
		}
		
		if ($pass==null || $pass==$row['password']){
			// echo "Password does not change \n";
			$b=0;
		}else{
			mysqli_query($con,"UPDATE user SET password='".$pass."'WHERE username='".$user."'");
			// echo "Password have changed \n";
			$b=1;
		}
			?><script>alert("<?echo $tanggal.$row['tanggal_lahir'];?>")</script><?
		if ($tanggal==null || $tanggal==$row['tanggal_lahir']){
			// echo "Date of Birth does not change \n";
			$c=0;
		}else{
			mysqli_query($con,"UPDATE user SET tanggal_lahir='".$tanggal."'WHERE username='".$user."'");
			// echo "Date of Birth have changed \n";
			$c=1;
		}
		
		if ($avatar==null || $avatar==$row['avatar']){
			// echo "Avatar does not change \n";
			$d=0;
		}else{
			if ($_FILES["avatar"]["error"] > 0)
			{
				echo "Return Code: " . $_FILES["avatar"]["error"] . "<br>";
			}
			else
			{				
				if (file_exists("upload/" . $_FILES["avatar"]["name"]))
				{
					//echo $_FILES["avatar"]["name"] . " already exists. ";
				}
				else
				{
					move_uploaded_file($_FILES["avatar"]["tmp_name"],"upload/" . $_FILES["avatar"]["name"]);
					//echo "Stored in: " . "upload/" . $_FILES["avatar"]["name"];
				}
			}
		
			mysqli_query($con,"UPDATE user SET avatar='upload/".$avatar."'WHERE username='".$user."'");
			// echo "Avatar have changed \n";
			$d=1;
		}
	}
	//header( "refresh:5;url=http://localhost/Progin2/index.php") ;
	header("Location: ./profile.php?a=".$a."&b=".$b."&c=".$c."&d=".$d);
	
	mysqli_close($con);
?>