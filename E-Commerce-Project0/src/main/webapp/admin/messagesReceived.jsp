<%@page import="java.sql.ResultSet" %>
<%@page import="jakarta.servlet.jsp.JspWriter" %>
<%@page import="jakarta.servlet.http.HttpServletRequest" %>
<%@page import="jakarta.servlet.http.HttpServletResponse" %>
<%@page import="jakarta.servlet.http.HttpSession" %>
<%@page import="service.MessageService" %>
<%@page import="model.Message" %>
<%@page import="java.util.List" %>
<%@page import="model.Message" %>

<%@page import="util.ConnectionProvider" %>
<%@page import="java.sql.*" %>
<%@include file="adminHeader.jsp" %>


<%@page import="model.Message" %>
<%@page import="java.util.List" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Messages Received</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background-color: #283747;
            color: #fff;
            font-family: Arial, sans-serif;
        }
        .header {
            color: #ffcc00;
            text-align: center;
            font-size: 30px;
            margin: 20px 0;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px auto;
        }
        th, td {
            padding: 15px;
            text-align: center;
            border: 1px solid #ddd;
            color: #fff;
        }
        th {
            background-color: #17202a;
        }
        tbody tr:nth-child(even) {
            background-color: #1c2833;
        }
        tbody tr:nth-child(odd) {
            background-color: #2c3e50;
        }
    </style>
</head>
<body>

    
    
    <div class="container">
        <div class="header">Review <i class="fas fa-comment-alt"></i></div>

        <table class="table table-dark">
            <thead>
                <tr>
                    <th scope="col">ID</th>
                    <th scope="col">Email</th>
                    <th scope="col">Subject</th>
                    <th scope="col">Body</th>
                </tr>
            </thead>
            <tbody>
          <%
                List<Message> messages = (List<Message>) request.getAttribute("messages");
                if (messages != null && !messages.isEmpty()) {
                    for (Message message : messages) {
                %>
                    <tr>
                        <td><%= message.getId() %></td>
                        <td><%= message.getEmail() %></td>
                        <td><%= message.getSubject() %></td>
                        <td><%= message.getBody() %></td>
                    </tr>
                <%
                    }
                } 
                %>
            </tbody>
        </table>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>
