<%@page import="util.ConnectionProvider" %>
<%@page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Change Mobile Number</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <style>
        html, body {
            margin: 0;
            padding: 0;
            width: 100%;
            height: 100%;
            overflow-x: hidden; /* Prevents horizontal scrolling */
        }

        body {
            background-image: url("https://assets.bacancytechnology.com/main-boot-5/images/ecommerce-development/banner.jpg?v-1");
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center center;
        }

        .change-container {
            margin-left: 10% !important; /* Center the container */
            margin-top: 5% !important;
            margin-bottom: 4%;
            width: 50% !important; /* Set the width to 50% */
            padding: 2%;
            background: #17202a; /* Background color */
            border: 2.5px solid #d4ac0d; /* Border color */
            border-radius: 10px; /* Rounded corners */
            box-shadow: 0 5px 8px 0 rgba(0, 0, 0, 0.2), 0 9px 26px 0 rgba(0, 0, 0, 0.19); /* Shadow */
            color: #fff;
        }

        .change-container h3 {
            text-align: center;
            margin-bottom: 3%;
            color: #fff;
        }

        .input-style {
            border: 2px solid #6e2c00; /* Border color */
            border-radius: 5px; /* Rounded corners */
            padding: 5px; /* Padding inside the text box */
            width: 100%; /* Full width */
            box-sizing: border-box; /* Include padding in the width */
            margin-bottom: 5px; /* Space between input fields */
        }

        .button {
            font-weight: 600;
            width: 100%;
            color: #282726;
            background-color: #fff;
            border: 2px solid #f4f6f7; /* Border color */
            border-radius: 1.5rem;
            padding: 2%;
            transition: background-color 0.3s ease, color 0.3s ease;
            cursor: pointer;
            margin-top: 20px;
        }

        .button:hover {
            color: #f4f6f7;
            background-color: #186a3b;
        }

        .alert {
            color: #ffcc00;
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>
<%@include file="changeDetailsHeader.jsp" %>
<body>

<div class="container change-container">
    <%
    String msg = request.getParameter("msg");
    if ("done".equals(msg)) {
    %>
    <h3 class="alert" style="color:green;">Your Mobile Number Successfully Changed!</h3>
    <% } else if ("wrong".equals(msg)) { %>
    <h3 class="alert" style="color:red;">Your Password is Wrong!</h3>
    <% } %>

    <form action="${pageContext.request.contextPath}/ChangeMobileNumberServlet" method="post">
        <h3>Enter Your New Mobile Number</h3>
        <input class="input-style" type="number" name="mobileNumber" placeholder="Enter new mobile number" required>
        <hr style="width:100%;color:white;">

        <h3>Enter Password (For Security)</h3>
        <input class="input-style" type="password" name="password" placeholder="Enter your password" required>
        <hr style="width:100%;color:white;">

        <button class="button" type="submit">Save <i class='far fa-arrow-alt-circle-right'></i></button>
    </form>
</div>

</body>
</html>
