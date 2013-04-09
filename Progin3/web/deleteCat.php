<?
	$con = mysqli_connect('localhost', 'progin', 'progin',"progin_405_13510093");
	session_start();
	if (!$con)
	{
		echo "Failed to connect to MySQL: " . mysqli_connect_error();
	}

	mysqli_query($con,"DELETE FROM kategori WHERE id_kategori='".$_GET['idcat']."'");
	
	mysqli_close($con);
	
	header("Location: ./home.php");
?>