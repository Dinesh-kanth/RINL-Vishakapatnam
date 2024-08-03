<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Confirmation</title>
    <link rel="icon" type="image/x-icon" href="images/favicon.png">
    <link rel="stylesheet" href="css/cart_style.css">
</head>
<body>
    <div class="container">
        <h1>Order Confirmation</h1>
        <p><%= request.getAttribute("message") %></p>
        <a href="home.jsp">Go to Home</a>
    </div>
</body>
</html>
