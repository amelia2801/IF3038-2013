//Dashboard javascript
var ajaxRequest;
var iskonkat = false;
var konkat = "";

function confirmCategory()
{
	var x=window.confirm("Are you sure you want to delete this category ?\n(All the tasks in this category will also be deleted)")
	if (x)
		window.alert("Category is succesfully deleted")
}

function confirmTask()
{
	var x=window.confirm("Are you sure you want to delete this task ?")
	if (x)
		window.alert("Task is succesfully deleted")
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

function autoCompleteAsignee(){
	getAjax();

	var asignee = document.getElementById("asignee").value;
        var asigneeindex;
        var asigneearray;
	var suggestion = "";
	var suggestionarray;
	
	var index = asignee.length;
	
	if(asignee !== "")
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
                x="<datalist id=\"assignee\">";
                for (var i = 0; i < suggestionarray.length; i++) {
                        x += "<option value=\""+konkat+suggestionarray[i]+"\">";
                }
                x += "</datalist>";
                document.getElementById("assignee-suggest").innerHTML=x;
            };
            ajaxRequest.send();
	}
	else
	{
            konkat = "";
	}
	
	//ajaxRequest.open("GET","php/checkavailid.php?idinput="+document.getElementById("username").value,false);
	
}

function setCompleteStatus(idx,taskid){
	getAjax();
	var status = document.getElementById("red-text"+idx).innerHTML;
	//alert("aaaaaaaaa "+document.getElementById("red-text"+idx).innerHTML);
	if(status!=""){
		ajaxRequest.open("GET","updatecompletestatus?status="+status+"&taskid="+taskid,false);
	
		ajaxRequest.onreadystatechange = function()
		{
			document.getElementById("red-text"+idx).innerHTML =  ajaxRequest.responseText;
		}
		
		ajaxRequest.send();
	}
}
