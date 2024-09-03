package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.CartService;

import java.io.IOException;

@WebServlet("/incDecQuantityServlet")
public class incDecQuantityServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CartService cartService;

    @Override
    public void init() {
        cartService = new CartService();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the session and retrieve the email attribute
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");

        // Retrieve form parameters
        int productId = Integer.parseInt(request.getParameter("id"));
        String action = request.getParameter("quantity");

        String result;
        if ("inc".equals(action)) {
            result = cartService.incrementQuantity(email, productId);
        } else if ("dec".equals(action)) {
            result = cartService.decrementQuantity(email, productId);
        } else {
            result = "error";
        }

        // Redirect based on the result
        if ("success".equals(result)) {
            response.sendRedirect("myCart.jsp?msg=" + action);
        } else if ("maxQuantityReached".equals(result)) {
            response.sendRedirect("myCart.jsp?msg=maxQuantity");
        } else if ("minQuantityReached".equals(result)) {
            response.sendRedirect("myCart.jsp?msg=minQuantity");
        } else {
            response.sendRedirect("myCart.jsp?msg=error");
        }
    }
}
