<?php
	session_start();
	$user=$_POST["username"];
	$pass=$_POST["password"];
	
	$con = mysqli_connect('localhost', 'progin', 'progin',"progin_405_13510093");
	
	
	
	if (!$con)
	{
		echo "Failed to connect to MySQL: " . mysqli_connect_error();
	}

	$result = mysqli_query($con,"SELECT password FROM user WHERE username='".$user."'");

	$row = mysqli_fetch_array($result);
	
	if ($row==NULL)
	{
		echo 'false';
	}
	else
	{
		if ($row[0]==$pass){
			echo 'true';
			$_SESSION['user']=$user;
			$_SESSION['CREATED'] = time();
		}else{
			echo 'false';
		}
	}

	mysqli_close($con);
?>