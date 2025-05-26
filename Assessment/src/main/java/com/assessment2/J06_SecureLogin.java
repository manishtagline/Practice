package com.assessment2;
//        Secure Login & Encryption Demo
//        Requirements:
//        Accept login credentials from user input and hash passwords using MessageDigest.
//        Encrypt sensitive data using AES (javax.crypto.Cipher).
//        Validate login and simulate secured user authentication.


import javax.crypto.*;
import java.security.InvalidKeyException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;
import java.util.Scanner;

public class J06_SecureLogin {

    public static final String adminPassword = "8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918";//admin
    public static final String userPassword = "04f8996da763b7a969b1028ee3007569eaf3a635486ddab211d512c85b9df8fb";//user

    public static void main(String[] args) throws NoSuchAlgorithmException, NoSuchPaddingException, IllegalBlockSizeException, BadPaddingException, InvalidKeyException {

        //Taking user input of Role verification
        Scanner sc = new Scanner(System.in);
        System.out.println("Enter your role(Admin/User) :");
        String role = sc.next();

        //Verifying the role and also ask password according to role
        if(role.equalsIgnoreCase("admin")){
            //Taking password from user
            System.out.println("Enter your password :");
            String password = sc.next();
            String hashInput = passwordVerification(password);

            //Generating key for AES algorithm and also initializing length of AES
            KeyGenerator keyGen = KeyGenerator.getInstance("AES");
            keyGen.init(128);
            //Generating secretkey
            SecretKey secretKey = keyGen.generateKey();

            //Verification of password
            if(hashInput.equalsIgnoreCase(adminPassword)){
                //After verification taking a text for encryption
                System.out.println("Welcome Admin...");
                System.out.println("Enter your text :");
                sc.nextLine();
                String text = sc.nextLine();
                //Encrypting the text
                String encryptedText = encrypt(text,secretKey);
                System.out.println("The text after encryption : "+encryptedText);
                //Decrypting the text
                String decryptedText = decrypt(encryptedText, secretKey);
                System.out.println("After the decryption the text is  : "+decryptedText);
            }else{
                System.out.println("Wrong Password!!!");
            }

        }else if(role.equalsIgnoreCase("user")){
            System.out.println("Enter your password :");
            String password = sc.next();
            String hashInput = passwordVerification(password);

            //Generating key for AES algorithm and also initializing length of AES
            KeyGenerator keyGen = KeyGenerator.getInstance("AES");
            keyGen.init(128);
            //Generating secretkey
            SecretKey secretKey = keyGen.generateKey();

            //Verification of password
            if(hashInput.equalsIgnoreCase(userPassword)){
                //After verification taking a text for encryption
                System.out.println("Welcome User...");
                System.out.println("Enter your text");
                sc.nextLine();
                String text = sc.nextLine();
                //Encrypting the text
                String encryptedText = encrypt(text,secretKey);
                System.out.println("The text after encryption : "+encryptedText);
                //Decrypting the text
                String decryptedText = decrypt(encryptedText, secretKey);
                System.out.println("After the decryption the text is  : "+decryptedText);
            }else{
                System.out.println("Wrong Password!!!");
            }
        }else{
            System.out.println("Invalid role!!!");
        }

    }

    //For Authentication of valid user
    public static String passwordVerification(String password) throws NoSuchAlgorithmException {
        MessageDigest digest = MessageDigest.getInstance("SHA-256");
        byte[] pass = digest.digest(password.getBytes());

        StringBuilder hashPassword = new StringBuilder();
        for (byte b : pass) {
            hashPassword.append(String.format("%02x",b));
        }
        return hashPassword.toString();
    }

    //For Encryption of user text
    public static String encrypt(String plainText, SecretKey key) throws NoSuchPaddingException, NoSuchAlgorithmException, InvalidKeyException, IllegalBlockSizeException, BadPaddingException {
        Cipher cipher = Cipher.getInstance("AES");
        cipher.init(Cipher.ENCRYPT_MODE, key);

        byte[] encrypted = cipher.doFinal(plainText.getBytes());

        return Base64.getEncoder().encodeToString(encrypted);
    }

    //For Decryption of encrypted text
    public static String decrypt(String encryptedText, SecretKey key) throws NoSuchPaddingException, NoSuchAlgorithmException, InvalidKeyException, IllegalBlockSizeException, BadPaddingException {
        Cipher cipher = Cipher.getInstance("AES");
        cipher.init(Cipher.DECRYPT_MODE,key);

        byte[] decrypted = cipher.doFinal(Base64.getDecoder().decode(encryptedText));

        return new String(decrypted);
    }

}
