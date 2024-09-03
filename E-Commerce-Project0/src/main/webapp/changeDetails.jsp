<%@page import="util.ConnectionProvider" %>
<%@page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Change Details</title>
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

        .container {
            max-width: 100%; /* Ensure container is responsive */
        }

        .details-container {
            margin-left: 12%; /* Center the container */
            margin-top: 5%;
            margin-bottom: 4%;
            width: 50%; /* Set the width to 50% */
            padding: 2%;
            background: #17202a; /* Background color */
            border: 2.5px solid #d4ac0d; /* Border color */
            border-radius: 10px; /* Rounded corners */
            box-shadow: 0 5px 8px 0 rgba(0, 0, 0, 0.2), 0 9px 26px 0 rgba(0, 0, 0, 0.19); /* Shadow */
            color: #fff;
        }

        .details-container h3 {
            margin-bottom: 20px;
            font-size: 18px;
        }

        .details-container hr {
            width: 100%;
            border-top: 1px solid #d4ac0d;
            margin: 10px 0; 
        }
    </style>
</head>
<%@include file="changeDetailsHeader.jsp" %>
<body>

<div class="container">
    <div class="details-container">
        <%
        try {
            Connection con = ConnectionProvider.getCon();
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("select * from users where email='" + email + "' ");
            while (rs.next()) {
        %>
        <h3><i class="fa-solid fa-user"></i>&nbsp;Name: <%= rs.getString(1) %></h3>
        <hr>

        <h3><i class="fa-solid fa-envelope"></i>&nbsp;Email: <%= rs.getString(2) %></h3>
        <hr>

        <h3><i class="fa-solid fa-phone"></i>&nbsp;Mobile Number: <%= rs.getString(3) %></h3>
        <hr>

        <h3><i class="fa-solid fa-question-circle"></i>&nbsp;Security Question: <%= rs.getString(4) %></h3>
        <hr>

        <%
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        %>
    </div>
</div>

</body>
</html>
