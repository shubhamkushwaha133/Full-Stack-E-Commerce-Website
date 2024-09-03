package servlets;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import service.LoginService;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form parameters
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Create an instance of LoginService
        LoginService loginService = new LoginService();
        
        // Authenticate the user
        User user = loginService.authenticateUser(email, password);

        if (user != null) {
            // User authenticated successfully
            HttpSession session = request.getSession();
            session.setAttribute("email", user.getEmail());
            if ("seller".equalsIgnoreCase(user.getRole())) {
                // Redirect to admin page if the user is a seller
                response.sendRedirect("admin/adminHome.jsp");
            } else {
                // Redirect to home page if the user is a buyer
                response.sendRedirect("home.jsp");
            }
        } else {
            // Authentication failed
            response.sendRedirect("login.jsp?msg=notexist");
        }
    }
}
