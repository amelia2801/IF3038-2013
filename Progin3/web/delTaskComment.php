<?php
	
	$id_komentar = $_GET["idcomment"];
	
	$conn = mysqli_connect('localhost', 'progin', 'progin',"progin_405_13510093");

	if (!$conn)
	{
		echo "Failed to connect to MySQL: " . mysqli_connect_error();
	}
	
	echo $id_komentar;
	$query = "DELETE FROM komentar WHERE id_komentar='$id_komentar'";
	$result = mysqli_query($conn,$query);
	
	if($result) echo "success";
	else echo "failed";
?>