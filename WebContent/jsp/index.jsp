<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>SubReddit</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.2.min.js"></script>
</head>
<body>
<div id="login" style="color:red;"></div>
<div style="color:red;">${error}</div>
	<h1>Login</h1>
	<form id="fm" action="formlogin" method="post">
		<h4>Username:</h4>	
		<input id="u" type="text" name="username" required/>
		<h4>Password</h4>
		<input id="p" type="password" name="password" required/><br/><br/>
		<input type="submit" value="submit"/>
	</form>
	<br/>
	<h5>Don't have an account? <a style="text-decoration:none;color:blue;" href="signup">Sign up now</a></h5>
<h3>Links</h3>
<div id="main">
 There is no link to display
</div>
<script>
$( document ).ready(function() {

	 $.ajax({
		 url: "jsp/loginajax.jsp", 
		 success: function(result){
		        $("#main").html(result);
		    }});
	 });
</script>
</script>
</body>
</html>