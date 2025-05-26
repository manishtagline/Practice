package Prac;


import java.util.*;

public class Question {

    public static void main(String[] args) {

        Scanner sc = new Scanner(System.in);

        while (true) {
            System.out.println("\nHere are the choice:");
            System.out.println("1 for checking Arrays program.");
            System.out.println("2 for checking Strings program.");
            System.out.println("3 for checking Collections program.");
            System.out.println("4 for checking Exception program.");
            System.out.println("5 for exit.");
            System.out.println("Enter your choice :");
            int choice = sc.nextInt();

            if (choice != 5) {
                switch (choice) {
                    case 1:
                        System.out.println();
                        System.out.println("This is an Array program.");
                        //getting array size form user
                        System.out.println("Enter the size array.");
                        int size1 = sc.nextInt();
                        int[] arr = new int[size1];

                        //putting user data into array
                        System.out.println("\nEnter the array values");
                        for (int i = 0; i < size1; i++) {
                            arr[i] = sc.nextInt();
                        }

                        //Printing a array values
                        System.out.print("The array values are :");
                        for (int i : arr) {
                            System.out.print(i + ", ");
                        }
                        break;

                    case 2:
                        //getting a string from user
                        System.out.println("\nThis is an String program.");
                        System.out.print("Enter your string:");
                        sc.nextLine();
                        String str = sc.nextLine();

                        //converting the string in upper case
                        System.out.println("\nConverting the string in UpperCase : " + str.toUpperCase());
                        System.out.println("\nEnter your range for getting the string between them.");

                        //getting range from user to get string between them.
                        System.out.print("From :");
                        int from = sc.nextInt();
                        System.out.print("To :");
                        int to = sc.nextInt();

                        String str2 = str.substring(from, to);
                        System.out.println("The ranged string : " + str2);
                        int count = 0;
                        int fromIndex = 0;
                        while ((fromIndex = str.indexOf(str2,fromIndex)) != -1){
                            count++;
                            fromIndex += str2.length();
                        }
                        System.out.println("There is "+ count +" time occurrence of "+ str2 +".");

                        //for checking the specific content
                        System.out.println("\nEnter specific character for checking:");
                        String check = sc.next();
                        if (str.contains(check)) {
                            System.out.println("Yes, " + str + " content " + check);
                        } else {
                            System.out.println("No, " + str + " not content " + check);
                        }
                        break;

                    case 3:
                        System.out.println();
                        System.out.println("What you want to do in Collections.");
                        System.out.println("Enter 1 for ArrayList program and 2 for Map.");
                        int selection = sc.nextInt();

                        switch (selection) {
                            case 1:
                                ArrayList<Integer> list = new ArrayList<>();
                                System.out.println("This is an ArrayList program.");

                                //getting arraylist size form user
                                System.out.println("Enter the size ArrayList.");
                                int size2 = sc.nextInt();

                                //putting user data into arraylist
                                System.out.println("\nEnter the ArrayList values.");
                                for (int i = 0; i < size2; i++) {
                                    list.add(sc.
                                            nextInt());
                                }

                                //Printing a Arraylist values
                                System.out.print("The ArrayList values are :");
                                for (Integer integer : list) {
                                    System.out.print(integer + ", ");
                                }
                                break;

                            case 2:
                                HashMap<Integer, String> map = new HashMap<>();
                                System.out.println("This is an HashMap program.");

                                //getting hashmap size form user
                                System.out.println("Enter the size HashMap.");
                                int size3 = sc.nextInt();

                                //putting user data into map
                                for (int i = 0; i < size3; i++) {
                                    System.out.print("Enter key :");
//                                    Integer key = sc.nextInt();
                                    String input = sc.next();
                                    Integer key = null; // Default to null

                                    if (!input.isEmpty()) {
                                        try {
                                            key = Integer.parseInt(input);
                                        } catch (NumberFormatException e) {
                                            System.out.println("Invalid number format.");
                                        }
                                    }
                                    System.out.print("Enter value :");
                                    String value = sc.next();

                                    map.put(key, value);
                                }

                                //Printing a HashMap values
                                System.out.print("The HashMap values are :");
                                for (Map.Entry data : map.entrySet()) {
                                    System.out.println(data.getKey() + " : " + data.getValue());
                                }
                                break;
                        }
                        break;

                    case 4:
                        System.out.println("For Exception checking enter the tow number and try the divide the number by zero.");
                        System.out.println("Enter num1 :");
                        int num1 = sc.nextInt();
                        System.out.println("Enter num2 :");
                        int num2 = sc.nextInt();
                        try {
                            int result = num1 / num2;
                            System.out.println("The result is " + result);
                        } catch (ArithmeticException e) {
                            System.out.println(e);
                        }
                        break;

                }

            } else {
                System.out.print("Program terminated...");
                break;
            }

        }
        sc.close();

    }
}

