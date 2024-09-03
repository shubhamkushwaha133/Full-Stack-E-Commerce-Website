<%@page import="util.ConnectionProvider" %>
<%@page import="java.sql.*" %>


<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Change Security Question</title>
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

<div class="container change-container">
    <%  
        String msg = request.getParameter("msg");
        if ("done".equals(msg)) {
    %>
    <h3 class="alert" style="color:green;">Your security question was successfully changed!</h3>
    <% } else if ("wrong".equals(msg)) { %>
    <h3 class="alert" style="color:red;">Your password is wrong!</h3>
    <% } %>
    
    <form action="${pageContext.request.contextPath}/ChangeSecurityQuestionServlet" method="post">
        <h3><i class="fa-solid fa-lock"></i>&nbsp;Change Security Question</h3>
        
        <h3 style="color:white;">Select Your New Security Question</h3>
        <select class="input-style" name="securityQuestion" required>
            <option value="What was your first car?">What was your first car?</option>
            <option value="What is the name of your first pet?">What is the name of your first pet?</option>
            <option value="What elementary school did you attend?">What elementary school did you attend?</option>
            <option value="What is the name of the town where you were born?">What is the name of the town where you were born?</option>
        </select>

        <h3 style="color:white;">Enter Your New Answer</h3>
        <input class="input-style" type="text" name="newAnswer" placeholder="Enter your new answer" required>
        
        <h3 style="color:white;">Enter Password (For Security)</h3>
        <input class="input-style" type="password" name="password" placeholder="Enter your password" required>
        
        <button class="button" type="submit">Save&nbsp;<i class='far fa-arrow-alt-circle-right'></i></button>
    </form>
</div>

</body>
</html>
