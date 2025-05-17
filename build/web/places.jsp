<%@ include file="db.jsp" %>
<html>
<head><title>Pakistan Places</title></head>
<body>
<h2>Explore Famous Places in the Pakistan</h2>
<%
    Statement stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT * FROM places");

    while (rs.next()) {
        out.println("<h3>" + rs.getString("name") + " (" + rs.getString("location") + ")</h3>");
        out.println("<p>" + rs.getString("description") + "</p><hr>");
    }
    conn.close();
%>
</body>
</html>
