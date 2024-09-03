package servlets;

import java.io.File;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import model.Product;
import service.ProductService;

@WebServlet("/FileUploadServlet")
@MultipartConfig
public class FileUploadServlet extends HttpServlet {
    private ProductService productService = new ProductService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String category = request.getParameter("category");
        String price = request.getParameter("price");
        String active = request.getParameter("active");
        String details = request.getParameter("details");
        String pquantity = request.getParameter("pquantity");
        
        Part filePart = request.getPart("productImage");
        String fileName = filePart.getSubmittedFileName();

        String uploadPath = "C:/Users/ASUS/eclipse-workspace/E-Commerce-Project0/src/main/webapp/img";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }
        
        String filePath = uploadPath + File.separator + fileName;
        filePart.write(filePath);
        
        String imagePath = "img/" + fileName;

        Product product = new Product();
        product.setId(Integer.parseInt(id));
        product.setName(name);
        product.setCategory(category);
        product.setPrice(Integer.parseInt(price));
        product.setActive(active);
        product.setDetails(details);
        product.setPquantity(Integer.parseInt(pquantity));
        product.setImagePath(imagePath);

        boolean isProductAdded = productService.addProduct(product);
        
        if (isProductAdded) {
            response.sendRedirect("admin/addNewProduct.jsp?msg=done");
        } else {
            response.sendRedirect("admin/addNewProduct.jsp?msg=wrong");
        }
    }
}
