<?php
	
	$id_tugas = $_GET["id"];
	
	$conn = mysqli_connect('localhost', 'progin', 'progin',"progin_405_13510093");

	if (!$conn)
	{
		echo "Failed to connect to MySQL: " . mysqli_connect_error();
	}
	
	$query1 = "SELECT nama_file FROM attachment WHERE id_tugas='$id_tugas'";
	$result1 = mysqli_query($conn,$query1);	
	// if($result1) echo "success";
	// else echo "failed";
	
	$string = "";
	while($temp = mysqli_fetch_array($result1)) {
		$attach = $temp['nama_file'];
		if(strlen($string) > 0) {
			$string = $string . ";" . $attach;
		} else {
			$string = $attach;
		}
	}
	
	echo $string;
	
?>