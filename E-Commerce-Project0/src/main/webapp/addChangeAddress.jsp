<%@page import="util.ConnectionProvider" %>
<%@page import="java.sql.*" %>


<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add or Change Address</title>
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

        .address-container {
            
            margin-left: 10% !important; /* Center the container */
            margin-top: 5% !important;
            margin-bottom: 4% !important;
            width: 50% !important; /* Set the width to 50% */ 
            padding: 2%;
            background: #17202a; /* Background color */
            border: 2.5px solid #d4ac0d; /* Border color */
            border-radius: 10px; /* Rounded corners */
            box-shadow: 0 5px 8px 0 rgba(0, 0, 0, 0.2), 0 9px 26px 0 rgba(0, 0, 0, 0.19); /* Shadow */
            color: #fff;
        }

        .address-container h5 {
            text-align: center;
            margin-bottom: 3%;
            color: #fff;
        }

        .input-style {
            border: 2px solid #6e2c00;
            border-radius: 5px;
            padding: 10px;
            width: 100%;
            box-sizing: border-box;
            margin-bottom: 15px;
            background: #fff;
        }

        .button {
            font-weight: 600;
            width: 100%;
            color: #282726;
            background-color: #fff;
            border: none;
            border-radius: 1.5rem;
            padding: 2%;
            transition: background-color 0.3s ease, color 0.3s ease;
            cursor: pointer;
            margin-top: 20px;
        }

        .button:hover {
            color: #f4f6f7 ;
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

<div class="container address-container">
    <%  
        String msg = request.getParameter("msg");
        if ("valid".equals(msg)) {
    %>
    <h6 class="alert" style="color:green;">Address Successfully Updated!</h6>
    <% } else if ("invalid".equals(msg)) { %>
    <h6 class="alert" style="color:red;">Something Went Wrong! Try Again!</h6>
    <% } %>
    
    <%
    try {
        Connection con = ConnectionProvider.getCon();
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("select * from users where email='" + email + "' ");
        while (rs.next()) {
    %>
    <form action="${pageContext.request.contextPath}/AddChangeAddressServlet" method="post">
        <h5><i class="fa-solid fa-map-marker-alt"></i>&nbsp;Enter Address</h5>
        <input class="input-style" type="text" name="address" value="<%=rs.getString(7) %>" placeholder="Enter address" required>
        <hr style="width:100%;color:black;">

        <h5><i class="fa-solid fa-city"></i>&nbsp;Enter City</h5>
        <input class="input-style" type="text" name="city" value="<%=rs.getString(8) %>" placeholder="Enter city" required>
        <hr style="width:100%;color:black;">

        <h5><i class="fa-solid fa-state"></i>&nbsp;Enter State</h5>
        <input class="input-style" type="text" name="state" value="<%=rs.getString(9) %>" placeholder="Enter state" required>
        <hr style="width:100%;color:black;">

        <h5><i class="fa-solid fa-globe"></i>&nbsp;Enter Country</h5>
        <input class="input-style" type="text" name="country" value="<%=rs.getString(10) %>" placeholder="Enter country" required>
        <hr style="width:100%;color:black;">

        <button class="button" type="submit">Save&nbsp;<i class='far fa-arrow-alt-circle-right'></i></button>
    </form>
    <% 
        }
    } catch (Exception e) {
        System.out.println(e);
    }
    %>
</div>

</body>
</html>
