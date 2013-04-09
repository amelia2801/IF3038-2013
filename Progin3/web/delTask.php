<?php

	$id_tugas = $_POST["idtugas"];
	
	echo $id_tugas;
	
	$conn = mysqli_connect('localhost', 'progin', 'progin',"progin_405_13510093");

	if (!$conn)
	{
		echo "Failed to connect to MySQL: " . mysqli_connect_error();
	}
	
	$query = "DELETE FROM tugas WHERE id_tugas='$id_tugas'";
	$result = mysqli_query($conn,$query);
	
	if($result) echo "succes";
	else echo "failed";
	
	mysqli_close($conn);
	
?>














