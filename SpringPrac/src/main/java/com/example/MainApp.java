package com.example;

import com.example.Config.AppConfig;
import com.example.entity.Student;
import com.example.jdbc.StudentService;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

public class MainApp {
    public static void main(String[] args) {

        // Hibernate to auto-create table
        SessionFactory factory = new Configuration()
                .configure("hibernate.cfg.xml")
                .addAnnotatedClass(Student.class)
                .buildSessionFactory();

        Session session = factory.openSession();
        session.beginTransaction();
        session.getTransaction().commit();
        session.close();


        ApplicationContext context = new AnnotationConfigApplicationContext(AppConfig.class);
        StudentService service = context.getBean(StudentService.class);

        // Spring JDBC to insert data
//        service.insertData("Harvey", "A+");
//        service.insertData("Pearson", "B1");
//        service.insertData("Louis", "C2");
//        service.insertData("Alex", "F");

        // Spring JDBC to read all data
//        List<Student> list =  service.getAllStudents();
//        for (Student s : list) {
//            System.out.println("Id : "+s.getId()+", Name : "+s.getName()+", Grade : "+s.getGrade());
//        }

        // Spring JDBC to update data
//        service.updateStudentGrade(2,"B1");

        // Spring JDBC to delete data
//        service.deleteStudent(8);

        // Spring JDBC to read single data
        Student student = service.getStudentById(5);
        System.out.println(student);

    }
}
