package railwaymgt;

import java.sql.*;
import java.util.*; 

public class Employee_Positions {
    
    public int      position_id;
    public String   position_title;

    public ArrayList<Integer>   position_idList      = new ArrayList<>();
    public ArrayList<String>    position_titleList   = new ArrayList<>();

    public Employee_Positions() {}

    public int show_employee_positions() {
        try{
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/railway_db?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection Successful!");   

            PreparedStatement pstmtPos = conn.prepareStatement("SELECT position_id, position_title FROM employee_positions");
            ResultSet rstPos = pstmtPos.executeQuery();

            position_idList.clear();
            position_titleList.clear();

            while(rstPos.next()) {
                position_id = rstPos.getInt("position_id");
                position_title = rstPos.getString("position_title");
                position_idList.add(position_id);
                position_titleList.add(position_title);
            }

            pstmtPos.close();
            conn.close();

            System.out.println("Successful");
            return 1;


        } catch(Exception e){
            System.out.println("SQL Error: " + e.getMessage());
            
            return 0;
        } 
    }
    
    public int view_all_employee_positions() {
        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/railway_db?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection Successful");

            PreparedStatement pstmt = conn.prepareStatement("SELECT position_title FROM employee_positions");
            ResultSet rst = pstmt.executeQuery();

            position_titleList.clear();


            while (rst.next()) {
                position_titleList.add(rst.getString("position_title"));
            }

            pstmt.close();
            conn.close();

            return 1;
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return 0;
        }
    }


}
