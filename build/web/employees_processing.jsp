<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create New Employee Processing</title>
    </head>
    <body>
        <jsp:useBean id ="I" class="railwaymgt.Individual" scope ="session"/>
        <jsp:useBean id="E" class="railwaymgt.Employee" scope="session"/>
        <%
            String indiv_lastname = request.getParameter("indiv_lastname");
            String indiv_firstname = request.getParameter("indiv_firstname");
            String indiv_gender = request.getParameter("indiv_gender");
            String email = request.getParameter("email");
            String phone_number = request.getParameter("phone_number");

            int assigned_station = Integer.parseInt(request.getParameter("employee_station"));
            String shift_type = request.getParameter("shift_type");
            String[] shift_days = request.getParameterValues("shift_days[]");
            int position_title = Integer.parseInt(request.getParameter("position_title"));

            I.indiv_lastname = indiv_lastname;
            I.indiv_firstname = indiv_firstname;
            I.indiv_gender = indiv_gender;
            I.email = email;
            I.phone_number = phone_number;

            E.indiv_id = I.signup_individual("Employee");
            E.assigned_station = assigned_station;
            E.shift_type = shift_type;
            E.position_id = position_title;
            
            int statusE = E.create_employee();
            /*
            // E.shift_days = shift_days;
            
            */
            if (E.indiv_id != 0) {
            %>
            <h1>Create New Employee Successful</h1>
            <%
            }
            else {
            %>
            <h1>Create New Employee Failed</h1>
            <%
            }  
            %>
            
            <form action="index.html" method="POST">
            <input type="submit" value="Go Back">
            </form>
        
    </body>
</html>