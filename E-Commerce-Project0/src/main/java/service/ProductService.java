package service;

import java.util.List;

import dao.ProductDAO;
import model.Product;

public class ProductService {
    private ProductDAO productDAO = new ProductDAO();

    public boolean addProduct(Product product) {
        return productDAO.addProduct(product);
    }

    public List<Product> getAllProducts() {
        return productDAO.getAllProducts();
    }

    
    public boolean updateProduct(Product product) {
        return productDAO.updateProduct(product);
    }
    
    public List<Product> searchProducts(String search) {
        return productDAO.searchProducts(search);
    }
    
    public List<Product> getActiveProducts() {
        return productDAO.getActiveProducts();
    }
    
   

}
