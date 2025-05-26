package com.functionalInterface;

import java.util.Arrays;
import java.util.List;
import java.util.function.Consumer;
import java.util.function.Predicate;
import java.util.stream.Collectors;

@FunctionalInterface
interface EmployeeFilter{
    boolean test(Employee employee);
}

class Employee{
    String name;
    String department;
    double salary;

    public Employee(String name, String department, double salary) {
        this.name = name;
        this.department = department;
        this.salary = salary;
    }

    @Override
    public String toString() {
        return name + " (" + department + ", ₹" + salary + ")";
    }
}

public class EmployeeFilterDemo {
    public static List<Employee> filterEmployee(List<Employee> employees, EmployeeFilter filter){
        return employees.stream()
                            .filter(filter::test)
                            .collect(Collectors.toList());
    }

    public static void main(String[] args) {
        List<Employee> list = Arrays.asList(new Employee("Harvey","CEO",100000),
                                                new Employee("Louis","HR",45000),
                                                new Employee("Mark","IT",20000),
                                                new Employee("Cory", "Marketing",30000),
                                                new Employee("Williams", "IT",60000),
                                                new Employee("Harry","Sales",15000),
                                                new Employee("Nathan","IT",65000));

        List<Employee> itEmployee = filterEmployee(list, e -> e.department.startsWith("IT"));
        System.out.println("Employees are work in it department : "+itEmployee);

        List<Employee> highestSalary = filterEmployee(list,employee -> employee.salary>50000);
        System.out.println("Highest Earners : "+highestSalary );

        List<Employee> nameStartWith = filterEmployee(list, employee -> employee.name.startsWith("H"));
        System.out.println("Name start with H : "+nameStartWith);
    }
}
