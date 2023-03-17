<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="login.css">
<title>Login</title>
</head>
<body>

	<div class="float-container" style="display: flex">
		<div class="container">
			<div class="new">
				<form method="post" action="login">
					<p>
						LOGIN TO <strong>BIDSY</strong>
					</p>
					<label for="uname">Username</label> <input type="text"
						placeholder="Enter Username" name="uname" id="uname" required>

					<label for="psw">Password</label> <input type="password"
						placeholder="Enter Password" name="psw" id="psw" required>
					<br> <br>
					<button type="submit">Login</button>


					<br> <br> <a href="signup.jsp"
						style="color: rgb(57, 57, 107); text-align: center;"><span>
							<b>Don't have an account ?</b>
					</span></a>
			</div>
		</div>

		</form>
</body>
</html>