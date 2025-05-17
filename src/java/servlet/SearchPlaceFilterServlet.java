/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package servlet;

/**
 *
 * @author SAQIB
 */


import dbConnection.DBConnection;
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;

@WebServlet("/searchPlace")
public class SearchPlaceFilterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String searchQuery = request.getParameter("searchQuery");

        if (searchQuery == null || searchQuery.trim().isEmpty()) {
            // If no search query is provided, return all bookings
            showAllBookings(request, response);
        } else {
            // Perform search for places matching the query
            searchBookingsByPlace(request, response, searchQuery);
        }
    }

    // Method to display all bookings
    private void showAllBookings(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            // Get database connection
            conn = DBConnection.getConnection();
            stmt = conn.createStatement();

            // Execute query to fetch all bookings
            rs = stmt.executeQuery(
                "SELECT b.id, b.name, b.email, b.booking_date, p.name AS place_name, p.location " +
                "FROM bookings b JOIN places p ON b.place_id = p.id ORDER BY b.booking_date DESC"
            );

            // Set the ResultSet as an attribute to be accessed in the JSP page
            request.setAttribute("bookings", rs);

            // Forward the request and response to the JSP page for rendering the table
            RequestDispatcher dispatcher = request.getRequestDispatcher("/allbookings.jsp");
            dispatcher.forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close resources
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // Method to search bookings based on the place
    private void searchBookingsByPlace(HttpServletRequest request, HttpServletResponse response, String searchQuery) throws ServletException, IOException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // Get database connection
            conn = DBConnection.getConnection();

            // Execute the query to search bookings by place name or location
            String sql = "SELECT b.id, b.name, b.email, b.booking_date, p.name AS place_name, p.location " +
                         "FROM bookings b JOIN places p ON b.place_id = p.id " +
                         "WHERE p.name LIKE ? OR p.location LIKE ? " +
                         "ORDER BY b.booking_date DESC";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, "%" + searchQuery + "%");
            stmt.setString(2, "%" + searchQuery + "%");
            rs = stmt.executeQuery();

            // Set the ResultSet as an attribute to be accessed in the JSP page
            request.setAttribute("bookings", rs);

            // Forward the request and response to the JSP page for rendering the table
            RequestDispatcher dispatcher = request.getRequestDispatcher("/allbookings.jsp");
            dispatcher.forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close resources
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
