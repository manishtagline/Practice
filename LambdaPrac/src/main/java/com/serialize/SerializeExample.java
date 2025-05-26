package com.serialize;

import java.io.*;
import java.util.Arrays;

class Person implements Serializable{
    int id;
    String name;

    public Person(int id, String name){
        this.id = id;
        this.name = name;
    }
}

class Student extends Person{
    int fees;
    transient String course; //Using transient keyword
    static String address;  //s tatic variable are not serialize

    int[] marks;

    public Student(int id, String name,int fees,String course,int[] marks) {
        super(id, name);
        this.fees = fees;
        this.course = course;
        this.marks = marks;
    }
}

public class SerializeExample {
    public static void main(String[] args) throws IOException, ClassNotFoundException {
        Student st = new Student(1,"Harry", 32000, "Java Course",new int[]{45,65,48,54,60});
        Student.address="Bharuch";

        FileOutputStream fileOut = new FileOutputStream("file.txt");
        ObjectOutputStream obj = new ObjectOutputStream(fileOut);

        obj.writeObject(st);

        ObjectInputStream obj2 = new ObjectInputStream(new FileInputStream("file.txt"));
        Student s = (Student)obj2.readObject();

        System.out.println("Id : "+ s.id +", Name : "+ s.name +", Course : "+ s.course +", Fees : "+ s.fees+ ", Address : "+ s.address +", Marks : "+ Arrays.toString(s.marks));


    }
}
