package dao;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import model.Cart;
import util.ConnectionProvider;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Product;

public class CartDAO {
	private static final Logger logger = LogManager.getLogger(CartDAO.class);


    public Cart getCartItem(String email, int productId) throws SQLException {
        Cart cart = null;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = ConnectionProvider.getCon();
            String query = "SELECT * FROM cart WHERE email = ? AND product_id = ? AND address IS NULL";
            ps = con.prepareStatement(query);
            ps.setString(1, email);
            ps.setInt(2, productId);
            rs = ps.executeQuery();

            if (rs.next()) {
                cart = new Cart();
                cart.setEmail(rs.getString("email"));
                cart.setProductId(rs.getInt("product_id"));
                cart.setQuantity(rs.getInt("quantity"));
                cart.setPrice(rs.getInt("price"));
                cart.setTotal(rs.getInt("total"));
            }
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        }
        return cart;
    }

    public boolean updateCart(Cart cart) throws SQLException {
        Connection con = null;
        PreparedStatement ps = null;
        int result = 0;

        try {
            con = ConnectionProvider.getCon();
            String query = "UPDATE cart SET quantity = ?, total = ? WHERE email = ? AND product_id = ? AND address IS NULL";
            ps = con.prepareStatement(query);
            ps.setInt(1, cart.getQuantity());
            ps.setInt(2, cart.getTotal());
            ps.setString(3, cart.getEmail());
            ps.setInt(4, cart.getProductId());
            result = ps.executeUpdate();
        } finally {
            if (ps != null) ps.close();
            if (con != null) con.close();
        }

        return result > 0;
    }

    public boolean addCart(Cart cart) throws SQLException {
        Connection con = null;
        PreparedStatement ps = null;
        int result = 0;

        try {
            con = ConnectionProvider.getCon();
            String query = "INSERT INTO cart (email, product_id, quantity, price, total) VALUES (?, ?, ?, ?, ?)";
            ps = con.prepareStatement(query);
            ps.setString(1, cart.getEmail());
            ps.setInt(2, cart.getProductId());
            ps.setInt(3, cart.getQuantity());
            ps.setInt(4, cart.getPrice());
            ps.setInt(5, cart.getTotal());
            result = ps.executeUpdate();
        } finally {
            if (ps != null) ps.close();
            if (con != null) con.close();
        }

        return result > 0;
    }

    
    public int getProductQuantity(int productId) throws SQLException {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        int quantity = 0;

        try {
            con = ConnectionProvider.getCon();
            String query = "SELECT pquantity FROM product WHERE id = ?";
            ps = con.prepareStatement(query);
            ps.setInt(1, productId);
            rs = ps.executeQuery();

            if (rs.next()) {
                quantity = rs.getInt("pquantity");
            }
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        }
        return quantity;
    }
     
    public List<Cart> getOrdersByUser(String email) {
        List<Cart> orders = new ArrayList<>();
        logger.info("Retrieving orders for email: {}", email);
        try (Connection con = ConnectionProvider.getCon()) {
            String query = "SELECT c.*, p.name AS productName, p.category AS productCategory, p.price AS productPrice, p.image_path AS productImage " +
                           "FROM cart c " +
                           "INNER JOIN product p ON c.product_id = p.id " +
                           "WHERE c.email = ? AND c.orderdate IS NOT NULL";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, email);

            

            ResultSet rs = ps.executeQuery();

            if (!rs.isBeforeFirst()) {
                System.out.println("No results found for email: " + email); 
            }

            while (rs.next()) {
                Cart order = new Cart();
                order.setEmail(rs.getString("email"));
                order.setProductId(rs.getInt("product_id")); 
                order.setQuantity(rs.getInt("quantity"));
                order.setPrice(rs.getInt("productPrice"));
                order.setTotal(rs.getInt("total"));
                order.setAddress(rs.getString("address"));
                order.setCity(rs.getString("city"));
                order.setState(rs.getString("state"));
                order.setCountry(rs.getString("country"));
                order.setMobileNumber(rs.getLong("mobileNumber"));
                order.setOrderDate(rs.getString("orderDate"));
                order.setDeliveryDate(rs.getString("deliveryDate"));
                order.setPaymentMethod(rs.getString("paymentMethod"));
                order.setTransactionId(rs.getString("transactionId"));
                order.setStatus(rs.getString("status"));

                
                Product product = new Product();
                product.setId(rs.getInt("product_id")); 
                product.setName(rs.getString("productName"));
                product.setCategory(rs.getString("productCategory"));
                product.setPrice(rs.getInt("productPrice"));
                product.setImagePath(rs.getString("productImage"));

                order.setProduct(product);

                orders.add(order);
            }

            

        } catch (Exception e) {
            e.printStackTrace();
        }
        return orders;
    }

    
    
}
