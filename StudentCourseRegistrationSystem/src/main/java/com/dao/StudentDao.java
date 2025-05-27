package com.dao;

import com.model.Course;
import com.model.Student;

import java.util.List;

public interface StudentDao {

    void addStudent(Student student);
    Student getStudentById(int id);
    void deleteStudent(int id);
    void updateStudent(Student student);
    List<Course> getAllCourse();
    List<Student> getAllStudent();
    Course courseById(int id);

}
