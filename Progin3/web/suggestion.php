<?php
	
	$input = $_GET["str"];
	$suggest = "";
	
	if(strlen($input) > 0) {
		$conn = mysqli_connect("localhost",'progin','progin',"progin_405_13510093");
		
		if(!$conn) {
			die('Could not connect: ' . mysqli_error());
		}

		$sql = "SELECT * FROM user";
		$result = mysqli_query($conn,$sql);
		while($temp = mysqli_fetch_array($result)) {
			// echo "input:" . $input . strncmp($input,$temp["username"],strlen($input)) . "<br>";
			if(strncmp($input,$temp["username"],strlen($input)) == 0) {
				$suggest = $suggest . $temp["username"] . "<br>";
				if(strlen($input) == strlen($temp['username'])) {
					$suggest = "complete";
				}
			} 
		}
	}
	
	if($suggest == "") {
		echo "empty";
	} else {
		echo $suggest;
	}
	
?>