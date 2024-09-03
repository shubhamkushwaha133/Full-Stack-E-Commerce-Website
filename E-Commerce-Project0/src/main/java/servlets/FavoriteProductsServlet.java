package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product;
import service.FavoriteService;
import java.io.IOException;
import java.util.List;


@WebServlet("/FavoriteProductsServlet")
public class FavoriteProductsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private FavoriteService favoriteService = new FavoriteService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userEmail = (String) request.getSession().getAttribute("email");

        if (userEmail != null) {
            List<Product> favoriteProducts = favoriteService.getFavoriteProducts(userEmail);
            request.setAttribute("favoriteProducts", favoriteProducts);
            request.getRequestDispatcher("favouriteProduct.jsp").forward(request, response);
        } else {
            response.sendRedirect("login.jsp");
        }
    }
}
