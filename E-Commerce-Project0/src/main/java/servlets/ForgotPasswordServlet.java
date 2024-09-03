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
import util.ConnectionProvider;

@WebServlet("/ForgotPasswordServlet")
public class ForgotPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String mobileNumber = request.getParameter("mobileNumber");
        String securityQuestion = request.getParameter("securityQuestion");
        String answer = request.getParameter("answer");
        String newPassword = request.getParameter("newPassword");

        int check = 0;

        try {
            // Establish a connection to the database
            Connection con = ConnectionProvider.getCon();
            // Create a statement
            Statement st = con.createStatement();
            // Execute the SQL query
            ResultSet rs = st.executeQuery("SELECT * FROM users WHERE email='" + email + "' AND mobileNumber='" + mobileNumber + "' AND securityQuestion='" + securityQuestion + "' AND answer='" + answer + "'");

            // Check if the user is found
            while (rs.next()) {
                check = 1;
                // Update the password
                st.executeUpdate("UPDATE users SET password='" + newPassword + "' WHERE email='" + email + "'");
                response.sendRedirect("forgotPassword.jsp?msg=done");
            }

            // If no matching record is found
            if (check == 0) {
                response.sendRedirect("forgotPassword.jsp?msg=invalid");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("forgotPassword.jsp?msg=error");
        }
    }
}
