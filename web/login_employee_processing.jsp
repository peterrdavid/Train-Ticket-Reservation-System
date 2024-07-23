<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, java.util.*, railwaymgt.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Log In Employee Processing</title>
    </head>
    <body>
        <%
        try {
            String default_username = "admin";
            String default_password = "1234";

            String username = request.getParameter("username");
            String password = request.getParameter("password");
            
            boolean loginStatus = username.equals(default_username) && password.equals(default_password);
                
            if (loginStatus) {
                response.sendRedirect("employee_view.html");
             } else {
            %>
                <h1>Login failed!</h1><br>
                <a href="login_employee.html">Go Back</a><br>
            <% }
        } catch (Exception e) {
            out.println("<h1>Error during login: " + e.getMessage() + "</h1>");
        }
        %>
    </body>
</html>