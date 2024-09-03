package model;

public class Favorites {
    private int id;
    private String userEmail;
    private int productId;

    // Constructors
    public Favorites() {}

    public Favorites(int id, String userEmail, int productId) {
        this.id = id;
        this.userEmail = userEmail;
        this.productId = productId;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }  
}
