package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Message;
import util.ConnectionProvider;

public class MessageDAO {

   
    public boolean saveMessage(Message message) {
        boolean isSaved = false;
        String query = "INSERT INTO message (email, subject, body) VALUES (?, ?, ?)";
        try (Connection con = ConnectionProvider.getCon();
             PreparedStatement ps = con.prepareStatement(query)) {

            System.out.println("DAO: Preparing to save message with email = " + message.getEmail());

        
            ps.setString(1, message.getEmail());
            ps.setString(2, message.getSubject());
            ps.setString(3, message.getBody());

          
            int rowsAffected = ps.executeUpdate();
            isSaved = rowsAffected > 0;
            System.out.println("DAO: Save result = " + isSaved);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return isSaved;
    }

    
    public List<Message> getAllMessages() {
        List<Message> messages = new ArrayList<>();
        String query = "SELECT * FROM message";
        try (Connection con = ConnectionProvider.getCon();
             PreparedStatement ps = con.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Message message = new Message();
                message.setId(rs.getInt("id"));
                message.setEmail(rs.getString("email"));
                message.setSubject(rs.getString("subject"));
                message.setBody(rs.getString("body"));
                messages.add(message);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return messages;
    }

}
