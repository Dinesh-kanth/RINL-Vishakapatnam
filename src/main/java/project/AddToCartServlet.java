package project;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productId = request.getParameter("product_id");
        String email = null;
        String quantityStr = request.getParameter("quantity");

        // Retrieve email from cookies
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("userEmail".equals(cookie.getName())) {
                    email = cookie.getValue();
                    break;
                }
            }
        }

        if (productId == null || email == null || quantityStr == null) {
            response.sendRedirect("home.jsp?msg=invalid");
            return;
        }

        int quantity;
        try {
            quantity = Integer.parseInt(quantityStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("home.jsp?msg=invalid_quantity");
            return;
        }

        try {
            Connection con = ConnectionProvider.getCon();
            
            // Check if the product already exists in the cart for this user
            PreparedStatement ps = con.prepareStatement("SELECT * FROM cart WHERE product_id=? AND email=?");
            ps.setString(1, productId);
            ps.setString(2, email);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                // Product already in the cart, update quantity and total
                int existingQuantity = rs.getInt("quantity");
                int newQuantity = existingQuantity + quantity;
                double price = rs.getDouble("price");
                double total = price * newQuantity;
                
                ps = con.prepareStatement("UPDATE cart SET quantity=?, total=? WHERE product_id=? AND email=?");
                ps.setInt(1, newQuantity);
                ps.setDouble(2, total);
                ps.setString(3, productId);
                ps.setString(4, email);
                ps.executeUpdate();
                
                response.sendRedirect("home.jsp?msg=exists");
            } else {
                // Product not in the cart, insert new record
                ps = con.prepareStatement("SELECT price FROM product WHERE id=?");
                ps.setString(1, productId);
                rs = ps.executeQuery();
                rs.next();
                double price = rs.getDouble("price");
                double total = price * quantity;
                
                ps = con.prepareStatement("INSERT INTO cart (product_id, email, quantity, price, total) VALUES (?, ?, ?, ?, ?)");
                ps.setString(1, productId);
                ps.setString(2, email);
                ps.setInt(3, quantity);
                ps.setDouble(4, price);
                ps.setDouble(5, total);
                ps.executeUpdate();
                
                response.sendRedirect("home.jsp?msg=added");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("home.jsp?msg=error");
        }
    }
}
