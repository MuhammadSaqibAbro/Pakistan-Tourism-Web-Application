<%@ page import="java.sql.*" %>
<%
    String url = "jdbc:mysql://localhost:3306/uk_places_db";
    String user = "root";
    String password = "123456"; // your DB password

    Connection conn = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);
    } catch (Exception e) {
        out.println("Database connection error: " + e.getMessage());
    }
%>
