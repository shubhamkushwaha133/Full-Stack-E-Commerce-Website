<%@page import="util.ConnectionProvider" %>
<%@page import="java.sql.*" %>
<%@include file="header.jsp" %>
<%@page import="service.ProductService" %>
<%@page import="model.Product" %>
<%@page import="java.util.List" %>


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
        }
        .container {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background-color: #1c2833;
            border-radius: 8px;
        }
        .title {
            color: #ffcc00;
            text-align: center;
            font-size: 30px;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
       
        .btn-custom {
            background-color: white;
            color: red;
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
    <div class="title">Home <i class="fa fa-institution"></i></div>

    


<table>
        <thead>
            <tr>
                <th scope="col">ID</th>
                <th scope="col">Name</th>
                <th scope="col">Category</th>
                <th scope="col"><i class="fa fa-inr"></i> Price</th>
                <th scope="col">Image</th>
                <th scope="col">Add to Cart</th>
                
            </tr>
        </thead>
       <tbody>
                <% 
                    String search = request.getParameter("search");
                    ProductService productService = new ProductService();
                    List<Product> products = productService.searchProducts(search);
                    for (Product product : products) {
                %>
                <tr>
                    <td><%= product.getId() %></td>
                    <td><%= product.getName() %></td>
                    <td><%= product.getCategory() %></td>
                    <td><%= product.getPrice() %></td>
                    <td><img src="<%= product.getImagePath() %>" alt="Product Image" style="width: 100px; height: auto;"></td>
                    <td><a href="${pageContext.request.contextPath}/AddToCartServlet?id=<%= product.getId() %>" class="btn btn-custom" style="color:black;background-color:yellow;">
                    Add to Cart <i class='fas fa-cart-plus'></i></a></td>
                </tr>
                <% } %>
            </tbody>
    </table>
    

</div>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>

</body>
</html>
<%@include file="footer.jsp" %>







