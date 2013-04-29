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

function setCompleteStatus(idx,taskid){
	getAjax();
	var status = document.getElementById("red-text"+idx).innerHTML;
	//alert("aaaaaaaaa "+document.getElementById("red-text"+idx).innerHTML);
	if(status!=""){
		ajaxRequest.open("GET","../php/updatecompletestatus.php?status="+status+"&taskid="+taskid,false);
	
		ajaxRequest.onreadystatechange = function()
		{
			document.getElementById("red-text"+idx).innerHTML =  ajaxRequest.responseText;
		}
		
		ajaxRequest.send();
	}
}
