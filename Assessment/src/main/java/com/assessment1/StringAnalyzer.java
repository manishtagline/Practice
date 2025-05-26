package com.assessment1;

import java.util.Scanner;

public class StringAnalyzer {
    public static void main(String[] args) {
//        Question :- 6
//        Requirements:
//        Accept a sentence from user input.
//        Count:
//        Total vowels
//        Total words
//        Reverse the sentence
//        Identify the longest word

        Scanner sc = new Scanner(System.in);
        System.out.println("Enter your sentence :");
        String sentence = sc.nextLine();

        //Counting total vowels in the sentence
        int totalVowel = 0;
        for(int i=0; i<sentence.length(); i++){
            char ch = sentence.charAt(i);
            if(ch == 'a' || ch == 'e' || ch == 'i' || ch == 'o' || ch == 'u'){
                totalVowel++;
            }
        }
        System.out.println("There are "+totalVowel+" vowels in the sentence.");


        //Counting total words in the setence
        int totalWords = 0;
        for (int i = 0; i <sentence.length(); i++) {
            char ch = sentence.charAt(i);
            if(ch != ' '){
                totalWords++;
            }
        }
        System.out.println("There are total "+totalWords+" words in the sentence.");

        //reverse the sentence
        StringBuilder builder = new StringBuilder(sentence);
        System.out.println("This is the reverse of sentence "+builder.reverse());

        //Finding the longest word in sentence
        String[] word = sentence.split(" ");
        String longestWord = null;
        for (int i = 0; i <word.length; i++) {
            for (int j = i + 1; j <word.length; j++) {
                if (word[i].length() >= word[j].length()) {
                    longestWord = word[i];
                    break;
                }
            }
        }

        System.out.println("The longest in the sentence is "+longestWord);


    }
}
