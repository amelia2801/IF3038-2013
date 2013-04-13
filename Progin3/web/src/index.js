function checkUsername(){
	var obj=document.getElementById("user");
	var pass=document.getElementById("pass");
	var email=document.getElementById("email");

	if (obj.value.length<5) 
	{
		alert("username minimal 5 karakter");
		user.value="";
		obj.focus();
	}
	else if(obj.value==pass.value)
	{
		alert("password sama dengan username");
		pass.value="";
		pass.focus();
	}
	else
	{
		var xmlhttp;
		if (window.XMLHttpRequest)
		{// code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttp=new XMLHttpRequest();
		}
		else
		{// code for IE6, IE5
			xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp.onreadystatechange=function()
		{
			if (xmlhttp.readyState==4 && xmlhttp.status==200)
			{
				if (xmlhttp.responseText.search("true") != -1)
				{
					isFilled();
				}else{
					alert("Username telah dipakai");
					user.value="";
				}
			}
		}
		xmlhttp.open("GET","src/validReg.jsp?user="+obj.value+"&email="+email,true);
		xmlhttp.send();
	}
}

function checkPassword(){
	var obj=document.getElementById("user");
	var pass=document.getElementById("pass");
	if(pass.value.length<8)
	{
		alert("password minimal 8 karakter");	
		pass.value="";
		pass.focus();
	}
	else if(obj.value==pass.value)
	{
		alert("password sama dengan username");
		pass.value="";
		pass.focus();
	}
	else
	{
		isFilled();	
	}
}

function checkConfirmedPass(){
	var pass=document.getElementById("pass");
	var passconfirmed=document.getElementById("passconfirmed");
	if(pass.value!=passconfirmed.value)
	{
		alert("confirmed password harus sama dengan password");
		passconfirmed.value="";
		passconfirmed.focus();
	}
	else
	{
		isFilled();
	}
}

function checkNamaLengkap(){
	var nama=document.getElementById("namalengkap");
	var spasi=/ /;
	if (spasi.test(namalengkap.value)) {
		var a1 = new Array();
		a1=namalengkap.value.split(' ');
		if(a1.length<2)
		{
			alert("Nama lengkap minimal terdiri dari dua kata");
			nama.value="";
			nama.focus();
		}
		else
		{
			isFilled();		
		}
	}
	else
	{
		alert("Nama lengkap minimal terdiri dari dua kata");
		nama.value="";
		nama.focus();
	}
}

function checkEmail(){
	var email=document.getElementById("email");
	var reg=/\S+@\S+\.\S+/;
	//cek terdapat @ ato ga
	if (reg.test(email.value)) 
	{
		var a0 = new Array();
		a0=email.value.split('@');
		var a1=new Array();
		a1=a0[1].split('.');
		if(a1[1].length<2)
		{
			alert("format email salah");
			email.value="";
			email.focus();
		}
		else
		{
			var xmlhttp;
			if (window.XMLHttpRequest)
			{// code for IE7+, Firefox, Chrome, Opera, Safari
				xmlhttp=new XMLHttpRequest();
			}
			else
			{// code for IE6, IE5
				xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
			}
			xmlhttp.onreadystatechange=function()
			{
				if (xmlhttp.readyState==4 && xmlhttp.status==200)
				{
					if (xmlhttp.responseText.search("true") != -1)
					{
						isFilled();
					}else{
						alert("Email telah dipakai");
						email.value="";
					}
				}
			}
			xmlhttp.open("GET","src/validReg.jsp?user=''&email="+email.value,true);
			xmlhttp.send();
		}
	}
	else
	{
		alert("format email salah");
		email.value="";
		email.focus();
	}
}

function isFilled(){
	
	var button=document.getElementById("registerbutton");
	var namauser=document.forms["registerform"]["user"].value;
	var password=document.forms["registerform"]["pass"].value;
	var confpassword=document.forms["registerform"]["passconfirmed"].value;
	var namalengkap=document.forms["registerform"]["namalengkap"].value;
	var email=document.forms["registerform"]["email"].value;
	var avatar=document.forms["registerform"]["avatar"].value;
	
if ((namauser==null || namauser=="")|| (avatar==null || avatar=="") ||(password==null || password=="") || (confpassword==null || confpassword=="") ||(namalengkap==null || namalengkap=="") || (email==null || email==""))
  {
 	document.getElementById("registerbutton").disabled = true;
  }
  else
	{
		document.getElementById("registerbutton").disabled = false;
	}
}

function generateDate()
{
	// var obj=document.getElementById("user");
	// var email=document.getElementById("email");
	// var nama=document.getElementById("namalengkap");
	
	// obj.value = "";
	// email.value = "";
	
	var b = document.getElementById("tanggallist");
	for (var i = 1; i <= 31; i++)
	{
		var option = document.createElement("option");
		option.text = "" + i;
		option.value = ""+i;
		b.appendChild(option);
	}
	
	var c = document.getElementById("bulanlist");
	for (var i = 1; i <= 12; i++)
	{
		var option = document.createElement("option");
		option.text = "" + i;
		option.value = ""+ i;
		c.appendChild(option);
	}
	
	var d = document.getElementById("tahunlist");
	for (var i = 1955; i <= 2013; i++)
	{
		var option = document.createElement("option");
		option.text = "" + i;
		option.value = ""+ i;
		d.appendChild(option);
	}
}

function checkAvatar(){
	var extensions = new Array("jpg","jpeg");
	var image_file=document.getElementById("avatar").value;
	var image_length=document.getElementById("avatar").value.length;
	var pos = image_file.lastIndexOf('.') + 1;
	var ext = image_file.substring(pos, image_length);
	var final_ext = ext.toLowerCase();
	var flag = 0;
	
	for (i = 0; i < extensions.length && flag==0; i++)
	{
		if(extensions[i] == final_ext)
		{
			flag = 1;
		}
	}
	
	if (flag!=1){
		alert("File tidak berekstensi jpg, jpeg, atau png");
		// get the file upload element
		fileField     = document.getElementById("avatar");
		// get the file upload parent element
		parentNod     = fileField.parentNode;
		// create new element
		tmpForm        = document.createElement("form");
		parentNod.replaceChild(tmpForm,fileField);
		tmpForm.appendChild(fileField);
		tmpForm.reset();
		parentNod.replaceChild(fileField,tmpForm);
	}
	
	isFilled();
}

function isAlreadyLogin(){
	if(typeof(Storage)!=="undefined")
	  {
		var xmlhttp;
		if (window.XMLHttpRequest)
		{// code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttp=new XMLHttpRequest();
		}
		else
		{// code for IE6, IE5
			xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		}

		if (localStorage.getItem('userlogin')){
			//alert("Sudah Login");			
			
			xmlhttp.onreadystatechange=function()
			{
				if (xmlhttp.readyState==4 && xmlhttp.status==200)
				{
					if (xmlhttp.responseText == "true")
					{
						window.location =("src/home.jsp");
					}else{
						alert("Error detected !!");
					}
				}
			}
			
			xmlhttp.open("GET","src/getLocal.jsp?local="+localStorage.getItem('userlogin'),true);
			xmlhttp.send();
		}else{
			generateDate();
			//alert("Belum Login");
		}
		
	  }
	else
	  {
		alert("Sorry, your browser does not support web storage...");
	  }
}

function editProfile(){
	var pass=document.getElementById("pass");
	var nama=document.getElementById("namalengkap");
	var b = document.getElementById("tanggallist");
	var c = document.getElementById("bulanlist");
	var d = document.getElementById("tahunlist");
	var avatar=document.getElementById("avatar");
	var tanggal = d.value+"-"+c.value+"-"+b.value;
	
	var xmlhttp;
	if (window.XMLHttpRequest)
	{// code for IE7+, Firefox, Chrome, Opera, Safari
		xmlhttp=new XMLHttpRequest();
	}
	else
	{// code for IE6, IE5
		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.onreadystatechange=function()
	{
		if (xmlhttp.readyState==4 && xmlhttp.status==200)
		{
			if (xmlhttp.responseText.search("false") == 1)
			{
				alert("Update Failure");
			}else{
				alert(xmlhttp.responseText);
			}
		}
	}
	xmlhttp.open("POST","editprofile.jsp",true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send("nama="+nama.value+"&pass="+pass.value+"&tanggal="+tanggal+"&avatar="+avatar.value);

}

