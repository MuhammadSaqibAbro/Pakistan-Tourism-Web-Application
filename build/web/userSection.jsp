<%@ page import="java.sql.*, java.util.*" %>
<%@ include file="db.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
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
    <title>User Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Google Material Icons -->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

    <style>
        html, body {
            margin: 0;
            padding: 0;
            height: 100%;
            font-family: 'Segoe UI', sans-serif;
            background-color: #f4f7fc;
        }

        body {
            display: flex;
            flex-direction: column;
        }

        .navbar {
            background-color: #204060;
            padding: 25px 30px;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
        }

        .navbar-title {
            font-size: 26px;
            font-weight: bold;
        }

        .nav-links a {
            color: white;
            margin-left: 25px;
            text-decoration: none;
            font-size: 16px;
            display: inline-flex;
            align-items: center;
            transition: color 0.3s ease;
        }

        .nav-links a i {
            margin-right: 5px;
        }

        .nav-links a:hover {
            color: #a8c0e0;
        }

        .container {
            flex: 1;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 40px 20px;
        }

        .dashboard {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 30px;
            width: 100%;
            max-width: 1200px;
            margin-bottom: 40px;
        }

        .dashboard-card {
            background-color: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.1);
            width: 280px;
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .dashboard-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
        }

        .dashboard-card h3 {
            color: #204060;
            font-size: 26px;
            margin-bottom: 10px;
        }

        .dashboard-card p {
            font-size: 24px;
            color: #333;
            font-weight: bold;
        }

        .buttons-container {
            margin-top: 30px;
        }
                .nav-links .logout-button {
            background-color: red;
            padding: 8px 16px;
        }
        .nav-links .logout-button:hover {
            background-color: darkred;
        }
        .button {
            background-color: #204060;
            color: white;
            padding: 14px 32px;
            border-radius: 8px;
            font-size: 18px;
            text-decoration: none;
            transition: background 0.3s ease;
        }

        .button:hover {
            background: linear-gradient(45deg, #102030, #305080);
        }

        .footer {
            background-color: #204060;
            color: white;
            text-align: center;
            padding: 20px;
            font-size: 14px;
        }

        @media (max-width: 600px) {
            .dashboard {
                flex-direction: column;
                align-items: center;
            }
            .nav-links {
                width: 100%;
                text-align: center;
                margin-top: 10px;
            }
            .nav-links a {
                display: block;
                margin: 10px 0;
            }
        }
    </style>
</head>
<body>

    <!-- Navbar -->
    <div class="navbar">
        <div class="navbar-title">User Dashboard</div>
        <div class="nav-links">
            <a href="index.jsp"><i class="material-icons">home</i>Home</a>
            <a href="aboutUsUser.jsp"><i class="material-icons">info</i>About Us</a>
            <a href="book_place.jsp"><i class="material-icons">event</i>Booking</a>
             <a href="user_login.jsp" class="logout-button">Logout</a>
        </div>
    </div>

    <!-- Main Content -->
    <div class="container">
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

        <div class="buttons-container">
            <a href="book_place.jsp" class="button">Book a Place</a>
        </div>
    </div>

    <!-- Footer -->
    <div class="footer">
        &copy; 2025 Your Project Name. All rights reserved.
    </div>

</body>
</html>
