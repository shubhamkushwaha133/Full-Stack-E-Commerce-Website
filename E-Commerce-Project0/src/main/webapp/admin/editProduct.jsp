<%@page import="util.ConnectionProvider" %>
<%@page import="java.sql.*" %>
<%@include file="adminHeader.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Product</title>
    <link rel="stylesheet" href="../css/addNewProduct-style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <style>
        body {
            background-color: #283747;
            color: #fff;
            font-family: Arial, sans-serif;
        }

        .container {
            max-width: 800px;
            margin-top: 15px;
            padding: 20px;
            background-color: #1c2833;
            border-radius: 8px;
        }

        h3 {
            color: #ffcc00;
        }

        .alert {
            color: #ffcc00;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .input-style {
            width: 90% !important;
            padding: 10px;
            margin-top: 5px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            background-color: #fff;
            color: #000;
        }

        .input-style:focus {
            border-color: #ffcc00;
            outline: none;
        }

        .button {
            background-color: #007bff;
            border: none;
            width: 20%;
            color: white;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 20px;
        }

        .button i {
            margin-left: 8px;
        }

        .button:hover {
            background-color: green;
            color: white;
        }

        .form-group {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        .form-group div {
            flex: 1;
            margin-right: 20px;
        }

        .form-group div:last-child {
            margin-right: 0;
        }

        .form-group h3 {
            margin-bottom: 10px;
        }

        .form-group input, .form-group select, .form-group textarea {
            width: 100%;
        }

        .back {
            color: #ffcc00;
            text-decoration: none;
            font-size: 18px;
            margin-left: 2.5%;
        }

        .back:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2><a class="back" href="allProductEditProduct.jsp"><i class='fas fa-arrow-circle-left'></i> Back</a></h2>
        <%
        String id = request.getParameter("id");
        try {
            Connection con = ConnectionProvider.getCon();
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM product WHERE id='" + id + "'");
            if (rs.next()) {
        %>
        <form action="${pageContext.request.contextPath}/EditProductServlet" method="post" enctype="multipart/form-data">
            <input type="hidden" name="id" value="<%= id %>">
            <div class="form-group">
                <div>
                    <h3>Enter Name</h3>
                    <input class="input-style" type="text" name="name" value="<%= rs.getString("name") %>" required>
                </div>
                <div>
                    <h3>Enter Category</h3>
                    <input class="input-style" type="text" name="category" value="<%= rs.getString("category") %>" required>
                </div>
            </div>
            <div class="form-group">
                <div>
                    <h3>Enter Price</h3>
                    <input class="input-style" type="number" name="price" value="<%= rs.getDouble("price") %>" required>
                </div>
                <div>
                    <h3>Active</h3>
                    <select class="input-style" name="active">
                        <option value="Yes" <%= "Yes".equals(rs.getString("active")) ? "selected" : "" %>>Yes</option>
                        <option value="No" <%= "No".equals(rs.getString("active")) ? "selected" : "" %>>No</option>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <div>
                    <h3>Enter Description</h3>
                    <textarea class="input-style" name="details" rows="4"><%= rs.getString("details") %></textarea>
                </div>
            </div>
            <div class="form-group">
                <div>
                    <h3>Enter Quantity</h3>
                    <input class="input-style" type="number" name="pquantity" value="<%= rs.getInt("pquantity") %>" required>
                </div>
                <div>
                    <h3>Upload Image (Optional)</h3>
                    <input class="input-style" type="file" name="productImage">
                </div>
            </div>
            <button class="button" type="submit">Save <i class='far fa-arrow-alt-circle-right'></i></button>
        </form>
        <%
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        %>
    </div>
</body>
</html> 
 