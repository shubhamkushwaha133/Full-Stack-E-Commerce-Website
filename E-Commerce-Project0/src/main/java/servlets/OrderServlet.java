package servlets;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Cart;
import service.CartService;

@WebServlet("/OrderServlet")
public class OrderServlet extends HttpServlet {
    private CartService cartService = new CartService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "User is not logged in.");
            return;
        }

        String email = (String) session.getAttribute("email");
        if (email == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Email not found in session.");
            return;
        }

        List<Cart> orders = cartService.getOrdersByUser(email);
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("/myOrders.jsp").forward(request, response);
    }
}
