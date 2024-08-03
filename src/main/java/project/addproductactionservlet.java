package project;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
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

@WebServlet("/addproductactionservlet")
@MultipartConfig
public class addproductactionservlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        String productName = request.getParameter("productname");
        String productPrice = request.getParameter("productprice");
        String status = request.getParameter("status");
        Part filePart = request.getPart("fileUpload");
        String description = request.getParameter("message");

        String fileName = extractFileName(filePart);
        String savePath = "C:\\Users\\dines\\eclipse-workspace\\RINL Vishakapatnam\\src\\main\\webapp\\images" + File.separator + fileName;

        // Create the images directory if it does not exist
        File fileSaveDir = new File("C:\\Users\\dines\\eclipse-workspace\\RINL Vishakapatnam\\src\\main\\webapp\\images");
        if (!fileSaveDir.exists()) {
            fileSaveDir.mkdirs();
        }

        // Save the file to the images directory
        try (InputStream inputStream = filePart.getInputStream();
             FileOutputStream outputStream = new FileOutputStream(savePath)) {

            int read;
            final byte[] bytes = new byte[1024];

            while ((read = inputStream.read(bytes)) != -1) {
                outputStream.write(bytes, 0, read);
            }
        }

        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = ConnectionProvider.getCon();
            ps = con.prepareStatement("INSERT INTO product VALUES(?,?,?,?,?,?)");

            ps.setString(1, id);
            ps.setString(2, productName);
            ps.setString(3, productPrice);
            ps.setString(4, status);
            ps.setString(5, fileName); // Store the file name in the database
            ps.setString(6, description);

            ps.executeUpdate();

            response.sendRedirect("addproducts.jsp?msg=done");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("addproducts.jsp?msg=wrong");
        } finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

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
