<%@page import="project.ConnectionProvider"%>
<%@page import="java.sql.*"%>
<%
try {
    Connection con = ConnectionProvider.getCon();
    Statement st = con.createStatement();

    String q1 = "CREATE TABLE IF NOT EXISTS users (username VARCHAR(100), email VARCHAR(100) PRIMARY KEY, phoneNumber BIGINT, password VARCHAR(100))";
    String q2 = "CREATE TABLE IF NOT EXISTS product (id INT PRIMARY KEY, name VARCHAR(255) NOT NULL, price DECIMAL(10, 2) NOT NULL, status VARCHAR(10) NOT NULL, image VARCHAR(255) NOT NULL, description TEXT)";
	String q3 = "CREATE TABLE IF NOT EXISTS cart (id INT AUTO_INCREMENT PRIMARY KEY,product_id INT NOT NULL,email VARCHAR(50) NOT NULL,quantity INT NOT NULL, price DECIMAL(10, 2) NOT NULL,total DECIMAL(10, 2) NOT NULL,address VARCHAR(255), FOREIGN KEY (product_id) REFERENCES product(id))";
    st.execute(q1);
    st.execute(q2);
	st.execute(q3);
    System.out.println("Tables Created");

    st.close();
    con.close();
} catch (Exception e) {
    System.out.println(e);
}
%>