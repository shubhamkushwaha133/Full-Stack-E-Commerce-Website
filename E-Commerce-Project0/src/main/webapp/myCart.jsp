<%@page import="util.ConnectionProvider" %>
<%@page import="java.sql.*" %>
<%@include file="header.jsp" %>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src='https://kit.fontawesome.com/a076d05399.js'></script>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>My Cart</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #283747 !important;
        margin: 0;
        padding: 0;
    }
    h3.alert {
        color: yellow;
        text-align: center;
        background-color: #17202a;
        padding: 10px;
        border-radius: 5px;
    }
    .header {
        color: #17202a;
        text-align: center;
        font-size: 30px;
        margin: 20px 0;
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
    }
    th[scope="col"][style="background-color: yellow;"] {
        background-color: yellow;
        color: black;
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

<div class="header" style="color:white;">My Cart<i class='fas fa-cart-arrow-down'></i></div>

<%
String msg = request.getParameter("msg");
if ("minQuantity".equals(msg)) {
%>
<h3 class="alert">There is only one quantity! So click on remove!</h3>
<%
}
%>
<%
if ("inc".equals(msg)) {
%>
<h3 class="alert">Quantity increased successfully!</h3>
<%
}
%>
<%
if ("dec".equals(msg)) {
%>
<h3 class="alert">Quantity decreased successfully!</h3>
<%
}
%>
<%
if ("maxQuantity".equals(msg)) {
%>
<h3 class="alert">Maximum Quantity Reached!</h3>
<%
}
%>
<%
if ("removed".equals(msg)) {
%>
<h3 class="alert">Product successfully removed!</h3>
<%
}
%>

<table>
    <thead>
        <%
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

        <tr>
            <th scope="col" style="background-color: yellow; color:black">Total: <i class="fa fa-inr"></i><%= total %></th>
            <% if (total > 0) { %>
            <th scope="col"><a href="addressPaymentForOrder.jsp">Proceed to order</a></th>
            <% } %>
        </tr>
    </thead>
    <thead>
        <tr >
            <th scope="col" style="color:white !important;">S.No</th>
            <th scope="col" style="color:white !important;">Product Name</th>
            <th scope="col" style="color:white !important;">Category</th>
            <th scope="col" style="color:white !important;"><i class="fa fa-inr"></i> Price</th>
            <th scope="col" style="color:white !important;">Quantity</th>
            <th scope="col" style="color:white !important;">Sub Total</th>
            <th scope="col" style="color:white !important;">Remove <i class='fas fa-trash-alt'></i></th>
        </tr>
    </thead>
    <tbody>
    <%
        ResultSet rs = st.executeQuery("select * from product inner join cart on product.id=cart.product_id and cart.email='" + email + "' and cart.address is null ");
        while (rs.next()) {
            sno = sno + 1;
    %>
        <tr>
            <td><%= sno %></td>
            <td><%= rs.getString(2) %></td>
            <td><%= rs.getString(3) %></td>
            <td><i class="fa fa-inr"></i> <%= rs.getString(4) %></td>
            <td>
                <a href="${pageContext.request.contextPath}/incDecQuantityServlet?id=<%= rs.getString(1) %>&quantity=inc"><i class='fas fa-plus-circle'></i></a>
                <%= rs.getString(12) %>
                <a href="${pageContext.request.contextPath}/incDecQuantityServlet?id=<%= rs.getString(1) %>&quantity=dec"><i class='fas fa-minus-circle'></i></a>
            </td>
            <td><i class="fa fa-inr"></i> <%= rs.getString("total") %></td>
            <td><a href="${pageContext.request.contextPath}/RemoveFromCartServlet?id=<%= rs.getString(1) %>">Remove <i class='fas fa-trash-alt'></i></a></td>
        </tr>
    <%
        }
    } catch (Exception e) {
        System.out.println(e);
    }
    %>
    </tbody>
</table>

</body>
</html>
