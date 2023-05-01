<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="user_landing.css">
<title>User Landing</title>
</head>
<body>
	<div class="logout">
		<form name="form1" method="post" action="logout">
			<label style="float: right" class="logoutLblPos">
				<button name="logout">logout</button>
			</label>
		</form>
	</div>

	<div class="user-dashboard">
		<div class="form">
		<div>			<%
			String fname = (String) session.getAttribute("fname");
			String lname = (String) session.getAttribute("lname");
			out.print("Welcome " + fname + " " + lname);
			%>
			</div>
			<div>
				<a href="marketplace.jsp"><button class="redirect buy">Buy items</button></a>
			</div>
			<div>
				<a href="sell_item.jsp"><button class="redirect sell">Sell items</button></a>
			</div>
			<div>
				<a href="checkAlerts.jsp"><button class="redirect check">check Alerts</button></a>
			</div>
		</div>

	</div>
</body>
</html>