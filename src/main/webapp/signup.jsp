<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/signup_style.css">
    <link rel="icon" type="image/x-icon" href="images/favicon.png">
    <title>RINL | SignUp</title>
    <style>
        body {
            background-image: url('images/reg_bg.jpg');
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <a href="signup.jsp"><img src="images/rinl_logo.png" alt="RINL LOGO"></a>
            <div class="title">
                <span class="t1">Rashtriya Ispat Nigam Limited</span><br>
                <span class="t2">Vishakaptnam Steel Plant</span><br>
                <span class="t3">(A Govt. of India Enterprise)</span>
            </div>
        </header>
        <div class="signup">
            <h1>Sign Up</h1>
            <form id="signupForm" action="signupAction.jsp" method="post" onsubmit="return validateForm()">
                <input type="text" name="username" placeholder="Enter Your username" required>
                <input type="email" name="email" placeholder="Enter Your email" required autocomplete="off">
                <input type="number" name="phoneNumber" placeholder="Enter Phone Number" required autocomplete="off">
                <input type="password" name="password" placeholder="Enter password" required autocomplete="off">
                <input type="password" name="confirmPassword" placeholder="Re-Enter password" required autocomplete="off">
                <p id="error-message" style="color: red; display: none;">Passwords do not match!</p>
                <button type="submit" class="button">SignUp</button>
            </form>
            <p>Existing user? <a href="login.jsp">LogIn</a></p>
            <% String msg = request.getParameter("msg"); %>
            <% if ("password_mismatch".equals(msg)) { %>
                <p style="color: red;">Passwords do not match!</p>
            <% } else if ("valid".equals(msg)) { %>
                <p style="color: green;">Registration successful!</p>
            <% } else if ("invalid".equals(msg)) { %>
                <p style="color: red;">Registration failed! Please try again.</p>
            <% } %>
        </div>
    </div>
    <script>
        function validateForm() {
            var password = document.forms["signupForm"]["password"].value;
            var confirmPassword = document.forms["signupForm"]["confirmPassword"].value;
            if (password !== confirmPassword) {
                document.getElementById("error-message").style.display = "block";
                return false;
            }
            return true;
        }
    </script>
</body>
</html>
