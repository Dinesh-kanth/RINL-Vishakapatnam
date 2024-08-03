<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/login_style.css">
    <link rel="icon" type="image/x-icon" href="images/favicon.png">
    <title>RINL | LogIn</title>
    <style>
    	body{
    		background-image: url('images/reg_bg.jpg');
    	}
    </style>
</head>
<body>
    <div class="container">
        <header>
            <a href="login.jsp"><img src="images/rinl_logo.png" alt="RINL LOGO"></a>
            <div class="title">
                <span class="t1">Rashtriya Ispat Nigam Limited</span><br>
                <span class="t2">Vishakaptnam Steel Plant</span><br>
                <span class="t3">(A Govt. of India Enterprise)</span>
            </div>
        </header>
        <div class="login">
            <h1>Log In</h1>
            <form id="loginForm" action="loginAction.jsp" method="post" onsubmit="return validateForm()">
                <input type="text" name="email" placeholder="Enter Your Mail" required>
                <input type="password" name="password" placeholder="Enter password" required autocomplete="off">
                <% String msg = request.getParameter("msg"); %>
                <% if ("wrong_password".equals(msg)) { %>
                    <p class="ip" style="color: red;">Password wrong!!<br> Re-enter the password</p>
                <% } else if ("not_registered".equals(msg)) { %>
                    <p class="em" style="color: red;">Email has not been registered yet!!!</p>
                <% } %>
                <button type="submit" class="button">Log In</button>
            </form>
            <p>Don't have an account? <a href="signup.jsp">SignUp</a></p>
        </div>
    </div>
    <script>
        function validateForm() {
            var email = document.forms["loginForm"]["email"].value;
            var password = document.forms["loginForm"]["password"].value;
            if (email == "" || password == "") {
                alert("Both fields must be filled out");
                return false;
            }
            return true;
        }
    </script>
</body>
</html>
