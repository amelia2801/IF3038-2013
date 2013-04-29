//add_task javascript
var chktaskname = false;
var chkattach1 = true;
var chkattach2 = true;
var chkattach3 = true;
var chkattach4 = true;
var chkattach5 = true;
var chkassignee = false;
var chktag = false
var chktime = false;

var iskonkat = false;
var konkat = "";

function hide_create_button() {
	document.getElementById("create").style.display = 'none';
}

function show_create_button() {
	if (chktime == true && chktaskname == true && chkattach1 == true && chkattach2 == true && chkattach3 == true && chkattach4 == true && chkattach5 == true && chkassignee == true && chktag == true) {
		document.getElementById("create").style.display = 'block';
	}
}

function check_string() {
	var i;
	var str = document.getElementById("taskname").value;
	for (i = 0; i < str.length; i++) {
		if ((str.charAt(i) != ' ' && str.charCodeAt(i) < 48) || (str.charCodeAt(i) > 57 && str.charCodeAt(i) < 65) || (str.charCodeAt(i) > 90 && str.charCodeAt(i) < 97) || str.charCodeAt(i) > 122) {
			return false;
		}
	}
	return true;
}

function check_task_name() {
	if (document.getElementById("taskname").value.length > 0 && document.getElementById("taskname").value.length < 26) {
		chktaskname = check_string();
		if (chktaskname == true) {
			show_create_button();
			document.getElementById("warning-message").innerHTML="";			
		} else {
			hide_create_button();
			document.getElementById("warning-message").innerHTML="Task name contains special characters";
		}
	} else {
		chktaskname = false;
		hide_create_button();
		document.getElementById("warning-message").innerHTML="Task name is not valid";
	}
}

function check_attachment1() {
	var str = document.getElementById("attached1").value;
	var ext = str.substring(str.lastIndexOf('.') + 1, str.length).toLowerCase();
	if (ext == "pdf" || ext == "doc" || ext == "docx" || ext == "ppt" || ext == "pptx" || ext == "java" || ext == "jpg" || ext =="jpeg" || ext == "gif" || ext == "mp4" || ext == "txt" || str === "") {
		chkattach1 = true;
		show_create_button();
		document.getElementById("warning-message").innerHTML="";
	} else {
		chkattach1 = false;
		hide_create_button();
		document.getElementById("warning-message").innerHTML="Uploaded files no.1 is not supported";
	}
}

function check_attachment2() {
	var str = document.getElementById("attached2").value;
	var ext = str.substring(str.lastIndexOf('.') + 1, str.length).toLowerCase();
	if (ext == "pdf" || ext == "doc" || ext == "docx" || ext == "ppt" || ext == "pptx" || ext == "java" || ext == "jpg" || ext =="jpeg" || ext == "gif" || ext == "mp4" || ext == "txt") {
		chkattach2 = true;
		show_create_button();
		document.getElementById("warning-message").innerHTML="";
	} else {
		chkattach2 = false;
		hide_create_button();
		document.getElementById("warning-message").innerHTML="Uploaded files no.2 is not supported";
	}
}

function check_attachment3() {
	var str = document.getElementById("attached3").value;
	var ext = str.substring(str.lastIndexOf('.') + 1, str.length).toLowerCase();
	if (ext == "pdf" || ext == "doc" || ext == "docx" || ext == "ppt" || ext == "pptx" || ext == "java" || ext == "jpg" || ext =="jpeg" || ext == "gif" || ext == "mp4" || ext == "txt") {
		chkattach3 = true;
		show_create_button();
		document.getElementById("warning-message").innerHTML="";
	} else {
		chkattach3 = false;
		hide_create_button();
		document.getElementById("warning-message").innerHTML="Uploaded files no.3 is not supported";
	}
}

function check_attachment4() {
	var str = document.getElementById("attached4").value;
	var ext = str.substring(str.lastIndexOf('.') + 1, str.length).toLowerCase();
	if (ext == "pdf" || ext == "doc" || ext == "docx" || ext == "ppt" || ext == "pptx" || ext == "java" || ext == "jpg" || ext =="jpeg" || ext == "gif" || ext == "mp4" || ext == "txt") {
		chkattach4 = true;
		show_create_button();
		document.getElementById("warning-message").innerHTML="";
	} else {
		chkattach4 = false;
		hide_create_button();
		document.getElementById("warning-message").innerHTML="Uploaded files no.4 is not supported";
	}
}

function check_attachment5() {
	var str = document.getElementById("attached5").value;
	var ext = str.substring(str.lastIndexOf('.') + 1, str.length).toLowerCase();
	if (ext == "pdf" || ext == "doc" || ext == "docx" || ext == "ppt" || ext == "pptx" || ext == "java" || ext == "jpg" || ext =="jpeg" || ext == "gif" || ext == "mp4" || ext == "txt") {
		chkattach5 = true;
		show_create_button();
		document.getElementById("warning-message").innerHTML="";
	} else {
		chkattach5 = false;
		hide_create_button();
		document.getElementById("warning-message").innerHTML="Uploaded files no.5 is not supported";
	}
}

function check_assignee() {
	if (document.getElementById("task-assignee").value.length > 0) {
		chkassignee = true;
		show_create_button();
		document.getElementById("warning-message").innerHTML="";
	} else {
		chkassignee = false;
		hide_create_button();
		document.getElementById("warning-message").innerHTML="Some assignee are not recognized";
	}
}

function check_tag() {
	if (document.getElementById("tag").value.length > 0) {
		chktag = true;
		show_create_button();
		document.getElementById("warning-message").innerHTML="";
	} else {
		chktag = false;
		hide_create_button();
		document.getElementById("warning-message").innerHTML="Tag is not valid";
	}
}

function check_time() {
	if (document.getElementById("time").value.length == 5) {
		chktime = true;
		show_create_button();
		document.getElementById("warning-message").innerHTML="";
	} else {
		chktime = false;
		hide_create_button();
		document.getElementById("warning-message").innerHTML="Deadline time is not valid";
	}
}

function addAssignee() {
	check_assignee();
	autoCompleteAsignee();
}

function getAjax() //a function to get AJAX from browser
{
	try
	{
		ajaxRequest = new XMLHttpRequest();
	}
	catch (e)
	{
		try
		{
			ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
		}
		catch (e) 
		{
			try
			{
				ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
			}
			catch (e)
			{
				alert("Can't get AJAX, browser error");
				return false;
			}
		}
	}
}

function autoCompleteAsignee() {
	getAjax();

	var asignee = document.getElementById("task-assignee").value;
        var asigneeindex;
        var asigneearray;
	var suggestion = "";
	var suggestionarray;
	
	var index = asignee.length;
	
	if(asignee!=="")
	{
		if (asignee.indexOf(",") !== -1) {
                    if (asignee.charAt(index - 1) === ',')
                    {
                            konkat = asignee.substr(0,index);
                    }
                    asigneearray = asignee.split(",");
                    asigneeindex = asigneearray.length - 1;
                    ajaxRequest.open("GET","autocompleteasignee?asignee="+asigneearray[asigneeindex],false);
                }
                else {
                    ajaxRequest.open("GET","autocompleteasignee?asignee="+asignee,false);
                }
		ajaxRequest.onreadystatechange = function()
		{
			suggestion =  ajaxRequest.responseText;
			suggestion = suggestion.substr(0,suggestion.length-1);
			suggestionarray = suggestion.split("|");
			
			var x;
			x="<datalist id=\"assignee-task\">";
			for (var i = 0; i < suggestionarray.length; i++) {
				x += "<option value=\""+konkat+suggestionarray[i]+"\">";
			}
			x += "</datalist>";
			document.getElementById("shared-with").innerHTML=x;
		}
		
		ajaxRequest.send();
	}
	else
	{
		konkat = "";
	}
	
	//ajaxRequest.open("GET","php/checkavailid.php?idinput="+document.getElementById("username").value,false);
	
}