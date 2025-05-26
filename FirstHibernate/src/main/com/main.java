package com;

import com.entity.Employee;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.hibernate.query.Query;

import java.util.Arrays;
import java.util.List;


public class main {
    public static void main(String[] args) {
        SessionFactory factory = new Configuration()
                .configure("hibernate.cfg.xml")
                .addAnnotatedClass(Employee.class)
                .buildSessionFactory();

//        List<String> list = Arrays.asList("Blood Management","Bank Security","Payment Application");

        Session session = factory.openSession();
//        Employee emp = new Employee("Manish","Bharuch",4585962311l,4526.02, list);

        session.beginTransaction();
        //for inserting
//        session.save(emp);

//        List<Employee> employeeList = session.createQuery("from Employee").list();


//        Employee e = session.get(Employee.class, 2);
//        session.delete(e);

//        Query<Employee> query = session.createQuery("FROM Employee", Employee.class);

        Query<Employee> query1 = session.createQuery("FROM Employee e WHERE e.salary > :maxSalary ", Employee.class);
        query1.setParameter("maxSalary",4000.0);
        List<Employee> list = query1.getResultList();

        for ( Employee e:list) {
            System.out.println(e);
        }
        
        session.getTransaction().commit();
//        System.out.println(e);
    }
}
