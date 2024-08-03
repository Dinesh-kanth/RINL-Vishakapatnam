package project;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("LOgin aervlet...");
    	
    	HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        System.out.println("email ::  "+email);
        //if (email != null) {
            Connection con = null;
            Statement st = null;
            ResultSet rs = null;
            ResultSet rs1 = null;
            try {
                con = ConnectionProvider.getCon();
                st = con.createStatement();

                rs1 = st.executeQuery("SELECT SUM(price * quantity) FROM cart WHERE email='" + email + "' AND address IS NULL");
                int total = 0;
                if (rs1.next()) {
                    total = rs1.getInt(1);
                }

                rs = st.executeQuery("SELECT product.id, product.name, cart.quantity, cart.price FROM product INNER JOIN cart ON product.id = cart.product_id WHERE cart.email='" + email + "' AND cart.address IS NULL");
                
                List<CartItem> cartItems = new ArrayList<>();
                while (rs.next()) {
                    CartItem item = new CartItem();
                    item.setProductId(rs.getInt("id"));
                    item.setProductName(rs.getString("name"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setPrice(rs.getDouble("price"));
                    cartItems.add(item);
                }
                System.out.println(cartItems);
                request.setAttribute("cartItems", cartItems);
                request.setAttribute("total", total);
                request.getRequestDispatcher("cart.jsp").forward(request, response);
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
			/*
			 * } else { response.sendRedirect("login.jsp"); }
			 */
    }
}
