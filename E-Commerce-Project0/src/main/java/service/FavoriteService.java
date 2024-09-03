package service;

import java.util.List;
import dao.ProductDAO;
import model.Product;

public class FavoriteService {
    private ProductDAO productDAO = new ProductDAO();

    public List<Product> getFavoriteProducts(String userEmail) {
        return productDAO.getFavoriteProductsByUser(userEmail);
    }

    public boolean toggleFavorite(String userEmail, int productId) {
        return productDAO.toggleFavorite(userEmail, productId);
    }
}
