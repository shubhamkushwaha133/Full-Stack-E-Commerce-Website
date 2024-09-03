package servlets;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Message;
import service.MessageService;

@WebServlet("/MessageServlet")
public class MessageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        // Get the session and retrieve the email attribute
        HttpSession session = request.getSession();
        String email = session.getAttribute("email").toString();

        // Retrieve form parameters
        String subject = request.getParameter("subject");
        String body = request.getParameter("body");

        // Create a new message object
        Message message = new Message();
        message.setEmail(email);
        message.setSubject(subject);
        message.setBody(body);

        // Use the MessageService to save the message
        MessageService messageService = new MessageService();
        boolean isSaved = messageService.saveMessage(message);

        // Redirect based on the result of the save operation
        if (isSaved) {
            response.sendRedirect("messageUs.jsp?msg=valid");
        } else {
            response.sendRedirect("messageUs.jsp?msg=invalid");
        }
    }
}
