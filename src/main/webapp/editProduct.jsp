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
                <a href="#edit-products">Edit Products <i class="bi bi-pencil-square"></i></a>s
                <a href="logout.jsp">Logout <i class="bi bi-box-arrow-right"></i></a>
            </nav>
        </div>
    </header>
    <section>
        <div class="form-container">
            <% 
                String productId = request.getParameter("id");
                String productName = "", productPrice = "", status = "", description = "", image = "";
                try {
                    Connection con = ConnectionProvider.getCon();
                    PreparedStatement pst = con.prepareStatement("SELECT * FROM product WHERE id=?");
                    pst.setString(1, productId);
                    ResultSet rs = pst.executeQuery();
                    if (rs.next()) {
                        productName = rs.getString("name");
                        productPrice = rs.getString("price");
                        status = rs.getString("status");
                        description = rs.getString("description");
                        image = rs.getString("image");
                    }
                    rs.close();
                    pst.close();
                    con.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
            <h3>Edit Product</h3>
            <form action="editProductAction" method="post" enctype="multipart/form-data">
                <input type="hidden" name="id" value="<%= productId %>">
                <div class="form-group">
                    <label for="productname">Product Name:</label>
                    <input type="text" id="productname" name="productname" value="<%= productName %>" required>
                </div>
                <div class="form-group">
                    <label for="productprice">Product Price:</label>
                    <input type="number" id="productprice" name="productprice" value="<%= productPrice %>" required>
                </div>
                <div class="form-group">
                    <label for="status">Product Status:</label>
                    <select id="status" name="status">
                        <option value="Yes" <%= "Yes".equals(status) ? "selected" : "" %>>Yes</option>
                        <option value="No" <%= "No".equals(status) ? "selected" : "" %>>No</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="fileUpload">Choose the Product image to upload:</label>
                    <input type="file" id="fileUpload" name="fileUpload">
                    <img src="uploads/<%= image %>" alt="Current Image" width="100">
                </div>
                <div class="form-group">
                    <label for="description">Product Description:</label>
                    <textarea id="description" name="description" rows="10" cols="30"><%= description %></textarea>
                </div>
                <div class="form-group">
                    <button type="submit">Update Product</button>
                </div>
            </form>
        </div>
    </section>
</body>
</html>
