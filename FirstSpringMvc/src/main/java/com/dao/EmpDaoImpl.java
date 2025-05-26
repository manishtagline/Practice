package com.dao;

import com.model.Employee;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public class EmpDaoImpl implements  EmpDao{

    @Autowired
    private HibernateTemplate hibernateTemplate;

    public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
        this.hibernateTemplate = hibernateTemplate;
    }

    @Transactional
    public void saveEmployee(Employee employee){
        hibernateTemplate.save(employee);
    }

    @Transactional
    public void deleteEmployee(int id){
        Employee emp = hibernateTemplate.get(Employee.class, id);
        if(emp != null){
            hibernateTemplate.delete(emp);
        }
    }

    @Transactional
    public void updateEmployee(Employee e){
        hibernateTemplate.update(e);
    }

    @Transactional(readOnly = true)
    public Employee getEmployeeById(int id){
        return hibernateTemplate.get(Employee.class, id);
    }

    @Transactional(readOnly = true)
    public List<Employee> getAllEmployee(){
        return hibernateTemplate.loadAll(Employee.class);
    }
}
