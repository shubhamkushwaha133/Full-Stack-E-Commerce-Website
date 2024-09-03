package servlets;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;
import service.SignupService;

@WebServlet("/SignupServlet")
public class SignupServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form parameters
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String mobileNumber = request.getParameter("mobileNumber");
        String securityQuestion = request.getParameter("securityQuestion");
        String answer = request.getParameter("answer");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        // Default values for address
        String address = "";
        String city = "";
        String state = "";
        String country = "";

        // Create a User object
        User user = new User(name, email, mobileNumber, securityQuestion, answer, password, role, address, city, state, country);

        // Call the UserService to handle the business logic
        SignupService userService = new SignupService();
        boolean isSuccess = userService.registerUser(user);

        if (isSuccess) {
            // Redirect to the signup page with a success message
            response.sendRedirect("signup.jsp?msg=valid");
        } else {
            // Redirect to the signup page with an error message
            response.sendRedirect("signup.jsp?msg=invalid");
        }
    }
}
