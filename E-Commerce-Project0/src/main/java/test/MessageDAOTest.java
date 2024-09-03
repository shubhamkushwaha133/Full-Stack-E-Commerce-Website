package test;  

import dao.MessageDAO;
import model.Message;
import java.util.List;

public class MessageDAOTest {

    public static void main(String[] args) {
        MessageDAO dao = new MessageDAO();
        List<Message> messages = dao.getAllMessages();
        
        if (messages.isEmpty()) {
            System.out.println("No messages found in the database.");
        } else {
            for (Message message : messages) {
                System.out.println("Message ID: " + message.getId());
                System.out.println("Email: " + message.getEmail());
                System.out.println("Subject: " + message.getSubject());
                System.out.println("Body: " + message.getBody());
                System.out.println("------");
            }
        }
    }
}
