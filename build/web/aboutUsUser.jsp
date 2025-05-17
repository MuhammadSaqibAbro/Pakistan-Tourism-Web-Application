<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, java.util.*" %>
<%@ include file="db.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us</title>
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
        .container {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 50px 30px;
        }
        .about-header {
            text-align: center;
            font-size: 36px;
            color: #204060;
            margin-bottom: 40px;
        }
        .about-content {
            display: flex;
            justify-content: space-around;
            width: 100%;
            max-width: 1200px;
            margin-bottom: 50px;
            gap: 40px;
        }
        .about-text {
            width: 50%;
            text-align: left;
        }
        .about-text h2 {
            font-size: 32px;
            color: #204060;
            margin-bottom: 20px;
        }
        .about-text p {
            font-size: 18px;
            color: #555;
            line-height: 1.6;
        }
        .about-footer {
            text-align: center;
            padding: 20px;
            background-color: #204060;
            color: white;
        }
        .about-footer p {
            margin: 0;
            font-size: 14px;
        }
    </style>
</head>
<body>

    <!-- Navbar -->
    <div class="navbar">
        <div class="navbar-title">Admin Dashboard</div>
        <div class="nav-links">
            <a href="index.jsp">Home</a>
            <a href="aboutUsUser.jsp">About Us</a>
            <a href="user_login.jsp" class="logout-button">Logout</a>
        </div>
    </div>

    <!-- Main Content -->
    <div class="container">
        <!-- About Us Header -->
        <div class="about-header">
            <h1>About Us</h1>
            <p>Learn more about our mission and what we do</p>
        </div>

        <!-- About Us Content -->
        <div class="about-content">
            <div class="about-text">
                <h2>Our Mission</h2>
                <p>
                    We are a team dedicated to providing the best experiences for travelers and event-goers. Our platform allows users to easily explore places and book events with a simple and user-friendly interface. Our mission is to make booking and event management a hassle-free experience for everyone, ensuring smooth operations for both visitors and venue managers.
                </p>

                <h2>What We Do</h2>
                <p>
                    We offer a diverse range of places and events, from concerts to private bookings, allowing users to browse through available events and make informed decisions. Our goal is to continuously improve our services and create an environment that simplifies event management and enhances user satisfaction.
                </p>
            </div>
        </div>

        <!-- About Us Footer -->
        <div class="about-footer">
            <p>&copy; 2025 Your Project Name. All rights reserved.</p>
        </div>
    </div>

</body>
</html>
