<%@page import="util.ConnectionProvider" %>
<%@page import="java.sql.*" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

<!DOCTYPE html>
<html>
<head>
    <title>Order Receipt</title>
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
    <style>
        body {
            background-color: #17202a;
            color: #fff;
        }
        .container {
            margin-top: 20px;
        }
        .table th, .table td {
            vertical-align: middle;
        }
        .table thead th {
            background-color: #343a40;
            color: #fff;
        }
        .table tfoot th {
            background-color: yellow;
            color: #343a40;
        }
        .input-style {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        .button {
            background-color: #28a745;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 10px;
        }
        .button:hover {
            background-color: #218838;
        }
        .left-div, .right-div {
            width: 48%;
            float: left;
            margin: 1%;
        }
    </style>
</head>
<body>

<div class="container">
    <%
    String email = session.getAttribute("email").toString();
    int total = 0;
    int sno = 0;
    try {
        Connection con = ConnectionProvider.getCon();
        Statement st = con.createStatement();
        ResultSet rs1 = st.executeQuery("select sum(total) from cart where email='" + email + "' and address is null ");
        while (rs1.next()) {
            total = rs1.getInt(1);
        }
    %>
    <div class="row">
        <div class="col-md-6">
            <a href="myCart.jsp" class="btn btn-warning"><i class='fas fa-arrow-circle-left'></i> Back</a>
        </div>
        <div class="col-md-6 text-right">
            <h4>Total: <i class="fa fa-inr"></i> <%= total %></h4>
        </div>
    </div>
    <table class="table table-dark table-striped mt-4">
        <thead>
            <tr>
                <th>S.No</th>
                <th>Product Name</th>
                <th>Category</th>
                <th><i class="fa fa-inr"></i> Price</th>
                <th>Quantity</th>
                <th>Sub Total</th>
            </tr>
        </thead>
        <tbody>
        <%
            ResultSet rs = st.executeQuery("select * from product inner join cart on product.id=cart.product_id and cart.email='" + email + "' and cart.address is null "); 
            while (rs.next()) {
        %>
            <tr>
                <td><%= ++sno %></td>
                <td><%= rs.getString(2) %></td>
                <td><%= rs.getString(3) %></td>
                <td><i class="fa fa-inr"></i> <%= rs.getString(4) %></td>
                <td><%= rs.getString("quantity") %></td>
                <td><i class="fa fa-inr"></i> <%= rs.getString("total") %></td>
            </tr>
        <%
            }
            ResultSet rs2 = st.executeQuery("select * from users where email='" + email + "'  ");
            while (rs2.next()) {
        %>
        </tbody>
    </table>

    <hr>
    <form action="${pageContext.request.contextPath}/AddressPaymentForOrderServlet" method="post">
        <div class="row">
            <div class="col-md-6">
                <h5>Enter Address</h5>
                <input class="input-style" type="text" name="address" value="<%= rs2.getString(7) %>" placeholder="Enter your Address" required>
            </div>
            <div class="col-md-6">
                <h5>Enter City</h5>
                <input class="input-style" type="text" name="city" value="<%= rs2.getString(8) %>" placeholder="Enter your City" required>
            </div>
        </div>

        <div class="row">
            <div class="col-md-6">
                <h5>Enter State</h5>
                <input class="input-style" type="text" name="state" value="<%= rs2.getString(9) %>" placeholder="Enter your State" required>
            </div>
            <div class="col-md-6">
                <h5>Enter Country</h5>
                <input class="input-style" type="text" name="country" value="<%= rs2.getString(10) %>" placeholder="Enter your Country" required>
            </div>
        </div>

     
        <hr>

        <div class="row">
            <div class="col-md-6">
                <h5>Select Way of Payment</h5>
                <select class="input-style" name="paymentMethod">
                    <option value="Cash on delivery(COD)">Cash on delivery(COD)</option>
                    <option value="Online Payment">Online Payment</option>
                </select>
            </div>
            <div class="col-md-6">
                <h5>Pay online at shubhamkushwaha133@ybl</h5>
                <input class="input-style" type="text" name="transactionId" placeholder="Enter Transaction ID">
        
            </div>
        </div>
        <hr>

        <div class="row">
            <div class="col-md-6">
                <h5>Mobile Number</h5>
                <input class="input-style" type="text" name="mobileNumber" value="<%= rs2.getString(3) %>" placeholder="Enter Mobile Number" required>
                
            </div>
            <div class="col-md-6">
                
                <button class="button btn btn-success mt-3" type="submit">Proceed to Generate Bill & Save <i class='far fa-arrow-alt-circle-right'></i></button>
                
            </div>
        </div>
    </form>
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
<%@include file="footer.jsp" %>
