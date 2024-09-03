package service;

import model.User;
import dao.UserDAO;

public class SignupService {

    private UserDAO userDAO = new UserDAO();

    public boolean registerUser(User user) {
        return userDAO.registerUser(user);
    }
}
