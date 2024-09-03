package servlets;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import util.ConnectionProvider;
import service.FavoriteService;

@WebServlet("/ToggleFavoriteServlet")
public class ToggleFavoriteServlet extends HttpServlet {
    private FavoriteService favoriteService = new FavoriteService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String productId = request.getParameter("productId");
        String userEmail = (String) request.getSession().getAttribute("email");

        if (userEmail != null && productId != null) {
            int pid = Integer.parseInt(productId);
            favoriteService.toggleFavorite(userEmail, pid);
        }

        response.sendRedirect("home.jsp");
    }
}
