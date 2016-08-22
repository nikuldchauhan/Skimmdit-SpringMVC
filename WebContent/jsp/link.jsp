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
<a style="text-decoration:none;" href="link/logout" ><input type="button" value="Logout" /></a>
   <form id="fm" action="link/linksubmit" method="post">
   <h4>Link Descriptin</h4>
   <input id="ln" type="text" name="linkd" required />
   <h4>Link Address</h4>
   <input id="la" type="text" name="linka" required/><br/><br/>
   <input type="submit" value="submit"/>
 </form>
 <h2>Links</h2>
 <div id="main" style="width:500px;">
 There is no link to display
 </div>
 <script>
 $( document ).ready(function() {

	 $.ajax({
		 url: "jsp/ajaxlink.jsp", 
		 success: function(result){
		        $("#main").html(result);
		    }});

	 });
 </script>
</body>
</html>