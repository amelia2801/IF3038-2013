<?
	$con = mysqli_connect('localhost', 'progin', 'progin',"progin_405_13510093");
	session_start();
	if (!$con)
	{
		echo "Failed to connect to MySQL: " . mysqli_connect_error();
	}
	
	$resultcat = mysqli_query($con,"SELECT * FROM `kategori` natural join `user` natural join `anggota` WHERE `user`.username='".$_SESSION['user']."'");
	$kategori = mysqli_fetch_array($resultcat);
	
	if ($_GET["cat"]==0){
		if (count($kategori['nama_kategori'])==0){
		}else{
			while (count($kategori['nama_kategori'])!=0)
			{
				echo "				
					<li>
					<div class=\"judulkategoriwrap\">
						<div class=\"judulkategori\">"
							.$kategori['nama_kategori'].
						"</div>
						<div class=\"kategoriaddtugas\">
							<a href=\"MakeTask.php?idcat=".$kategori['id_kategori']."\">+</a>
							<a href=\"deleteCat.php?idcat=".$kategori['id_kategori']."\">x</a>
						</div>
					</div>";
				$resulttugas = mysqli_query($con,"SELECT * FROM `tugas` natural join `user` natural join `kategori` natural join `anggota` WHERE `user`.username='".$_SESSION['user']."' AND `kategori`.nama_kategori='".$kategori['nama_kategori']."'");
				$tugas = mysqli_fetch_array($resulttugas);
				
				if (count($tugas['nama_tugas'])!=0){
					while (count($tugas['nama_tugas'])!=0)
					{
						echo "
							<div class=\"tugaswrap\">
								<input type=\"checkbox\" id=\"checklist".$tugas['id_tugas']."\" ";
						if ($tugas['status_tugas']=="done"){
							echo 'checked';
						}
						echo " name=\"check\" onclick=\"changevalues(".$tugas['id_tugas'].");\" />
								<a class=\"kategoritugas\" href=\"taskdetails.php?idtask=".$tugas['id_tugas']."&iduser=".$tugas['id_user']."\">".$tugas['nama_tugas']."<span>Tag: ";
						$resulttag = mysqli_query($con,"SELECT * FROM `tag` natural join `tugas` WHERE `tugas`.nama_tugas='".$tugas['nama_tugas']."'");
						$tag = mysqli_fetch_array($resulttag);
						if (count($tag['label'])==0){
							echo "-";
						}else{
							while (count($tag['label'])!=0)
							{
								echo $tag['label'];
								$tag = mysqli_fetch_array($resulttag);
								if ($tag){
									echo ",";
								}
							}
						}
						echo "</span></a>
								<div class=\"kategoritugastanggal\">".$tugas['deadline']."</div>
							</div>";
						$tugas = mysqli_fetch_array($resulttugas);
					}
				}else{
				}
				echo"</li>";
				$kategori = mysqli_fetch_array($resultcat);
			}
		}
	}else{
		if (count($kategori['nama_kategori'])==0){
		}else{
			$i=1;
			while ($i != $_GET["cat"]){
				$kategori = mysqli_fetch_array($resultcat);
				$i++;
			}
			
			echo "				
				<li>
					<div class=\"judulkategoriwrap\">
						<div class=\"judulkategori\">"
							.$kategori['nama_kategori'].
						"</div>
						<div class=\"kategoriaddtugas\">
							<a href=\"MakeTask.php?idcat=".$kategori['id_kategori']."\">+</a>
							<a href=\"deleteCat.php?idcat=".$kategori['id_kategori']."\">x</a>
						</div>
					</div>";
								
			$resulttugas = mysqli_query($con,"SELECT * FROM `tugas` natural join `user` natural join `kategori` natural join `anggota` WHERE `user`.username='".$_SESSION['user']."' AND `kategori`.nama_kategori='".$kategori['nama_kategori']."'");
			$tugas = mysqli_fetch_array($resulttugas);
					
			if (count($tugas['nama_tugas'])!=0){
				while (count($tugas['nama_tugas'])!=0)
				{
					echo "
						<div class=\"tugaswrap\">
							<input type=\"checkbox\" ";
					if ($tugas['status_tugas']=="done"){
						echo 'checked';
					}
					echo " name=\"check\" onclick=\"changevalues(".$tugas['id_tugas'].");\" />
							<a class=\"kategoritugas\" href=\"taskdetails.php?idtask=".$tugas['id_tugas']."&iduser=".$tugas['id_user']."\">".$tugas['nama_tugas']."<span>Tag: ";
					$resulttag = mysqli_query($con,"SELECT * FROM `tag` natural join `tugas` WHERE `tugas`.nama_tugas='".$tugas['nama_tugas']."'");
					$tag = mysqli_fetch_array($resulttag);
					if (count($tag['label'])==0){
						echo "-";
					}else{
						while (count($tag['label'])!=0)
						{
							echo $tag['label'];
							$tag = mysqli_fetch_array($resulttag);
							if ($tag){
								echo ",";
							}
						}
					}
					echo "</span></a>
							<div class=\"kategoritugastanggal\">".$tugas['deadline']."</div>
						</div>";
					$tugas = mysqli_fetch_array($resulttugas);
				}
			}else{
			
			}
			echo"</li>";

		}
	}
?>