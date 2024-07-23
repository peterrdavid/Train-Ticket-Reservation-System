

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, java.util.*, railwaymgt.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Edit Train</title>
</head>
    <body>
        <form action="train_editprocessing.jsp" method="post">
            <jsp:useBean id="T" class="railwaymgt.Train" scope="session" />
            <%
                String edit_train_id = request.getParameter("edit_train_id");
                T.get_train_details(Integer.parseInt(edit_train_id));
            %>
            <h1>Edit Train</h1>
            Train Name: <input type="text" id="train_name" name="train_name" value="<%=T.train_name%>"><br>

            Origin Station: <select id="origin_station" name="origin_station" onchange="updateDestinationStations()">
                <%
                    T.available_stations();
                    for (int i = 0; i < T.available_stations.size(); i++) {
                %>
                    <option value="<%=T.available_stations.get(i)%>" <%= (T.available_stations.get(i) == T.origin_station) ? "selected" : "" %>>
                        <%=T.station_names.get(i)%>
                    </option>
                <% }
                %>
                    
            </select><br>

            <!-- Hidden input fields to store values -->
            <input type="hidden" id="hidden_destination_station" value="<%=T.destination_station%>">
            <input type="hidden" id="hidden_departure_datetime" value="<%=T.departure_datetime%>">
            
                

            Destination Station: <select id="destination_station" name="destination_station">
                <!-- The options will be populated dynamically using JavaScript -->
            </select><br>

            Departure Date <input type="date" id="departure_date" name="departure_date" value="<%=T.departure_date%>"><br>
            <%
                if (T.departure_time != null) {
            %>
                Departure Time <input type="time" id="departure_time" name="departure_time" value="<%=T.departure_time.substring(0, 5)%>"><br>
            <% } else {
            %>
                Departure Time <input type="time" id="departure_time" name="departure_time" value="<%=T.departure_time%>"><br>
            <% }
            %>
            <input type="hidden" id="train_id_to_edit" name="train_id_to_edit" value="<%=T.train_id%>">
            Capacity <input type="text" id="capacity" name="capacity" value="<%=T.capacity%>"><br>
            
            Status <select id="status" name="status">
                <%
                    ArrayList<String> status_list = new ArrayList<>();
                    status_list.add("En Route");
                    status_list.add("Available");
                    status_list.add("Under Maintenance");
                    for (int i = 0; i < status_list.size(); i++) {
                %>
                    <option value="<%=status_list.get(i)%>" <%= (status_list.get(i).equals(T.status)) ? "selected" : "" %>>
                        <%=status_list.get(i)%>
                    </option>
                <% }
                %>
            </select><br>
            
            Operator: <select id="operator" name="operator">
                <%
                    T.available_operators();
                    for (int i = 0; i < T.operator_idList.size(); i++) {
                %>
                    <option value="<%=T.operator_idList.get(i)%>" <%= (T.operator_idList.get(i) == T.operator) ? "selected" : "" %>>
                        <%=T.operator_nameList.get(i)%>
                    </option>
                <% }
                %>
            </select><br>

            <input type="submit" value="Submit"><br>
        </form>

        <form action="train_searchview.jsp">
            <br><input type="submit" value="Cancel">
        </form>

        <script>
            // JavaScript code at the bottom of the page
            function updateDestinationStations() {
                var originStationSelect = document.getElementById("origin_station");
                var destinationStationSelect = document.getElementById("destination_station");

                // Clear existing options
                destinationStationSelect.innerHTML = "";

                // Get the selected origin station
                var selectedOriginStation = originStationSelect.options[originStationSelect.selectedIndex].value;

                // Get the stored destination station value
                var storedDestinationStation = document.getElementById("hidden_destination_station").value;

                // Populate destination stations excluding the selected origin station
                <% for (int i = 0; i < T.available_stations.size(); i++) { %>
                    if ("<%=T.available_stations.get(i)%>" !== selectedOriginStation) {
                        var option = document.createElement("option");
                        option.value = "<%=T.available_stations.get(i)%>";
                        option.text = "<%=T.station_names.get(i)%>";

                        // Check if the current destination station matches the stored value
                        if ("<%=T.available_stations.get(i)%>" === storedDestinationStation) {
                            option.selected = true; // Set as preselected
                        }

                        destinationStationSelect.add(option);
                    }
                <% } %>
            }

            // Call the function on page load
            updateDestinationStations();
        </script>
    </body>


</html>

