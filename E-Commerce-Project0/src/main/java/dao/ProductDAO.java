package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.Product;
import util.ConnectionProvider;

public class ProductDAO {

    public boolean addProduct(Product product) {
        boolean isAdded = false;
        try {
            Connection con = ConnectionProvider.getCon();
            PreparedStatement ps = con.prepareStatement("INSERT INTO product(id, name, category, price, active, details, pquantity, image_path) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
            ps.setInt(1, product.getId());
            ps.setString(2, product.getName());
            ps.setString(3, product.getCategory());
            ps.setInt(4, product.getPrice());
            ps.setString(5, product.getActive());
            ps.setString(6, product.getDetails());
            ps.setInt(7, product.getPquantity());
            ps.setString(8, product.getImagePath());
            isAdded = ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isAdded;
    }

    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        try {
            Connection con = ConnectionProvider.getCon();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM product");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setCategory(rs.getString("category"));
                product.setPrice(rs.getInt("price"));
                product.setActive(rs.getString("active"));
                product.setImagePath(rs.getString("image_path"));
                product.setFavorites(rs.getBoolean("favorites"));
                product.setPquantity(rs.getInt("pquantity"));
                product.setDetails(rs.getString("details"));
                products.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }

   
    
    public boolean updateProduct(Product product) {
        try (Connection con = ConnectionProvider.getCon()) {
            String query = "UPDATE product SET name=?, category=?, price=?, active=?, details=?, pquantity=?";
            if (product.getImagePath() != null) {
                query += ", image_path=?";
            }
            query += " WHERE id=?";

            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, product.getName());
            ps.setString(2, product.getCategory());
            ps.setDouble(3, product.getPrice());
            ps.setString(4, product.getActive());
            ps.setString(5, product.getDetails());
            ps.setInt(6, product.getPquantity());
            if (product.getImagePath() != null) {
                ps.setString(7, product.getImagePath());
                ps.setInt(8, product.getId());
            } else {
                ps.setInt(7, product.getId());
            }

            int result = ps.executeUpdate();
            return result > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<Product> searchProducts(String search) {
        List<Product> products = new ArrayList<>();
        try {
            Connection con = ConnectionProvider.getCon();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM product WHERE (name LIKE ? OR category LIKE ?) AND active='Yes'");
            ps.setString(1, "%" + search + "%");
            ps.setString(2, "%" + search + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setCategory(rs.getString("category"));
                product.setPrice(rs.getInt("price"));
                product.setImagePath(rs.getString("image_path"));
                products.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }

    
    public List<Product> getFavoriteProductsByUser(String userEmail) {
        List<Product> products = new ArrayList<>();
        try (Connection con = ConnectionProvider.getCon()) {
            String query = "SELECT p.* FROM product p INNER JOIN favorites f ON p.id = f.product_id WHERE f.user_email = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, userEmail);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setCategory(rs.getString("category"));
                product.setPrice(rs.getInt("price"));
                product.setImagePath(rs.getString("image_path"));
                products.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }

    public boolean toggleFavorite(String userEmail, int productId) {
        try (Connection con = ConnectionProvider.getCon()) {
            String query = "SELECT * FROM favorites WHERE user_email = ? AND product_id = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, userEmail);
            ps.setInt(2, productId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // Remove from favorites
                String deleteQuery = "DELETE FROM favorites WHERE user_email = ? AND product_id = ?";
                ps = con.prepareStatement(deleteQuery);
                ps.setString(1, userEmail);
                ps.setInt(2, productId);
                ps.executeUpdate();
                return false;
            } else {
                // Add to favorites
                String insertQuery = "INSERT INTO favorites(user_email, product_id) VALUES (?, ?)";
                ps = con.prepareStatement(insertQuery);
                ps.setString(1, userEmail);
                ps.setInt(2, productId);
                ps.executeUpdate();
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<Product> getActiveProducts() {
        List<Product> products = new ArrayList<>();
        try {
            Connection con = ConnectionProvider.getCon();
            // Query to fetch only active products for users
            PreparedStatement ps = con.prepareStatement("SELECT * FROM product WHERE active='Yes'");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setCategory(rs.getString("category"));
                product.setPrice(rs.getInt("price"));
                product.setActive(rs.getString("active"));
                product.setImagePath(rs.getString("image_path"));
                product.setFavorites(rs.getBoolean("favorites"));
                product.setPquantity(rs.getInt("pquantity"));
                product.setDetails(rs.getString("details"));
                products.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }

    

    
}
