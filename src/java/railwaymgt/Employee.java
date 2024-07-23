package railwaymgt;

import java.util.*;
import java.sql.*;

public class Employee {
    
    public int      employee_id;
    public int      indiv_id;
    public int      assigned_station;
    public String   shift_type;
    public int      position_id;
    
    public String   indiv_lastname;
    public String   indiv_firstname;
    public String   indiv_gender;
    public String   email;
    public String   phone_number;
    public String   shift_days;
    public String   position_title;
    public String   station_name;
    
    public ArrayList<Integer>   employee_idList         = new ArrayList<>();
    public ArrayList<Integer>   indiv_idList            = new ArrayList<>();
    public ArrayList<Integer>   assigned_stationList    = new ArrayList<>();
    public ArrayList<String>    shift_typeList          = new ArrayList<>();
    public ArrayList<Integer>   position_idList         = new ArrayList<>();
    
    public ArrayList<String>    indiv_lastnameList      = new ArrayList<>();
    public ArrayList<String>    indiv_firstnameList     = new ArrayList<>();
    public ArrayList<String>    indiv_genderList        = new ArrayList<>();
    public ArrayList<String>    emailList               = new ArrayList<>();
    public ArrayList<String>    phone_numberList        = new ArrayList<>();
    public ArrayList<String>    shift_daysList          = new ArrayList<>();
    public ArrayList<String>    position_titleList      = new ArrayList<>();
    public ArrayList<String>    station_nameList        = new ArrayList<>();

    public Employee() {}

    public int create_employee() {
        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/railway_db?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection Successful");
            
            PreparedStatement pstmtEmployee = conn.prepareStatement("SELECT MAX(employee_id) + 1 AS new_employee_id FROM employee");
            ResultSet rstEmployee = pstmtEmployee.executeQuery();
            
            while (rstEmployee.next()) {
                employee_id = rstEmployee.getInt("new_employee_id");
            }

            pstmtEmployee = conn.prepareStatement("INSERT INTO employee VALUE (?, ?, ?, ?, ?)");
            pstmtEmployee.setInt(1, employee_id);
            pstmtEmployee.setInt(2, indiv_id);
            pstmtEmployee.setInt(3, assigned_station);
            pstmtEmployee.setString(4, shift_type);
            pstmtEmployee.setInt(5, position_id);

            pstmtEmployee.executeUpdate();
            
            pstmtEmployee.close();

            conn.close();

            System.out.println("Successful");
            return 1;
            
        } catch (Exception e) {
            System.out.println("SQL Error: " + e.getMessage());
            return 0;
        }
    }
    
    public int view_employee_by_search_name_and_assigned_station(String employeeLastName, String station_name) {
        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/railway_db?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection Successful");

            // Construct the SQL query based on the provided parameters
            StringBuilder queryBuilder = new StringBuilder("SELECT employee_id, indiv_lastname, indiv_firstname, indiv_gender, email, phone_number, shift_type, position_title, station_name, shift_type FROM employee e JOIN individual i ON e.indiv_id = i.indiv_id JOIN employee_positions ep ON e.position_id = ep.position_id JOIN station s ON e.assigned_station = s.station_id WHERE 1=1");

            if (employeeLastName != null && !employeeLastName.isEmpty()) {
                queryBuilder.append(" AND indiv_lastname LIKE ?");
            }

            if (station_name != null && !station_name.isEmpty()) {
                queryBuilder.append(" AND station_name = ?");
            }

            PreparedStatement pstmt = conn.prepareStatement(queryBuilder.toString());

            // Set parameters based on the provided values
            int parameterIndex = 1;

            if (employeeLastName != null && !employeeLastName.isEmpty()) {
                pstmt.setString(parameterIndex++, "%" + employeeLastName + "%");
            }

            if (station_name != null && !station_name.isEmpty()) {
                pstmt.setString(parameterIndex++, station_name);
            }

            ResultSet rst = pstmt.executeQuery();

            indiv_lastnameList.clear();
            indiv_firstnameList.clear();
            indiv_genderList.clear();
            emailList.clear();
            phone_numberList.clear();
            position_titleList.clear();
            station_nameList.clear();
            
            employee_idList.clear();
            indiv_idList.clear();
            shift_typeList.clear();

            while (rst.next()) {
                employee_idList.add(rst.getInt("employee_id"));
                indiv_lastnameList.add(rst.getString("indiv_lastname"));
                indiv_firstnameList.add(rst.getString("indiv_firstname"));
                indiv_genderList.add(rst.getString("indiv_gender"));
                emailList.add(rst.getString("email"));
                phone_numberList.add(rst.getString("phone_number"));
                position_titleList.add(rst.getString("position_title"));
                station_nameList.add(rst.getString("station_name"));
                shift_typeList.add(rst.getString("shift_type"));
            }

            pstmt.close();
            conn.close();

            return 1;
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return 0;
        }
    }
    
    public int view_all_employee() {
        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/railway_db?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection Successful");

            PreparedStatement pstmt = conn.prepareStatement("SELECT employee_id, indiv_lastname, indiv_firstname, indiv_gender, email, phone_number, shift_type, position_title, station_name, shift_type FROM employee e JOIN individual i ON e.indiv_id = i.indiv_id JOIN employee_positions ep ON e.position_id = ep.position_id JOIN station s ON e.assigned_station = s.station_id");
            ResultSet rst = pstmt.executeQuery();
    
            indiv_lastnameList.clear();
            indiv_firstnameList.clear();
            indiv_genderList.clear();
            emailList.clear();
            phone_numberList.clear();
            position_titleList.clear();
            station_nameList.clear();
            
            employee_idList.clear();
            indiv_idList.clear();
            shift_typeList.clear();


            while (rst.next()) {
                employee_idList.add(rst.getInt("employee_id"));
                indiv_lastnameList.add(rst.getString("indiv_lastname"));
                indiv_firstnameList.add(rst.getString("indiv_firstname"));
                indiv_genderList.add(rst.getString("indiv_gender"));
                emailList.add(rst.getString("email"));
                phone_numberList.add(rst.getString("phone_number"));
                position_titleList.add(rst.getString("position_title"));
                station_nameList.add(rst.getString("station_name"));
                shift_typeList.add(rst.getString("shift_type"));
              }
            
            pstmt.close();
            conn.close();

            return 1;
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return 0;
        }
    }
    
    public void get_employee_details(int employee_id) {
        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/railway_db?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection Successful");

            PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM employee e JOIN individual i ON e.indiv_id = i.indiv_id JOIN employee_positions ep ON e.position_id = ep.position_id JOIN station s ON e.assigned_station = s.station_id WHERE employee_id = ?");
            pstmt.setInt(1, employee_id);

            ResultSet rst = pstmt.executeQuery();

            while (rst.next()) {
                this.employee_id = rst.getInt("employee_id");
                this.indiv_lastname = rst.getString("indiv_lastname");
                this.indiv_firstname = rst.getString("indiv_firstname");
                this.indiv_gender = rst.getString("indiv_gender");
                this.email = rst.getString("email");
                this.phone_number = rst.getString("phone_number");
                this.position_title = rst.getString("position_title");
                this.station_name = rst.getString("station_name");
                this.shift_type = rst.getString("shift_type");
            }
            
            pstmt.close();
            conn.close();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }
    
    public int edit_employee(int employee_id, String new_indiv_lastname, String new_indiv_firstname, String new_indiv_gender, String new_email, String new_phone_number, String new_position_title, String new_station_name, String new_shift_type) {
        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/railway_db?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection Successful");

            PreparedStatement pstmt = conn.prepareStatement("UPDATE employee SET indiv_lastname = ?, indiv_firstname = ?, indiv_gender = ?, email = ?, phone_number = ?, position_title = ?, station_name = ?, shift_type = ? WHERE employee_id = ?");
            pstmt.setString(1, new_indiv_lastname);
            pstmt.setString(2, new_indiv_firstname);
            pstmt.setString(3, new_indiv_gender);
            pstmt.setString(4, new_email);
            pstmt.setString(5, new_phone_number);
            pstmt.setString(6, new_position_title);
            pstmt.setString(7, new_station_name);
            pstmt.setString(8, new_shift_type);
            pstmt.setInt(9, employee_id);
            
            /// pstmt.executeQuery();
            pstmt.executeUpdate();
            pstmt.close();
            conn.close();
            return 1;
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return 0;
        }
    }

    public void delete_employee(int employee_id) {
        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/railway_db?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection Successful");

            PreparedStatement pstmt = conn.prepareStatement("DELETE FROM employee WHERE employee_id = ?");
            pstmt.setInt(1, employee_id);
            pstmt.executeUpdate();

            pstmt.close();
            conn.close();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    public static void main(String args[]){
        
        Employee E = new Employee();
        E.employee_id = 5000001;
        E.indiv_id = 9000001;
        E.assigned_station = 1900001;
        E.shift_type = "Morning Shift";
        E.position_id = 01;
        E.create_employee();      
    }
}


