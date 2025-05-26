package com.hibernateTemplateXml.dao;

import com.hibernateTemplateXml.entity.Employee;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public class EmployeeDao {

    @Autowired
    private SessionFactory sessionFactory;

    @Transactional
    public void save(Employee employee){
       sessionFactory.getCurrentSession().save(employee);

       System.out.println("Employee successfully saved...");
    }

    @Transactional(readOnly = true)
    public List<Employee> getAllData(){
        return sessionFactory.getCurrentSession().createQuery("FROM Employee ", Employee.class).list();
    }

    @Transactional(readOnly = true)
    public Employee getById(int id){
        return sessionFactory.getCurrentSession().get(Employee.class, id);
    }

    @Transactional
    public void deleteData(Employee employee){
        sessionFactory.getCurrentSession().delete(employee);
        System.out.println("Employee name "+employee.getName()+" is Successfully deleted...");
    }

    @Transactional
    public void updateData(Employee employee){
        sessionFactory.getCurrentSession().update(employee);
        System.out.println("Employee with id of "+employee.getId()+" is Successfully updated...");
    }

}
