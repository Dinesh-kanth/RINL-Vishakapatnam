<%@ page import="java.sql.*" %>
<%@ page import="project.ConnectionProvider" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home | RINL</title>
    <link rel="icon" type="image/x-icon" href="images/favicon.png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="css/home_style.css">
</head>
<body>
    <div class="header">
        <nav>
            <img src="images/rinl_logo.png" alt="VIZAG-STEEL-logo" class="steel-plant-logo">
            <div class="header-text">
                <h3>Rashtriya Ispat Nigam Limited</h3>
                <h4>Visakhapatnam Steel Plant</h4>
                <h5>(A Govt. of India Enterprise)</h5>
            </div>
            <img src="images/logo.png" alt="beti-bachao-beti-padhao-yojana-logo" class="beti-logo">
        </nav>
        <br>
        <div class="quick-access">
            <ul>
                <li><a href="home.jsp"><i class="fa-solid fa-house"></i> Home</a></li>
                <li><a href="https://www.vizagsteel.com/mobile/mob/index.html">Mobile Apps</a></li>
                <li><a href="https://www.vizagsteel.com/code/r_port_new/">Retired Employees</a></li>
                <li><a href="https://www.vizagsteel.com/ptms/">Internship (PTMS)</a></li>
            </ul>
            <div class="quick-access-icons">
			    <a href="CartServlet" data-tooltip="Cart"><i class="fa-sharp fa-solid fa-cart-shopping"></i></a>
			    <a href="" data-tooltip="Profile"><i class="fa-solid fa-circle-user"></i></a>
			    <a href="logout.jsp" data-tooltip="Logout">Logout <i class="bi bi-box-arrow-right"></i></a>
			</div>
        </div>
        <br>
        <div class="page-heading">
            <h2>Products :</h2>
        </div>
        <div>
        <%
        String msg = request.getParameter("msg");
        if ("added".equals(msg)) {
        %>
            <h3 style="color:green;">Product added to cart successfully</h3>
        <% } %>
        <%
        if ("exists".equals(msg)) {
        %>
            <h3 style="color:green;">Product already exists in cart!!! Quantity Increased</h3>
        <% } %>
        <%
        if ("invalid".equals(msg)) {
        %>
            <h3 style="color:red;">Invalid request parameters!</h3>
        <% } %>
        <%
        if ("invalid_quantity".equals(msg)) {
        %>
            <h3 style="color:red;">Invalid quantity!</h3>
        <% } %>
        <%
        if ("error".equals(msg)) {
        %>
            <h3 style="color:red;">An error occurred while adding to cart!</h3>
        <% } %>
        </div>
        <table class="table table-striped table-hover">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Price</th>
                    <th>Status</th>
                    <th>Image</th>
                    <th>Description</th>
                    <th>Add to Cart</th>
                </tr>
            </thead>
            <tbody>
            <%
            try {
                Connection con = ConnectionProvider.getCon();
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery("SELECT * FROM product WHERE status='Yes'");
                while (rs.next()) {
            %>
                <tr>
                    <td><%= rs.getString(1) %></td>
                    <td><%= rs.getString(2) %></td>
                    <td><%= rs.getString(3) %></td>
                    <td><%= rs.getString(4) %></td>
                    <td><img src="images/<%= rs.getString(5) %>" alt="<%= rs.getString(2) %>" style="width: 100px; height: auto;"></td>
                    <td><%= rs.getString(6) %></td>
                    <td><a href="AddToCartServlet?product_id=<%= rs.getString(1) %>&email=<%= request.getSession().getAttribute("email") %>&quantity=1" class="btn btn-primary add-to-cart">Add</a></td>
                </tr>
            <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            %>
            </tbody>
        </table>
    </div>

	<script>
	$(document).ready(function(){
	    // Animate the quick-access links on hover
	    $('.quick-access ul li a').hover(
	        function() {
	            $(this).css('transform', 'scale(1.1)');
	        }, function() {
	            $(this).css('transform', 'scale(1)');
	        }
	    );

	    // Animate the quick-access icons on hover
	    $('.quick-access-icons a').hover(
	        function() {
	            $(this).css('transform', 'scale(1.1)');
	        }, function() {
	            $(this).css('transform', 'scale(1)');
	        }
	    );
	});

	</script>
</body>
</html>
