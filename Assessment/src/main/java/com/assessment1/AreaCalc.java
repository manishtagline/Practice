package com.assessment1;

interface Shape{
    void calculateArea();
}

class Circle implements Shape{

    private double radius;

    public Circle(double radius) {
        this.radius = radius;
    }

    @Override
    public void calculateArea() {
        double result = Math.PI * radius * radius;
        System.out.println("The area of circle is "+result);
    }
}

class Rectangle implements Shape{

    private double length;
    private double breadth;

    public Rectangle(double length, double breadth) {
        this.length = length;
        this.breadth = breadth;
    }

    @Override
    public void calculateArea() {
        double result = length * breadth;
        System.out.println("The area of rectangle is "+result);
    }
}

public class AreaCalc {
    public static void main(String[] args) {
//        Question :- 4
//        Requirements:
//        Create a Shape interface with calculateArea() method.
//        Implement Circle and Rectangle classes.
//        Use abstraction via interface.

        Circle circle = new Circle(4);
        Rectangle rect = new Rectangle(4,2);

        circle.calculateArea();
        rect.calculateArea();

    }
}
