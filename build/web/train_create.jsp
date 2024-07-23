<%-- 
    Document   : train_create
    Created on : 11 20, 23, 2:04:38 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, java.util.*, railwaymgt.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Train</title>
    </head>
    <body>
        <form action="train_createprocessing.jsp" method="post" onsubmit="return validateForm()">
            <jsp:useBean id="T" class="railwaymgt.Train" scope="session" />
            <h1>Create New Train</h1>
            Train Name: <input type="text" id="train_name" name="train_name"><br>

            Origin Station: <select id="origin_station" name="origin_station" onchange="updateDestinationStations()">
                <%
                    T.available_stations();
                    for (int i = 0; i < T.available_stations.size(); i++) {
                %>
                    <option value="<%=T.available_stations.get(i)%>"><%=T.station_names.get(i)%></option>
                <% }
                %>
            </select><br>

            Destination Station: <select id="destination_station" name="destination_station">
                <!-- The options will be populated dynamically using JavaScript -->
            </select><br>

            Departure Date <input type="date" id="departure_date" name="departure_date"><br>
            Departure Time <input type="time" id="departure_time" name="departure_time"><br>
            Capacity <input type="text" id="capacity" name="capacity"><br>
            Operator: <select id="operator" name="operator">
                <%
                    T.available_operators();
                    for (int i = 0; i < T.operator_idList.size(); i++) {
                %>
                    <option value="<%=T.operator_idList.get(i)%>"><%=T.operator_nameList.get(i)%></option>
                <% }
                %>
            </select><br>

            <input type="submit" value="Submit"><br>
        </form>

        <form action="manage_trains.html">
            <br><input type="submit" value="Cancel">
        </form>

        <script>
            function updateDestinationStations() {
                var originStationSelect = document.getElementById("origin_station");
                var destinationStationSelect = document.getElementById("destination_station");

                // Clear existing options
                destinationStationSelect.innerHTML = "";

                // Get the selected origin station
                var selectedOriginStation = originStationSelect.options[originStationSelect.selectedIndex].value;

                // Populate destination stations excluding the selected origin station
                <% for (int i = 0; i < T.available_stations.size(); i++) { %>
                    if ("<%=T.available_stations.get(i)%>" !== selectedOriginStation) {
                        var option = document.createElement("option");
                        option.value = "<%=T.available_stations.get(i)%>";
                        option.text = "<%=T.station_names.get(i)%>";
                        destinationStationSelect.add(option);
                    }
                <% } %>
            }
        </script>
    </body>
</html>
