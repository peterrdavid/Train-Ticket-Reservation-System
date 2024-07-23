<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
      <title>Create New Employee</title>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <form action="employees_processing.jsp">
            Last Name:         <input type="text" id="indiv_lastname" name="indiv_lastname" required><br>
            First Name:          <input type="text" id="indiv_firstname" name="indiv_firstname" required><br>
            Gender:             <select id="indiv_gender" name="indiv_gender" required>
                                    <option value="Male">Male</option>
                                    <option value="Female">Female</option>
                                    <option value="Other">Other</option>
                                </select><br>
            Email:              <input type="email" id="email" name="email" required><br>
            Phone Number:       <input type="text" id="phone_number" name="phone_number" required><br>
            
            <%--Change below--%>
            
            <jsp:useBean id="T" class="railwaymgt.Train" scope="session"/>
            Assigned Station: <select id="employee_station" name="employee_station">
                <%
                    T.available_stations();
                    for (int i = 0; i < T.available_stations.size(); i++) {
                %>
                    <option value="<%=T.available_stations.get(i)%>"><%=T.station_names.get(i)%></option>
                <% }
                %>
            </select><br>

            Shift Type:         <select id="shift_type" name="shift_type" required>
                                    <option value="Morning Shift">Morning Shift</option>
                                    <option value="Afternoon Shift">Afternoon Shift</option>
                                </select><br>
            
            <jsp:useBean id="P" class="railwaymgt.Shift_Days" scope="session"/>
            Shift Days:         <br>
                                <input type="checkbox" id="monday" name="shift_days[]" value="Monday">
                                <label for="monday">Monday</label><br>
                                <input type="checkbox" id="tuesday" name="shift_days[]" value="Tuesday">
                                <label for="tuesday">Tuesday</label><br>
                                <input type="checkbox" id="wednesday" name="shift_days[]" value="Wednesday">
                                <label for="wednesday">Wednesday</label><br>
                                <input type="checkbox" id="thursday" name="shift_days[]" value="Thursday">
                                <label for="thursday">Thursday</label><br>
                                <input type="checkbox" id="friday" name="shift_days[]" value="Friday">
                                <label for="friday">Friday</label><br>
                                <input type="checkbox" id="saturday" name="shift_days[]" value="Saturday">
                                <label for="saturday">Saturday</label><br>
                                <input type="checkbox" id="sunday" name="shift_days[]" value="Sunday">
                                <label for="sunday">Sunday</label><br>
           
            <jsp:useBean id="EP" class="railwaymgt.Employee_Positions" scope="session"/>
            Position:           <select id="position_title" name="position_title" required>
                                <%
                                    EP.show_employee_positions();
                                    for(int i=0; i<EP.position_idList.size(); i++) {
                                %>
                                    <option value="<%=EP.position_idList.get(i)%>"><%=EP.position_titleList.get(i)%></option>
                                <%  }
                                %>
                                </select><br>
            <input type="submit" value="Submit">
        </form>
    </body>
</html>