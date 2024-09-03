package servlets;

import model.Product;
import service.ProductService;

import java.io.File;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/EditProductServlet")
@MultipartConfig
public class EditProductServlet extends HttpServlet {

    private final ProductService productService = new ProductService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String category = request.getParameter("category");
        String price = request.getParameter("price");
        String active = request.getParameter("active");
        String description = request.getParameter("details");
        String quantity = request.getParameter("pquantity");

        Part filePart = request.getPart("productImage");
        String fileName = filePart != null ? filePart.getSubmittedFileName() : null;
        String imagePath = null;

        String uploadPath = "C:/Users/ASUS/eclipse-workspace/E-Commerce-Project0/src/main/webapp/img";
        if (fileName != null && !fileName.isEmpty()) {
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            String filePath = uploadPath + File.separator + fileName;
            try {
                filePart.write(filePath);
            } catch (IOException e) {
                e.printStackTrace();
                response.sendRedirect("admin/allProductEditProduct.jsp?msg=uploadError");
                return;
            }

            imagePath = "img/" + fileName;
        }

        Product product = new Product();
        product.setId(Integer.parseInt(id));
        product.setName(name);
        product.setCategory(category);
        product.setPrice((int) Double.parseDouble(price));
        product.setActive(active);
        product.setDetails(description);
        product.setPquantity(Integer.parseInt(quantity));
        product.setImagePath(imagePath);

        boolean isUpdated = productService.updateProduct(product);
        if (isUpdated) {
            response.sendRedirect("admin/allProductEditProduct.jsp?msg=done");
        } else {
            response.sendRedirect("admin/allProductEditProduct.jsp?msg=wrong");
        }
    }
}
 