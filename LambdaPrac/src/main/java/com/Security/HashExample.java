package com.Security;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Scanner;

public class HashExample {
    private static final String storedPassword = "5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8";

    public static void main(String[] args) throws NoSuchAlgorithmException {
        Scanner sc = new Scanner(System.in);
        System.out.println("Enter your password : ");
        String password = sc.next();

        String hashedInput = hashPassword(password);
        if(hashedInput.equals(storedPassword)){
            System.out.println("Authentication Successful...");
        }else{
            System.out.println("Invalid password...");
        }

    }

    public static String hashPassword(String password) throws NoSuchAlgorithmException {

        MessageDigest digest = MessageDigest.getInstance("SHA-256");

        byte[] hash = digest.digest(password.getBytes());

        StringBuilder hashPass = new StringBuilder();
        for (byte h: hash) {
           hashPass.append(String.format("%02x",h));
        }
        return hashPass.toString();
    }
}
