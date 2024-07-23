package railwaymgt;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author ccslearner
 */

import java.sql.*;
import java.util.*; 

public class Individual {
    
    // fields of individual 
    
    public int      indiv_id;
    public String   indiv_lastname;
    public String   indiv_firstname;
    public String   indiv_gender;
    public String   indiv_type;
    public String   email;
    public String   phone_number;
   
    
    public ArrayList<Integer>   indiv_idlist         = new ArrayList<> ();
    public ArrayList<String>    indiv_lastnamelist   = new ArrayList<> ();
    public ArrayList<String>    indiv_firstnamelist  = new ArrayList<> ();
    public ArrayList<String>    indiv_genderlist     = new ArrayList<> ();
    public ArrayList<String>    indiv_typelist       = new ArrayList<> ();
    public ArrayList<String>    emaillist            = new ArrayList<> ();
    public ArrayList<String>    phone_numberlist     = new ArrayList<> ();

    public Individual(){}
    
    public int signup_individual(String type){
        
        try{
            // codes to interact w databases
            
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/railway_db?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection Successful!");            
            
            PreparedStatement pstmtIndiv = conn.prepareStatement("SELECT MAX(indiv_id) + 1 AS new_indiv_id FROM individual");
            ResultSet rstIndiv = pstmtIndiv.executeQuery();
        
            while(rstIndiv.next()){
                indiv_id = rstIndiv.getInt("new_indiv_id");
            }
           
            /*
            indiv_lastname = "Rex";
            indiv_firstname = "Orange County";
            indiv_gender = "Female";
            indiv_type = "Customer";
            email = "blue@gmail.com";
            phone_number = "+63-912-345-6789";
            */
            
            // insert into individual
            // (indiv_id, indiv_lastname, indiv_firstname, indiv_gender, email, phone_number)
            
            pstmtIndiv = conn.prepareStatement("INSERT INTO individual VALUE (?, ?, ?, ?, ?, ?, ?)");
            pstmtIndiv.setInt(1, indiv_id);
            pstmtIndiv.setString(2, indiv_lastname);
            pstmtIndiv.setString(3, indiv_firstname);
            pstmtIndiv.setString(4, indiv_gender);
            pstmtIndiv.setString(5, type);
            pstmtIndiv.setString(6, email);
            pstmtIndiv.setString(7, phone_number);
            
            pstmtIndiv.executeUpdate();
            pstmtIndiv.close();
            conn.close();            
            System.out.println("Successful");
            return indiv_id;
             
        } catch(Exception e){
            System.out.println("SQL Error: " + e.getMessage());
            return 0;
        }
    }
    
    public int view_all_employee_individuals() {
        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/railway_db?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection Successful");

            PreparedStatement pstmt = conn.prepareStatement("SELECT indiv_id, indiv_lastname, indiv_firstname, indiv_gender, email, phone_number FROM individual WHERE indiv_type ='Customer'");
            ResultSet rst = pstmt.executeQuery();

            indiv_idlist.clear();
            indiv_lastnamelist.clear();
            indiv_firstnamelist.clear();
            indiv_genderlist.clear();
            emaillist.clear();
            phone_numberlist.clear();


            while (rst.next()) {
                indiv_idlist.add(rst.getInt("indiv_id"));
                indiv_lastnamelist.add(rst.getString("indiv_lastname"));
                indiv_firstnamelist.add(rst.getString("indiv_firstname"));
                indiv_genderlist.add(rst.getString("indiv_gender"));
                emaillist.add(rst.getString("email"));
                phone_numberlist.add(rst.getString("phone_number"));
            }

            pstmt.close();
            conn.close();

            return 1;
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return 0;
        }
    }
    
    public static void main(String args[]){
        
        Individual I = new Individual();
        
        
        //I.signup_individual();

    }
    
}

