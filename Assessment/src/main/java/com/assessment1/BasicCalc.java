package com.assessment1;

import java.util.Scanner;

public class BasicCalc {
    public static void main(String[] args) {
//        Question :- 1
//        Requirements:
//        Ask the user to input two numbers and an operator (+, -, *, /).
//        Use if-else or switch-case to determine and perform the operation.
//        Handle invalid input gracefully.

        Scanner sc = new Scanner(System.in);
        System.out.println("Enter the value of a:");
        int num1 = sc.nextInt();
        System.out.println("Enter the value of b:");
        int num2 = sc.nextInt();
        System.out.println("Enter the operation you want to perform on it :");
        String operator = sc.next();

        if ("+".equals(operator)) {
            System.out.println("The result of a + b is " + (num1 + num2));
        }else if("-".equals(operator)){
            System.out.println("The result of a - b is "+(num1 - num2));
        }else if("*".equals(operator)){
            System.out.println("The result of a * b is "+(num1 * num2));
        }else if("/".equals(operator)){
            System.out.println("The result of a / b is "+(num1 / num2));
        }else{
            System.out.println("Please enter the valid operator like +, -, *, / .");
        }


    }
}

