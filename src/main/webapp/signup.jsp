<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="signup.css">
<title>Login</title>
</head>
<body>
    <div class="signup-page">
  <div class="form">
    <form class="register-form" method="post" action="signup">
      <input type="text" placeholder="First Name"/>
        <input type="text" placeholder="Last Name"/>
        <input type="text" placeholder="User Id"/>
      <input type="password" placeholder="Password"/>
      <input type="text" placeholder="Email Address"/>
        <input type="text" placeholder="Phone Number"/>
        <input type="text" placeholder="Address"/>
        <input type="text" placeholder="Account Number"/>
        <input type="text" placeholder="Routing Number"/>
      <button>create</button>
      <p class="message">Already registered? <a href="login.jsp">Sign In</a></p>
    </form>
  </div>
</div>
</body>
</html>