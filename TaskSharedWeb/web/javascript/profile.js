var ajaxRequest;
var chkpassword = false;

function check_password(userid) {
	if (document.getElementById("newpasstext").value.length > 7) {
		if (document.getElementById("newpasstext").value != userid) {
			chkpassword = true;
			document.getElementById("warning-message").innerHTML="";
		}
		else {
			chkpassword = false;
			document.getElementById("warning-message").innerHTML="Password same as username !";
		}
	} else {
		chkpassword = false;
		document.getElementById("warning-message").innerHTML="Password less than 8 characters !";
	}
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

function edit_aboutme(userid){
	document.getElementById("aboutme_edit").style.display = 'block';
	var val = document.getElementById("aboutme_show").innerHTML;
	document.getElementById("aboutme_to_edit").value = val;
	document.getElementById("aboutme_show").style.display = 'none';
	document.getElementById("right-main-body").innerHTML = "<div id=\"right-main-body\"><a href=\"#\" onClick=\"just_edit_aboutme('"+userid+"')\"><u><p>done</p></u></a></div>";
}
function just_edit_aboutme(userid){
	getAjax();
	var aboutme = document.getElementById("aboutme_to_edit").value;
	
	ajaxRequest.open("GET","updateAboutMe?aboutme="+aboutme+"&userid="+userid,false);
	
	ajaxRequest.onreadystatechange = function()
	{
		document.getElementById("aboutme_show").innerHTML =  ajaxRequest.responseText;
	}
	
	ajaxRequest.send();

	document.getElementById("aboutme_edit").style.display = 'none';
	document.getElementById("aboutme_show").style.display = 'block';
	document.getElementById("right-main-body").innerHTML = "<div id=\"right-main-body\"><a href=\"#\" onClick=\"edit_aboutme('"+userid+"')\"><u><p>edit</p></u></a></div>";
}

function edit_fullname(userid){
	document.getElementById("left-profile-newname").style.display = 'block';
	var val = document.getElementById("left-profile-name").innerHTML;
	var l = val.length;
	val = val.substring(15, l - 4);
	document.getElementById("newname").value = val;
	document.getElementById("left-profile-name").style.display = 'none';
	document.getElementById("right-profile-editname").innerHTML = "<a href=\"#\" onclick=\"just_edit_fullname('"+userid+"')\"><u><p>done</p></u></a>";
}
function just_edit_fullname(userid){
	getAjax();
	var name = document.getElementById("newname").value;
	
	ajaxRequest.open("GET","updateFullNameProf?name="+name+"&userid="+userid,false);
	
	ajaxRequest.onreadystatechange = function()
	{
		document.getElementById("left-profile-name").innerHTML = "<p>Full Name : " + ajaxRequest.responseText + "</p>";
	}
	
	ajaxRequest.send();

	document.getElementById("left-profile-newname").style.display = 'none';
	document.getElementById("left-profile-name").style.display = 'block';
	document.getElementById("right-profile-editname").innerHTML = "<a href=\"#\" onclick=\"edit_fullname('"+userid+"')\"><u><p>edit</p></u></a>";
}

function edit_birthday(userid){
	document.getElementById("left-profile-newbirthday").style.display = 'block';
	var val = document.getElementById("left-profile-birthday").innerHTML;
	var l = val.length;
	val = val.substring(16, l - 4);
	document.getElementById("newbirthday").value = val;
	document.getElementById("left-profile-birthday").style.display = 'none';
	document.getElementById("right-profile-editbirthday").innerHTML = "<a href=\"#\" onclick=\"just_edit_birthday('"+userid+"')\"><u><p>done</p></u></a>";
}
function just_edit_birthday(userid){
	getAjax();
	var birthday = document.getElementById("newbirthday").value;
	
	ajaxRequest.open("GET","updateBirthdayProf?birthday="+birthday+"&userid="+userid,false);
	
	ajaxRequest.onreadystatechange = function()
	{
		document.getElementById("left-profile-birthday").innerHTML = "<p>Birth Date : " + ajaxRequest.responseText + "</p>";
	}
	
	ajaxRequest.send();

	document.getElementById("left-profile-newbirthday").style.display = 'none';
	document.getElementById("left-profile-birthday").style.display = 'block'; 
	document.getElementById("right-profile-editbirthday").innerHTML = "<a href=\"#\" onclick=\"edit_birthday('"+userid+"')\"><u><p>edit</p></u></a>";
}


function edit_email(userid){
	document.getElementById("left-profile-newemail").style.display = 'block';
	var val = document.getElementById("left-profile-email").innerHTML;
	var l = val.length;
	val = val.substring(14, l - 8);
	document.getElementById("newemail").value = val;
	document.getElementById("left-profile-email").style.display = 'none';
	document.getElementById("right-profile-editemail").innerHTML = "<a href=\"#\" onclick=\"just_edit_email('"+userid+"')\"><u><p>done</p></u></a>";
}
function just_edit_email(userid){
	getAjax();
	var email = document.getElementById("newemail").value;
	
	ajaxRequest.open("GET","updateEmailProf?email="+email+"&userid="+userid,false);
	
	ajaxRequest.onreadystatechange = function()
	{
		document.getElementById("left-profile-email").innerHTML = "<p>Email : " + ajaxRequest.responseText + "</p>";
	}
	
	ajaxRequest.send();

	document.getElementById("left-profile-newemail").style.display = 'none';
	document.getElementById("left-profile-email").style.display = 'block';
	document.getElementById("right-profile-editemail").innerHTML = "<a href=\"#\" onclick=\"edit_email('"+userid+"')\"><u><p>edit</p></u></a>";
}

function edit_password(userid) {
	document.getElementById("password_form").style.display = 'block';
	document.getElementById("change_password").innerHTML = "<a href=\"#\" onClick=\"just_edit_password('"+userid+"')\">Save Password</a>";
}

function just_edit_password(userid) {
	if (chkpassword) {
		getAjax();
		var newpass = document.getElementById("newpasstext").value;

		ajaxRequest.open("GET","changepassword?newpass="+newpass+"&userid="+userid,false);
                
                ajaxRequest.onreadystatechange = function()
                {
                        alert("Succes Update");
                }

                ajaxRequest.send();
                
		document.getElementById("password_form").style.display = 'none';
		document.getElementById("change_password").style.display = 'block';
		document.getElementById("change_password").innerHTML = "<a href=\"#\" onClick=\"edit_password('"+userid+"')\">Change Password</a>";
	}
}

function edit_avatar(userid){
	document.getElementById("uploader").style.display = 'block';
	document.getElementById("upload_button").innerHTML = "<a href=\"#\" onClick=\"just_edit_avatar('"+userid+"')\">Save Avatar</a>";
}

function just_edit_avatar(userid){
	getAjax();

	var newava = document.getElementById("inputfileid").value;

	ajaxRequest.open("GET","../php/getavatar.php?newava="+newava+"&userid="+userid,false);
	//ajaxRequest.onreadystatechange = function()
	//{
	//	alert(ajaxRequest.responseText);
	//}
	alert(newava);
	
	ajaxRequest.send();	

	document.getElementById("uploader").style.display = 'none';
	document.getElementById("upload_button").style.display = 'block';
	document.getElementById("upload_button").innerHTML = "<a href=\"#\" onClick=\"edit_avatar('"+userid+"')\">Upload New Avatar</a>";
}

function hidden_update_box(){
	document.getElementById("aboutme_edit").style.display = 'none';
	document.getElementById("left-profile-newemail").style.display = 'none';
	document.getElementById("left-profile-newname").style.display = 'none';
	document.getElementById("left-profile-newbirthday").style.display = 'none';
	document.getElementById("uploader").style.display = 'none';
	document.getElementById("password_form").style.display = 'none';
}

