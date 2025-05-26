package com.hibernateTemplateAnnotation;

import com.hibernateTemplateAnnotation.config.AppConfig;
import com.hibernateTemplateAnnotation.dao.EmployeeDao;
import com.hibernateTemplateAnnotation.entity.Employee;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

public class Main {
    public static void main(String[] args) {
        ApplicationContext context = new AnnotationConfigApplicationContext(AppConfig.class);

        EmployeeDao dao = context.getBean(EmployeeDao.class);

        Employee e = new Employee("Manish", "Bharuch");
        dao.save(e);
    }
}
