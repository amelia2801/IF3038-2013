<?php
	
	$id_tugas = $_GET["id"];
	$state = $_GET["state"];
	
	$conn = mysqli_connect('localhost', 'progin', 'progin',"progin_405_13510093");

	if (!$conn)
	{
		echo "Failed to connect to MySQL: " . mysqli_connect_error();
	}
	
	$start = ($state*10) - 10;
	$count = $state * 10;
	
	$query1 = "SELECT * FROM komentar WHERE id_tugas='$id_tugas' ORDER BY tanggal_komentar DESC LIMIT $start,$count";
	$result1 = mysqli_query($conn,$query1);	
	
	$string = "";
	while($temp = mysqli_fetch_array($result1)) {
		$iduser = $temp['id_user'];
		$query2 = "SELECT avatar FROM user WHERE id_user='$iduser'";
		$result2 = mysqli_query($conn,$query2);
		$tempresult2 = mysqli_fetch_array($result2);
		$temp7 = "";
		$temp7 = $temp7 . $tempresult2['avatar'];
		$temp2 = $temp['isi_komentar'];
		$temp3 = $temp['tanggal_komentar'];
		$query3 = "SELECT username FROM user WHERE id_user='$iduser'";
		$result3 = mysqli_query($conn,$query3);
		$tempresult = mysqli_fetch_array($result3);
		$temp4 = $tempresult['username'];
		$temp6 = $temp['id_komentar'];
		$temp5 = $temp2 . "*" . $temp3 . "*" . $temp4 . "*" . $iduser . "*" . $temp6 . "*" . $temp7;
		if(strlen($string) > 0) {
			$string = $string . ";" . $temp5;
		} else {
			$string = $temp5;
		}
	}
	
	echo $string;
	
?>