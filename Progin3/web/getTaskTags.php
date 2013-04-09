<?php
	
	$id_tugas = $_GET["id"];
	
	$conn = mysqli_connect('localhost', 'progin', 'progin',"progin_405_13510093");

	if (!$conn)
	{
		echo "Failed to connect to MySQL: " . mysqli_connect_error();
	}
	
	$query1 = "SELECT label FROM tag WHERE id_tugas='$id_tugas'";
	$result1 = mysqli_query($conn,$query1);
	// if($result1) echo "success";
	// else echo "failed";
	
	$string = "";
	
	while($temp = mysqli_fetch_array($result1)) {
		if(strlen($string) > 0) {
			$string = $string . "," . $temp['label'];
		} else {
			$string = $temp['label'];
		}
	}
	
	echo $string;
	
?>