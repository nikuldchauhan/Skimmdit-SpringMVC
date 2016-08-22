<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Subreddit</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.2.min.js"></script>
</head>
<body>
<div style="color:red;">${error}</div>
<div style="display:none;color:red;" id="errr"></div>
<h1>SignUp</h1>
<form id="fm" action="formsignup" method="post">
		<h4>Username:</h4>	
		<input id="u" type="text" name="username" required/>
		<h4>Password</h4>
		<input id="p" type="password" name="password" required/>
		<h4>Retype-Password</h4>
		<input id="p1" type="password" required/><br/><br/>
		<input type="submit" value="submit"/>
</form>
<br/>
<a style="text-decoration:none;" href="back"><input type="button" value="Back"/></a>
<script>
$("#fm").submit(function(event) {
	$("#e").html("");
	$("#errr").html("");
	$("#errr").css("display","none");
	$("#p").removeClass('textboxred');
	$("#p1").removeClass('textboxred');
	err="";
	p = $("#p").val();
	p1 = $("#p1").val();
	if(p=="")
	{
		bb=true;
		if(b)
		{
			err+=" and Password";
		}
		else
		{
			err+="Password";
		}	
		$("#p").addClass("textboxred");
	}	
	if(p1=="")
	{
		$("#p1").addClass("textboxred");
	}	
	if(p!=p1)
	{
		$("#p1").addClass("textboxred");
		err+="<br/>Password does not match";
	}	
	if(err!="")
	{
		$("#errr").html(err);
		$("#errr").css("display","block");
		return false;
	}	
	return true;
});
</script>
</body>
</html>