package project;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        // Add your authentication logic here
        boolean isAuthenticated = authenticateUser(email, password);
        
        if (isAuthenticated) {
            HttpSession session = request.getSession();
            session.setAttribute("email", email);
            response.sendRedirect("homepage.jsp");
        } else {
            response.sendRedirect("login.jsp?error=invalid");
        }
    }
    
    private boolean authenticateUser(String email, String password) {
        // Your authentication logic
        return true; // Assume the user is authenticated for this example
    }
}
