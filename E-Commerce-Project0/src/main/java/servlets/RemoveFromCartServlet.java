package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import util.ConnectionProvider;

@WebServlet("/RemoveFromCartServlet")
public class RemoveFromCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

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

        // Retrieve the product ID from the request parameters
        String productId = request.getParameter("id");

        // Initialize the result message
        String message = "error";

        // Perform the deletion operation
        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = ConnectionProvider.getCon();
            String query = "DELETE FROM cart WHERE email = ? AND product_id = ? AND address IS NULL";
            ps = con.prepareStatement(query);
            ps.setString(1, email);
            ps.setString(2, productId);

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                message = "removed";
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        // Redirect to the myCart.jsp page with the result message
        response.sendRedirect("myCart.jsp?msg=" + message);
    }
}
