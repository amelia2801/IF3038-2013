<?
	session_start();
	$_SESSION['user']=$_GET["local"];
	if(isset($_SESSION['user'])){
		//header( "Location: http://localhost/Progin2/src/home.php") ;
		echo 'true';
	}else{
		//header( "Location: http://localhost/Progin2/src/home.html") ;
		echo 'false';
	}
?>