package com.dao;

import com.model.Employee;

import java.util.List;

public interface EmpDao {

    void saveEmployee(Employee e);
    void deleteEmployee(int id);
    void updateEmployee(Employee e);
    Employee getEmployeeById(int id);
    List<Employee> getAllEmployee();

}
