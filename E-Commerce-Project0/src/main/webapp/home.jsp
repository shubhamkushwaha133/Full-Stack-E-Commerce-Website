<%@page import="util.ConnectionProvider" %>
<%@page import="java.sql.*" %>
<%@include file="header.jsp" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>
<%@ page import="service.ProductService" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background-color: #283747;
            color: #fff;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        .header {
            color: #ffcc00;
            text-align: center;
            font-size: 30px;
            margin: 20px 0;
        }
        .alert {
            color: #ffcc00;
            background-color: #17202a;
            text-align: center;
            font-weight: bold;
            padding: 10px;
            border-radius: 5px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px auto;
        }
        th, td {
            padding: 15px;
            text-align: center;
            border: 1px solid #ddd;
            color: #fff; /* Text color for table cells */
        }
        th {
            background-color: #17202a; /* Dark background for headers */
        }
        tbody tr:nth-child(even) {
            background-color: #1c2833; /* Dark background for alternate rows */
        }
        tbody tr:nth-child(odd) {
            background-color: #2c3e50; /* Slightly lighter background for odd rows */
        }
        td img {
            border-radius: 5px;
        }
        a {
            color: #ffcc00;
            text-decoration: none;
            font-weight: bold;
        }
        a:hover {
            text-decoration: underline;
            color: #f1c40f;
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
    </style>
</head>
<body>
    <div class="container">
        <div class="header">Home <i class="fa fa-institution"></i></div>

        <%
        String msg = request.getParameter("msg");
                if ("added".equals(msg)) {
        %>
            <div class="alert">Product added successfully!</div>
        <%
        } else if ("notAvailable".equals(msg)) {
        %>
            <div class="alert">Product quantity not available!</div>
        <%
        } else if ("exist".equals(msg)) {
        %>
            <div class="alert">Product already exists in your cart! Quantity increased!</div>
        <%
        } else if ("invalid".equals(msg)) {
        %>
            <div class="alert">Something went wrong! Try Again!</div>
        <%
        }
        %> 
    
    <table class="table table-dark">
    <thead>
        <tr>
            <th scope="col">ID</th>
            <th scope="col">Name</th>
            <th scope="col">Category</th>
            <th scope="col">Description</th>
            <th scope="col">Quantity</th>
            <th scope="col"><i class="fa fa-inr"></i> Price</th>
            <th scope="col">Image</th>
            <th scope="col">Add to Cart <i class='fas fa-cart-plus'></i></th>
        </tr>
    </thead>
    <tbody>
    <%
        ProductService productService = new ProductService();
        List<Product> products = productService.getActiveProducts(); // Use the new method here
        for (Product product : products) {
    %>
        <tr>
            <td><%= product.getId() %></td>
            <td><%= product.getName() %></td>
            <td><%= product.getCategory() %></td>
            <td><%= product.getDetails() %></td>
            <td><%= product.getPquantity() %></td>
            <td><i class="fa fa-inr"></i> <%= product.getPrice() %></td>
            <td><img src="<%= product.getImagePath() %>" alt="Product Image" width="100" height="100" /></td>
            <td><a href="${pageContext.request.contextPath}/AddToCartServlet?id=<%= product.getId() %>" class="btn btn-custom">Add to Cart <i class='fas fa-cart-plus'></i></a></td>
            <td>
                <a href="${pageContext.request.contextPath}/ToggleFavoriteServlet?productId=<%= product.getId() %>" 
                   class="favorite-icon <%= product.isFavorites() ? "active" : "" %>">
                    <i class="fas fa-heart"></i>
                </a>
            </td>
        </tr>
    <%
        }
    %>
    </tbody>
</table>
    
    
    </div>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>
