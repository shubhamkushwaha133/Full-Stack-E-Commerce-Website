<%@page errorPage="error.jsp" %>
<%@include file="header.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Change Details</title>
    <link rel="stylesheet" href="css/home-style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .topnav {
    background-color: #f2f2f2;
    border-bottom: 0.2px solid #ccc;
    margin-bottom: 0; /* Remove bottom margin */
    padding: 5px 0; /* Reduce padding to minimize white space */
}

        .topnav h2 {
            margin: 5px;
            font-size: 18px;
        }
        .topnav .nav-link {
            color: white;
            margin: 0 6px;
            font-size: 16px;
            
        }
        .topnav .nav-link:hover {
            color: white; /* Accent color */
             background-color: #145a32;
             border-radius: 10px;
             
        }
        .user-email {
            font-size: 16px;
            margin-top: 5px;
        }
       
    </style>
</head>
<body>

<!-- Bootstrap Navbar -->
<div class="topnav sticky" style="background-color: black;">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center">
           
            <% email = session.getAttribute("email").toString(); %>
            <div class="d-flex" >
                <a href="home.jsp" class="nav-link"><i class='fas fa-arrow-circle-left'></i> Back</a>
                <a href="#" class="nav-link" >(<% out.print(email); %>) <i class='fas fa-user-alt'></i></a>
                <a href="changePassword.jsp" class="nav-link" >Change Password <i class='fas fa-key'></i></a>
                <a href="addChangeAddress.jsp" class="nav-link">Update Address <i class='fas fa-map-marker-alt'></i></a>
                <a href="changeSecurityQuestion.jsp" class="nav-link" >Update Security Question <i class="fa fa-repeat"></i></a>
                <a href="changeMobileNumber.jsp" class="nav-link" >Update Mobile Number <i class='fas fa-phone'></i></a>
            </div>
        </div>
    </div>
</div>

<!-- Main Content -->
<div class="container mt-4">
    <!-- Table or other content goes here -->
</div>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>
