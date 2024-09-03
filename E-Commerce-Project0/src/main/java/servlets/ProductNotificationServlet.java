package servlets;

import dao.ProductDAO;
import model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/ProductNotificationServlet")
public class ProductNotificationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProductDAO productDAO = new ProductDAO();
        List<Product> allProducts = productDAO.getAllProducts();
        List<Product> lowStockProducts = allProducts.stream()
                .filter(product -> product.getPquantity() < 3)
                .toList();

        request.setAttribute("lowStockProducts", lowStockProducts);
        request.getRequestDispatcher("/admin/lowStockNotification.jsp").forward(request, response);
    }
}
