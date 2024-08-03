<%@ page import="java.sql.*" %>
<%@ page import="project.ConnectionProvider" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Product</title>
    <link rel="icon" type="image/x-icon" href="images/favicon.png">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" />
    <link rel="stylesheet" href="css/addproducts_style.css">
    <link rel="stylesheet" href="css/adminHeaderStyle.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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

    <section>
        <div class="form-container">
            <%
                int id = 1;
                try {
                    Connection con = ConnectionProvider.getCon();
                    Statement st = con.createStatement();
                    ResultSet rs = st.executeQuery("SELECT MAX(id) FROM product");
                    if (rs.next()) {
                        id = rs.getInt(1) + 1;
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }

                String msg = request.getParameter("msg");
            %>
            <h3>Add Product</h3>
            <% 
                if ("done".equals(msg)) { 
            %>
            <h5 class="msgg">Product added successfully!!!</h5>
            <% 
                } else if ("wrong".equals(msg)) { 
            %>
            <h5 class="msgr">Something went wrong!!! Please Try Again!!!</h5>
            <% 
                } 
            %>
            <form action="addproductactionservlet" method="post" enctype="multipart/form-data">
                <input type="hidden" name="id" value="<%= id %>">
                <div class="form-group">
                    <label for="productname">Product Name:</label>
                    <input type="text" id="productname" name="productname" placeholder="Enter Product name" required>
                </div>
                <div class="form-group">
                    <label for="productprice">Product Price:</label>
                    <input type="number" id="productprice" name="productprice" placeholder="Enter Product Price" required>
                </div>
                <div class="form-group">
                    <label for="status">Product Status:</label>
                    <select id="status" name="status">
                        <option value="Yes" selected>Yes</option>
                        <option value="No">No</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="fileUpload">Choose the Product image to upload:</label>
                    <input type="file" id="fileUpload" name="fileUpload" required>
                </div>
                <div class="form-group">
                    <label for="message">Product Description:</label>
                    <textarea id="message" name="message" placeholder="Enter the product Description here..." rows="10" cols="30"></textarea>
                </div>
                <div class="form-group">
                    <button type="submit">Add Product</button>
                </div>
            </form>
        </div>
    </section>

    <script>
        $(document).ready(function(){
            $('input, select, textarea').focus(function(){
                $(this).css('border-color', '#007bff');
            }).blur(function(){
                $(this).css('border-color', '#ddd');
            });
        });
    </script>
</body>
</html>
