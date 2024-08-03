<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Statement"%>
<%@page import="project.ConnectionProvider"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.util.List" %>
<%@ page import="project.CartItem" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cart</title>
    <link rel="icon" type="image/x-icon" href="images/favicon.png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="css/cart_style.css">
</head>
<body>
    <nav>
        <img src="images/rinl_logo.png" alt="VIZAG-STEEL-logo" class="steel-plant-logo">
        <div class="header-text">
            <h1>Rashtriya Ispat Nigam Limited</h1>
            <h2>Visakhapatnam Steel Plant</h2>
            <h3>(A Govt. of India Enterprise)</h3>
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
            <a href="#"><i class="fa-sharp fa-solid fa-cart-shopping"></i></a>
            <a href="#"><i class="fa-solid fa-circle-user"></i></a>
        </div>
    </div>
    
    
    <%
    
    //String email ="dineshkanthyandra@gmail.com";

    String email = (String) session.getAttribute("email");
    System.out.println("email ::  "+email);
    //if (email != null) {
        Connection con = null;
        Statement st = null;
        ResultSet rs = null;
        ResultSet rs1 = null;
        double total = 0;
        List<CartItem> cartItems = new ArrayList<>();
        try {
            con = ConnectionProvider.getCon();
            st = con.createStatement();

/*             rs1 = st.executeQuery("SELECT SUM(price * quantity) FROM cart WHERE email='" + email + "' AND address IS NULL");
            int total = 0;
            if (rs1.next()) {
                total = rs1.getInt(1);
            } */

            rs = st.executeQuery("SELECT product.id, product.name, cart.quantity, cart.price FROM product INNER JOIN cart ON product.id = cart.product_id WHERE cart.email='" + email + "' AND cart.address IS NULL");
            
          

            while (rs.next()) {
                CartItem item = new CartItem();
                item.setProductId(rs.getInt("id"));
                item.setProductName(rs.getString("name"));
                item.setQuantity(rs.getInt("quantity"));
                item.setPrice(rs.getDouble("price"));
                total = total + item.getPrice();
                cartItems.add(item);
            }
            System.out.println(cartItems);
           // request.setAttribute("cartItems", cartItems);
           // request.setAttribute("total", total);
            //request.getRequestDispatcher("cart.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        } finally {
            try {
                if (rs1 != null) rs1.close();
                if (rs != null) rs.close();
                if (st != null) st.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    
    
    
    
    %>
    
    
    <div class="container">
        <h1>Your Cart</h1>
        <table>
            <thead>
                <tr>
                    <th>Total: <%= total %></th>
                    <% if ( total > 0) { %>
                        <th>
                            <form action="confirmOrder" method="post">
                                <input type="submit" value="Place Order">
                            </form>
                        </th>
                    <% } %>
                </tr>
                <tr>
                    <th>Product ID</th>
                    <th>Product Name</th>
                    <th>Quantity</th>
                    <th>Price</th>
                </tr>
            </thead>
            <tbody>
                <% 
                if (cartItems.size()>0) {
                    for (CartItem item : cartItems) {
                %>
                        <tr>
                            <td><%= item.getProductId() %></td>
                            <td><%= item.getProductName() %></td>
                            <td><%= item.getQuantity() %></td>
                            <td><%= item.getPrice() %></td>
                        </tr>
                <% 
                    }
                } 
                %>
            </tbody>
        </table>
        <div class="buttons">
            <a href="home.jsp">Continue Shopping</a>
        </div>
    </div>
    <script>
    $(document).ready(function() {
        // Animate cart items appearance
        $('.cart-item').each(function(index) {
            $(this).delay(200 * index).queue(function(next) {
                $(this).addClass('show');
                next();
            });
        });

        // Add any other interactive features here
    });

    </script>
</body>
</html>
