<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="signup.css" />
        <title>Login</title>
    </head>
    <body>
        <div class="signup-page">
            <div class="form">
                <form class="register-form" method="post" action="signup">
                    <input type="text" required placeholder="First Name" name="first_name" /> <input type="text" required placeholder="Last Name" name="last_name" />
                    <!-- <input type="text" placeholder="User Id"/> -->
                    <input type="password" required placeholder="Password" name="password" />
                    <input type="text" required placeholder="Email Address" name="email" />
                    <input type="text" required placeholder="Phone Number" name="phone_number" /> <input type="text" required placeholder="Address" name="address" />
                    <input type="text" required placeholder="Account Number" name="account_number" /> <input type="text" required placeholder="Routing Number" name="routing_number" />
                    <button>create</button>
                    <p class="message">Already registered? <a href="login.jsp">Sign In</a></p>
                </form>
            </div>
        </div>
    </body>
</html>
