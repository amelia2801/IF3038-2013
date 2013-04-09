function checkUsername(){
	var obj=document.getElementById("user");
	var pass=document.getElementById("pass");
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
		isFilled();	
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
				isFilled();		
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
if ((namauser==null || namauser=="") ||(password==null || password=="") || (confpassword==null || confpassword=="") ||(namalengkap==null || namalengkap=="") || (email==null || email==""))
  {
 		
  }
  else
  {
		  button.removeAttribute("disabled");
	}
}

function generateDate()
{
	var b = document.getElementById("tanggallist");
	for (var i = 1; i <= 31; i++)
	{
		var option = document.createElement("option");
		option.text = "" + i;
		option.value = "date" + i;
		b.appendChild(option);
	}
	
	var c = document.getElementById("bulanlist");
	for (var i = 1; i <= 12; i++)
	{
		var option = document.createElement("option");
		option.text = "" + i;
		option.value = "month" + i;
		c.appendChild(option);
	}
	
	var d = document.getElementById("tahunlist");
	for (var i = 1955; i <= 2013; i++)
	{
		var option = document.createElement("option");
		option.text = "" + i;
		option.value = "month" + i;
		d.appendChild(option);
	}
}

function submit()
{
}