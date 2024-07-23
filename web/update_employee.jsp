<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, java.util.*, railwaymgt.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Update Employee</title>
</head>
    <body>
        <form action="update_employee_processing.jsp" method="post">
            <jsp:useBean id="I" class="railwaymgt.Individual" scope="session"/>
            <jsp:useBean id="E" class="railwaymgt.Employee" scope="session"/>
            <jsp:useBean id="EP" class="railwaymgt.Employee_Positions" scope="session"/>
            <jsp:useBean id="SD" class="railwaymgt.Shift_Days" scope="session"/>
            <jsp:useBean id="T" class="railwaymgt.Train" scope="session"/>
            <%
                String update_employee_id = request.getParameter("update_employee_id");
                E.get_employee_details(Integer.parseInt(update_employee_id));
            %>
            <h1>Update Employee</h1>
            Last Name: <input type="text" id="indiv_lastname" name="indiv_lastname" value="<%=E.indiv_lastname%>"><br>
            First Name: <input type="text" id="indiv_firstname" name="indiv_firstname" value="<%=E.indiv_firstname%>"><br>
            Gender: <select id="indiv_gender" name="indiv_gender">
                        <%
                            ArrayList<String> indiv_gender = new ArrayList<>();
                            indiv_gender.add("Male");
                            indiv_gender.add("Female");
                            indiv_gender.add("Other");
                            for (int i = 0; i < indiv_gender.size(); i++) {
                        %>
                            <option value="<%=indiv_gender.get(i)%>" <%= (indiv_gender.get(i).equals(E.indiv_gender)) ? "selected" : "" %>>
                                <%=indiv_gender.get(i)%>
                            </option>
                        <% }
                        %>
                    </select><br>
            Email: <input type="email" id="email" name="email" value="<%=E.email%>"><br>
            Phone Number: <input type="text" id="phone_number" name="phone_number" value="<%=E.phone_number%>"><br>
            Position Title: <select id="position_title" name="position_title">
                                <%
                                    EP.show_employee_positions();
                                    for(int i=0; i < EP.position_idList.size(); i++) {
                                %>
                                    <option value="<%=EP.position_idList.get(i)%>"><%= (EP.position_titleList.get(i) == E.position_title) ? "selected" : "" %></option>
                                <%  }
                                %>
                                </select><br>
            Assigned Station: <select id="employee_station" name="employee_station">
                                <%
                                    T.available_stations();
                                    for (int i = 0; i < T.available_stations.size(); i++) {
                                %>
                                    <option value="<%=T.available_stations.get(i)%>"><%= (T.station_names.get(i) == E.station_name) ? "selected" : "" %></option>
                                <% }
                                %>
                              </select><br>
            Shift Type: <select id="shift_type" name="shift_type">
                        <%
                            ArrayList<String> shift_type = new ArrayList<>();
                            shift_type.add("Morning Shift");
                            shift_type.add("Afternoon Shift");
                            for (int i = 0; i < shift_type.size(); i++) {
                        %>
                            <option value="<%=shift_type.get(i)%>" <%= (shift_type.get(i).equals(E.shift_type)) ? "selected" : "" %>>
                                <%=shift_type.get(i)%>
                            </option>
                        <% }
                        %>
                    </select><br>

            <input type="hidden" name="employee_id_to_edit" value="<%=update_employee_id%>">

            <input type="submit" value="Submit"><br>
        </form>

        <form action="train_searchview.jsp">
            <br><input type="submit" value="Cancel">
        </form>
    </body>
</html>

