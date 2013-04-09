<?
	session_start();
	$_SESSION['user']=$_GET["local"];
	if(isset($_SESSION['user'])){
		echo 'true';
	}else{
		echo 'false';
	}
?>