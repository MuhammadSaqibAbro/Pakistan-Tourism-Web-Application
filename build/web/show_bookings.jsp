<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="db.jsp" %>

<%
    Statement stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery(
        "SELECT b.id, b.name, b.email, b.booking_date, p.name AS place_name, p.location " +
        "FROM bookings b JOIN places p ON b.place_id = p.id ORDER BY b.booking_date DESC"
    );
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>All Bookings</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f9fafb;
            margin: 30px;
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
            background-color: white;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        th, td {
            padding: 12px 15px;
            border: 1px solid #ddd;
            text-align: left;
        }
        th {
            background-color: #204060;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f1f4f7;
        }
    </style>
</head>
<body>

<h2>All Bookings</h2>

<table>
    <tr>
        <th>Booking ID</th>
        <th>Name</th>
        <th>Email</th>
        <th>Place Name</th>
        <th>Location</th>
        <th>Booking Date</th>
    </tr>
<%
    while (rs.next()) {
%>
    <tr>
        <td><%= rs.getInt("id") %></td>
        <td><%= rs.getString("name") %></td>
        <td><%= rs.getString("email") %></td>
        <td><%= rs.getString("place_name") %></td>
        <td><%= rs.getString("location") %></td>
        <td><%= rs.getDate("booking_date") %></td>
    </tr>
<%
    }
    conn.close();
%>
</table>

</body>
</html>
