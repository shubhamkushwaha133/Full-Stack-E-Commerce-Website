<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password</title>
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

        .forgot-container {
            margin-top: 6%;
            margin-bottom: 1%;
            width: 40%;
            max-width: 100%;
            margin-left: 21%; /* Adjust this value to move the container left */
            padding: 2%;
            background: #17202a; /* Background color */
            border: 2px solid #d4ac0d; /* Border color */
            border-radius: 10px; /* Rounded corners */
            box-shadow: 0 5px 8px 0 rgba(0, 0, 0, 0.2), 0 9px 26px 0 rgba(0, 0, 0, 0.19); /* Shadow */
        }

        .forgot-container h3 {
            text-align: center;
            margin-bottom: 3%;
            color: #fff;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-control {
            width: 100%;
            box-sizing: border-box;
        }

        select.form-control {
            padding-right: 20px; /* Add padding to make space for a custom arrow if desired */
        }

        select.form-control option {
            padding: 10px;
        } 

        .btnSubmit {
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

        .btnSubmit:hover {
            background-color: #1d8348;
            color: #fdfefe;
        }

        .whyforgotPassword h3 {
            color: #ffcc00;
            text-align: center;
            margin-top: 20px;
        }

        .whyforgotPassword h2 {
            color: #fff;
            text-align: center;
            margin-top: 40px;
        }

        .whyforgotPassword p {
            color: #fff;
            text-align: center;
            margin-top: 20px;
            padding: 0 20px;
        }

        .login-link {
            text-align: center;
            margin-top: 20px;
            color: #fff;
        }

        .login-link a {
            color: #f8f9f9;
            text-decoration: none;
        }

        .login-link a:hover {
           
            color: #1d8348;
            text-decoration: underline;  
        }

    </style>
</head>
<body>

<div class="whyforgotPassword">
    <%  
        String msg = request.getParameter("msg");
        if ("done".equals(msg)) {
    %>
    <h3>Password Changed Successfully!</h3>
    <% } else if ("invalid".equals(msg)) { %>
    <h3>Something went wrong! Try again!</h3>
    <% } %>
</div>

<div class="container forgot-container">
    <h3><i class="fa-solid fa-key"></i>&nbsp;Forgot Password</h3>
    <form action="${pageContext.request.contextPath}/ForgotPasswordServlet" method="post">
        <div class="form-group">
            <input type="email" name="email" class="form-control" placeholder="Enter email" required>
        </div>
        <div class="form-group">
            <input type="number" name="mobileNumber" class="form-control" placeholder="Enter mobile number" required>
        </div>
        <div class="form-group">
            <select name="securityQuestion" class="form-control" required>
                <option value="" disabled selected>Select a security question</option>
                <option value="What was your first car?">What was your first car?</option>
                <option value="What is the name of your first pet?">What is the name of your first pet?</option>
                <option value="What elementary school did you attend?">What elementary school did you attend?</option>
                <option value="What is the name of the town where you were born?">What is the name of the town where you were born?</option>
            </select>
        </div>
        <div class="form-group">
            <input type="text" name="answer" class="form-control" placeholder="Enter the Security answer" required>
        </div>
        <div class="form-group">
            <input type="password" name="newPassword" class="form-control" placeholder="Enter your new password to set" required>
        </div>
        <input type="submit" class="btnSubmit" value="Save">
    </form>
    <div class="login-link">
        <h2><a href="login.jsp">Login&nbsp;<i class="fa-solid fa-right-to-bracket"></i></a></h2>
    </div>
</div>

</body>
</html>
