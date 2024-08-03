<%@ page import="java.sql.*" %>
<%@ page import="project.ConnectionProvider" %>
<%
String email = request.getParameter("email");
String password = request.getParameter("password");

try {
    Connection con = ConnectionProvider.getCon();
    if (con != null) {
        PreparedStatement ps = con.prepareStatement("SELECT * FROM users WHERE email = ?");
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();
        
        if (rs.next()) {
            String storedPassword = rs.getString("password");
            String role = rs.getString("role");
            if (storedPassword.equals(password)) {
                // Set the email in a cookie
                session.setAttribute("email", email);
                Cookie emailCookie = new Cookie("userEmail", email);
                emailCookie.setMaxAge(60 * 60 * 24); // 1 day
                response.addCookie(emailCookie);

                if ("admin".equals(role)) {
                    request.getRequestDispatcher("adminHome.jsp").forward(request, response); // Replace with admin page URL
                } else {
                	 request.getRequestDispatcher("home.jsp").forward(request, response);
                    //response.sendRedirect("home.jsp");
                }
            } else {
                response.sendRedirect("login.jsp?msg=wrong_password");
            }
        } else {
            response.sendRedirect("login.jsp?msg=not_registered");
        }
        rs.close();
        ps.close();
        con.close();
    } else {
        response.sendRedirect("login.jsp?msg=error");
    }
} catch (Exception e) {
    e.printStackTrace();
    response.sendRedirect("login.jsp?msg=error");
}
%>
