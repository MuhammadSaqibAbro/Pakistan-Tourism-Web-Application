<%@ page import="java.sql.*, java.util.*" %>
<%@ include file="db.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
    // Fetch total count of places and bookings
    Statement stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM places");
    rs.next();
    int totalPlaces = rs.getInt(1);

    rs = stmt.executeQuery("SELECT COUNT(*) FROM bookings");
    rs.next();
    int totalBookings = rs.getInt(1);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f7fc;
        }
        .navbar {
            background-color: #204060;
            padding: 10px 30px;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .navbar-title {
            font-size: 24px;
            font-weight: bold;
        }
        .nav-links {
            display: flex;
            gap: 20px;
        }
        .nav-links a {
            color: white;
            text-decoration: none;
            font-size: 16px;
            padding: 8px 16px;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }
        .nav-links a:hover {
            background-color: #a8c0e0;
        }
        .nav-links .logout-button {
            background-color: red;
            padding: 8px 16px;
        }
        .nav-links .logout-button:hover {
            background-color: darkred;
        }
        .container {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 30px;
        }
        .dashboard {
            display: flex;
            justify-content: space-around;
            width: 100%;
            max-width: 1200px;
            margin-bottom: 30px;
        }
        .dashboard-card {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 250px;
            text-align: center;
            transition: transform 0.3s ease;
        }
        .dashboard-card:hover {
            transform: translateY(-5px);
        }
        .dashboard-card h3 {
            color: #204060;
            font-size: 30px;
        }
        .dashboard-card p {
            font-size: 20px;
            color: #555;
        }
        .buttons-container {
            display: flex;
            gap: 20px;
            margin-top: 40px;
        }
        .button {
            background-color: #204060;
            color: white;
            padding: 15px 30px;
            border-radius: 6px;
            font-size: 18px;
            text-decoration: none;
            cursor: pointer;
            transition: background-color 0.3s ease;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .button:hover {
            background-color: #102030;
        }
        .footer {
            margin-top: 50px;
            text-align: center;
            padding: 10px;
            background-color: #204060;
            color: white;
        }
    </style>
</head>
<body>

    <!-- Navbar -->
    <div class="navbar">
        <div class="navbar-title">Admin Dashboard</div>
        <div class="nav-links">
            <a href="index.jsp">Home</a>
            <a href="aboutUs.jsp">About Us</a>
            <a href="admin_login.jsp" class="logout-button">Logout</a>
        </div>
    </div>

    <!-- Main Container -->
    <div class="container">
        <!-- Dashboard Overview -->
        <div class="dashboard">
            <div class="dashboard-card">
                <h3>Total Places</h3>
                <p><%= totalPlaces %></p>
            </div>
            <div class="dashboard-card">
                <h3>Total Bookings</h3>
                <p><%= totalBookings %></p>
            </div>
        </div>

        <!-- Navigation Buttons -->
        <div class="buttons-container">
            <a href="allplaces.jsp" class="button">
                <span class="material-icons">place</span>
                Go to Places
            </a>

            <a href="show_bookings.jsp" class="button">
                <span class="material-icons">visibility</span>
                Show All Bookings
            </a>
        </div>
    </div>

    <!-- Footer -->
    <div class="footer">
        <p>&copy; 2025 Your Project Name. All rights reserved.</p>
    </div>

</body>
</html>
