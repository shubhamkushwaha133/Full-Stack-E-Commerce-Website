package servlets;
import util.ConnectionProvider;
import model.Cart;
import service.CartService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        handleRequest(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        handleRequest(request, response);
    }

    private void handleRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        int productId = Integer.parseInt(request.getParameter("id"));
        int quantity = 1;

        CartService cartService = new CartService();
        Cart cart = cartService.getCartItem(email, productId);

        if (cart != null) {
            // Product already exists in cart, update it
            int newQuantity = cart.getQuantity() + 1;
            int newTotal = cart.getTotal() + cart.getPrice();
            cart.setQuantity(newQuantity);
            cart.setTotal(newTotal);
            boolean isUpdated = cartService.updateCart(cart);

            if (isUpdated) {
                response.sendRedirect("home.jsp?msg=exist");
            } else {
                response.sendRedirect("home.jsp?msg=error");
            }
        } else {
            // Product does not exist in cart, add it
            int productPrice = getProductPrice(productId);
            int productTotal = productPrice * quantity;

            cart = new Cart();
            cart.setEmail(email);
            cart.setProductId(productId);
            cart.setQuantity(quantity);
            cart.setPrice(productPrice);
            cart.setTotal(productTotal);

            boolean isAdded = cartService.addCart(cart);

            if (isAdded) {
                response.sendRedirect("home.jsp?msg=added");
            } else {
                response.sendRedirect("home.jsp?msg=error");
            }
        }
    }

    private int getProductPrice(int productId) {
        
        int price = 0;
        try (Connection con = ConnectionProvider.getCon();
             PreparedStatement ps = con.prepareStatement("SELECT price FROM product WHERE id = ?")) {
            ps.setInt(1, productId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    price = rs.getInt("price");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return price;
    }
}
