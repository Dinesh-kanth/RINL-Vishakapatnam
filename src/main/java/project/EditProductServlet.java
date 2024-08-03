package project;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/editProductAction")
@MultipartConfig
public class EditProductServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String id = request.getParameter("id");
            String productName = request.getParameter("productname");
            String productPrice = request.getParameter("productprice");
            String status = request.getParameter("status");
            String description = request.getParameter("description");

            Part filePart = request.getPart("fileUpload");
            String fileName = null;
            if (filePart != null && filePart.getSize() > 0) {
                fileName = filePart.getSubmittedFileName();
                String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();  // Create directories
                }
                filePart.write(uploadPath + File.separator + fileName);
            }

            Connection con = ConnectionProvider.getCon();
            String sql = "UPDATE product SET name=?, price=?, status=?, description=?";
            if (fileName != null) {
                sql += ", image=?";
            }
            sql += " WHERE id=?";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, productName);
            pst.setString(2, productPrice);
            pst.setString(3, status);
            pst.setString(4, description);
            if (fileName != null) {
                pst.setString(5, fileName);
                pst.setString(6, id);
            } else {
                pst.setString(5, id);
            }
            int row = pst.executeUpdate();
            if (row > 0) {
                response.sendRedirect("products.jsp?msg=edit_success");
            } else {
                throw new SQLException("Failed to update product");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("editProduct.jsp?msg=edit_fail&error=" + e.getMessage());
        }
    }
}
