<?php
	
	$id_tugas = $_GET["id"];
	
	$conn = mysqli_connect('localhost', 'progin', 'progin',"progin_405_13510093");

	if (!$conn)
	{
		echo "Failed to connect to MySQL: " . mysqli_connect_error();
	}
	
	$query1 = "SELECT status_tugas FROM tugas WHERE id_tugas='$id_tugas'";
	$result1 = mysqli_query($conn,$query1);
	
	// if($result1) echo "success";
	// else echo "failed";
	
	$task_status = mysqli_fetch_array($result1);
	
	echo $task_status['status_tugas'];
	
?>