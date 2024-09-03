package servlets;
import model.Message;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.ResultSet;
import java.util.List;

import service.MessageService;

@WebServlet("/admin/MessageReceivedServlet")
public class MessageReceivedServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        MessageService messageService = new MessageService();
        List<Message> messages = messageService.getAllMessages();
        request.setAttribute("debugMessage", "Servlet is passing data to JSP!");

        if (messages == null || messages.isEmpty()) {
            System.out.println("No messages found in the servlet.");
        } else {
            System.out.println("Messages found in the servlet.");
            for (Message message : messages) {
                System.out.println("Message ID: " + message.getId());
                System.out.println("Email: " + message.getEmail());
                System.out.println("Subject: " + message.getSubject());
                System.out.println("Body: " + message.getBody());
                System.out.println("------");
            }
        }

        request.setAttribute("messages", messages);
        request.getRequestDispatcher("/admin/messagesReceived.jsp").forward(request, response);
    }
}
