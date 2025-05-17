<%@ include file="db.jsp" %>
<%
    if (request.getParameter("cancel") != null) {
        String email = request.getParameter("email");

        PreparedStatement ps = conn.prepareStatement("DELETE FROM bookings WHERE email = ?");
        ps.setString(1, email);
        int rows = ps.executeUpdate();

        if (rows > 0) {
            response.sendRedirect("success.jsp?msg=Booking cancelled!");
        } else {
            response.sendRedirect("error.jsp?msg=No booking found for this email.");
        }
        return;
    }
%>
<html>
<body>
<h2>Cancel Booking</h2>
<form method="post">
    Enter your Email to cancel: <input type="email" name="email" required>
    <input type="submit" name="cancel" value="Cancel Booking">
</form>
</body>
</html>
