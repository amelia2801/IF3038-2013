<?php
if(isset($_GET['id']))
	{
	$getid = $_GET['id'];
	$getcheck = $_GET['ischeck'];
	
	$con = mysqli_connect('localhost', 'progin', 'progin',"progin_405_13510093");
	if (!$con)
	{
		echo "Failed to connect to MySQL: " . mysqli_connect_error();
	}
	
	if ($getcheck == "true"){
		$change = mysqli_query($con,'UPDATE `progin_405_13510093`.`tugas` SET `status_tugas` = "done" WHERE `tugas`.`id_tugas` = "'.$getid.'";');
		$change1 = mysqli_query($con,'SELECT a.status_tugas FROM `tugas` as a natural join `tag` as b WHERE a.`id_tugas` = "'.$getid.'";');
	}else{
		$change = mysqli_query($con,'UPDATE `progin_405_13510093`.`tugas` SET `status_tugas` = "in progress" WHERE `tugas`.`id_tugas` = "'.$getid.'";');
		$change1 = mysqli_query($con,'SELECT a.status_tugas FROM `tugas` as a natural join `tag` as b WHERE a.`id_tugas` = "'.$getid.'";');
	}
	mysqli_close($con);
	}
else{
		echo ("gagal");
}
?> 