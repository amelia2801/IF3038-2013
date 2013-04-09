<?php
	
	$id_user = $_GET["iduser"];
	$id_tugas = $_GET["idtugas"];
	$isi_komentar = $_GET["isikomentar"];
	
	$conn = mysqli_connect('localhost', 'progin', 'progin',"progin_405_13510093");

	if (!$conn)
	{
		echo "Failed to connect to MySQL: " . mysqli_connect_error();
	}
	
	$date = date('Y-m-d H:i:s');
	
	$query = "INSERT INTO komentar (id_komentar,id_user,id_tugas,isi_komentar,tanggal_komentar) VALUES(NULL,'$id_user','$id_tugas','$isi_komentar','$date')";
	$result = mysqli_query($conn,$query);
	
	if($result) echo "success";
	else echo "failed";
?>