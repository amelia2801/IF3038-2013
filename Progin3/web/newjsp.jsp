<%-- 
    Document   : newjsp
    Created on : Apr 12, 2013, 5:56:43 PM
    Author     : PATRICKLT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" style="text/css" href="style.css">
    </head>
    <body onload='init();'>
        <h1>Hello World!</h1>
        <form name="MakeForm" class="task" method="POST" action="UploadAttachments" enctype="multipart/form-data">
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
								<button class="task" name="submitbutton" type="submit"><b>Submit</b></button>
							</li>
						</ul>
					</form>
    </body>
    <script type='text/javascript'>
        var count = 0;
        function init() {
            var obj1 = document.getElementById("attachmentGroup");
            var temp1 = document.createElement("DIV");
            temp1.setAttribute("id","group");
            temp1.setAttribute("name","group");
            var temp = document.createElement("INPUT");
            temp.setAttribute("type","file");
            temp.setAttribute("id","filebutton"+count);
            temp.setAttribute("name","filebutton"+count);
            temp.setAttribute("onchange","attachmentCheck(this.id)");
            temp1.appendChild(temp);
            obj1.appendChild(temp1);
            count++;
        }
        function attachmentCheck(thisId)
        {
//                alert(thisId);
                var obj0 = document.getElementById("attachmentGroup");	// akses group attachment keseluruhan
                var obj1 = document.getElementById(thisId).parentNode;	// akses group field browse dan komentarnya
                var obj2 = document.getElementById(thisId);	// akses field browse saat ini
                var parse = obj2.value.split(".");
                var ext = parse[parse.length-1];
                if(ext === "jpg" || ext === "jpeg" || ext === "png" || ext === "gif"
                || ext === "avi" || ext === "mp4" || ext === "mkv" || ext === "3gp" || ext === "flv" || ext === "ogg" || ext === "wmv"
                || ext === "doc" || ext === "docx" || ext === "pdf" || ext === "txt") {	// ekstensi file sesuai
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
//                alert(document.getElementById("filebutton1"));
                count++;
//                alert(count);
        }
    </script>
</html>
