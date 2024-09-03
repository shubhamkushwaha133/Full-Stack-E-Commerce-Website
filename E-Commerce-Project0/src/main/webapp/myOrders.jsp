<%@page import="util.ConnectionProvider" %>
<%@page import="java.sql.*" %>
<%@include file="header.jsp" %>
<%@page import="service.ProductService" %>
<%@page import="model.Cart" %>
<%@page import="java.util.List" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Home</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #283747 !important;
        margin: 0;
        padding: 0;
    }
    .header {
        color: #17202a;
        text-align: center;
        font-size: 30px;
        margin: 20px 0;
        color:white;
    }
    table {
        width: 80%;
        margin: 20px auto;
        border-collapse: collapse;
        background-color: #17202a; /* Background color applied */
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        color: white; /* Text color changed to white for better contrast */
    }
    th, td {
        padding: 15px;
        text-align: center;
        border-bottom: 1px solid #ddd;
        background-color: white;
        color:black !important;
    }
    th {
        background-color: #2c3e50;
        color:white;
    }
    td img {
        border-radius: 5px;
    }
    tr:hover {
        background-color: green; /* Slightly lighter background on hover */
    }
    a {
        color: #3498db;
        text-decoration: none;
        font-weight: bold;
    }
    a:hover {
        text-decoration: underline;
    }
</style>
</head>
<body>

<div class="header">My Orders <i class='fab fa-elementor'></i></div>

<table>
    <thead>
        <tr>
            <th scope="col" style="color:white !important;">S.No</th>
            <th scope="col" style="color:white !important;">Product Name</th>
            <th scope="col" style="color:white !important;">Category</th>
            <th scope="col" style="color:white !important;"><i class="fa fa-inr"></i> Price</th>
            <th scope="col" style="color:white !important;">Quantity</th>
            <th scope="col" style="color:white !important;"><i class="fa fa-inr"></i> Sub Total</th>
            <th scope="col" style="color:white !important;">Order Date</th>
            <th scope="col" style="color:white !important;">Expected Delivery Date</th>
            <th scope="col" style="color:white !important;">Payment Method</th>
            <th scope="col" style="color:white !important;">Status</th>
        </tr>
    </thead>
<tbody>
<%
    List<Cart> orders = (List<Cart>) request.getAttribute("orders");
    if (orders == null || orders.isEmpty()) {
        out.println("<tr><td colspan='10' style='color:white;'>No orders found.</td></tr>"); // Debugging - No orders found
    } else {
        int sno = 0;
        for (Cart order : orders) {
            sno++;
%>
            <tr>
                <td><%= sno %></td>
                <td><%= order.getProduct().getName() %></td>
                <td><%= order.getProduct().getCategory() %></td>
                <td><i class="fa fa-inr"></i> <%= order.getProduct().getPrice() %></td>
                <td><%= order.getQuantity() %></td>
                <td><i class="fa fa-inr"></i> <%= order.getTotal() %></td>
                <td><%= order.getOrderDate() %></td>
                <td><%= order.getDeliveryDate() %></td>
                <td><%= order.getPaymentMethod() %></td>
                <td><%= order.getStatus() %></td>
            </tr>
<%
        }
    }
%>
</tbody>

</table>


<br><br><br>

</body>
</html>
