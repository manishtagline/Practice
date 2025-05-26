package com.Security;

import javax.crypto.*;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;
import java.util.Scanner;

public class AESEncryption {

    //Encrypt plaintext using AES key
    public static String encrypt(String plainText, SecretKey key) throws NoSuchPaddingException, NoSuchAlgorithmException, InvalidKeyException, IllegalBlockSizeException, BadPaddingException {
        //Creates a cipher object for AES encryption.
        Cipher cipher = Cipher.getInstance("AES");
        //Initializes the cipher in encrypt mode with the given secret key.
        cipher.init(Cipher.ENCRYPT_MODE, key);

        //Performs the encryption and returns encrypted bytes
        byte[] cipherText = cipher.doFinal(plainText.getBytes());

        //Converts encrypted bytes to a Base64 string for readable output.
        return Base64.getEncoder().encodeToString(cipherText);
    }

    //Decrypt ciphertext using AES key
    public static String decrypt(String encryptText, SecretKey key) throws NoSuchPaddingException, NoSuchAlgorithmException, InvalidKeyException, IllegalBlockSizeException, BadPaddingException {
        Cipher cipher = Cipher.getInstance("AES");
        cipher.init(Cipher.DECRYPT_MODE, key);

        byte[] decryptedText = cipher.doFinal(Base64.getDecoder().decode(encryptText));

        return new String(decryptedText);
    }

    public static void main(String[] args) throws NoSuchAlgorithmException, NoSuchPaddingException, IllegalBlockSizeException, BadPaddingException, InvalidKeyException {
        //Generating a key for AES with the size of 128
        KeyGenerator keyGen = KeyGenerator.getInstance("AES");
        keyGen.init(128);

        //Generating actual secret key for AES
        SecretKey secretKey = keyGen.generateKey();

        Scanner sc = new Scanner(System.in);
        System.out.print("Enter your text : ");
        String text = sc.nextLine();

        String encrypted = encrypt(text, secretKey);
        System.out.print("Encryption of the text is : "+encrypted);

        String decrypted = decrypt(encrypted, secretKey);
        System.out.println("\nDecrypted: " + decrypted);
    }
}
