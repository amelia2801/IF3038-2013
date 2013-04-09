<?php
	session_start();
	$user=$_POST["user"];
	$email=$_POST["email"];
	$pass=$_POST["pass"];
	$nama=$_POST["namalengkap"];
	$tanggal=$_POST["tahun"]."-".$_POST["bulan"]."-".$_POST["tanggal"];
	$avatar=$_FILES["avatar"]["name"];
	
	$con = mysqli_connect('localhost', 'progin', 'progin',"progin_405_13510093");

	if (!$con)
	{
		echo "Failed to connect to MySQL: " . mysqli_connect_error();
	}

  if ($_FILES["avatar"]["error"] > 0)
    {
    echo "Return Code: " . $_FILES["avatar"]["error"] . "<br>";
    }
  else
    {
    echo "Upload: " . $_FILES["avatar"]["name"] . "<br>";
    echo "Type: " . $_FILES["avatar"]["type"] . "<br>";
    echo "Size: " . ($_FILES["avatar"]["size"] / 1024) . " kB<br>";
    echo "Temp file: " . $_FILES["avatar"]["tmp_name"] . "<br>";

    if (file_exists("upload/" . $_FILES["avatar"]["name"]))
      {
      echo $_FILES["avatar"]["name"] . " already exists. ";
      }
    else
      {
      move_uploaded_file($_FILES["avatar"]["tmp_name"],
      "upload/" . $_FILES["avatar"]["name"]);
      echo "Stored in: " . "upload/" . $_FILES["avatar"]["name"];
      }
    }

	mysqli_query($con,"INSERT INTO user (nama_lengkap, email, username, password, tanggal_lahir,avatar)
	VALUES ('".$nama."', '".$email."','".$user."', '".$pass."','".$tanggal."','upload/".$avatar."')");
	
	$_SESSION['user']=$user;
	$_SESSION['CREATED'] = time();
	header( "Location: ./home.php");
?>

