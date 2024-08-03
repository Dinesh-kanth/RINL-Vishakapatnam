<%@ page import="java.sql.*" %>
<%@ page import="project.ConnectionProvider" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Product</title>
    <link rel="stylesheet" href="css/adminHeaderStyle.css">
    <link rel="icon" type="image/x-icon" href="images/favicon.png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" />
    <link rel="stylesheet" href="css/addproducts_style.css">
    <style>
        .product-image {
            width: 8em;
            height: 8em;
            object-fit: cover; /* To maintain aspect ratio and cover the area */
        }
    </style>
</head>
<body>
    <header>
        <div class="head">
            <a href="#"><img src="images/rinl_logo.png" alt="RINL LOGO"></a>
            <div class="title">
                <span class="t1">Rashtriya Ispat Nigam Limited</span><br>
                <span class="t2">Vishakaptnam Steel Plant</span><br>
                <span class="t3">(A Govt. of India Enterprise)</span>
            </div>
        </div>
        <div class="nav-container">
            <nav id="nav">
                <a href="addproducts.jsp">Add Products <i class="bi bi-plus-circle"></i></a>
                <a href="products.jsp">Edit Products <i class="bi bi-pencil-square"></i></a>
                <a href="logout.jsp">Logout <i class="bi bi-box-arrow-right"></i></a>
            </nav>
        </div>
    </header>
    <section style="margin-top:200px;">
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Product Name</th>
                    <th>Price</th>
                    <th>Status</th>
                    <th>Image</th>
                    <th>Description</th>
                    <th>Edit</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try {
                        Connection con = ConnectionProvider.getCon();
                        Statement st = con.createStatement();
                        ResultSet rs = st.executeQuery("SELECT * FROM product");
                        while (rs.next()) {
                %>
                <tr>
                    <td><%= rs.getInt("id") %></td>
                    <td><%= rs.getString("name") %></td>
                    <td><%= rs.getDouble("price") %></td>
                    <td><%= rs.getString("status") %></td>
                    <td>
                        <%
                            String imagePath = rs.getString("image");
                            if (imagePath != null && !imagePath.isEmpty()) {
                        %>
                        <img src="images/<%= imagePath %>" class="product-image" alt="Product Image">
                        <%
                            } else {
                        %>
                        <img src="images/default.png" class="product-image" alt="Default Image">
                        <%
                            }
                        %>
                    </td>
                    <td><%= rs.getString("description") %></td>
                    <td><a href="editProduct.jsp?id=<%= rs.getInt("id") %>">Edit</a></td>
                </tr>
                <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                %>
            </tbody>
        </table>
    </section>
</body>
</html>
