<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, java.util.*, railwaymgt.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Search & View Employees</title>
    </head>
        <body>
            <jsp:useBean id="I" class="railwaymgt.Individual" scope="session"/>
            <jsp:useBean id="E" class="railwaymgt.Employee" scope="session"/>
            <jsp:useBean id="EP" class="railwaymgt.Employee_Positions" scope="session"/>
            <jsp:useBean id="SD" class="railwaymgt.Shift_Days" scope="session"/>
            <h1>Search & View Employees</h1>

            <form action="searchview_employee.jsp" method="GET">
                <label for="employeeLastName">Search by Employee Last Name:</label>
                <input type="text" id="employeeLastName" name="employeeLastName">
                <label for="station_name">Filter by Assigned Station:</label>
                <jsp:useBean id="T" class="railwaymgt.Train" scope="session"/>
                    <select id="station_name" name="station_name">
                            <option value="">All</option>
                        <%
                            T.available_stations();
                            for (int i = 0; i < T.available_stations.size(); i++) {
                        %>
                            <option value="<%=T.available_stations.get(i)%>"><%=T.station_names.get(i)%></option>
                        <% }
                        %>
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
                    <th>Employee ID</th>
                    <th>Last Name</th>
                    <th>First Name</th>
                    <th>Gender</th>
                    <th>Email</th>
                    <th>Phone Number</th>
                    <th>Position Title</th>
                    <th>Assigned Station</th>
                    <th>Shift Type</th>
                </tr>

                <%
                    String search_name = request.getParameter("employeeLastName");
                    String station_name = request.getParameter("station_name");

                    if ((search_name != null && !search_name.isEmpty()) || (station_name != null && !station_name.isEmpty())) {
                        E.view_employee_by_search_name_and_assigned_station(search_name, station_name);
                    } else {
                        E.view_all_employee();
                    }

                    for (int i = 0; i < E.employee_idList.size(); i++) {
                %>

                <tr>
                    <td><%=E.employee_idList.get(i)%></td>
                    <td><%=E.indiv_lastnameList.get(i)%></td>
                    <td><%=E.indiv_firstnameList.get(i)%></td>
                    <td><%=E.indiv_genderList.get(i)%></td>
                    <td><%=E.emailList.get(i)%></td>
                    <td><%=E.phone_numberList.get(i)%></td>
                    <td><%=E.position_titleList.get(i)%></td>
                    <td><%=E.station_nameList.get(i)%></td>
                    <td><%=E.shift_typeList.get(i)%></td>
                    <td>
                        <form action="searchview_employee.jsp" method="POST">
                            <input type="hidden" name="deleteEmployeeId" value="<%=E.employee_idList.get(i)%>">
                            <input type="submit" value="Delete" name="action" class="action-button">
                        </form>
                        <form action="update_employee.jsp" method="GET">
                            <input type="hidden" name="editEmployeeId" value="<%=E.employee_idList.get(i)%>">
                            <input type="submit" value="Update" name="action" class="action-button">
                        </form>
                    </td>

                </tr>
                <% }
                %>
            </table>
        </body>
</html>