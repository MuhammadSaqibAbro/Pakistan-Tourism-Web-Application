<%@ page import="java.sql.*" %>
<%@ include file="db.jsp" %>
<%
    String query = request.getParameter("query");
    PreparedStatement ps = conn.prepareStatement("SELECT * FROM places WHERE name LIKE ? OR location LIKE ?");
    ps.setString(1, "%" + query + "%");
    ps.setString(2, "%" + query + "%");
    ResultSet rs = ps.executeQuery();
%>
<table>
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Location</th>
        <th>Description</th>
        <th>Actions</th>
    </tr>
<%
    while (rs.next()) {
%>
    <tr>
        <td><%= rs.getInt("id") %></td>
        <td><%= rs.getString("name") %></td>
        <td><%= rs.getString("location") %></td>
        <td><%= rs.getString("description") %></td>
        <td class="action-buttons">
            <a class="edit-btn" href="index.jsp?edit=<%= rs.getInt("id") %>">Edit</a>
            <a class="delete-btn" href="index.jsp?delete=<%= rs.getInt("id") %>" onclick="return confirm('Are you sure you want to delete this place?');">Delete</a>
        </td>
    </tr>
<%
    }
    conn.close();
%>
</table>
