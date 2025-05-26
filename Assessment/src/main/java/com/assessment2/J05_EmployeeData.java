package com.assessment2;

import java.io.*;
import java.util.Arrays;
import java.util.List;

class Employee implements Serializable{
    int employeeId;
    String employeeName;
    String address;

    public Employee(int employeeId, String employeeName, String address) {
        this.employeeId = employeeId;
        this.employeeName = employeeName;
        this.address = address;
    }

    @Override
    public String toString() {
        return "Id = " + employeeId +
                ", Name = " + employeeName  +
                ", Address = " + address;
    }
}

public class J05_EmployeeData {
    public static void main(String[] args) throws IOException, ClassNotFoundException {
//        Employee Data Persistence Tool
//        Requirements:
//        Create an Employee class and serialize a list of employees to a .ser file.
//        Deserialize the file back into Java objects.
//        Demonstrate custom serialization using writeObject()/readObject().

        List<Employee> employeeList = Arrays.asList(
                new Employee(1,"Harvey","New York"),
                new Employee(2,"Manish","Bharuch"),
                new Employee(3,"Cory","LA"),
                new Employee(4,"Mike","Chicago"),
                new Employee(5,"Rachel","Texas"),
                new Employee(6,"Williams","Miami"),
                new Employee(7,"Daniel","Las Vegas")
        );

        FileOutputStream fileOut = new FileOutputStream("file.ser");
        ObjectOutputStream outputStream = new ObjectOutputStream(fileOut);

        outputStream.writeObject(employeeList);

        FileInputStream fileIn = new FileInputStream("file.ser");
        ObjectInputStream inputStream = new ObjectInputStream(fileIn);

        List<Employee> emp = (List<Employee>) inputStream.readObject();

        for (Employee e : emp) {
            System.out.println(e);
        }
    }
}
