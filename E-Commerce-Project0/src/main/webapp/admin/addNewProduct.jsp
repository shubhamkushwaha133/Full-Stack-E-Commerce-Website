<%@page import="util.ConnectionProvider" %>
<%@page import="java.sql.*" %>
<%@include file="adminHeader.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Product</title>
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
    </style>
</head>
<body>

<%
String msg = request.getParameter("msg");
if ("done".equals(msg)) {
%>
    <h3 class="alert">Product Added Successfully!</h3>
<%
} else if ("wrong".equals(msg)) {
%>
    <h3 class="alert">Something went wrong! Try Again!</h3>
<%
}
%>

<%
int id = 1;
Connection con = null;
Statement st = null;
ResultSet rs = null;

try {
    con = ConnectionProvider.getCon();
    st = con.createStatement();
    rs = st.executeQuery("SELECT MAX(id) FROM product");
    if (rs.next()) {
        id = rs.getInt(1) + 1;
    }
} catch (Exception e) {
    e.printStackTrace(); // Log the exception
} finally {
    // Close resources
    try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
    try { if (st != null) st.close(); } catch (SQLException e) { e.printStackTrace(); }
    try { if (con != null) con.close(); } catch (SQLException e) { e.printStackTrace(); }
}
%>

<div class="container">
    <form action="${pageContext.request.contextPath}/FileUploadServlet" method="post" enctype="multipart/form-data">
        <h3>Product ID: <%= id %></h3>
        <input type="hidden" name="id" value="<%= id %>">

        <div class="form-group">
            <div>
                <h3>Enter Name</h3>
                <input class="input-style" type="text" name="name" placeholder="Enter name" required>
            </div>

            <div>
                <h3>Enter Category</h3>
                <input class="input-style" type="text" name="category" placeholder="Enter category" required>
            </div>
        </div>

        <div class="form-group">
            <div>
                <h3>Enter Price</h3>
                <input class="input-style" type="number" name="price" placeholder="Enter price" required>
            </div>

            <div>
                <h3>Active</h3>
                <select class="input-style" name="active">
                    <option value="Yes">Yes</option>
                    <option value="No">No</option>
                </select>
            </div>
        </div>

         <div class="form-group">
            <div>
                <h3>Enter Description</h3>
                <textarea class="input-style" name="details" placeholder="Enter details" rows="4" required></textarea>
            </div>
        </div>

        <div class="form-group">
            <div>
                <h3>Enter Quantity</h3>
                <input class="input-style" type="number" name="pquantity" placeholder="Enter quantity" required>
            </div>

            <div>
                <h3>Upload Image</h3>
                <input class="input-style" type="file" name="productImage" required>
            </div>
        </div>

        <button class="button">Save <i class='far fa-arrow-alt-circle-right'></i></button>
    </form>
</div>

</body>
</html>
     