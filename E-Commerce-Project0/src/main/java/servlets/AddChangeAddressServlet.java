package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import util.ConnectionProvider;

@WebServlet("/AddChangeAddressServlet")
public class AddChangeAddressServlet extends HttpServlet {
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

        try (Connection con = ConnectionProvider.getCon()) {
            String updateUserQuery = "UPDATE users SET address=?, city=?, state=?, country=? WHERE email=?";
            try (PreparedStatement ps = con.prepareStatement(updateUserQuery)) {
                ps.setString(1, address);
                ps.setString(2, city);
                ps.setString(3, state);
                ps.setString(4, country);
                ps.setString(5, email);
                ps.executeUpdate();
            }

            response.sendRedirect("addChangeAddress.jsp?msg=valid");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("addChangeAddress.jsp?msg=invalid");
        }
    }
}
