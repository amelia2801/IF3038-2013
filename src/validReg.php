<?php
	$user=$_GET["user"];
	$email=$_GET["email"];
	
	$con = mysqli_connect('localhost', 'progin', 'progin',"progin_405_13510093");

	if (!$con)
	{
		echo "Failed to connect to MySQL: " . mysqli_connect_error();
	}

	$result = mysqli_query($con,"SELECT * FROM user WHERE username='".$user."' OR email='".$email."'");

	$row = mysqli_fetch_array($result);
	
	if ($row==NULL)
	{
		echo 'true';
	}
	else
	{
		echo 'false';
	}

	mysqli_close($con);
?>