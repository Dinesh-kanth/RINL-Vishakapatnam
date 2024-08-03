package project;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/upload")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class FileUploadServlet extends HttpServlet {
    private static final String SAVE_DIR = "images";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String appPath = request.getServletContext().getRealPath("");
        String savePath = appPath + File.separator + SAVE_DIR;

        // Creates the save directory if it does not exist
        File fileSaveDir = new File(savePath);
        if (!fileSaveDir.exists()) {
            fileSaveDir.mkdir();
        }

        String fileName = "";
        for (Part part : request.getParts()) {
            fileName = extractFileName(part);
            if (fileName != null && !fileName.isEmpty()) {
                part.write(savePath + File.separator + fileName);
            }
        }

        // Retrieve form data
        int id = Integer.parseInt(request.getParameter("id"));
        String productName = request.getParameter("productname");
        double productPrice = Double.parseDouble(request.getParameter("productprice"));
        String status = request.getParameter("status");
        String description = request.getParameter("message");

        // Save product information in the database
        try {
            Connection con = ConnectionProvider.getCon();
            String query = "INSERT INTO product (id, name, price, status, description, image) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, id);
            ps.setString(2, productName);
            ps.setDouble(3, productPrice);
            ps.setString(4, status);
            ps.setString(5, description);
            ps.setString(6, fileName);
            int result = ps.executeUpdate();
            if (result > 0) {
                response.sendRedirect("addproducts.jsp?msg=done");
            } else {
                response.sendRedirect("addproducts.jsp?msg=wrong");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("addproducts.jsp?msg=wrong");
        }
    }

    /**
     * Extracts file name from HTTP header content-disposition
     */
    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
    }
}
