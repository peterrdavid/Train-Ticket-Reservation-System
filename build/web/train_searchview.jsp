<%-- 
    Document   : train_serachview.jsp
    Created on : 11 20, 23, 10:28:30 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, java.util.*, railwaymgt.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Search & View Trains</title>
    </head>
        <body>
            <jsp:useBean id="T" class="railwaymgt.Train" scope="session" />
            <h1>Search & View Trains</h1>

            <form action="train_searchview.jsp" method="GET">
                <label for="trainName">Search by Train Name:</label>
                <input type="text" id="trainName" name="trainName">
                <label for="status">Filter by Status:</label>
                <select id="status" name="status">
                    <option value="">All</option>
                    <option value="En Route">En Route</option>
                    <option value="Under Maintenance">Under Maintenance</option>
                    <option value="Available">Available</option>
                </select>
                <input type="submit" value="Search"><br><br>
            </form>

            <style>
                table {
                    border-collapse: collapse;
                    width: 100%;
                }

                th, td {
                    border: 1px solid #dddddd;
                    text-align: left;
                    padding: 8px;
                }

                tr:nth-child(even) {
                    background-color: #f2f2f2;
                }
                
                .action-button {
                    width: 80px;
                    text-align: center;
                }
            </style>

            <table>
                <tr>
                    <th>Train ID</th>
                    <th>Train Name</th>
                    <th>Origin</th>
                    <th>Destination</th>
                    <th>Departure Time</th>
                    <th>Capacity</th>
                    <th>Status</th>
                    <th>Operator</th>
                    <th>Action</th>
                </tr>

                <%
                    String searchName = request.getParameter("trainName");
                    String statusFilter = request.getParameter("status");

                    if ((searchName != null && !searchName.isEmpty()) || (statusFilter != null && !statusFilter.isEmpty())) {
                        T.view_trains_by_name_and_status(searchName, statusFilter);
                    } else { 
                        T.view_all_trains();
                    }

                    for (int i = 0; i < T.train_idList.size(); i++) {
                %>

                <tr>
                    <td><%=T.train_idList.get(i)%></td>
                    <td><%=T.train_nameList.get(i)%></td>

                    <%
                        if (T.train_originList.get(i) != 0) {
                    %>
                        <td><%=T.get_station_name(T.train_originList.get(i))%></td>
                        <td><%=T.get_station_name(T.train_destinationList.get(i))%></td>
                    <% } else {
                    %>
                        <td>-</td>
                        <td>-</td>
                    <% }
                    %>
                    <td><%=(T.departure_datetimeList.get(i) != null) ? T.departure_datetimeList.get(i).substring(0, 19) : '-' %></td>
                    <td><%=T.train_capacityList.get(i)%></td>
                    <td><%=T.train_statusList.get(i)%></td>
                    <td><%=T.get_operator_name(T.operator_idList.get(i))%></td>
                    <td>
                        <form action="train_searchview.jsp" method="POST">
                            <input type="hidden" name="delete_train_id" value="<%=T.train_idList.get(i)%>">
                            <input type="submit" value="Delete" name="action" class="action-button">
                        </form>
                        <form action="train_edit.jsp" method="GET">
                            <input type="hidden" name="edit_train_id" value="<%=T.train_idList.get(i)%>">
                            <input type="submit" value="Update" name="action" class="action-button">
                        </form>
                    </td>

                </tr>
                <% }
                %>
            </table>

            <%
                String delete_train_id = request.getParameter("delete_train_id");
                if (delete_train_id != null && !delete_train_id.isEmpty()) {
                    T.delete_train(Integer.parseInt(delete_train_id));
                    response.sendRedirect("train_searchview.jsp");
                }
            %>

        </body>




</html>
