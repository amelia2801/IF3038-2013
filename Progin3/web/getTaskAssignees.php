<?php
	
	$id_tugas = $_GET["id"];
	
	$conn = mysqli_connect('localhost', 'progin', 'progin',"progin_405_13510093");

	if (!$conn)
	{
		echo "Failed to connect to MySQL: " . mysqli_connect_error();
	}
	
	$query1 = "SELECT id_user FROM mengerjakan WHERE id_tugas='$id_tugas'";
	$result1 = mysqli_query($conn,$query1);
	// if($result1) echo "success";
	// else echo "failed";
	
	$string = "";
	
	while($temp = mysqli_fetch_array($result1)) {
		$id = $temp['id_user'];
		$query2 = "SELECT username FROM user WHERE id_user='$id'";
		$result2 = mysqli_query($conn,$query2);
		$temp = mysqli_fetch_array($result2);
		if(strlen($string) > 0) {
			$string = $string . "," . $temp['username'];
		} else {
			$string = $temp['username'];
		}
		
	}
	
	echo $string;
	
?>