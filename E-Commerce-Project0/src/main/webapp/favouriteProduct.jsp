<%@ include file="header.jsp" %>
<%@page import="java.util.List" %>
<%@page import="model.Product" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Favorites</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body style="background-color: #283747 !important;">
    <div class="container">
        <h1 class="header" style="color:white;">Favorite Products <i class="fas fa-heart"></i></h1>

        <table class="table table-dark">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Category</th>
                    <th>Price</th>
                    <th>Image</th>
                    <th>Action</th>
                    <th>Add to Cart</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    List<Product> favoriteProducts = (List<Product>) request.getAttribute("favoriteProducts");
                    if (favoriteProducts != null) {
                        for (Product product : favoriteProducts) {
                %>
                    <tr>
                        <td><%= product.getId() %></td>
                        <td><%= product.getName() %></td>
                        <td><%= product.getCategory() %></td>
                        <td><%= product.getPrice() %></td>
                        <td><img src="<%= product.getImagePath() %>" alt="Product Image" width="100" height="100"/></td>
                        <td>
                            <a href="${pageContext.request.contextPath}/ToggleFavoriteServlet?productId=<%= product.getId() %>" class="btn btn-danger">
                                Remove <i class="fas fa-trash-alt"></i>
                            </a>
                        </td>
                        <td><a href="${pageContext.request.contextPath}/AddToCartServlet?id=<%= product.getId() %>" class="btn btn-custom" style="color:black;background-color:yellow;">
                    Add to Cart <i class='fas fa-cart-plus'></i></a></td>
                    </tr>
                    
                <% 
                        }
                    } 
                %>
            </tbody>
        </table>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>
