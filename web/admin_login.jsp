<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="javax.servlet.*,javax.servlet.http.*" %>
<%
    String error = "";
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if ("admin".equals(email) && "admin123".equals(password)) {
            response.sendRedirect("adminSection.jsp");
            return;
        } else {
            error = "Invalid admin credentials!";
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Login</title>
    <style>
        body {
            background-color: #102031;
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
            padding: 0;
            color: #fff;
        }
        .login-box {
            background-color: #204060;
            width: 400px;
            margin: 100px auto;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.3);
            text-align: center;
        }
        .login-box h2 {
            margin-bottom: 30px;
        }
        input[type="text"], input[type="password"] {
            width: 90%;
            padding: 12px;
            margin: 10px 0;
            border: none;
            border-radius: 8px;
            font-size: 16px;
        }
        input[type="submit"] {
            background-color: #102031;
            color: white;
            padding: 12px 30px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #0d1a26;
        }
        .error {
            color: #ff4d4d;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <div class="login-box">
        <h2>Admin Login</h2>
        <form method="post">
            <input type="text" name="email" placeholder="Admin Email" required><br>
            <input type="password" name="password" placeholder="Password" required><br>
            <input type="submit" value="Login">
        </form>
        <% if (!error.isEmpty()) { %>
            <div class="error"><%= error %></div>
        <% } %>
    </div>
</body>
</html>
