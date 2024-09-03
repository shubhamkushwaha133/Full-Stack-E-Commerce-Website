package service;

import dao.CartDAO;
import model.Cart;

import java.sql.SQLException;
import java.util.List;

public class CartService {
    private CartDAO cartDAO;

    public CartService() {
        this.cartDAO = new CartDAO();
    }
    
    public List<Cart> getOrdersByUser(String email) {
        return cartDAO.getOrdersByUser(email);
    }
    
    public Cart getCartItem(String email, int productId) {
        try {
            return cartDAO.getCartItem(email, productId);
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public boolean updateCart(Cart cart) {
        try {
            return cartDAO.updateCart(cart);
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean addCart(Cart cart) {
        try {
            return cartDAO.addCart(cart);
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Increment the quantity of a product in the cart
    public String incrementQuantity(String email, int productId) {
        try {
            Cart cart = cartDAO.getCartItem(email, productId);
            int maxQuantity = cartDAO.getProductQuantity(productId);

            if (cart == null) {
                return "error"; // Cart item not found
            }

            if (cart.getQuantity() < maxQuantity) {
                cart.setQuantity(cart.getQuantity() + 1);
                cart.setTotal(cart.getTotal() + cart.getPrice());
                if (cartDAO.updateCart(cart)) {
                    return "success";
                }
            }
            return "maxQuantityReached";
        } catch (SQLException e) {
            e.printStackTrace();
            return "error";
        }
    }

    // Decrement the quantity of a product in the cart
    public String decrementQuantity(String email, int productId) {
        try {
            Cart cart = cartDAO.getCartItem(email, productId);

            if (cart == null) {
                return "error"; // Cart item not found
            }

            if (cart.getQuantity() > 1) {
                cart.setQuantity(cart.getQuantity() - 1);
                cart.setTotal(cart.getTotal() - cart.getPrice());
                if (cartDAO.updateCart(cart)) {
                    return "success";
                }
            } else {
                return "minQuantityReached"; // Can't decrement below 1
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return "error";
        }
        return "error";
    }
}
