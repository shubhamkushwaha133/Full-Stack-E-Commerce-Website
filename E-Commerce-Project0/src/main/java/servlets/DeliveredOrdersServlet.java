package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import util.ConnectionProvider;

@WebServlet("/DeliveredOrdersServlet")
public class DeliveredOrdersServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        handleRequest(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        handleRequest(request, response);
    }

    private void handleRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        String email = request.getParameter("email");
        String status = "Delivered";

        try (Connection con = ConnectionProvider.getCon()) {
            String updateQuery = "UPDATE cart SET status=? WHERE product_id=? AND email=? AND address IS NOT NULL";
            try (PreparedStatement ps = con.prepareStatement(updateQuery)) {
                ps.setString(1, status);
                ps.setString(2, id);
                ps.setString(3, email);
                ps.executeUpdate();
            }
            response.sendRedirect("admin/ordersReceived.jsp?msg=delivered");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin/ordersReceived.jsp?msg=wrong");
        }
    }
}
