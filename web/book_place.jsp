<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="db.jsp" %>

<%
    String placeId = request.getParameter("place_id");
    String email = request.getParameter("email");
    String name = request.getParameter("name");
    String action = request.getParameter("action");

    if ("confirm".equals(action) && placeId != null && email != null && name != null) {
        try {
            java.sql.Date sqlDate = new java.sql.Date(new java.util.Date().getTime());

            PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO bookings (name, email, place_id, booking_date) VALUES (?, ?, ?, ?)"
            );
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setInt(3, Integer.parseInt(placeId));
            ps.setDate(4, sqlDate);

            ps.executeUpdate();

            out.println("<script>alert('Booking confirmed!'); window.location.href='book_place.jsp';</script>");
        } catch (SQLException e) {
            out.println("<script>alert('Booking failed: " + e.getMessage() + "');</script>");
        }
    }

    Statement stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT * FROM places");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book a Place</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #f2f4f8;
            padding: 30px;
            color: #333;
        }
        h2 {
            text-align: center;
            color: #204060;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 40px;
            background: white;
            box-shadow: 0 0 10px #ccc;
        }
        th, td {
            padding: 12px 15px;
            border: 1px solid #ddd;
            text-align: left;
        }
        th {
            background: #204060;
            color: white;
        }
        .button {
            background: #204060;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }
        .button:hover {
            background: #102030;
        }
        /* Navbar Styles */
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
    </style>
    <script>
        function confirmBooking(placeId, placeName) {
            const name = prompt("Enter your name:");
            if (!name) {
                alert("Name is required.");
                return;
            }

            const email = prompt("Enter your email:");
            if (!email) {
                alert("Email is required.");
                return;
            }

            const confirmMsg = "Confirm booking for '" + placeName + "'?\nName: " + name + "\nEmail: " + email;
            if (confirm(confirmMsg)) {
                const url = "book_place.jsp?place_id=" + placeId + 
                            "&name=" + encodeURIComponent(name) + 
                            "&email=" + encodeURIComponent(email) + 
                            "&action=confirm";
                window.location.href = url;
            }
        }
    </script>
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
    <h2>Book a Place</h2>

    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Location</th>
            <th>Description</th>
            <th>Action</th>
        </tr>
    <%
        while (rs.next()) {
    %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getString("location") %></td>
            <td><%= rs.getString("description") %></td>
            <td>
                <button class="button" onclick="confirmBooking('<%= rs.getInt("id") %>', '<%= rs.getString("name").replace("'", "\\'") %>')">Book</button>
            </td>
        </tr>
    <%
        }
        conn.close();
    %>
    </table>

</body>
</html>
