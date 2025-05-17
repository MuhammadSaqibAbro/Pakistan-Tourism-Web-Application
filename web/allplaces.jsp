<%@ page import="java.sql.*" %>
<%@ include file="db.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
    // Handle Add
    if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("add") != null) {
        String name = request.getParameter("name");
        String location = request.getParameter("location");
        String description = request.getParameter("description");
        PreparedStatement ps = conn.prepareStatement("INSERT INTO places (name, location, description) VALUES (?, ?, ?)");
        ps.setString(1, name);
        ps.setString(2, location);
        ps.setString(3, description);
        ps.executeUpdate();
    }

    // Handle Delete
    if (request.getParameter("delete") != null) {
        int id = Integer.parseInt(request.getParameter("delete"));
        PreparedStatement ps = conn.prepareStatement("DELETE FROM places WHERE id=?");
        ps.setInt(1, id);
        ps.executeUpdate();
    }

    // Handle Update
    if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("update") != null) {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String location = request.getParameter("location");
        String description = request.getParameter("description");
        PreparedStatement ps = conn.prepareStatement("UPDATE places SET name=?, location=?, description=? WHERE id=?");
        ps.setString(1, name);
        ps.setString(2, location);
        ps.setString(3, description);
        ps.setInt(4, id);
        ps.executeUpdate();
    }

    ResultSet editPlace = null;
    if (request.getParameter("edit") != null) {
        int editId = Integer.parseInt(request.getParameter("edit"));
        PreparedStatement ps = conn.prepareStatement("SELECT * FROM places WHERE id=?");
        ps.setInt(1, editId);
        editPlace = ps.executeQuery();
        editPlace.next();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Pakistan Places CRUD</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #f2f4f8;
            margin: 0;
        }

        .navbar {
            background-color: #204060;
            padding: 15px 30px;
            color: white;
            font-size: 20px;
            font-weight: bold;
        }

        .container {
            padding: 30px;
            max-width: 900px;
            margin: auto;
        }

        h2 {
            text-align: center;
            color: #204060;
        }

        form {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px #ccc;
            margin-top: 20px;
        }

        input, textarea {
            width: 100%;
            padding: 10px;
            margin: 8px 0;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        button {
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            margin-right: 10px;
        }

        .btn-add {
            background-color: #204060;
            color: white;
        }

        .btn-update {
            background-color: green;
            color: white;
        }

        .search-box {
            margin-top: 30px;
            margin-bottom: 20px;
            text-align: center;
        }

        .search-box input {
            width: 60%;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        table {
            width: 100%;
            border-collapse: collapse;
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

        .action-buttons {
            display: flex;
            gap: 10px;
        }

        .edit-btn {
            background-color: green;
            color: white;
            padding: 6px 12px;
            text-decoration: none;
            border-radius: 5px;
        }

        .delete-btn {
            background-color: red;
            color: white;
            padding: 6px 12px;
            text-decoration: none;
            border-radius: 5px;
        }

        .edit-btn:hover, .delete-btn:hover {
            opacity: 0.85;
        }
    </style>

    <script>
        function searchPlaces() {
            var query = document.getElementById("search").value;
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "search_places.jsp?query=" + query, true);
            xhr.onreadystatechange = function () {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    document.getElementById("places-table").innerHTML = xhr.responseText;
                }
            };
            xhr.send();
        }
    </script>
</head>
<body>

<div class="navbar">
    Pakistan Places Management
</div>

<div class="container">
    <h2>Explore & Manage Pakistan Places</h2>

    <form method="post">
        <%
            if (editPlace != null) {
        %>
            <input type="hidden" name="id" value="<%= editPlace.getInt("id") %>">
            <input type="text" name="name" value="<%= editPlace.getString("name") %>" placeholder="Name" required>
            <input type="text" name="location" value="<%= editPlace.getString("location") %>" placeholder="Location" required>
            <textarea name="description" placeholder="Description" required><%= editPlace.getString("description") %></textarea>
            <button type="submit" name="update" class="btn-update">Update Place</button>
        <%
            } else {
        %>
            <input type="text" name="name" placeholder="Name" required>
            <input type="text" name="location" placeholder="Location" required>
            <textarea name="description" placeholder="Description" required></textarea>
            <button type="submit" name="add" class="btn-add">Add Place</button>
        <%
            }
        %>
    </form>

    <div class="search-box">
        <input type="text" id="search" placeholder="Search by name or location..." onkeyup="searchPlaces()">
    </div>

    <div id="places-table">
        <table>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Location</th>
                <th>Description</th>
                <th>Actions</th>
            </tr>
            <%
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM places");
                while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getInt("id") %></td>
                <td><%= rs.getString("name") %></td>
                <td><%= rs.getString("location") %></td>
                <td><%= rs.getString("description") %></td>
                <td class="action-buttons">
                    <a class="edit-btn" href="allplaces.jsp?edit=<%= rs.getInt("id") %>">Edit</a>
                    <a class="delete-btn" href="allplaces.jsp?delete=<%= rs.getInt("id") %>" onclick="return confirm('Are you sure you want to delete this place?');">Delete</a>
                </td>
            </tr>
            <%
                }
                conn.close();
            %>
        </table>
    </div>
</div>

</body>
</html>
