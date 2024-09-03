package service;

import model.User;
import dao.UserDAO;

public class LoginService {

    private UserDAO userDAO = new UserDAO();

    public User authenticateUser(String email, String password) {
        return userDAO.authenticateUser(email, password);
    }
}
