<?
	$name = $_POST["catName"];
	$assignees = $_POST["assname"];

	session_start();
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

	
	$query1 = "INSERT INTO kategori (id_kategori,nama_kategori) VALUES (NULL,'$name')";
	$result1 = mysqli_query($conn,$query1);
	
	$query2 = "SELECT id_kategori FROM kategori WHERE nama_kategori='$name'";
	$result2 = mysqli_query($conn,$query2);
	$temp = mysqli_fetch_array($result2);
	$id_kategori = $temp['id_kategori'];
	
	$query3 = "SELECT id_user FROM user WHERE username='".$_SESSION['user']."'";
	$result3 = mysqli_query($conn,$query3);
	$temp = mysqli_fetch_array($result3);
	$id_user = $temp['id_user'];
	$query4 = "INSERT INTO anggota (id_user,id_kategori,status) VALUES ('$id_user','$id_kategori','ongoing')";
	$result4 = mysqli_query($conn,$query4);
	
	
	for($i=0;$i<$n_assignees;$i++) {
		$query3 = "SELECT id_user FROM user WHERE username='$assignee[$i]'";
		$result3 = mysqli_query($conn,$query3);
		$temp = mysqli_fetch_array($result3);
		$id_user = $temp['id_user'];
		$query4 = "INSERT INTO anggota (id_user,id_kategori,status) VALUES ('$id_user','$id_kategori','ongoing')";
		$result4 = mysqli_query($conn,$query4);
	}
	
	mysqli_close($conn);
	header("Location: ./home.php");
?>