
<%@page errorPage="error.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
             background-color: #283747 !important;
        }
        .about-container {
            margin-top: 5%;
            padding: 2% 3%;
            background-color: #17202a ;
            color: white !important;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }
        .about-header {
            color: white ;
            font-size: 2.5rem;
            margin-bottom: 2rem;
        }
        .about-content {
            font-size: 1.2rem;
            color: #333;
        }
        .contact-info {
            margin-top: 2rem;
            font-size: 1.2rem;
        }
        .contact-info a {
            color: #007bff;
            text-decoration: none;
        }
        .contact-info a:hover {
            text-decoration: underline;
        }
      
    </style>
</head>
<%@include file="header.jsp"%>
<body>
    <div class="container about-container">
        <div class="about-header text-center">
            About <i class="fa fa-address-book"></i>
        </div>
        <div class="about-content text-center">
            <h2 style="color:white;">Shubham Kumar</h2>
            <p style="color:white;">Hey everyone!!</p>
            <p style="color:white;">I'm Shubham, and I'm from the town of Buxar in Bihar. I'm a passionate seller, dedicated to providing the best products and services to my customers. Feel free to reach out to me if you have any questions or need assistance!</p>
            <div class="contact-info">
                <p style="color:white;">Contact me at: <a href="mailto:shubhamkushwaha1304@gmail.com">shubhamkushwaha1304@gmail.com</a></p>
                <p style="color:white;">or connect with me on LinkedIn: <a href="https://www.linkedin.com/in/shubhamkushwaha0101" target="_blank">@shubhamkushwaha0101</a></p>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>

