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

@WebServlet("/ChangeSecurityQuestionServlet")
public class ChangeSecurityQuestionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String email = session.getAttribute("email").toString();
        String securityQuestion = request.getParameter("securityQuestion");
        String newAnswer = request.getParameter("newAnswer");
        String password = request.getParameter("password");

        int check = 0;

        try {
            // Establish a connection to the database
            Connection con = ConnectionProvider.getCon();
            // Create a statement
            Statement st = con.createStatement();
            // Execute the SQL query to verify the user
            ResultSet rs = st.executeQuery("SELECT * FROM users WHERE email='" + email + "' AND password='" + password + "'");

            // Check if the user is found and update the security question and answer
            if (rs.next()) {
                check = 1;
                st.executeUpdate("UPDATE users SET securityQuestion='" + securityQuestion + "', answer='" + newAnswer + "' WHERE email='" + email + "'");
                response.sendRedirect("changeSecurityQuestion.jsp?msg=done");
            }

            // If the password is incorrect
            if (check == 0) {
                response.sendRedirect("changeSecurityQuestion.jsp?msg=wrong");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("changeSecurityQuestion.jsp?msg=error");
        }
    }
}
