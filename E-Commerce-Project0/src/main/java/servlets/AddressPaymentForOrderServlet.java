package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import util.ConnectionProvider;

@WebServlet("/AddressPaymentForOrderServlet")
public class AddressPaymentForOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        handleRequest(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        handleRequest(request, response);
    }

    private void handleRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String email = session.getAttribute("email").toString();
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String country = request.getParameter("country");
        String mobileNumber = request.getParameter("mobileNumber");
        String paymentMethod = request.getParameter("paymentMethod");
        String transactionId = request.getParameter("transactionId");
        String status = "bill";

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = ConnectionProvider.getCon();

            // Update user address details
            String updateUserQuery = "UPDATE users SET address=?, city=?, state=?, country=?, mobileNumber=? WHERE email=?";
            ps = con.prepareStatement(updateUserQuery);
            ps.setString(1, address);
            ps.setString(2, city);
            ps.setString(3, state);
            ps.setString(4, country);
            ps.setString(5, mobileNumber);
            ps.setString(6, email);
            ps.executeUpdate();
            ps.close();

            // Update cart details
            String updateCartQuery = "UPDATE cart SET address=?, city=?, state=?, country=?, mobileNumber=?, orderdate=NOW(), deliveryDate=DATE_ADD(orderdate, INTERVAL 7 DAY), paymentMethod=?, transactionId=?, status=? WHERE email=? AND address IS NULL";
            ps = con.prepareStatement(updateCartQuery);
            ps.setString(1, address);
            ps.setString(2, city);
            ps.setString(3, state);
            ps.setString(4, country);
            ps.setString(5, mobileNumber);
            ps.setString(6, paymentMethod);
            ps.setString(7, transactionId);
            ps.setString(8, status);
            ps.setString(9, email);
            ps.executeUpdate();
            ps.close();

            // Fetch the latest orderdate
            String fetchOrderDateQuery = "SELECT MAX(orderdate) AS latestOrderDate FROM cart WHERE email=? AND address IS NOT NULL";
            ps = con.prepareStatement(fetchOrderDateQuery);
            ps.setString(1, email);
            rs = ps.executeQuery();
            String latestOrderDate = null;
            if (rs.next()) {
                latestOrderDate = rs.getString("latestOrderDate");
            }
            rs.close();
            ps.close();

            // Update product quantities based on the latest orderdate
            if (latestOrderDate != null) {
                updateProductQuantities(con, email, latestOrderDate);
            }

            response.sendRedirect("bill.jsp");

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp"); // Redirect to an error page in case of an exception
        } finally {
            // Clean up resources
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    private void updateProductQuantities(Connection con, String email, String orderDate) throws SQLException {
        // Retrieve cart items for the user based on the latest orderdate
        String cartItemsQuery = "SELECT product_id, quantity FROM cart WHERE email=? AND orderdate=?";
        try (PreparedStatement ps = con.prepareStatement(cartItemsQuery)) {
            ps.setString(1, email);
            ps.setString(2, orderDate);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int productId = rs.getInt("product_id");
                    int orderedQuantity = rs.getInt("quantity");

                    // Update the product quantity in the product table
                    String updateProductQuery = "UPDATE product SET pquantity = pquantity - ? WHERE id=?";
                    try (PreparedStatement psUpdate = con.prepareStatement(updateProductQuery)) {
                        psUpdate.setInt(1, orderedQuantity);
                        psUpdate.setInt(2, productId);
                        psUpdate.executeUpdate();
                    }
                }
            }
        }
    }
}
