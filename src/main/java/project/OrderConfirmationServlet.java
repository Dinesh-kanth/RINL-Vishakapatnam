package project;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/confirmOrder")
public class OrderConfirmationServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        if (email != null) {
            try {
                Connection con = ConnectionProvider.getCon();
                Statement st = con.createStatement();
                // Example logic to update database, set order status, etc.

                // Assuming you update order status and other details here

                request.setAttribute("message", "Order confirmed successfully!");
                request.getRequestDispatcher("orderConfirmation.jsp").forward(request, response);
            } catch (SQLException e) {
                e.printStackTrace();
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
        } else {
            response.sendRedirect("login.jsp");
        }
    }
}
