package com.hibernateTemplateXml;

import com.hibernateTemplateXml.dao.EmployeeDao;
import com.hibernateTemplateXml.entity.Employee;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.List;

public class Main {
    public static void main(String[] args) {
        ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");

        EmployeeDao dao = context.getBean(EmployeeDao.class);

        //For inserting a data
//        Employee emp2 = new Employee("abc","etc");
//        dao.save(emp2);

        //For deleting a data
//        dao.deleteData(emp2);

        // For getting a data by id and then after we update that data
//        Employee e = dao.getById(3);
//        e.setAddress("Texas");
//        dao.updateData(e);


        //For reading all data
        List<Employee> list = dao.getAllData();
        for (Employee e:list) {
            System.out.println(e);
        }
    }
}
