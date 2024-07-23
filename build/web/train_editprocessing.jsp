<%-- 
    Document   : train_editprocessing
    Created on : 11 21, 23, 7:05:05 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Train Processing</title>
    </head>
    <body>
        <jsp:useBean id ="T" class="railwaymgt.Train" scope ="session"/>
        <%
            int edit_train_id = Integer.parseInt(request.getParameter("train_id_to_edit"));
            String train_name = request.getParameter("train_name");
            
            int origin_station = Integer.parseInt(request.getParameter("origin_station"));
            int destination_station = Integer.parseInt(request.getParameter("destination_station"));
            String departure_date = request.getParameter("departure_date");
            String departure_time = request.getParameter("departure_time");
            int capacity = Integer.parseInt(request.getParameter("capacity"));
            String status = request.getParameter("status");
            int operator = Integer.parseInt(request.getParameter("operator"));
            
            T.train_name = train_name;
            T.origin_station = origin_station;
            T.destination_station = destination_station;
            T.departure_date = departure_date;
            T.departure_time = departure_time;
            T.capacity = capacity;
            T.operator = operator;
            T.status = status;

            int update_status = T.edit_train(edit_train_id, train_name, origin_station, destination_station, departure_date, departure_time, capacity, status, operator);
            
            if (update_status == 1) {
        %>
        
        <h1>Edit Train Successful</h1><br>
        <a href="manage_trains.html">Go Back</a><br>
        
        <%
            }
            else {
        %>
        
        <h1>Edit Train Failed</h1><br>
        <a href="manage_trains.html">Go Back</a><br>
        <%
            }  
        %>
    </body>
</html>
