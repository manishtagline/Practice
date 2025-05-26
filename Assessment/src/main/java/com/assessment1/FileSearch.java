package com.assessment1;

import java.io.*;
import java.util.Scanner;

public class FileSearch {
    public static void main(String[] args) {
//        Question :- 8
//        Requirements:
//        Read a .txt file line by line.
//        Accept a search keyword.
//        Print lines where the keyword is found.

        Scanner sc = new Scanner(System.in);

        String folderPath = "/Users/tagline/Desktop/AssessmentText";
        String filePath = folderPath + "/Notes.txt";

        System.out.println("Here are the option.");
        System.out.println("1 for write in the file.");
        System.out.println("2 for read the file.");
        System.out.println("3 for specific search.");
        System.out.println("Enter your choice :");
        int choice = sc.nextInt();

        try{

            switch (choice){
                case 1:
                    //This is for writing a txt file
                    File file = new File(folderPath);
                    if(!file.exists()){
                        file.mkdirs();
                        System.out.println("Folder created : "+folderPath);
                    }

                    FileWriter writer = new FileWriter(filePath, true);
                    BufferedWriter bufferedWriter = new BufferedWriter(writer);

                    System.out.println("Write exit for terminate the program....");
                    System.out.println("Enter your notes : ");

                    while(true){
                        String sentence = sc.nextLine();
                        if(sentence.equalsIgnoreCase("exit")){
                            break;
                        }
                        bufferedWriter.write(sentence);
                        bufferedWriter.newLine();
                    }
                    bufferedWriter.close();
                    break;

                case 2:
                    //This is for reading txt file
                    FileReader reader = new FileReader(filePath);
                    BufferedReader bufferedReader = new BufferedReader(reader);
                    int i = 0;
                    while((i = bufferedReader.read()) != -1){
                        System.out.print((char)i);
                    }
                    bufferedReader.close();
                    reader.close();
                    break;

                case 3:
                    System.out.println("Enter specific word for searching :");
                    String word = sc.next();
                    FileReader reader1 = new FileReader(filePath);
                    BufferedReader bufferedReader1 = new BufferedReader(reader1);
                    String line;
                    while((line = bufferedReader1.readLine()) != null){
                        if(line.contains(word)){
                            System.out.println(line);
                        }
                    }
                    break;
            }



        }catch (Exception e){
            System.out.println(e);
        }
    }
}
