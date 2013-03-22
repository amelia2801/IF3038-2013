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
	}
	else
	{
		alert("Nama lengkap minimal terdiri dari dua kata");
		nama.value="";
		nama.focus();
	}
}


function generateDate()
{	
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
}

// function editProfile(){
	// var pass=document.getElementById("pass");
	// var nama=document.getElementById("namalengkap");
	// var b = document.getElementById("tanggallist");
	// var c = document.getElementById("bulanlist");
	// var d = document.getElementById("tahunlist");
	// var avatar=document.getElementById("avatar");
	// var tanggal = d.value+"-"+c.value+"-"+b.value;
	
	// var xmlhttp;
	// if (window.XMLHttpRequest)
	// {// code for IE7+, Firefox, Chrome, Opera, Safari
		// xmlhttp=new XMLHttpRequest();
	// }
	// else
	// {// code for IE6, IE5
		// xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	// }
	// xmlhttp.onreadystatechange=function()
	// {
		// if (xmlhttp.readyState==4 && xmlhttp.status==200)
		// {
			// if (xmlhttp.responseText.search("false") == 1)
			// {
				// alert("Update Failure");
			// }else{
				// alert(xmlhttp.responseText);
			// }
		// }
	// }
	// xmlhttp.open("POST","editprofile.php",true);
	// xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	// xmlhttp.send("nama="+nama.value+"&pass="+pass.value+"&tanggal="+tanggal+"&avatar="+avatar.value);

// }

