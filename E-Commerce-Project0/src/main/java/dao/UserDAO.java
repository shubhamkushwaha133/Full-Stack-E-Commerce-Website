package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.User;
import util.ConnectionProvider;

public class UserDAO {

   
    public boolean registerUser(User user) {
        boolean isRegistered = false;
        String query = "INSERT INTO users (name, email, mobileNumber, securityQuestion, answer, password, address, city, state, country, role) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = ConnectionProvider.getCon();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getMobileNumber());
            ps.setString(4, user.getSecurityQuestion());
            ps.setString(5, user.getAnswer());
            ps.setString(6, user.getPassword());
            ps.setString(7, user.getAddress());
            ps.setString(8, user.getCity());
            ps.setString(9, user.getState());
            ps.setString(10, user.getCountry());
            ps.setString(11, user.getRole());

            int rowsAffected = ps.executeUpdate();
            isRegistered = rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return isRegistered;
    }

    // Method to authenticate a user
    public User authenticateUser(String email, String password) {
        User user = null;
        String query = "SELECT * FROM users WHERE email = ? AND password = ?";

        try (Connection con = ConnectionProvider.getCon();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setString(1, email);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    user = new User();
                    user.setEmail(rs.getString("email"));
                    user.setPassword(rs.getString("password"));
                    user.setRole(rs.getString("role"));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }
}
