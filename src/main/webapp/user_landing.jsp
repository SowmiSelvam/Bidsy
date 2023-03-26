<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="user_landing.css">
<title>Admin Landing</title>
</head>
<body>
<div class="admin-dashboard">
<div class ="form" >
<% 
String fname=(String)session.getAttribute("fname"); 
String lname=(String)session.getAttribute("lname"); 
out.print("Welcome "+ fname+" "+lname);
%> 
<form  name="form1" method="post" action="logout">
  <label style="float:right" class="logoutLblPos">
  <button name="logout" >logout</button>
  </label>
</form>
</div>
</div>
</body>
</html>