<%@include file="adminHeader.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background-color: #283747;
            color: #fff;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        .welcome-header {
            text-align: center;
            margin-top: 100px;
        }
        .welcome-header h1 {
            color: #ffcc00;
            font-size: 100px;
            margin: 0;
        }
        .welcome-header p {
            color: #fff;
            font-size: 24px;
        }
        .btn-custom {
            background-color: #ffcc00 !important;
            color: #000 !important;
            border: none;
            font-weight: bold;
        }
        .btn-custom:hover {
            background-color: #f1c40f;
            color: #fff;
        }
        .container {
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="welcome-header">
            <h1>Welcome Admin!</h1>
            <p>Manage your products, view orders, and more.</p>
            <a href="allProductEditProduct.jsp" class="btn btn-custom">Manage Products <i class="fa fa-box"></i></a>
            <a href="ordersReceived.jsp" class="btn btn-custom">View Orders <i class="fa fa-receipt"></i></a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>

<%@include file="/footer.jsp" %>
