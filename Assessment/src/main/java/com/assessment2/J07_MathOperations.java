package com.assessment2;

import java.util.Optional;
import java.util.Scanner;

interface ArithmeticOperation{
    Optional<Integer> mathOperation(int a, int b);
}

class Addition implements ArithmeticOperation{
    @Override
    public Optional<Integer> mathOperation(int a, int b) {
        int add = a + b;
        if(a>=0 && b>=0){
            return Optional.of(add);
        }else{
            return Optional.empty();
        }
    }
}

class Subtraction implements ArithmeticOperation{
    @Override
    public Optional<Integer> mathOperation(int a, int b) {
        int sub = a - b;
        if(a>=0 && b>=0 || a>b){
            return Optional.of(sub);
        }else {
            return Optional.empty();
        }
    }
}

class Division implements ArithmeticOperation{
    @Override
    public Optional<Integer> mathOperation(int a, int b) {
        int div = a / b;
        if(a>=0 && b>0 ){
            return Optional.of(div);
        }else {
            return Optional.empty();
        }
    }
}

class Multiplication implements ArithmeticOperation{
    @Override
    public Optional<Integer> mathOperation(int a, int b) {
        int multi = a* b;
        if(multi!=0){
            return Optional.of(multi);
        }else {
            return Optional.empty();
        }
    }
}

public class J07_MathOperations {
    public static void main(String[] args) {
//        Math Operations with Optional Handling
//        Requirements:
//        Create functional interfaces for arithmetic operations like add, subtract.
//        Use Optional to avoid NullPointerException for missing inputs.
//        Demonstrate Optional.of(), Optional.empty(), orElse(), etc.

        Scanner sc = new Scanner(System.in);

        while(true){

            System.out.println("Here are the option :");
            System.out.println("Enter 1 for addition.");
            System.out.println("Enter 2 for subtraction.");
            System.out.println("Enter 3 for division.");
            System.out.println("Enter 4 for multiplication.");
            System.out.println("Enter 5 for termination.");
            int choice = sc.nextInt();

            if(choice != 5) {
                switch (choice){
                    case 1:
                        System.out.print("Enter value of a :");
                        int num1 = sc.nextInt();
                        System.out.print("Enter value of b :");
                        int num2 = sc.nextInt();
                        Addition add = new Addition();
                        System.out.println("The addition of two number is "+add.mathOperation(num1, num2));
                        break;

                    case 2:
                        System.out.print("Enter value of a :");
                        int num3 = sc.nextInt();
                        System.out.print("Enter value of b :");
                        int num4 = sc.nextInt();
                        Subtraction sub = new Subtraction();
                        System.out.println("The subtraction of two number is "+sub.mathOperation(num3, num4));
                        break;

                    case 3:
                        System.out.print("Enter value of a :");
                        int num5 = sc.nextInt();
                        System.out.print("Enter value of b :");
                        int num6 = sc.nextInt();
                        Division div = new Division();
                        System.out.println("The division of two number is "+div.mathOperation(num5, num6));
                        break;

                    case 4:
                        System.out.print("Enter value of a :");
                        int num7 = sc.nextInt();
                        System.out.print("Enter value of b :");
                        int num8 = sc.nextInt();
                        Multiplication multi = new Multiplication();
                        System.out.println("The multiplication of two number is "+multi.mathOperation(num7, num8));
                        break;
                }
            }else{
                System.out.println("Program terminated...");
                break;
            }

        }









    }
}
