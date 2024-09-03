package service;

import java.util.List;
import dao.MessageDAO;
import model.Message;

public class MessageService {

    private MessageDAO messageDAO = new MessageDAO();

   
    public boolean saveMessage(Message message) {
        System.out.println("Service: Saving message with email = " + message.getEmail());
        boolean result = messageDAO.saveMessage(message);
        System.out.println("Service: Save result = " + result);
        return result;
    }

    
    public List<Message> getAllMessages() {
        System.out.println("Service: Fetching all messages");
        List<Message> messages = messageDAO.getAllMessages();
        System.out.println("Service: Retrieved " + (messages != null ? messages.size() : 0) + " messages");
        return messages;
    }
}
