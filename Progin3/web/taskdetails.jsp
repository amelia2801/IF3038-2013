<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Banana Board - Your Task's Details</title>		
        <link rel="stylesheet" type="text/css" href="style.css"> 
    </head>

    <body onload="initialize();">
        <div id="content">
<!--			<?
				include("header.php");
			?>-->
            
			<div id="isi">
				<div id="leftsidebar">
					<ul>
						<li>
							<a id="searchresultleft">Task Details</a>
						</li>	
					</ul>
					<img src="../leftmenu.png"/>
				</div>
			
				<div id="rightsidebar"><input id="thecreator" clas="thecreator" type="button">
					<form id="detiltask" class="detiltask" name="detiltask">
						<ul class="task">
							<h1>Details</h1><input id="state" class="state" type="button" value="1"/>as
							<li>
								<label for="tugas">Nama Tugas</label>
								<input id="tugas" type="text" size="50" disabled/><br>
							</li>
							<li>
								<label for="status">Status Tugas</label>
								<input id="status" type="text" size="50" disabled/><br>
								<div id="status"></div>
							</li>
							<li>
								<div id="attachgroup" class="attachgroup">
									<div id="files">
										<div class="rincianleft">FILES:</div>
									</div><br>
									<div id="images">
										<div class="rincianleft">IMAGES:</div>
									</div><br>
									<div id="videos">
										<div class="rincianleft">VIDEOS:</div>
									</div><br>
								</div>
							</li>
							<li>
								<label for="deadline">Deadline</label>
								<select id="tanggallist" class="deadline" disabled>
								</select>
								<select id="bulanlist" class="deadline" disabled>
								</select>
								<select id="tahunlist" class="deadline" disabled>
								</select>
							</li>
							<li>
								<label for="assignee">Assignee</label>
								<div id="assignees" class="assignees"></div>
							</li>					
							<li>
								<label for="textfields">Tag</label>
								<input id="textfields" type="text" size="50" disabled/><br>
							</li>
							<li>
								<button id="edit" name="edit" type="button" onclick="editTask()"><b>EDIT</b></button><br>
							</li>
						</ul>
						<div id="comment">
							<div id="commentgroup" class="commentgroup">
							</div>
						</div>
					</form>
				</div>
			</div>
			
<!--			<?
				include("footer.php");
			?>-->
        </div>
        
        <script	type="text/javascript">
            function checkSuggestion(str) {
                var obj = document.getElementById("suggestion");
                if(str.length == 0) {
                    obj.innerHTML = "";
                    obj.style.visibility = "hidden";
                    obj.style.border = "0px";
                } else {
                    var idx = str.lastIndexOf(",");
                    if(idx != -1) {
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
                            if(xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                                if(xmlhttp.responseText != "empty" && xmlhttp.responseText != "complete") {
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
                        }
                        xmlhttp.open("GET","suggestion?str="+str,true);
                        xmlhttp.send();
                    }
                }
            }
			
            function editTask() {
                var obj1 = document.getElementById("detiltask");
                var temp1 = document.getElementById("tugas").value;
                var temp2 = getTaskAssigneeWithoutCreator("<?echo $_GET['idtask'];?>");
                var temp3 = document.getElementById("textfields").value;
                var temp4 = document.getElementById("status").value;
                var day = document.getElementById("tanggallist").value;
                if(day[0] == 0) day = day[1];
                var month = document.getElementById("bulanlist").value;
                if(month[0] == 0) month = month[1];
//                alert(month);
                var year = document.getElementById("tahunlist").value;
                if(temp4 == "done") {
                    var blabla = '<label for="status">Status Tugas</label><input id="status" name="status" type="checkbox" value="done" onchange="changeStatus()" checked/>Done<br>';
                }
                else {
                    var blabla = '<label for="status">Status Tugas</label><input id="status" name="status" type="checkbox" value="in progress" onchange="changeStatus()" unchecked/>Done<br>';
                }
//                if(document.getElementById("thecreator").value == "<?echo $_GET['iduser'];?>") {
//                    obj1.innerHTML = '<ul class="task"><h1>Edit Details</h1><li><label for="tugas" >Nama Tugas</label><input id="tugas" maxlength="25" name="tugas" type="text" value=' + temp1 + ' /><br><div id="errorTaskName"></div></li><li>' + blabla + '</li><li><label for="deadline">Deadline</label><select id="tanggallist" class="deadline" enabled></select><select id="bulanlist" class="deadline" enabled></select><select id="tahunlist" class="deadline" enabled></select></li><li><label for="asignee">Assignee</label><input id="asignee" name="asignee" type="text" value=' + temp2 + ' onkeyup="checkSuggestion(this.value)"/><div id="suggestion"></div><span>*dipisahkan dengan ","</span></li><li><label for="tag">Tag</label><input id="tag" name="tag" type="text" size="20" value=' + temp3 + ' /><br><span>*dipisahkan dengan ","</span><br><button id="savebutton" name="savebutton" type="button" onclick="saveEditTask()"><b>SAVE</b></button><br><button id="delete" name="save" type="button" onclick="delTask()"><b>DELETE</b></button></li></ul><div id="comment"><div id="commentgroup" class="commentgroup"></div></div>';
//                } else {
//                    obj1.innerHTML = '<ul class="task"><h1>Edit Details</h1><li><label for="tugas" >Nama Tugas</label><input id="tugas" maxlength="25" name="tugas" type="text" value=' + temp1 + ' /><br><div id="errorTaskName"></div></li><li>' + blabla + '</li><li><label for="deadline">Deadline</label><select id="tanggallist" class="deadline" enabled></select><select id="bulanlist" class="deadline" enabled></select><select id="tahunlist" class="deadline" enabled></select></li><li><label for="asignee">Assignee</label><input id="asignee" name="asignee" type="text" value=' + temp2 + ' onkeyup="checkSuggestion(this.value)"/><div id="suggestion"></div><span>*dipisahkan dengan ","</span></li><li><label for="tag">Tag</label><input id="tag" name="tag" type="text" size="20" value=' + temp3 + ' /><br><span>*dipisahkan dengan ","</span><br><button id="savebutton" name="savebutton" type="button" onclick="saveEditTask()"><b>SAVE</b></button></li></ul><div id="comment"><div id="commentgroup" class="commentgroup"></div></div>';
//                }
//                alert(document.getElementById("thecreator").value);
                if(document.getElementById("thecreator").value == "2") {
                    obj1.innerHTML = '<ul class="task"><h1>Edit Details</h1><li><label for="tugas" >Nama Tugas</label><input id="tugas" maxlength="25" name="tugas" type="text" value=' + temp1 + ' /><br><div id="errorTaskName"></div></li><li>' + blabla + '</li><li><label for="deadline">Deadline</label><select id="tanggallist" class="deadline" enabled></select><select id="bulanlist" class="deadline" enabled></select><select id="tahunlist" class="deadline" enabled></select></li><li><label for="asignee">Assignee</label><input id="asignee" name="asignee" type="text" value=' + temp2 + ' onkeyup="checkSuggestion(this.value)"/><div id="suggestion"></div><span>*dipisahkan dengan ","</span></li><li><label for="tag">Tag</label><input id="tag" name="tag" type="text" size="20" value=' + temp3 + ' /><br><span>*dipisahkan dengan ","</span><br><button id="savebutton" name="savebutton" type="button" onclick="saveEditTask()"><b>SAVE</b></button><br><button id="delete" name="save" type="button" onclick="delTask()"><b>DELETE</b></button></li></ul><div id="comment"><div id="commentgroup" class="commentgroup"></div></div>';
                } else {
                    obj1.innerHTML = '<ul class="task"><h1>Edit Details</h1><li><label for="tugas" >Nama Tugas</label><input id="tugas" maxlength="25" name="tugas" type="text" value=' + temp1 + ' /><br><div id="errorTaskName"></div></li><li>' + blabla + '</li><li><label for="deadline">Deadline</label><select id="tanggallist" class="deadline" enabled></select><select id="bulanlist" class="deadline" enabled></select><select id="tahunlist" class="deadline" enabled></select></li><li><label for="asignee">Assignee</label><input id="asignee" name="asignee" type="text" value=' + temp2 + ' onkeyup="checkSuggestion(this.value)"/><div id="suggestion"></div><span>*dipisahkan dengan ","</span></li><li><label for="tag">Tag</label><input id="tag" name="tag" type="text" size="20" value=' + temp3 + ' /><br><span>*dipisahkan dengan ","</span><br><button id="savebutton" name="savebutton" type="button" onclick="saveEditTask()"><b>SAVE</b></button></li></ul><div id="comment"><div id="commentgroup" class="commentgroup"></div></div>';
                }
                
                generateDate(day,month,year);
                //alert(document.getElementById("asignee").innerHTML);
                document.getElementById("edit").style.visibility="hidden";
                document.getElementById("save").style.visibility="visible";
            }
            
            function getTaskAssigneeWithoutCreator(idtugas) {
                var xmlhttp;
                if(window.XMLHttpRequest) {	// code for IE7+, Firefox, Chrome, Opera, Safari
                        xmlhttp = new XMLHttpRequest();
                } else {	// code for IE6, IE5
                        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                }

                var temp = "";

                xmlhttp.onreadystatechange = function() {
                        if(xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                                temp = xmlhttp.responseText;
                        }
                }

                xmlhttp.open("GET","getTaskAssigneeWithoutCreator?id="+idtugas,false);
                xmlhttp.send();

                if(temp.length>0) return temp;
            }
            
            function delTask() {
                var xmlhttp;
                var idtugas = "<?echo $_GET['idtask'];?>";

                if(window.XMLHttpRequest) {
                    xmlhttp = new XMLHttpRequest();
                } else {
                    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                }

                xmlhttp.onreadystatechange = function() {
                    if(xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                        //alert("masuk" + xmlhttp.responseText);					
                    }
                }

                xmlhttp.open("POST","delTask",false);
                xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                xmlhttp.send("idtugas="+idtugas);
            }	
			
            function changeStatus() {
                var obj = document.getElementById("status");
                if(obj.value == "done") obj.value = "in progress";
                else obj.value = "done";
            }
			
            function saveEditTask() {
//                alert("d");
                var idtugas = "<?echo $_GET['idtask'];?>";
                var taskname = document.getElementById("tugas").value;
                var assignees = document.getElementById("asignee").value;
                var tags = document.getElementById("tag").value;
                var day = document.getElementById("tanggallist").value;
                var month = document.getElementById("bulanlist").value;
                var year = document.getElementById("tahunlist").value;
                var tanggal = year + "-" + month + "-" + day;
                var status = document.getElementById("status").value;
//                alert("e");
//                alert(document.getElementById("thecreator"));
                var idcreator = document.getElementById("thecreator").value;
//                alert("c");
                var params = "idtugas=" + idtugas + "&namatugas=" + taskname + "&date=" + tanggal + "&assignee=" + assignees + "&tag=" + tags + "&status=" + status + "&idcreator=" + idcreator;
//                alert(params);
                var xmlhttp;
                if(window.XMLHttpRequest) {
                    xmlhttp = new XMLHttpRequest();
                } else {
                    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                }

                xmlhttp.onreadystatechange = function() {
                    if(xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                        //alert("masuk" + xmlhttp.responseText);					
                    }
                }
//                alert("a");
                xmlhttp.open("POST","editTask",false);
//                alert("b");
                xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                xmlhttp.send(params);
                document.getElementById("detiltask").innerHTML = '<ul class="task"><h1>Details</h1><input id="state" class="state" type="button" value="1"/><li><label for="tugas">Nama Tugas</label><input id="tugas" type="text" size="50" disabled/><br></li><li><label for="status">Status Tugas</label><input id="status" type="text" size="50" disabled/><br><div id="status"></div></li><li><div id="attachgroup" class="attachgroup"><div id="files"><div class="rincianleft">FILES:</div></div><br><div id="images"><div class="rincianleft">IMAGES:</div></div><br><div id="videos"><div class="rincianleft">VIDEOS:</div></div><br></div></li><li><label for="deadline">Deadline</label><select id="tanggallist" class="deadline" disabled></select><select id="bulanlist" class="deadline" disabled></select><select id="tahunlist" class="deadline" disabled></select></li><li><label for="assignee">Assignee</label><div id="assignees" class="assignees"></div></li>					<li><label for="textfields">Tag</label><input id="textfields" type="text" size="50" disabled/><br></li><li><button id="edit" name="edit" type="button" onclick="editTask()"><b>EDIT</b></button><br></li></ul><div id="comment"><div id="commentgroup" class="commentgroup"></div></div>';
                //alert(document.getElementById("detiltask").innerHTML);
                initialize();
            }
			
            function initialize()
            {
                var taskname = getTaskName("<?echo $_GET['idtask'];?>");
                var taskstatus = getTaskStatus("<?echo $_GET['idtask'];?>");
                var taskdeadline = getTaskDeadline("<?echo $_GET['idtask'];?>");
                var temp = taskdeadline.split("-");
                var year = temp[0];
                var month = temp[1];
                var day = temp[2];
                var assignees = getTaskAssignees("<?echo $_GET['idtask'];?>");
                var creator = getTaskCreator("<?echo $_GET['idtask'];?>");
                var tags = getTaskTags("<?echo $_GET['idtask'];?>");
                var attachments = getTaskAttachments("<?echo $_GET['idtask'];?>");
                var obj1 = document.getElementById("tugas");
                var obj2 = document.getElementById("tanggallist");
                var obj3 = document.getElementById("bulanlist");
                var obj4 = document.getElementById("tahunlist");
                var obj5 = document.getElementById("assignees");
                var obj6 = document.getElementById("textfields");
                var obj7 = document.getElementById("files");
                var obj8 = document.getElementById("images");
                var obj9 = document.getElementById("videos");
                var obj10 = document.getElementById("status");
                if(attachments != undefined) {
                    var files = "";
                    var images = "";
                    var videos = "";
//                    alert(attachments);
                    var temp = attachments.split(";");
                    for(var i=0;i<temp.length;i++) {
//                        alert(i);
                        var temp1 = temp[i].split(".");
//                        alert(temp1[1]);
                        if(temp1[1] == "jpg" || temp1[1] == "jpeg" || temp1[1] == "png" || temp1[1] == "gif") {
                            if(files.length > 0) {
                                images = images + ";" + temp[i];
                            } else {
                                images = temp[i];
                            }
                        } else if(temp1[1] == "avi" || temp1[1] == "mp4" || temp1[1] == "mkv" || temp1[1] == "3gp" || temp1[1] == "flv" || temp1[1] == "ogg" || temp1[1] == "wmv") {
                            if(videos.length > 0) {
                                videos = videos + ";" + temp[i];
                            } else {
                                videos = temp[i];
                            }
                        } else if(temp1[1] == "doc" || temp1[1] == "docx" || temp1[1] == "pdf") {
                            if(images.length > 0) {
                                files = files + ";" + temp[i];
                            } else {
                                files = temp[i];
                            }
                        }
                    }
                    //alert(files);
                    if(files.length > 0) {
                        var stringfile = "";
                        var splitfiles = files.split(";");
                        for(var i=0;i<splitfiles.length;i++) {
                            stringfile = stringfile + "<br><a href='assets/" + splitfiles[i] + "' target='_blank'>" + splitfiles[i] + "</a>";
                        }
                        //alert(stringfile);
                        obj7.innerHTML = obj7.innerHTML + stringfile;
                    }

                    if(images.length > 0) {
                        var stringimg = "";
                        var splitimg = images.split(";");
                        for(var i=0;i<splitimg.length;i++) {
                            stringimg = stringimg + "<img class=taskimage src='assets/" + splitimg[i] + "' ></img>";
                        }
                        obj8.innerHTML = obj8.innerHTML + stringimg;
                    }
                    
                    if(videos.length > 0) {
                        var stringvid = "";
                        var splitvid = videos.split(";");
                        for(var i=0;i<splitvid.length;i++) {
                            //alert(splitvid[i]);
                            stringvid += '<video width="320" height="240" controls><source src="assets/' + splitvid[i] + '" type="video/mp4"><source src="assets/' + splitvid[i] + '" type="video/ogg"><source src="assets/' + splitvid[i] + '" type="video/webm"><object data="movie.mp4" width="320" height="240"><embed src="assets/' + splitvid[i] + '" width="320" height="240"></object></video>';
                        }
                        obj9.innerHTML = obj9.innerHTML + stringvid;
                    }
                }	
                obj1.value = taskname;
                obj10.value = taskstatus;
                var option1 = document.createElement("option");
                option1.text = day;
                option1.value = day;
                obj2.appendChild(option1);
                var option2 = document.createElement("option");
                option2.text = month;
                option2.value = month;
                obj3.appendChild(option2);
                var option3 = document.createElement("option");
                option3.text = year;
                option3.value = year;
                obj4.appendChild(option3);
                obj6.value=tags;
                var split = assignees.split(",");
                var stringasign = "";
                for(var i=0;i<split.length;i++) {
                    stringasign = stringasign + "<div class=taskasignee><a  href='searchProfile.php?user="+split[i]+"'>" + split[i] + "</a></div>;";
                }
                stringasign += "<input type='button' id='theasign' class='theasign' value=" + split +" style='visibility:hidden;'/>";
                document.getElementById("thecreator").value = creator;     
//                var assigneesid = getAssigneesId("<?echo $_GET['idtask'];?>");
//                if(creator != "<?echo $_GET['iduser'];?>" || !isAssignee("<?echo $_GET['iduser'];?>","<?echo $_GET['idtask'];?>")) {
//                    document.getElementById("edit").style.visibility = "hidden";
//                }
                if(!isAssignee("1","<?echo $_GET['idtask'];?>") && creator != "<?echo $_GET['iduser'];?>") {
                    document.getElementById("edit").style.visibility = "hidden";
                }
                
                obj5.innerHTML = stringasign;
//                alert(document.getElementById("thecreator").value);
//                alert(assigneesid);
                initComment();
            }
            
            function isAssignee(iduser,idtugas) {
                var xmlhttp;
                if(window.XMLHttpRequest) {	// code for IE7+, Firefox, Chrome, Opera, Safari
                        xmlhttp = new XMLHttpRequest();
                } else {	// code for IE6, IE5
                        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                }
//                alert("a");
                var temp = "";
                xmlhttp.onreadystatechange = function() {
                        if(xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                                temp = xmlhttp.responseText;
                                var temp1 = temp.split(";");
                                var flag = false;
                                var idx = 0;
                                while(!flag && idx < temp1.length) {
                                    if(iduser == temp1[idx]) flag = true;
                                    else idx++;
                                }
                                return flag;
                        }
                }
                xmlhttp.open("GET","getAssigneesId?id="+idtugas,false);

                xmlhttp.send();
                
                if(temp.length>0) return temp;
            }
            
//            function getAssigneesId(idtugas) {
//                var xmlhttp;
//                if(window.XMLHttpRequest) {	// code for IE7+, Firefox, Chrome, Opera, Safari
//                        xmlhttp = new XMLHttpRequest();
//                } else {	// code for IE6, IE5
//                        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
//                }
//
//                var temp = "";
//                xmlhttp.onreadystatechange = function() {
//                        if(xmlhttp.readyState == 4 && xmlhttp.status == 200) {
//                                temp = xmlhttp.responseText;
//                        }
//                }
//                xmlhttp.open("GET","getAssigneesId?id="+idtugas,false);
//
//                xmlhttp.send();
//                
//                if(temp.length>0) return temp;
//            }
    
            function submitComment() {
                var isicomment = document.getElementById("commentfield").value;
                var xmlhttp;
                if(isicomment.length > 0) {
                        var iduser = "<?echo $_GET['iduser'];?>";
                        var idtugas = "<?echo $_GET['idtask'];?>";

                        if(window.XMLHttpRequest) {	// code for IE7+, Firefox, Chrome, Opera, Safari
                                xmlhttp = new XMLHttpRequest();
                        } else {	// code for IE6, IE5
                                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                        }

                        xmlhttp.onreadystatechange = function() {
                                if(xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                                        //alert(xmlhttp.responseText);
                                }
                        }

                        xmlhttp.open("GET","addTaskComment?iduser="+iduser+"&idtugas="+idtugas+"&isikomentar="+isicomment,false);
                        xmlhttp.send();
                }
                initComment();
            }
			
            function initComment() {
//                alert("coment" + document.getElementById("thecreator"));
                var comments = getTaskComments("<?echo $_GET['idtask'];?>");
                if(comments != undefined) {
                    var thesplitcomments = comments.split(";");
                    var isi = "",datetime="",username="",userid="",avatar="",datetimesplit="",datesplit="",YY="",MM="",DD="",timesplit="",hh="",mm="",datetimestamp="",isicomment="";
                    var splitcomments = "";
                    var groupcomment = document.getElementById("commentgroup");
                    var tempinner = "";
                    for(var i=(thesplitcomments.length-1);i>=0;i--) {
                        splitcomments = thesplitcomments[i].split("*");
                        isi = splitcomments[0];
                        datetime = splitcomments[1];
                        username = splitcomments[2];
                        userid = splitcomments[3];
                        idcomment = splitcomments[4];
                        avatar = splitcomments[5];
                        datetimesplit = datetime.split(" ");
                        datesplit = datetimesplit[0].split("-");
                        YY = datesplit[0];
                        MM = datesplit[1];
                        DD = datesplit[2];
                        timesplit = datetimesplit[1].split(":");
                        hh = timesplit[0];
                        mm = timesplit[1];
                        datetimestamp = hh + ":" + mm + " - " + DD + "/" + MM + "/" + YY;
                        isicomment = username + "\t" + datetimestamp + "\n\n" + isi;
                        //alert(isicomment);
                        if(avatar.length > 0) {
                                tempinner = tempinner + "<div class=commentwrap><img width='70px' height='70px' src=" + avatar + " ></img>";
                        } else {
                                tempinner = tempinner + "<div class=commentwrap><img width='70px' height='70px' src='assets/no_avatar.png'></img>";
                        }
                        tempinner = tempinner + "<textarea id=" + i + " class='textareas' cols='50px' rows='6px' disabled>" + isicomment + "</textarea>";
                        tempinner = tempinner + "<input style='visibility:hidden;' type='button' width='1px' id=" + (200+i) + " class='deletevalue' value=" + idcomment + " />";
                        if(userid == "2") {
                                tempinner = tempinner + "<input id=" + (100+i) + " class='deletecomment' type='button' value='Delete' onclick='deleteComment(this.id),initComment()'/>";
                        }
                        tempinner = tempinner + "</div>";
                    }
                    tempinner = tempinner + "<br><input id='prev' type='button' value='<' onclick='prevComment()'/><input id='next' type='button' value='>' onclick='nextComment()'/><br><input id='commentfield' name='commentfield' type='text'/> <input id='commentbutton' name='commentbutton' type='submit' value='Comment' onclick='submitComment()'/>";
                    groupcomment.innerHTML = tempinner;
                } else {
//                    alert("a");
                    var groupcomment = document.getElementById("commentgroup");
                    var tempinner = "<br><input id='commentfield' name='commentfield' type='text'/> <input id='commentbutton' name='commentbutton' type='submit' value='Comment' onclick='submitComment()'/>";
                    groupcomment.innerHTML = tempinner;
                }
            }
			
            function deleteComment(id) {
                var xmlhttp;
                //alert(document.getElementById((100+parseInt(id))).value);
                if(window.XMLHttpRequest) {	// code for IE7+, Firefox, Chrome, Opera, Safari
                        xmlhttp = new XMLHttpRequest();
                } else {	// code for IE6, IE5
                        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                }
//                alert(id);
                xmlhttp.onreadystatechange = function() {
                        if(xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                                //alert(xmlhttp.responseText);
                                initComment();
                                document.getElementById("state").value = "1";
                        }
                }

                xmlhttp.open("GET","delTaskComment?idcomment="+(document.getElementById((100+parseInt(id))).value),false);
                xmlhttp.send();
            }
			
            function prevComment() {
                var obj1 = document.getElementById("state");
                var thistate = parseInt(obj1.value);
                if(thistate > 1) {
                        obj1.value = thistate - 1;
                        initComment();
                }
            }
			
            function nextComment() {
                var obj1 = document.getElementById("state");
                var thistate = parseInt(obj1.value);
                obj1.value = thistate + 1;
                var comments = getTaskComments("<?echo $_GET['idtask'];?>");
                if(comments != undefined) {
                        initComment();
                } else {
                        obj1.value = thistate;
                }
            }
			
            function getTaskName(idtugas) {
                var xmlhttp;
                if(window.XMLHttpRequest) {	// code for IE7+, Firefox, Chrome, Opera, Safari
                    xmlhttp = new XMLHttpRequest();
                } else {	// code for IE6, IE5
                    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                }

                var temp = "";

                xmlhttp.onreadystatechange = function() {
                    if(xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                        temp = xmlhttp.responseText;
                    }
                }

                xmlhttp.open("GET","getTaskName?id="+idtugas,false);
                xmlhttp.send();

                if(temp.length>0) return temp;
            }
			
            function getTaskStatus(idtugas) {
                var xmlhttp;
                if(window.XMLHttpRequest) {	// code for IE7+, Firefox, Chrome, Opera, Safari
                        xmlhttp = new XMLHttpRequest();
                } else {	// code for IE6, IE5
                        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                }

                var temp;

                xmlhttp.onreadystatechange = function() {
                        if(xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                                temp = xmlhttp.responseText;
                        }
                }

                xmlhttp.open("GET","getTaskStatus?id="+idtugas,false);
                xmlhttp.send();

                if(temp.length>0) return temp;
            }
			
            function getTaskDeadline(idtugas) {
                var xmlhttp;
                if(window.XMLHttpRequest) {	// code for IE7+, Firefox, Chrome, Opera, Safari
                        xmlhttp = new XMLHttpRequest();
                } else {	// code for IE6, IE5
                        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                }

                var temp = "";

                xmlhttp.onreadystatechange = function() {
                        if(xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                                temp = xmlhttp.responseText;
                        }
                }

                xmlhttp.open("GET","getTaskDeadline?id="+idtugas,false);
                xmlhttp.send();

                if(temp.length>0) return temp;
            }
			
            function getTaskAssignees(idtugas) {
                var xmlhttp;
                if(window.XMLHttpRequest) {	// code for IE7+, Firefox, Chrome, Opera, Safari
                        xmlhttp = new XMLHttpRequest();
                } else {	// code for IE6, IE5
                        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                }

                var temp = "";

                xmlhttp.onreadystatechange = function() {
                        if(xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                                temp = xmlhttp.responseText;
                        }
                }

                xmlhttp.open("GET","getTaskAssignees?id="+idtugas,false);
                xmlhttp.send();

                if(temp.length>0) return temp;
            }
            
            function getTaskCreator(idtugas) {
                var xmlhttp;
                if(window.XMLHttpRequest) {	// code for IE7+, Firefox, Chrome, Opera, Safari
                        xmlhttp = new XMLHttpRequest();
                } else {	// code for IE6, IE5
                        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                }

                var temp = "";

                xmlhttp.onreadystatechange = function() {
                        if(xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                                temp = xmlhttp.responseText;
                        }
                }

                xmlhttp.open("GET","getTaskCreator?id="+idtugas,false);
                xmlhttp.send();

                if(temp.length>0) return temp;
            }
            
            function getTaskTags(idtugas) {
                var xmlhttp;
                if(window.XMLHttpRequest) {	// code for IE7+, Firefox, Chrome, Opera, Safari
                        xmlhttp = new XMLHttpRequest();
                } else {	// code for IE6, IE5
                        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                }

                var temp = "";

                xmlhttp.onreadystatechange = function() {
                        if(xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                                temp = xmlhttp.responseText;
                        }
                }

                xmlhttp.open("GET","getTaskTags?id="+idtugas,false);
                xmlhttp.send();

                if(temp.length>0) return temp;
            }
			
            function getTaskComments(idtugas) {
                var xmlhttp;
                if(window.XMLHttpRequest) {	// code for IE7+, Firefox, Chrome, Opera, Safari
                        xmlhttp = new XMLHttpRequest();
                } else {	// code for IE6, IE5
                        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                }

                var temp = "";
                var state = document.getElementById("state").value; 

                xmlhttp.onreadystatechange = function() {
                        if(xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                                temp = xmlhttp.responseText;
                        }
                }

                xmlhttp.open("GET","getTaskComments?id="+idtugas+"&state="+state,false);
                xmlhttp.send();

                if(temp.length>0) return temp;
            }
			
            function getTaskAttachments(idtugas) {
                var xmlhttp;
                if(window.XMLHttpRequest) {	// code for IE7+, Firefox, Chrome, Opera, Safari
                        xmlhttp = new XMLHttpRequest();
                } else {	// code for IE6, IE5
                        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                }

                var temp = "";

                xmlhttp.onreadystatechange = function() {
                        if(xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                                temp = xmlhttp.responseText;
                        }
                }

                xmlhttp.open("GET","getTaskAttachments?id="+idtugas,false);
                xmlhttp.send();

                if(temp.length>0) return temp;
            }
			
            function generateDate(day,month,year)
            {
                var browser = document.createElement("input");
                browser.setAttribute("type", "date");
                var a = document.getElementById("customdate");
//                a.style.display = "block";
                var b = document.getElementById("tanggallist");
                
                for (var i = 1; i <= 31; i++)
                {
                        var option = document.createElement("option");
                        option.text = "" + i;
                        option.value = i;
                        b.appendChild(option);
                }
                b.value = day;
                
                var c = document.getElementById("bulanlist");
                for (var i = 1; i <= 12; i++)
                {
                        var option = document.createElement("option");
                        option.text = "" + i;
                        option.value = i;
                        c.appendChild(option);
                }
//                alert(month);
                c.value = month;
                
                var d = document.getElementById("tahunlist");
                for (var i = 1955; i <= 2013; i++)
                {
                        var option = document.createElement("option");
                        option.text = "" + i;
                        option.value = i;
                        d.appendChild(option);
                }
                d.value = year;
            }
        </script>
    </body>
</html>
