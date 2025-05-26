package com.assessment2;

import javax.crypto.*;
import javax.crypto.spec.SecretKeySpec;
import java.io.*;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.*;
import java.util.stream.Collectors;

class Student implements Serializable{

    int id;
    String name;
    transient String email;
    String grade;

    public Student(int id, String name,String email,String grade)  {
        this.id = id;
        this.name = name;
        this.email = email;
        this.grade = grade;
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

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade;
    }

    @Override
    public String toString() {
        return  "Id = " + id +
                ", Name = " + name +
                ", Email = " + email +
                ", Grade = " + grade ;
    }

}

//Using Strategy design pattern
interface FileGeneratorForMarks{
    void fileGen();
}

class PdfGeneratorForMarks implements FileGeneratorForMarks{

    @Override
    public void fileGen() {
        System.out.println("Creating PDF of file.");
    }
}

class CsvGeneratorForMarks implements FileGeneratorForMarks{

    @Override
    public void fileGen() {
        System.out.println("Creating CSV of file.");
    }
}

class GetMarksFile{
    FileGenerator file;

    public GetMarksFile(FileGenerator file) {
        this.file = file;
    }

    public void callMethod(){
        file.fileGen();
    }
}

public class J08_StudentResult {

    private static final String SECRET_KEY = "1234567890123456"; // 16 chars = 128 bits
    private static final SecretKeySpec key = new SecretKeySpec(SECRET_KEY.getBytes(), "AES");


    public static void main(String[] args) throws NoSuchAlgorithmException, NoSuchPaddingException, IllegalBlockSizeException, BadPaddingException, InvalidKeyException, IOException, ClassNotFoundException {
//        Student Result Processing System
//        Requirements:
//        Read a student list, process grades concurrently (Multithreading).
//        Use Stream API for filtering and sorting results.
//        Secure sensitive student data (like email) using encryption.
//        Serialize and deserialize the processed data to/from a file.
//        Use Factory + Strategy Patterns to generate different types of reports (CSV/PDF).
//        Use Optional and Functional Interfaces where applicable.

        Scanner sc = new Scanner(System.in);



        List<Student> studentList = Arrays.asList(
                new Student(1,"Harvey","harvey@gmail.com","A+"),
                new Student(2,"Manish","manish@gmail.com","B1"),
                new Student(3,"Mike","mike@gmail.com","C2"),
                new Student(4,"Cory","cory@gmail.com","F"),
                new Student(5,"Maxwell","maxwell@gmail.com","B2"),
                new Student(6,"Benstokes","benstokes@gmail.com","C1")
        );

        while(true){
            System.out.println("\nHere are the option :");
            System.out.println("Enter 1 for read a student list :");
            System.out.println("Enter 2 for filter a student by name or grade :");
            System.out.println("Enter 3 for sorting a list by Grade :");
            System.out.println("Enter 4 for convert the list into bytes :");
            System.out.println("Enter 5 for read a list from .ser file");
            System.out.println("Enter 6 for generating a PDF/CSV file for mark sheet :");
            System.out.println("Enter 7 for encryption and decryption of email:");
            System.out.println("Enter 8 for termination.");
            System.out.print("\nEnter your choice :");
            int choice = sc.nextInt();

            if(choice!=8){
                switch (choice) {

                    case 1 -> {
                        System.out.println("\nHere are list of student.");
                        for (Student st : studentList) {
                            System.out.println(st);
                        }
                    }

                    case 2 -> {
                        System.out.println("\nEnter what you want to search for by name/grade:");
                        String searchBy = sc.next();
                        if (searchBy.equalsIgnoreCase("name")) {
                            System.out.print("Enter the name you want to search :");
                            String searchName = sc.next();
                            List<Student> st = studentList.stream().filter(student -> student.name.startsWith(searchName)).collect(Collectors.toList());
                            for (Student s : st) {
                                System.out.println(s);
                            }
                        } else if (searchBy.equalsIgnoreCase("grade")) {
                            System.out.print("Enter the grade you want to search for :");
                            String searchGrade = sc.next();
                            List<Student> st = studentList.stream().filter(student -> student.grade.startsWith(searchGrade)).collect(Collectors.toList());
                            for (Student s : st) {
                                System.out.println(s);
                            }
                        } else {
                            System.out.println("Incorrect input!!!");
                        }
                    }

                    case 3 -> {
                        System.out.println("\nHere are the sorted list :");
                        List<Student> st1 = studentList.stream().sorted(Comparator.comparing(grade -> grade.grade)).collect(Collectors.toList());
                        for (Student s : st1) {
                            System.out.println(s);
                        }
                    }

                    case 4 -> {
                        FileOutputStream fOut = new FileOutputStream("file1.ser");
                        ObjectOutputStream fileOut = new ObjectOutputStream(fOut);
                        fileOut.writeObject(studentList);
                        System.out.println("List converted successfully into bytes...");
                    }

                    case 5 -> {
                        FileInputStream fIn = new FileInputStream("file1.ser");
                        ObjectInputStream fileIn = new ObjectInputStream(fIn);
                        List<Student> list = (List<Student>) fileIn.readObject();
                        for (Student s : list) {
                            System.out.println(s);
                        }
                    }

                    case 6 -> {
                        System.out.print("\nWhat would you like to generate PDF/CSV enter the File format :");
                        String fileFormat = sc.next();
                        GetFile file;
                        if (fileFormat.equalsIgnoreCase("pdf")) {
                            file = new GetFile(new PdfGenerator());
                            file.callMethod();
                        } else {
                            //For creating a CSV file
                            file = new GetFile(new CsvGenerator());
                            file.callMethod();
                        }
                    }

                    case 7 -> {
                        System.out.println("Encrypting student emails...");
                        for (Student s : studentList) {
                            String encrypted = emailEncryption(s.getEmail());
                            System.out.println("Encrypted email for " + s.getName() + ": " + encrypted);

                            String decrypted = emailDecryption(encrypted);
                            System.out.println("Decrypted: " + decrypted);
                        }
                    }
                }
            }else{
                System.out.println("Program terminated...");
                break;
            }
        }

    }

    //For Encryption of user email
    public static String emailEncryption(String email) throws NoSuchPaddingException, NoSuchAlgorithmException, InvalidKeyException, IllegalBlockSizeException, BadPaddingException {
//        KeyGenerator keyGen = KeyGenerator.getInstance("AES");
//        keyGen.init(128);
//        SecretKey key = keyGen.generateKey();
        Cipher cipher = Cipher.getInstance("AES");
        cipher.init(Cipher.ENCRYPT_MODE, key);

        byte[] encrypted = cipher.doFinal(email.getBytes());

        return Base64.getEncoder().encodeToString(encrypted);
    }

    //For Decryption of encrypted email
    public static String emailDecryption(String encryptedEmail) throws NoSuchPaddingException, NoSuchAlgorithmException, InvalidKeyException, IllegalBlockSizeException, BadPaddingException {
//        KeyGenerator keyGen = KeyGenerator.getInstance("AES");
//        keyGen.init(128);
//        SecretKey key = keyGen.generateKey();
        Cipher cipher = Cipher.getInstance("AES");
        cipher.init(Cipher.DECRYPT_MODE,key);

        byte[] decrypted = cipher.doFinal(Base64.getDecoder().decode(encryptedEmail));

        return new String(decrypted);
    }

}