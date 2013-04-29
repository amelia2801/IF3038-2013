// JavaScript Document
var ajaxRequest;

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

			function login() {
				getAjax();
				
				if(document.getElementById("login1")!="" && document.getElementById("login2")!=""){
					ajaxRequest.open("GET","checkidexistence?id="+document.getElementById("login1").value+"&pass="+document.getElementById("login2").value,false);//+"&pass="+document.getElementById("input2").value
					ajaxRequest.onreadystatechange = function()
					{
						var loginresponse = ajaxRequest.responseText;
                                                
						if(loginresponse == "true"){
							self.location="dashboard.jsp";
						}else{
                                                    alert("Username or password is wrong");
						}
						
					}
					ajaxRequest.send();
				}
			//if (document.getElementById("login1").value == 'meckyr' && document.getElementById("login2").value == 'meckyr') {
			//	self.location="page/dashboard.php";
			//}
			}
			var chkusername = false;
			var chkpassword = false;
			var cnfrmpassword = false;
			var chkfullname = false;
			var chkemail = false;
			var chkavatar = false;
			function hide_submit_button() {
				document.getElementById("submit").style.display = 'none';
			}
			function show_submit_button() {
				if(chkusername == true && chkpassword == true && cnfrmpassword == true && chkfullname == true && chkemail == true && chkavatar == true) {
					document.getElementById("submit").style.display = 'block';
				}
			}
			
			function check_username() {
				getAjax();
				
				if (document.getElementById("username").value.length > 4 && document.getElementById("username").value != document.getElementById("password").value) {
					var result;
					
					ajaxRequest.open("GET","checkavailid?idinput="+document.getElementById("username").value,false);
					ajaxRequest.onreadystatechange = function()
					{
						document.getElementById("warning-message").innerHTML = ajaxRequest.responseText;
						if(document.getElementById("warning-message").innerHTML == ""){
							chkusername = true;	
							show_submit_button();
						}
					}
					ajaxRequest.send();
				} else {
					chkusername = false;
					hide_submit_button();
					document.getElementById("warning-message").innerHTML="Username must be more than 4 characters";
				}
			}
			
			function check_password() {
				if (document.getElementById("password").value.length > 7 && document.getElementById("password").value != document.getElementById("username").value && document.getElementById("password").value != document.getElementById("email").value) {
					chkpassword = true;
					show_submit_button();
					document.getElementById("warning-message").innerHTML="";
				} else {
					chkpassword = false;
					hide_submit_button();
					document.getElementById("warning-message").innerHTML="Password must be more than 7 characters";
				}
			}
			function confirm_password() {
				if (document.getElementById("password").value == document.getElementById("password2").value) {
					cnfrmpassword = true;
					show_submit_button();
					document.getElementById("warning-message").innerHTML="";
				} else {
					cnfrmpassword = false;
					hide_submit_button();
					document.getElementById("warning-message").innerHTML="Passwords are not match";
				}
			}
			function check_full_name() {
				var str = document.getElementById("fullname").value;
				var idx = str.indexOf(' ');
				if (idx > 0 && idx < str.length - 1) {
					var chr1 = str.charAt(idx - 1);
					var chr2 = str.charAt(idx + 1);
					if (chr1 != ' ' && chr2 != ' ') {
						chkfullname = true;
						show_submit_button();
						document.getElementById("warning-message").innerHTML="";
					} else {
						chkfullname = false;
						hide_submit_button();
						document.getElementById("warning-message").innerHTML="Name is not valid";
					}
				} else {
					chkfullname = false;
					hide_submit_button();
					document.getElementById("warning-message").innerHTML="Name is not valid";
				}
			}
			
			function check_email() {
				getAjax();
			
				var str = document.getElementById("email").value;
				var at = str.indexOf('@');
				var dot = str.lastIndexOf('.');
				if (at > 0 && (dot - at) > 1 && dot < str.length - 2) {
					var result;
					
					ajaxRequest.open("GET","checkavailemail?emailinput="+document.getElementById("email").value,false);
					ajaxRequest.onreadystatechange = function()
					{
						document.getElementById("warning-message").innerHTML = ajaxRequest.responseText;
						if(document.getElementById("warning-message").innerHTML == ""){
							chkemail = true;
							show_submit_button();
						}
					}
					ajaxRequest.send();
				} else {
					chkemail = false;
					hide_submit_button();
					document.getElementById("warning-message").innerHTML="Email is not valid";
				}
			}
			
			function check_avatar() {
				var str = document.getElementById("avatar").value;
				var ext = str.substring(str.lastIndexOf('.') + 1, str.length);
				if (ext.toLowerCase() == "jpeg" || ext.toLowerCase() == "jpg" || ext.toLowerCase() == "png") {
					chkavatar = true;
					show_submit_button();
					document.getElementById("warning-message").innerHTML="";
				} else {
					chkavatar = false;
					hide_submit_button();
					document.getElementById("warning-message").innerHTML="File is not an image";
				}
			}
			function show_register_form() {
				document.getElementById("login-form").style.display = "none";
				document.getElementById("login-bottom").style.display = "none";
				document.getElementById("register-form").style.display = "block";
				document.getElementById("register-bottom").style.display = "block";
			}
			function show_login_form() {
				document.getElementById("register-form").style.display = "none";
				document.getElementById("register-bottom").style.display = "none";
				document.getElementById("login-form").style.display = "block";
				document.getElementById("login-bottom").style.display = "block";
			}
			
			//---buatan martin---
			function checkAutenthication(){
				
			}