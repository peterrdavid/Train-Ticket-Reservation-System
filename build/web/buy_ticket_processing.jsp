<%-- 
    Document   : buy_ticker_processing
    Created on : 11 20, 23, 3:02:24 AM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, java.util.*, railwaymgt.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Buy Ticket Processing</title>
    </head>
    <body>
        <jsp:useBean id = "T" class="railwaymgt.Train" scope ="session"/>
        <jsp:useBean id = "C" class="railwaymgt.Ticket" scope ="session"/>
        <%
            try {
                String origin_station = request.getParameter("origin_station");
                String destination_station = request.getParameter("destination_station");
               
                T.origin_station = origin_station;
                T.destination_station = destination_station;
                
                if (0==0) {
                %>
                    <h1>TEXT</h1>
                <% } else {
                %>
                    <h1>TEXT</h1><br>
                <%  }
            } catch (Exception e) {
                out.println("<h1>Error during login: " + e.getMessage() + "</h1>");
            }
        %>
    </body>
</html>