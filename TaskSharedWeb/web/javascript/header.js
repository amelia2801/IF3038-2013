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

function checkHeaderValidation(){
	getAjax();
	var content = document.getElementById("search_text").value;
	var elmt = document.getElementById("modesearch").value;
	var filter = document.getElementById("filtering").value;
	var suggestion;
	var suggestionarray;
	
	if(content!=""){
		ajaxRequest.open("GET","headervalidation?content="+content+"&idx="+elmt+"&filter="+filter,false);
		ajaxRequest.onreadystatechange = function()
		{
			suggestion = ajaxRequest.responseText;
			suggestion = suggestion.substr(0,suggestion.length-1);
			suggestionarray = suggestion.split("|");
			
			var x;
			x="<datalist id=\"searching-auto\">";
			for (var i = 0; i < suggestionarray.length; i++) {
				x += "<option value=\""+suggestionarray[i]+"\">";
			}
			x += "</datalist>";
			document.getElementById("list-search").innerHTML=x;
		}
		
		ajaxRequest.send();
	}
}

function filter() {
	var x = document.getElementById("modesearch").value;
	if (x == 2) {
		document.getElementById("user-filtering").style.display = 'block';
		document.getElementById("searching-header").style.paddingLeft = '0px';
	}
	else {
		document.getElementById("user-filtering").style.display = 'none';
		document.getElementById("searching-header").style.paddingLeft = '100px';
	}
}

function initialize() {
	document.getElementById("user-filtering").style.display = 'none';
	document.getElementById("searching-header").style.paddingLeft = '100px';
}
