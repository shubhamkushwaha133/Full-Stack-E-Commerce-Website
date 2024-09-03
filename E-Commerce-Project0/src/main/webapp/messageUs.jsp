<%@page import="util.ConnectionProvider" %>
<%@page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Message Us</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
    <style>
        .input-style {
            border: 2px solid black; /* Border color */
            border-radius: 5px; /* Rounded corners */
            padding: 10px; /* Padding inside the text box */
            width: 100%; /* Full width */
            box-sizing: border-box; /* Include padding in the width */
            margin-bottom: 15px; /* Space between input fields */
        }

        .input-style:focus {
            border-color: #ffcc00; /* Border color on focus */
            outline: none; /* Remove default focus outline */
        }

        .button {
            background-color: black; /* Button background color */
            color: white !important; /* Button text color */
            border: none;
            border-radius: 5px; /* Rounded corners */
            padding: 10px 20px; /* Padding inside the button */
            font-size: 16px; /* Font size */
            cursor: pointer; /* Pointer cursor on hover */
            transition: background-color 0.3s ease, color 0.3s ease; /* Smooth color transition */
        }

        .button:hover {
            color: white !important; /* Text color on hover */
            background-color: #186a3b; /* Background color on hover */
        }

        hr {
            border: 1px solid black; /* Black border color */
            width: 100%; /* Full width */
            margin: 20px 0; /* Margin for spacing */
        }

        .message-container {
            margin-top: 5%;
            padding: 2%;
            background-color: #1c2833 ;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }

        .message-header {
            color: #17202a;
            text-align: center;
            font-size: 2.5rem;
            margin-bottom: 2rem;
        }

        .alert {
            text-align: center;
            font-size: 1.2rem;
            margin-bottom: 1rem;
        }

        .alert-success {
            color: green;
        }

        .alert-danger {
            color: red;
        }
    </style>
</head>
<%@include file="header.jsp" %>
<body style="background-color:#2c3e50;">
    <div class="container message-container">
        <div class="message-header" style="color:white;">
            Product Review <i class='fas fa-comment-alt'></i>
        </div>
        <%
        String msg = request.getParameter("msg");
        if ("valid".equals(msg)) {
        %>
        <div class="alert alert-success" style="color:black;">
            Message successfully sent. Our team will contact you soon!
        </div>
        <% } else if ("invalid".equals(msg)) { %>
        <div class="alert alert-danger" style="color:red;">
            Something went wrong! Try again!
        </div>
        <% } %>
        <form action="${pageContext.request.contextPath}/MessageServlet" method="post">
            <input style="color:black;" class="input-style" name="subject" type="text" placeholder="Subject" required>
            <hr>
            <textarea style="color:black;" class="input-style" name="body" placeholder="Enter your message" required></textarea>
            <hr>
            <button class="button" type="submit" style="color:black;">Send <i class="far fa-arrow-alt-circle-right"></i></button>
        </form>
    </div>
</body>
</html>
