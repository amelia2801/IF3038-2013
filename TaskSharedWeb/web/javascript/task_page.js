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

function addComment(taskid,index){
	getAjax();
	var comment = document.getElementById("textarea-comment").value;
	if(comment!=""){
		ajaxRequest.open("GET","updatecomment?comment="+comment+"&taskid="+taskid+"&index="+index,false);
                
		ajaxRequest.onreadystatechange = function()
		{
                    document.getElementById("user-comment").innerHTML =  ajaxRequest.responseText;
		}
		
		ajaxRequest.send();
	}
}

function nextPage(taskid,index){
	getAjax();
        ajaxRequest.open("GET","nextcomment?taskid="+taskid+"&index="+index,false);

        ajaxRequest.onreadystatechange = function()
        {
            document.getElementById("user-comment").innerHTML =  ajaxRequest.responseText;
        }

        ajaxRequest.send();
}

function prevPage(taskid,index){
	getAjax();
        ajaxRequest.open("GET","prevcomment?taskid="+taskid+"&index="+index,false);

        ajaxRequest.onreadystatechange = function()
        {
            document.getElementById("user-comment").innerHTML =  ajaxRequest.responseText;
        }

        ajaxRequest.send();
	
}

function deleteComment(commentid,taskid,index){
	getAjax();
	ajaxRequest.open("GET","deleteComment?commentid="+commentid+"&taskid="+taskid+"&index="+index,false);
	ajaxRequest.onreadystatechange = function()
	{
		document.getElementById("user-comment").innerHTML =  ajaxRequest.responseText;
	};
	
	ajaxRequest.send();
}

function edit_deadline() {
	document.getElementById("deadline_edit").style.display = 'block';
	document.getElementById("deadline_done").style.display = 'none';
}
function finish_deadline(taskid) {
	getAjax();

	var deadlinetime = document.getElementById("datedeadlineinput").value + " " + document.getElementById("timedeadlineinput").value;
	ajaxRequest.open("GET","changedeadline?deadlinetime="+deadlinetime+"&taskid="+taskid,false);
	ajaxRequest.onreadystatechange = function()
	{
		document.getElementById("left-main-body").innerHTML =  ajaxRequest.responseText;
	}
	ajaxRequest.send();
	
	
	document.getElementById("deadline_edit").style.display = 'none';
	document.getElementById("deadline_done").style.display = 'block';
}
function edit_assignee() {
	document.getElementById("assignee_edit").style.display = 'block';
	document.getElementById("assignee_done").style.display = 'none';
}
function finish_assignee(taskid) {
	getAjax();
	var listAssigne = document.getElementById("task-assignee").value;
	if(listAssigne!=""){
		ajaxRequest.open("GET","updateSharedWithDB?listAssigne="+listAssigne+"&taskid="+taskid,false);
                
		ajaxRequest.onreadystatechange = function()
		{
			document.getElementById("left-main-body2").innerHTML = ajaxRequest.responseText;
		}
		ajaxRequest.send();
	}
	document.getElementById("assignee_edit").style.display = 'none';
	document.getElementById("assignee_done").style.display = 'block';
        checkIsMeAssignee(taskid);
}

function checkIsMeAssignee(taskid){
    getAjax();
    ajaxRequest.open("GET","deleteassignee?taskid="+taskid,false);
                
    ajaxRequest.onreadystatechange = function()
    {
        if(ajaxRequest.responseText == "false"){
            document.getElementById("editAssignee").style.display = 'none';
            document.getElementById("editDeadline").style.display = 'none';
            document.getElementById("editStatus").style.display = 'none';
            document.getElementById("editTag").style.display = 'none';
        }
    }
    ajaxRequest.send();
}
function edit_tag() {
	document.getElementById("tag_edit").style.display = 'block';
	document.getElementById("tag_done").style.display = 'none';
}
function finish_tag(taskid) {
	getAjax();
	var tag = document.getElementById("tag-edit").value;
	if(tag!=""){
		ajaxRequest.open("GET","updateTagDB?tag="+tag+"&taskid="+taskid,false);

		ajaxRequest.onreadystatechange = function()
		{
			document.getElementById("left-main-body3").innerHTML = ajaxRequest.responseText;
		}
		ajaxRequest.send();
	}
	document.getElementById("tag_edit").style.display = 'none';
	document.getElementById("tag_done").style.display = 'block';
}
function check_html5() {
	if (navigator.userAgent.indexOf('Chrome') != -1 || navigator.userAgent.indexOf('Opera') != -1){
		document.getElementById("date_html5").style.display = 'block';
		document.getElementById("date_html").style.display = 'none';
	} else {
		document.getElementById("date_html5").style.display = 'none';
		document.getElementById("date_html").style.display = 'block';
	}
}
function myFunction(e)
{
	e.preventDefault();
	var x;
	var name = document.getElementById("textarea-comment").value;
	if (name!=null)
	{
		x="<div id=comment><div id=user-info><div id=left-comment-body><img src=../image/ecky.jpg width=50px height=50px"+
			"/></div><div id=right-comment-body><b id=komentator>meckyr</b><br><b id=post-date"+
			">Post at 4.30 AM, February 4th, 2013</b></div></div><div id=comment-box><p>"+name+"</p></div></div>";
		document.getElementById("new-comment").innerHTML=x;
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
        
	if(asignee!="")
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
			//alert(suggestionarray);
			
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
}

function setCompleteStatus(taskid){
	getAjax();
	var status = document.getElementById("left-main-body4").innerHTML;
	status = status.substring(9,status.length);
	if(status!=""){
		ajaxRequest.open("GET","updatecompletestatus?status="+status+"&taskid="+taskid,false);
	
		ajaxRequest.onreadystatechange = function()
		{
			document.getElementById("left-main-body4").innerHTML =  "Status : "+ajaxRequest.responseText;
		}
		
		ajaxRequest.send();
	}
}