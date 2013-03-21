<?php	
	$con = mysqli_connect('localhost', 'progin', 'progin',"progin_405_13510093");

	if (!$con)
	{
		echo "Failed to connect to MySQL: " . mysqli_connect_error();
	}
	session_start();
	// store session data
	if(isset($_SESSION['user']) /* && (time() - $_SESSION['CREATED'] < 1800) */){
	}else{
		session_destroy();
		header( "Location: http://localhost/Progin2/index.php") ;
	}
	
	if ($_GET){
		if ($_GET["a"]==0){
			$temp = 'Full name not change \n';
		}else{
			$temp = 'Full name have changed \n';
		}
		
		if ($_GET["b"]==0){
			$temp = $temp.'Password not change \n';
		}else{
			$temp = $temp.'Password have changed \n';
		}
		
		if ($_GET["c"]==0){
			$temp = $temp.'Date of Birth not change \n';
		}else{
			$temp = $temp.'Date of Birth have changed \n';
		}
		
		if ($_GET["c"]==0){
			$temp = $temp.'Avatar not change \n';
		}else{
			$temp = $temp.'Avatar have changed \n';
		}
		
		?><script>alert("<?echo $temp?>")</script><?
	}else{
	}

// class Hello{
	// private $hello_string;
	// private $name;
	
	// public function __construct(){
		// $this->set_name("beni");
		// $this->hello_string = "Hello". $this->name;
	// }
	
	// public function set_name($name){
		// $this->name = $name;
	// }
	
	// public function say_helo(){
		// echo  $this->hello_string;
	// }
// }

// $model_hello = new Hello;
// $model_hello->say_helo();


?>

<div id="header" onload="isAlreadylogin()">
	<div id="logo">
		<!-- <a href="index.html" class="header">board</a> -->
		<img src="../logo.png"/>
		</div>
		<div id="menu">
		<ul>
			<li> <a href="home.php"> DASHBOARD </a> </li>
			<li> <a href="profile.php"> PROFILE </a> </li>
			<li> <a href="logout.php" onclick=localStorage.removeItem("userlogin");> LOGOUT </a> </li>
		</ul>
		<form action="index.html">
			<input class="button" type="submit" value="">
			<input class="box" type="text" onclick="this.value='';" onfocus="this.select()" onblur="this.value=!this.value?'Enter search query':this.value;" value="Enter search query">
			
		</form>
	</div>
</div>