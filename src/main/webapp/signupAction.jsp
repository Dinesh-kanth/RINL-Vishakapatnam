<%@ page import="java.sql.*" %>
<%@ page import="project.ConnectionProvider" %>
<%
String userName = request.getParameter("username");
String email = request.getParameter("email");
String phoneNumber = request.getParameter("phoneNumber");
String password = request.getParameter("password");
String confirmPassword = request.getParameter("confirmPassword");
String role = request.getParameter("role"); // Ensure you have a role input in your form if required

if (password.equals(confirmPassword)) {
    try {
        Connection con = ConnectionProvider.getCon();
        PreparedStatement ps = con.prepareStatement("INSERT INTO users (username, email, phoneNumber, password, role) VALUES (?, ?, ?, ?, ?)");
        ps.setString(1, userName);
        ps.setString(2, email);
        ps.setString(3, phoneNumber);
        ps.setString(4, password);
        ps.setString(5, role);
        int result = ps.executeUpdate();
        
        if (result > 0) {
            response.sendRedirect("signup.jsp?msg=valid");
        } else {
            response.sendRedirect("signup.jsp?msg=invalid");
        }
        ps.close();
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("signup.jsp?msg=invalid");
    }
} else {
    response.sendRedirect("signup.jsp?msg=password_mismatch");
}
%>
