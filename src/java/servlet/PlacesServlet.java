/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.util.*;

public class PlacesServlet extends HttpServlet {
    
    private Connection conn;

    @Override
    public void init() throws ServletException {
        try {
            // Establish database connection (make sure to replace with your own database connection setup)
            String dbUrl = "jdbc:mysql://localhost:3306/yourDatabase";
            String dbUser = "root";
            String dbPassword = "password";
            conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException("Database connection error.");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve all places or handle edit/delete actions
        String action = request.getParameter("action");
        
        if ("edit".equals(action)) {
            int placeId = Integer.parseInt(request.getParameter("id"));
            try {
                PreparedStatement ps = conn.prepareStatement("SELECT * FROM places WHERE id=?");
                ps.setInt(1, placeId);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    request.setAttribute("place", rs);
                    RequestDispatcher dispatcher = request.getRequestDispatcher("editPlace.jsp");
                    dispatcher.forward(request, response);
                }
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendRedirect("error.jsp");
            }
        } else if ("delete".equals(action)) {
            int placeId = Integer.parseInt(request.getParameter("id"));
            try {
                PreparedStatement ps = conn.prepareStatement("DELETE FROM places WHERE id=?");
                ps.setInt(1, placeId);
                ps.executeUpdate();
                response.sendRedirect("allplaces.jsp"); // Refresh the page after delete
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendRedirect("error.jsp");
            }
        } else {
            // Display all places
            try {
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM places");
                List<Map<String, Object>> places = new ArrayList<>();
                while (rs.next()) {
                    Map<String, Object> place = new HashMap<>();
                    place.put("id", rs.getInt("id"));
                    place.put("name", rs.getString("name"));
                    place.put("location", rs.getString("location"));
                    place.put("description", rs.getString("description"));
                    places.add(place);
                }
                request.setAttribute("places", places);
                RequestDispatcher dispatcher = request.getRequestDispatcher("allplaces.jsp");
                dispatcher.forward(request, response);
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendRedirect("error.jsp");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Handle add and update actions
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            String name = request.getParameter("name");
            String location = request.getParameter("location");
            String description = request.getParameter("description");
            try {
                PreparedStatement ps = conn.prepareStatement("INSERT INTO places (name, location, description) VALUES (?, ?, ?)");
                ps.setString(1, name);
                ps.setString(2, location);
                ps.setString(3, description);
                ps.executeUpdate();
                response.sendRedirect("allplaces.jsp"); // Redirect after adding place
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendRedirect("error.jsp");
            }
        } else if ("update".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String location = request.getParameter("location");
            String description = request.getParameter("description");
            try {
                PreparedStatement ps = conn.prepareStatement("UPDATE places SET name=?, location=?, description=? WHERE id=?");
                ps.setString(1, name);
                ps.setString(2, location);
                ps.setString(3, description);
                ps.setInt(4, id);
                ps.executeUpdate();
                response.sendRedirect("allplaces.jsp"); // Redirect after updating place
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendRedirect("error.jsp");
            }
        }
    }

    @Override
    public void destroy() {
        try {
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
