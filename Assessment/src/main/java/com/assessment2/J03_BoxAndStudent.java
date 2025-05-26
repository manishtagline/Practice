package com.assessment2;

import java.util.HashSet;
import java.util.HashMap;

class Box<T>{

    public T name;
    public T address;
    public T phoneNumber;

    public Box(T name, T address, T phoneNumber) {
        this.name = name;
        this.address = address;
        this.phoneNumber = phoneNumber;
    }

    @Override
    public String toString() {
        return  "name = " + name +
                ", address = " + address +
                ", phoneNumber = " + phoneNumber ;
    }
}

class StudentReport{
    int studentId;
    String studentName;
    HashSet<?> subjects = new HashSet<>();
    HashMap<?, Integer> marks = new HashMap<>();

    public StudentReport(int studentId, String studentName, HashSet<?> subjects, HashMap<?, Integer> marks) {
        this.studentId = studentId;
        this.studentName = studentName;
        this.subjects = subjects;
        this.marks = marks;
    }

    @Override
    public String toString() {
        return  "Id = " + studentId +
                ", Name = '" + studentName + '\'' +
                ", subjects = " + subjects +
                ", marks = " + marks ;
    }

}

public class J03_BoxAndStudent {
    public static void main(String[] args) {
//        Generic Box & Student Record System
//        Requirements:
//        Create a generic class Box<T> to hold any data type.
//        Build a student record system using List, Map, and Set to manage marks and subjects.

        Box b = new Box("Manish","Bharuch",65656689);

        System.out.println(b);

        HashSet<String> subects = new HashSet<>();
        subects.add("Maths");
        HashMap<String,Integer> marks = new HashMap<>();
        marks.put("Maths",45);

        StudentReport st = new StudentReport(1,"Shubham",subects,marks);

        System.out.println(st);
    }
}
