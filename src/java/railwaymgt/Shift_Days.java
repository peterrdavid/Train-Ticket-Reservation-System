package railwaymgt;

import java.sql.*;
import java.util.*; 

public class Shift_Days {
    
    public int      employee_id;
    public String   shift_days;

    public ArrayList<Integer>   employee_idList  = new ArrayList<>();
    public ArrayList<String>    shift_daysList   = new ArrayList<>();

    public Shift_Days() {}

    public int show_shift_days() {
        try{
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/railway_db?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection Successful!");   

            PreparedStatement pstmtShift = conn.prepareStatement("SELECT employee_id, shift_days FROM shift_days");
            ResultSet rstShift = pstmtShift.executeQuery();

            employee_idList.clear();
            shift_daysList.clear();

            while(rstShift.next()) {
                employee_id = rstShift.getInt("employee_id");
                shift_days = rstShift.getString("shift_days");
                employee_idList.add(employee_id);
                shift_daysList.add(shift_days);
            }

            pstmtShift.close();
            conn.close();

            System.out.println("Successful");
            return 1;


        } catch(Exception e){
            System.out.println("SQL Error: " + e.getMessage());
            
            return 0;
        } 
    }
    
    public void insert_days(int employee_id, String[] days) {
        try{
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/railway_db?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection Successful!");   

            PreparedStatement pstmtShift = conn.prepareStatement("INSERT INTO shift_days VALUES (?, ?)");
            ResultSet rstShift = pstmtShift.executeQuery();

            for (int i = 0; i < days.length; i++) {
                pstmtShift.setInt(1, employee_id);
                pstmtShift.setString(2, days[i]);
            }

            pstmtShift.executeUpdate();
            pstmtShift.close();
            conn.close();

            System.out.println("Successful");

        } catch(Exception e){
            System.out.println("SQL Error: " + e.getMessage());
        } 
    }
    
    public int view_all_shift_days() {
        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/railway_db?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection Successful");

            PreparedStatement pstmt = conn.prepareStatement("SELECT shift_days FROM shift_days");
            ResultSet rst = pstmt.executeQuery();

            shift_daysList.clear();


            while (rst.next()) {
                shift_daysList.add(rst.getString("shift_days"));
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
