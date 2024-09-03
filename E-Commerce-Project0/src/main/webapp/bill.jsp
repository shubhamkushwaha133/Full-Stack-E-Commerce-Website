<%@page import="util.ConnectionProvider" %>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bill Invoice</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/bill.css">
    <style>
        body {
            background-color: #f8f9fa;
            color: #212529;
        }
        .container {
            margin-top: 20px;
        }
        .header, .footer {
            margin-top: 25px;
            text-align: center;
        }
        
        .table thead th {
            background-color: #343a40;
            color: #fff;
        }
        .table td, .table th {
            vertical-align: middle;
        }
        .button {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
        }
        .button:hover {
            background-color: green;
            color:white;
        }
        .left-div, .right-div {
            margin-bottom: 15px;
        }
        .left-div {
            float: left;
            width: 48%;
        }
        .right-div {
            float: right;
            width: 48%;
        }
    </style>
</head>
<body>

<div class="container">
    <%
    String email = session.getAttribute("email").toString();
    try {
        int total = 0;
        int sno = 0;
        Connection con = ConnectionProvider.getCon();
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("SELECT SUM(total) FROM cart WHERE email='" + email + "' AND status='bill'");
        while (rs.next()) {
            total = rs.getInt(1);
        }
        ResultSet rs2 = st.executeQuery("SELECT * FROM users INNER JOIN cart ON users.email = cart.email WHERE cart.email='" + email + "' AND cart.status='bill'");
        while (rs2.next()) {
    %>
    <div class="header">
        <h2>Online Shopping Bill</h2>
        <hr>
    </div>
    <div class="row">
        <div class="col-md-6 left-div">
            <h5>Name: <%= rs2.getString(1) %></h5>
            <h5>Order Date: <%= rs2.getString(22) %></h5>
            <h5>Transaction Id: <%= rs2.getString(25) %></h5>
            <h5>State: <%= rs2.getString(19) %></h5>
        </div>
        <div class="col-md-6 right-div">
            <h5>Email: <% out.println(email); %></h5>
            <h5>Payment Method: <%= rs2.getString(24) %></h5>
            <h5>Expected Delivery: <%= rs2.getString(23) %></h5>
            <h5>City: <%= rs2.getString(18) %></h5>
            <h5>Address: <%= rs2.getString(17) %></h5>
            <h5>Country: <%= rs2.getString(20) %></h5>
            <h5>Mobile Number: <%= rs2.getString(3) %></h5>
        </div>
    </div>
    <hr>
   
    <h3>Product Details</h3>
    
    <table class="table table-striped table-bordered">
        <thead>
            <tr>
                <th>S.No</th>
                <th>Product Name</th>
                <th>Category</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Sub Total</th>
            </tr>
        </thead>
        <tbody>
        <%
            ResultSet rs1 = st.executeQuery("SELECT * FROM cart INNER JOIN product ON cart.product_id = product.id WHERE cart.email='" + email + "' AND cart.status='bill'");
            while (rs1.next()) {
                sno = sno + 1;
        %>
            <tr>
                <td><%= sno %></td>
                <td><%= rs1.getString(17) %></td>
                <td><%= rs1.getString(18) %></td>
                <td><%= rs1.getString(19) %></td>
                <td><%= rs1.getString("quantity") %></td>
                <td><%= rs1.getString("total") %></td>
            </tr>
        <% } %>
        </tbody>
    </table>
     <h3 style="margin-bottom: 80px;">Total: <%= total %></h3>

    <div class="footer">
        <a href="continueShopping.jsp"><button class="button">Continue Shopping</button></a>
        <a onclick="window.print();"><button class="button">Print</button></a>
    </div>
    <%
        }
    } catch (Exception e) {
        System.out.println(e);
    }
    %>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>

