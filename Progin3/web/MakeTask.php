<!DOCTYPE html>
<html>

<head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title> Banana Board - New Task </title>
		<link rel="stylesheet" style="text/css" href="style.css">        
</head>
    
<body onload="generateDate();initAttachment();">
	<div id="content">
		<?
			include("header.php");
		?>

		<div id="isi">
			<div id="leftsidebar">
				<ul>
					<li>
						<a id="searchresultleft">CREATE NEW TASK</a>
					</li>	
				</ul>
				<img src="../leftmenu.png"/>
			</div>
		
			<div id="rightsidebar">
				<div id="wrapper-left">
					<form class="task" name="MakeForm" enctype="multipart/form-data">
						<ul>
							<h1>Fill Details</h1>
							<li>
								<label for="tugas" >Nama Tugas</label>
								<input id="tugas" name="tugas" type="text" maxlength="25" onkeyup="checkTaskName(this.value);"/><br>
								<div id="errorTaskName"></div>
							</li>
							<li>
								<label for="filebutton">Attachment</label>
								<div id="attachmentGroup">
								</div>
							</li>		
							<li>
								<label for="asignee">Assignee</label>
								<input id="asignee" name="asignee" type="text" onkeyup="checkSuggestion(this.value);"/>
								<div id="suggestion"></div>
								<span>*dipisahkan dengan ","</span>
							</li>
							<li>
								<label for="tag">Tag</label>
								<input id="tag" name="tag" type="text" size="20"/><br>
								<span>*dipisahkan dengan ","</span>
							</li>							
							<li>
								<label for="deadline">Deadline</label>
								<div id="defaultdate">
									<input id="deadline" type="date" required/>
								</div>
								<div id="customdate">
									<select id="tanggallist">
									</select>
									<select id="bulanlist">
									</select>
									<select id="tahunlist">
									</select>
								</div>
							</li>
							<li>
								<button class="task" name="submitbutton" type="submit" onClick="checkSubmission();"><b>Submit</b></button>
							</li>
						</ul>
					</form>
				</div>
			</div>
		</div>
		<?
			include("footer.php");
		?>
    </div>
	
		<script type="text/javascript">
		var count = 0;
		
		function checkTaskName(str) {
			var flag=0;
			var i=0;
			while(flag===0 && i<str.length) {
				if((str.charAt(i) >= 'a' && str.charAt(i) <= 'z') || (str.charAt(i) >= 'A' && str.charAt(i) <= 'Z') || (str.charAt(i) >= '0' && str.charAt(i) <= '9') || (str.charAt(i) === ' ')) {
					flag = 0;
				} else {
					flag = 1;
					document.getElementById("tugas").value = str.substr(0,i);
					alert("Task name only contains alphabets and numbers !");
				}
				i++;
			}
		}
		
		function checkSuggestion(str) {
			var obj = document.getElementById("suggestion");
			if(str.length === 0) {
				obj.innerHTML = "";
				obj.style.visibility = "hidden";
				obj.style.border = "0px";
			} else {
				var idx = str.lastIndexOf(",");
				if(idx !== -1) {
					str = str.substr(str.lastIndexOf(",")+1);
				}
				if(str.length > 0) {
					var xmlhttp;
					if(window.XMLHttpRequest) {	// code for IE7+, Firefox, Chrome, Opera, Safari
						xmlhttp = new XMLHttpRequest();
					} else {	// code for IE6, IE5
						xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
					}
					xmlhttp.onreadystatechange = function() {
						if(xmlhttp.readyState === 4 && xmlhttp.status === 200) {
							if(xmlhttp.responseText !== "empty" && xmlhttp.responseText !== "complete") {
								obj.innerHTML = xmlhttp.responseText;
								obj.style.visibility = "visible";
								obj.style.border = "3px ridge #A5ACB2";
								obj.style.left = "160px";
								obj.style.width = "200px";
								obj.style.position = "relative";
								obj.style.background = "white";
								obj.style.color = "black";
							} else {	
								obj.innerHTML = "";
								obj.style.visibility = "hidden";
								obj.style.border = "0px";
							}
						}
					};
					xmlhttp.open("GET","suggestion.php?str="+str,true);
					xmlhttp.send();
				}
			}
		}
		
		// inisialisasi struktur field input attachment
		function initAttachment() {
			var obj1 = document.getElementById("attachmentGroup");	// akses group attachment keseluruhan
			var temp1 = document.createElement("DIV");	// buat group field browse dan komentar yang pertama
			temp1.setAttribute("id","group");
			temp1.setAttribute("name","group");
			var temp2 = document.createElement("INPUT");	// buat field browse pertama
			temp2.setAttribute("type","file");
			temp2.setAttribute("id","filebutton"+count);
			temp2.setAttribute("name","filebutton"+count);
			temp2.setAttribute("onchange","attachmentCheck(this.id)");
			temp1.appendChild(temp2);
			obj1.appendChild(temp1);
			count++;
		}

		// checking extension and adding new field attachment according to condition
		function attachmentCheck(thisId)
		{
			var obj0 = document.getElementById("attachmentGroup");	// akses group attachment keseluruhan
			var obj1 = document.getElementById(thisId).parentNode;	// akses group field browse dan komentarnya
			var obj2 = document.getElementById(thisId);	// akses field browse saat ini
			var parse = obj2.value.split(".");
			var ext = parse[parse.length-1];
			if(ext === "jpg" || ext === "jpeg" || ext === "png" || ext === "gif"
			|| ext === "avi" || ext === "mp4" || ext === "mkv" || ext === "3gp" || ext === "flv" || ext === "ogg" || ext === "wmv"
			|| ext === "doc" || ext === "docx" || ext === "pdf") {	// ekstensi file sesuai
				if(obj1.nextSibling === null) {	// tidak memiliki field browse attachment kosong di bawahnya, tambahkan 1 field browse
					var temp1 = document.createElement("DIV");
					temp1.setAttribute("id","group"+document.getElementsByTagName("div").length);
					temp1.setAttribute("name","group"+document.getElementsByTagName("div").length);
					var temp2 = document.createElement("INPUT");
					temp2.setAttribute("type","file");
					temp2.setAttribute("id","filebutton"+count);
					temp2.setAttribute("name","filebutton"+count);
					temp2.setAttribute("onchange","attachmentCheck(this.id)");
					temp2.style.position = "relative";
					temp1.appendChild(temp2);
					obj0.appendChild(temp1);
				}
			} else {	// ektensi file tidak sesuai
				obj1.firstChild.value="";
				alert("can't upload *." + ext + ", please upload image/video/file only");
			}
			count++;
		}
		
		function checkSubmission()
		{
			var taskname = document.getElementById("tugas").value;
			var obj1 = document.getElementById("attachmentGroup");
			var n_obj1 = obj1.childElementCount;
			var attachment = "";
			for(var i=1;i<n_obj1;i++) {
				if(attachment.length > 0) {
					attachment = attachment + ";" + obj1.childNodes[i].firstChild.value;
				} else {
					attachment = obj1.childNodes[i].firstChild.value;
				}
			}
			var assignees = document.getElementById("asignee").value;
			var tags = document.getElementById("tag").value;
			var day = document.getElementById("tanggallist").value;
			var month = document.getElementById("bulanlist").value;
			var year = document.getElementById("tahunlist").value;
			var tanggal = year + "-" + month + "-" + day;
			var id_cat = "<?echo $_GET['idcat'];?>";
			
			//alert("year" + year);
			var params = "namatugas=" + taskname + "&date=" + tanggal + "&idcat=" + id_cat + "&assignee=" + assignees + "&tag=" + tags + "&attach=" + attachment;
			//alert(params);
			var xmlhttp;
			if(window.XMLHttpRequest) {
				xmlhttp = new XMLHttpRequest();
			} else {
				xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			
			xmlhttp.onreadystatechange = function() {
				if(xmlhttp.readyState === 4 && xmlhttp.status === 200) {
					//alert("masuk" + xmlhttp.responseText);					
				}
			};
			
			xmlhttp.open("POST","addTask.php",false);
			xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
			xmlhttp.send(params);
		}
		
		function generateDate()
		{
			var browser = document.createElement("input");
			browser.setAttribute("type", "date");
			var a = document.getElementById("customdate");
			a.style.display = "block";
			var b = document.getElementById("tanggallist");
			for (var i = 1; i <= 31; i++)
			{
				var option = document.createElement("option");
				option.text = "" + i;
				option.value = i;
				b.appendChild(option);
			}
			
			var c = document.getElementById("bulanlist");
			for (var i = 1; i <= 12; i++)
			{
				var option = document.createElement("option");
				option.text = "" + i;
				option.value = i;
				c.appendChild(option);
			}
			
			var d = document.getElementById("tahunlist");
			for (var i = 1955; i <= 2013; i++)
			{
				var option = document.createElement("option");
				option.text = "" + i;
				option.value = i;
				d.appendChild(option);
			}
		}
	</script>

</body>

</html>