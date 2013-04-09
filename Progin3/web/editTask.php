<?php

	$id_tugas = $_POST["idtugas"];
	$namatugas = $_POST["namatugas"];
	$tanggal = $_POST["date"];
	$assignees = $_POST["assignee"];
	$tags = $_POST["tag"];
	$status = $_POST["status"];
	
	$conn = mysqli_connect('localhost', 'progin', 'progin',"progin_405_13510093");

	if (!$conn)
	{
		echo "Failed to connect to MySQL: " . mysqli_connect_error();
	}
	$n = 0;
	
	$assignee = array();
	$token = strtok($assignees,",");
	while($token != false) {
		$assignee[$n] = $token;
		$n++;
		$token = strtok(",");
	}
	$n_assignees = $n;
	$n = 0;
	
	$tag = array();
	$token = strtok($tags,",");
	while($token != false) {
		$tag[$n] = $token;
		$n++;
		$token = strtok(",");
	}
	$n_tags = $n;
	$n = 0;
	
	$query10 = "UPDATE tugas SET nama_tugas='$namatugas', status_tugas='$status', deadline=date('$tanggal') WHERE id_tugas='$id_tugas'";
	$result10 = mysqli_query($conn,$query10);
	
	$query20 = "DELETE FROM tag WHERE id_tugas='$id_tugas'";
	$result20 = mysqli_query($conn,$query20);
	
	$query30 = "DELETE FROM mengerjakan WHERE id_tugas='$id_tugas'";
	$result30 = mysqli_query($conn,$query30);
	
	for($i=0;$i<$n_assignees;$i++) {
		$query3 = "SELECT id_user FROM user WHERE username='$assignee[$i]'";
		$result3 = mysqli_query($conn,$query3);
		$temp = mysqli_fetch_array($result3);
		$id_user = $temp['id_user'];
		$query4 = "INSERT INTO mengerjakan (id_user,id_tugas) VALUES ('$id_user','$id_tugas')";
		$result4 = mysqli_query($conn,$query4);
	}
	
	for($i=0;$i<$n_tags;$i++) {
		$query5 = "INSERT INTO tag (id_tugas,label) VALUES ('$id_tugas','$tag[$i]')";
		$result5 = mysqli_query($conn,$query5);
	}
	
	mysqli_close($conn);
	
?>














