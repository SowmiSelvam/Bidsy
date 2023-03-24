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
    <div class="login-page">
  <div class="form">
    <form class="login-form" method="post" action="login">
      <input type="text" required placeholder="Username"/>
      <input type="password" required placeholder="Password"/>
      <button>login</button>
      <p class="message">Not registered? <a href="signup.jsp">Create an account</a></p>
    </form>
  </div>
</div>
</body>
</html>