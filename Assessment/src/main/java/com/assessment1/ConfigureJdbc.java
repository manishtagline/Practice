package com.assessment1;

import java.sql.*;

public class ConfigureJdbc {

    public static void main(String args[]){

        //For select query
        try{
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jdbcprac","root","Manish789");
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM student");

//            while(rs.next()){
//                System.out.println(rs.getInt(1)+" "+rs.getString(2)+" "+rs.getString(3));
//            }
        }catch(SQLException e){
            System.out.println(e);
        }


        //For insert query
        try{
//            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jdbcprac","root","Manish789");
            PreparedStatement pre = con.prepareStatement("INSERT INTO student VALUES (?,?,? )");
            pre.setInt(1, 3);
            pre.setString(2, "Rohit");
            pre.setString(3, "48");

            /*int i = pre.executeUpdate();

            if(i>0){
                System.out.println("Data inserted successfully...");
            }*/
        }catch(SQLException e){
            System.out.println(e);
        }


        //For delete query
        try{
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jdbcprac","root","Manish789");
            PreparedStatement pre = con.prepareStatement("DELETE FROM student WHERE stID = ?");
            pre.setInt(1,3);

            /*int i = pre.executeUpdate();

            if(i>0){
                System.out.println("Data deleted successfully...");
            }*/
        }catch(SQLException e){
            System.out.println(e);
        }


        //For update query
        try{
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jdbcprac","root","Manish789");
            PreparedStatement pre = con.prepareStatement("UPDATE student SET stName=? WHERE stId =?");
            pre.setString(1,"Hariom");
            pre.setInt(2,2);

            int i = pre.executeUpdate();

            if(i>0){
                System.out.println("Data updated successfully...");
            }
        }catch(SQLException e){
            System.out.println(e);
        }
    }
}
