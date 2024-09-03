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

@WebServlet("/ChangeMobileNumberServlet")
public class ChangeMobileNumberServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve session and form data
        HttpSession session = request.getSession();
        String email = session.getAttribute("email").toString();
        String mobileNumber = request.getParameter("mobileNumber");
        String password = request.getParameter("password");
        
        int check = 0;

        try {
            Connection con = ConnectionProvider.getCon();
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM users WHERE email='" + email + "' AND password='" + password + "'");
            if (rs.next()) {
                check = 1;
                st.executeUpdate("UPDATE users SET mobileNumber='" + mobileNumber + "' WHERE email='" + email + "'");
                response.sendRedirect("changeMobileNumber.jsp?msg=done");
            }

            // If the password is incorrect
            if (check == 0) {
                response.sendRedirect("changeMobileNumber.jsp?msg=wrong");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("changeMobileNumber.jsp?msg=error");
        }
    }
}
