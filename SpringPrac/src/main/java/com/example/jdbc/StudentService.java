package com.example.jdbc;

import com.example.entity.Student;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class StudentService {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    //For inserting data into database
    public void insertData(String name,String grade){
        String query = "INSERT INTO student_grade (name, grade) VALUES (?,?)";
        jdbcTemplate.update(query, name, grade);

        System.out.println("Data inserted of student : "+name);
    }

    //For reading all data from database
    public List<Student> getAllStudents(){
        String query = "SELECT * FROM student_grade";
        return jdbcTemplate.query(query, new BeanPropertyRowMapper<>(Student.class));
    }

    //For updating the data
    public void updateStudentGrade(int id, String newGrade){
        String query = "UPDATE student_grade SET grade = ? WHERE id = ? ";
        jdbcTemplate.update(query, newGrade, id);
        System.out.println("Student of id = "+id+" Updated there grade to "+newGrade+".");
    }

    //For deleting the data
    public void deleteStudent(int id){
        String query = "DELETE FROM student_grade WHERE ID = ?";
        jdbcTemplate.update(query, id);
        System.out.println("Student of id = "+id+", is deleted successfully...");
    }

    //For getting single data from database
    public Student getStudentById(int id){
        String query = "SELECT * FROM student_grade WHERE id = ?";
        return jdbcTemplate.queryForObject(query, new BeanPropertyRowMapper<>(Student.class), id);
    }

}
