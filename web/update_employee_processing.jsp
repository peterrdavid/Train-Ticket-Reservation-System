<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Employee Processing</title>
    </head>
    <body>
        <jsp:useBean id ="E" class="railwaymgt.Employee" scope ="session"/>
        <%
            int edit_employee_id = Integer.parseInt(request.getParameter("employee_id_to_edit"));
            String indiv_lastname = request.getParameter("indiv_lastname");
            String indiv_firstname = request.getParameter("indiv_firstname");
            String indiv_gender = request.getParameter("indiv_gender");
            String email = request.getParameter("email");
            String phone_number = request.getParameter("phone_number");
            String position_title = request.getParameter("position_title");
            String station_name = request.getParameter("station_name");
            String shift_type = request.getParameter("shift_type");
            
            E.indiv_lastname = indiv_lastname;
            E.indiv_firstname = indiv_firstname;
            E.indiv_gender = indiv_gender;
            E.email = email;
            E.phone_number = phone_number;
            E.position_title = position_title;
            E.station_name = station_name;
            E.shift_type = shift_type;

            int update_status = E.edit_employee(edit_employee_id, indiv_lastname, indiv_firstname, indiv_gender, email, phone_number, position_title, station_name, shift_type);
            
            if (update_status == 1) {
        %>
        
        <h1>Edit Train Successful</h1><br>
        <a href="manage_employees.html">Go Back</a><br>
        
        <%
            }
            else {
        %>
        
        <h1>Edit Train Failed</h1><br>
        <a href="manage_employees.html">Go Back</a><br>
        <%
            }  
        %>
    </body>
</html>
