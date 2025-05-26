package com.lambda;

import java.util.*;
import java.util.function.Predicate;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@FunctionalInterface
interface Functional{
    void opreation(int a, int b);
}

public class lambdaPrac {
    public static void main(String[] args) {

        //For stream checking a letter
        List<String> list1 = Arrays.asList("a", "b", "c");
        list1.stream().filter(s -> s.equals("b")).forEach(System.out::println);

        //Using predicate interface for comparing to string
        Predicate<String> isLongWord = str -> str.length() > 5;
        System.out.println(isLongWord.test("Hellocdv"));
        System.out.println(isLongWord.test("hi"));

        ArrayList<Integer> al = new ArrayList<Integer>();
        al.add(1);
        al.add(2);
        al.add(3);
        al.add(4);

        // Using lambda expression to print all elements of al
        System.out.println("Elements of the ArrayList: ");
        al.forEach(System.out::println);

        //Using a lambda function for add method
        Functional add = (a , b) -> {
            System.out.println(a+b);
        };

        //Using a lambda function for multiplication
        Functional multi =(a , b) -> {
            System.out.println(a * b);
        };

        add.opreation(5,2);
        multi.opreation(4,65);

        //Using predicate for checking a string is palindrome or not
        Predicate<String> isPalindrome = s -> s.equalsIgnoreCase(new StringBuilder(s).reverse().toString());

        System.out.println(isPalindrome.test("madam"));
        System.out.println(isPalindrome.test("java"));

        List<Integer> al2 = new ArrayList<>();

                List<Integer> al1 = Arrays.asList(1,9);

        al1.stream()
                .filter(num -> num%2==0)
                .forEach(System.out::println);

        list1.stream()
                .map(letter -> letter.toUpperCase())
                .forEach(System.out::println);

        ArrayList<Integer> marks = new ArrayList<Integer>();

        marks.add(30);
        marks.add(78);
        marks.add(28);
        marks.add(26);
        marks.add(79);

        //Using stream api for adding grace marks
        System.out.println("Marks of students before grace : " + marks);

        List<Integer> updatedMarks = marks.stream()
                                            .filter(mark -> mark < 35)
                                            .map(i -> i+6)
                                            .collect(Collectors.toList());
        System.out.println("Marks of students  after grace : "+ updatedMarks);

        //Using stream api for string sorting
        List<String> sorting = Arrays.asList("n","j");

        sorting.stream().sorted().distinct().forEach(System.out::println);

        Stream<Integer>  intStream = Stream.of(1,58,2,2);

        //Using stream for set
        Set<Integer> collectedSet = intStream.collect(Collectors.toSet());
        System.out.println(collectedSet);

        //Count strings starting with letter using streams
        List < String > colors = Arrays.asList("Red", "Green", "Blue", "Pink", "Brown");
        char startingLetter = 'B';

        long count = colors.stream()
                            .filter(s -> s.startsWith(String.valueOf(startingLetter)))
                            .count();
        System.out.println("\nNumber of colors starting with '" + startingLetter + "': " + count);


        List<Integer> intList = Arrays.asList(12,66,35,65,9,65,145,23,35,25,663,45);

        //Finding second smallest number
        Integer smallest = intList.stream()
                                .distinct()
                                .sorted()
                                .skip(1)
                                .findFirst()
                                .orElse(null);

        Integer largest = intList.stream()
                                .distinct()
                                .sorted((a,b) -> Integer.compare(b,a))
                                .skip(1)
                                .findFirst()
                                .orElse(null);

        //Sum of list using stream.reduce() method
        Integer sum = intList.stream()
                                .reduce(0, Integer::sum);

        System.out.println("Second smallest number "+smallest);
        System.out.println("Second largest number "+largest);
        System.out.println("Sum of list "+sum);


    }
}
