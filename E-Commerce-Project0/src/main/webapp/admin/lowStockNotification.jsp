<%@page import="model.Product" %>
<%@page import="java.util.List" %>
<%@include file="adminHeader.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Low Stock Notification</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #283747 !important;
            margin: 0;
            padding: 20px;
        }
        .container {
            width: 80%;
            margin: 0 auto;
        }
        .notification {
            background-color: #283747;
            border: 1px solid #f5c6cb;
            padding: 15px;
            border-radius: 5px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
            color:white;
        }
        th {
            background-color: #17202a;
            color:white;
        }
        .message {
            color: red;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1 style="margin-top:15px; color:white;">Low Stock Notification</h1>
        <div class="notification">
            <p class="message">Products with stock less than the threshold value:</p>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Quantity</th>
                        <th>Price</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        List<Product> lowStockProducts = (List<Product>) request.getAttribute("lowStockProducts");
                        if (lowStockProducts != null && !lowStockProducts.isEmpty()) {
                            for (Product product : lowStockProducts) {
                    %>
                        <tr>
                            <td><%= product.getId() %></td>
                            <td><%= product.getName() %></td>
                            <td><%= product.getPquantity() %></td>
                            <td><%= product.getPrice() %></td>
                        </tr>
                    <% 
                            }
                        } else { 
                    %>
                        <tr>
                            <td colspan="4">No products are below the threshold.</td>
                        </tr>
                    <% 
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
