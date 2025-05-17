package servlet;

import dbConnection.DBConnection;
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;

@WebServlet("/allbookings")  // URL pattern for accessing the servlet
public class AllBookingsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("delete".equals(action)) {
            // Delete booking
            deleteBooking(request, response);
        } else if ("edit".equals(action)) {
            // Show edit booking page
            showEditBookingPage(request, response);
        } else {
            // Show all bookings (default)
            showAllBookings(request, response);
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

            // Execute query to fetch bookings
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

    // Method to delete a booking
    private void deleteBooking(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookingId = Integer.parseInt(request.getParameter("id"));
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            // Get database connection
            conn = DBConnection.getConnection();
            
            // Execute the delete query
            String sql = "DELETE FROM bookings WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, bookingId);
            int rowsAffected = stmt.executeUpdate();

            // If rows are affected, redirect to the all bookings page
            if (rowsAffected > 0) {
                response.sendRedirect("allbookings");
            } else {
                response.sendRedirect("error.jsp");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close resources
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // Method to show the edit booking page with existing booking details
    private void showEditBookingPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookingId = Integer.parseInt(request.getParameter("id"));
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // Get database connection
            conn = DBConnection.getConnection();
            
            // Execute the query to fetch booking details
            String sql = "SELECT b.id, b.name, b.email, b.booking_date, b.place_id " +
                         "FROM bookings b WHERE b.id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, bookingId);
            rs = stmt.executeQuery();

            // Set the booking details as a request attribute to be accessed in the edit page
            if (rs.next()) {
                request.setAttribute("booking", rs);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/editBooking.jsp");
                dispatcher.forward(request, response);
            } else {
                response.sendRedirect("error.jsp");
            }

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

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("create".equals(action)) {
            // Create a new booking
            createBooking(request, response);
        } else if ("update".equals(action)) {
            // Update an existing booking
            updateBooking(request, response);
        }
    }

    // Method to create a new booking
    private void createBooking(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String bookingDate = request.getParameter("booking_date");
        int placeId = Integer.parseInt(request.getParameter("place_id"));

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            // Get database connection
            conn = DBConnection.getConnection();

            // Insert the new booking into the database
            String sql = "INSERT INTO bookings (name, email, booking_date, place_id) VALUES (?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setString(3, bookingDate);
            stmt.setInt(4, placeId);
            int rowsAffected = stmt.executeUpdate();

            // If the booking was successfully created, redirect to all bookings page
            if (rowsAffected > 0) {
                response.sendRedirect("allbookings");
            } else {
                response.sendRedirect("error.jsp");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close resources
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // Method to update an existing booking
    private void updateBooking(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookingId = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String bookingDate = request.getParameter("booking_date");
        int placeId = Integer.parseInt(request.getParameter("place_id"));

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            // Get database connection
            conn = DBConnection.getConnection();

            // Update the booking details in the database
            String sql = "UPDATE bookings SET name = ?, email = ?, booking_date = ?, place_id = ? WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setString(3, bookingDate);
            stmt.setInt(4, placeId);
            stmt.setInt(5, bookingId);
            int rowsAffected = stmt.executeUpdate();

            // If the booking was successfully updated, redirect to all bookings page
            if (rowsAffected > 0) {
                response.sendRedirect("allbookings");
            } else {
                response.sendRedirect("error.jsp");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close resources
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
