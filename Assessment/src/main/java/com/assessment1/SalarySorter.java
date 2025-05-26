package com.assessment1;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

class Employee{

    private int id;
    private String name;
    private int salary;

    public Employee(int id, String name, int salary) {
        this.id = id;
        this.name = name;
        this.salary = salary;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getSalary() {
        return salary;
    }

    public void setSalary(int salary) {
        this.salary = salary;
    }
}

public class SalarySorter {
    public static void main(String[] args) {
//        Question :- 5
//        Requirements:
//        Create Employee class with id, name, and salary.
//        Store multiple employee objects in a List.
//        Sort them in ascending order of salary using Comparator.

        Employee e1 = new Employee(1,"John", 25800);
        Employee e2 = new Employee(2,"Cory", 23000);
        Employee e3 = new Employee(3,"Sunder", 75000);
        Employee e4 = new Employee(4,"Harry", 45000);
        Employee e5 = new Employee(5,"William", 13050);
        Employee e6 = new Employee(6,"Harvey", 150000);
        Employee e7 = new Employee(7,"Rachel", 60000);


        ArrayList<Employee> list = new ArrayList<>();
        list.add(e1);
        list.add(e2);
        list.add(e3);
        list.add(e4);
        list.add(e5);
        list.add(e6);
        list.add(e7);

        System.out.println("Printing original order.");
        for(Employee emp : list){
            System.out.println("Id : "+emp.getId()+", Name : "+emp.getName()+", salary : "+emp.getSalary());
        }

        System.out.println("\nPrinting the elements on the basis os salary.");
        Comparator<Employee> com = Comparator.comparing(Employee::getSalary);
        Collections.sort(list,com);

        for(Employee emp : list){
            System.out.println("Id : "+emp.getId()+", Name : "+emp.getName()+", salary : "+emp.getSalary());
        }

    }
}
