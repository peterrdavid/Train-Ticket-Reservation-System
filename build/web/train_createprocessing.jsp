<%-- 
    Document   : train_createprocessing
    Created on : 11 19, 23, 2:49:03 AM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, java.util.*, train_management.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Train Processing</title>
    </head>
    <body>
        <jsp:useBean id ="T" class="railwaymgt.Train" scope ="session"/>
        <%
            String train_name = request.getParameter("train_name");
            int origin_station = Integer.parseInt(request.getParameter("origin_station"));
            int destination_station = Integer.parseInt(request.getParameter("destination_station"));
            String departure_date = request.getParameter("departure_date");
            String departure_time = request.getParameter("departure_time");
            int capacity = Integer.parseInt(request.getParameter("capacity"));
            int operator = Integer.parseInt(request.getParameter("operator"));
            
            T.train_name = train_name;
            T.origin_station = origin_station;
            T.destination_station = destination_station;
            T.departure_date = departure_date;
            T.departure_time = departure_time;
            T.capacity = capacity;
            T.operator = operator;

            int status = T.register_train();
            
            if (status == 1) {
        %>
        
        <h1>Create Train Successful</h1><br>
        <a href="manage_trains.html">Go Back</a><br>
        
        <%
            }
            else {
        %>
        
        <h1>Create Train Failed</h1><br>
        <a href="manage_trains.html">Go Back</a><br>
        <%
            }  
        %>
        
    </body>
</html>
