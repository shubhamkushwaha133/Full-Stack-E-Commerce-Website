<%@page import="util.ConnectionProvider" %>
<%@page import="java.sql.*" %>
<%@include file="adminHeader.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delivered Orders</title>
    <link rel="stylesheet" href="../css/ordersReceived-style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background-color: #283747;
            color: #fff;
            font-family: Arial, sans-serif;
        }
        .header {
            color: #ffcc00;
            text-align: center;
            font-size: 30px;
            margin: 20px 0;
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
            color: #fff;
            word-wrap: break-word; /* Ensures long words wrap to the next line */
            overflow-wrap: break-word; /* Ensures long words wrap to the next line */
        }
        th {
            background-color: #17202a;
        }
        tbody tr:nth-child(even) {
            background-color: #1c2833;
        }
        tbody tr:nth-child(odd) {
            background-color: #2c3e50;
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
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            Delivered Orders <i class='fas fa-dolly'></i>
        </div>

        <table id="customers" class="table table-dark">
            <thead>
                <tr>
                    <th scope="col">Mobile Number</th>
                    <th scope="col">Product Name</th>
                    <th scope="col">Quantity</th>
                    <th scope="col"><i class="fa fa-inr"></i> Sub Total</th>
                    <th scope="col">Address</th>
                    <th scope="col">City</th>
                    <th scope="col">State</th>
                    <th scope="col">Country</th>
                    <th scope="col">Order Date</th>
                    <th scope="col">Expected Delivery Date</th>
                    <th scope="col">Payment Method</th>
                    <th scope="col">T-ID</th>
                    <th scope="col">Status</th>
                </tr>
            </thead>
            <tbody>
            <%
            try {
                Connection con = ConnectionProvider.getCon();
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery("SELECT * FROM cart INNER JOIN product ON cart.product_id = product.id WHERE cart.orderdate IS NOT NULL AND cart.status = 'Delivered'");
                while (rs.next()) {
            %>
                <tr>
                    <td><%= rs.getString(10) %></td>
                    <td><%= rs.getString(17) %></td>
                    <td><%= rs.getString(3) %></td>
                    <td><i class="fa fa-inr"></i> <%= rs.getString(5) %></td>
                    <td><%= rs.getString(6) %></td>
                    <td><%= rs.getString(7) %></td>
                    <td><%= rs.getString(8) %></td>
                    <td><%= rs.getString(9) %></td>
                    <td><%= rs.getString(11) %></td>
                    <td><%= rs.getString(12) %></td>
                    <td><%= rs.getString(13) %></td>
                    <td><%= rs.getString(14) %></td>
                    <td><%= rs.getString(15) %></td>
                </tr>
            <%
                }
            } catch (Exception e) {
                e.printStackTrace(); // Log the exception
            }
            %>
            </tbody>
        </table>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>
