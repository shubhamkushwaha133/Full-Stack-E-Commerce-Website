package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import util.ConnectionProvider;

@WebServlet("/ChangePasswordServlet")
public class ChangePasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve session and form data
        HttpSession session = request.getSession();
        String email = session.getAttribute("email").toString();
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Check if new password matches the confirmation password
        if (!confirmPassword.equals(newPassword)) {
            response.sendRedirect("changePassword.jsp?msg=notMatch");
            return;
        }

        int check = 0;

        try {
            // Establish a connection to the database
            Connection con = ConnectionProvider.getCon();
            // Create a statement
            Statement st = con.createStatement();
            // Execute SQL query to verify the current password
            ResultSet rs = st.executeQuery("SELECT * FROM users WHERE email='" + email + "' AND password='" + oldPassword + "'");

            // If the current password is correct, update to the new password
            if (rs.next()) {
                check = 1;
                st.executeUpdate("UPDATE users SET password='" + newPassword + "' WHERE email='" + email + "'");
                response.sendRedirect("changePassword.jsp?msg=done");
            }

            // If the current password is incorrect
            if (check == 0) {
                response.sendRedirect("changePassword.jsp?msg=wrong");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("changePassword.jsp?msg=error");
        }
    }
}
