<?php
if(isset($_GET['id']))
	{
	$getid = $_GET['id'];
	$getcheck = $_GET['ischeck'];
	$con = mysql_connect("localhost","root");
	if (!$con)
	{
		die('Could not connect: ' . mysql_error());
	}

	mysql_select_db("tubesprogin", $con);
	
	if ($getcheck == "true"){
		$change = mysql_query('UPDATE `tubesprogin`.`tugas` SET `status_tugas` = "done" WHERE `tugas`.`id_tugas` = "'.$getid.'";');
		$change1 = mysql_query('SELECT a.status_tugas FROM `tugas` as a natural join `tag` as b WHERE a.`id_tugas` = "'.$getid.'";');
	}else{
		$change = mysql_query('UPDATE `tubesprogin`.`tugas` SET `status_tugas` = "in progress" WHERE `tugas`.`id_tugas` = "'.$getid.'";');
		$change1 = mysql_query('SELECT a.status_tugas FROM `tugas` as a natural join `tag` as b WHERE a.`id_tugas` = "'.$getid.'";');
	}
	
	echo (json_encode(mysql_fetch_array($change1)));
	mysql_close($con);
	}
	else
	echo ("gagal");
?> 