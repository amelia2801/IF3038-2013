<?php

	$taskname = $_POST["namatugas"];
	$deadline = $_POST["date"];
	$id_category = $_POST["idcat"];
	$assignees = $_POST["assignee"];
	$tags = $_POST["tag"];
	$attachments = $_POST["attach"];
	
	echo "masuk";
	
	$conn = mysqli_connect("localhost",'progin','progin',"progin_405_13510093");
	
	if(!$conn) {
		die('Could not connect' . mysqli_error());
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
	
	$attachment = array();
	$token = strtok($attachments,";");
	while($token != false) {
		$attachment[$n] = $token;
		$n++;
		$token = strtok(";");
	}
	$n_attachments = $n;
	$n = 0;
	
	echo $taskname . $deadline . $id_category;
	$query1 = "INSERT INTO tugas (id_tugas,nama_tugas,deadline,id_kategori,status_tugas) VALUES (NULL,'$taskname',DATE('$deadline'),'$id_category','in progress')";
	$result1 = mysqli_query($conn,$query1);
	if($result1) {
		echo "1. insert tugas baru berhasil <br>";
	} else {
		echo "1. insert tugas baru gagal";
	}
	
	$query2 = "SELECT id_tugas FROM tugas WHERE nama_tugas='$taskname'";
	$result2 = mysqli_query($conn,$query2);
	$temp = mysqli_fetch_array($result2);
	$id_tugas = $temp['id_tugas'];
	
	for($i=0;$i<$n_assignees;$i++) {
		$query3 = "SELECT id_user FROM user WHERE username='$assignee[$i]'";
		$result3 = mysqli_query($conn,$query3);
		$temp = mysqli_fetch_array($result3);
		$id_user = $temp['id_user'];
		$query4 = "INSERT INTO mengerjakan (id_user,id_tugas) VALUES ('$id_user','$id_tugas')";
		$result4 = mysqli_query($conn,$query4);
		// if($result1) {
			// echo "4. insert mengerjakan berhasil <br>";
		// } else {
			// echo "4. insert mengerjakan gagal";
		// }
	}
	
	for($i=0;$i<$n_tags;$i++) {
		$query5 = "INSERT INTO tag (id_tugas,label) VALUES ('$id_tugas','$tag[$i]')";
		$result5 = mysqli_query($conn,$query5);
		// if($result1) {
			// echo "5. insert tag berhasil <br>";
		// } else {
			// echo "5. insert tag gagal";
		// }
	}
	
	for($i=0;$i<$n_attachments;$i++) {
		$attached = "assets/" . $attachment[$i];
		$query6 = "INSERT INTO attachment (id_tugas,nama_file) VALUES ('$id_tugas','$attachment[$i]')";
		$result6 = mysqli_query($conn,$query6);
		// if($result1) {
			// echo "6. insert attachment berhasil <br>";
		// } else {
			// echo "6. insert attachment gagal";
		// }
	}
	
	mysqli_close($conn);
	
?>














