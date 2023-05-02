<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="employee_register.css" />
<title>Employee Register</title>
</head>
<body>

	<div class="back">
		<label> <a href="admin_landing.jsp"><button name="back">Home</button></a>
		</label>
	</div>
	<div class="logout">
		<form name="form1" method="post" action="logout">
			<label style="float: right" class="logoutLblPos">
				<button name="logout">logout</button>
			</label>
		</form>
	</div>

	<div class="employee-register">
		<div class="form">
			<form class="register-form" method="post" action="employeeRegister">
				<input type="text" required placeholder="Employee ID" name="emp_id"
					maxlength="20" /> <input type="text" required
					placeholder="First Name" name="first_name" maxlength="30" /> <input
					type="text" required placeholder="Last Name" name="last_name"
					maxlength="30" /> <input type="password" required
					placeholder="Password" name="password" /> <input type="text"
					required placeholder="Email Address" name="email" /> <input
					type="text" required placeholder="Phone Number" name="phone_number"
					maxlength="10" /> <input type="text" required
					placeholder="Address" name="address" maxlength="50" /> <input
					type="text" required placeholder="Account Number"
					name="account_number" maxlength="10" /> <input type="text"
					required placeholder="Routing Number" name="routing_number"
					maxlength="8" />
				<button>Register</button>
				<p class="message">
					Employee registered? <a href="login.jsp">Sign In</a>
				</p>
			</form>

		</div>
	</div>
</body>
</html>
