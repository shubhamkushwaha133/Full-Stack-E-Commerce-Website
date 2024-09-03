<%@page import="util.ConnectionProvider" %>
<%@page import="java.sql.*" %>
<%@include file="adminHeader.jsp" %>
<%@page import="model.Product" %>
<%@page import="service.ProductService" %>
<%@page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Products & Edit Products</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background-color: #283747;
            color: #fff;
            font-family: Arial, sans-serif;
        }
        .page-title {
            color: #ffcc00;
            text-align: center;
            font-size: 30px;
            margin-bottom: 20px;
        }
        .alert {
            color: #ffcc00;
            font-weight: bold;
            text-align: center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
        .edit-icon {
            color: #007bff;
        }
        .product-image {
            width: 100px; /* Adjust as needed */
            height: auto;
        }
        .btn-custom {
            background-color: #ffcc00;
            color: #000;
            border: none;
        }
        .btn-custom:hover {
            background-color: #f1c40f;
            color: #fff;
        }
        .table-dark {
            background-color: #1c2833;
        }
        .table-dark th, .table-dark td {
            border-color: #ddd;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="page-title">All Products & Edit Products <i class='fab fa-elementor'></i></div>

        <%
        String msg = request.getParameter("msg");
        if ("done".equals(msg)) {
        %>
            <div class="alert alert-success" role="alert" style="color:black;">Product Successfully Updated!</div>
        <%} else if ("wrong".equals(msg)) { %>
            <div class="alert alert-danger" role="alert" style="color:black;">Something went wrong! Try again!</div>
        <%} %>

        <table class="table table-dark">
            <thead>
                <tr>
                    <th scope="col">ID</th>
                    <th scope="col">Name</th>
                    <th scope="col">Category</th>
                    <th scope="col">Description</th>
                    <th scope="col">Quantity</th>
                    <th scope="col">Price</th>
                    <th scope="col">Status</th>
                    <th scope="col">Image</th> <!-- New Column for Image -->
                    <th scope="col">Edit</th>
                </tr>
            </thead>
            <tbody>
         <%
            ProductService productService = new ProductService();
            List<Product> products = productService.getAllProducts();

            for (Product product : products) {
                String imageUrl = (product.getImagePath() != null && !product.getImagePath().isEmpty()) ? product.getImagePath() : "img/default-image.jpg";
                // Correcting image path by adding the context path
                String contextPath = request.getContextPath();
                String fullImageUrl = contextPath + "/" + imageUrl;
            %>
                <tr>
                    <td><%= product.getId() %></td>
                    <td><%= product.getName() %></td>
                    <td><%= product.getCategory() %></td>
                    <td><%= product.getDetails() %></td>
                    <td><%= product.getPquantity() %></td>
                    <td><%= product.getPrice() %></td>
                    <td><%= product.getActive() %></td>
                    <td><img src="<%= fullImageUrl %>" alt="Product Image" style="width:90px;height:80px;"></td>
                    <td><a href="editProduct.jsp?id=<%= product.getId() %>" class="btn btn-primary">Edit</a></td>
                </tr>
            <% } %>
            
            </tbody>
        </table>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html> 
