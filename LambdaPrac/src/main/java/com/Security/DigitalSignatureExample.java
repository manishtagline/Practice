package com.Security;

import java.nio.charset.StandardCharsets;
import java.security.*;
import java.util.Base64;
import java.util.Scanner;

public class DigitalSignatureExample {
    public static void main(String[] args) throws NoSuchAlgorithmException, InvalidKeyException, SignatureException {
        //Creates an instance of KeyPairGenerator for the RSA algorithm.
        KeyPairGenerator keyGen = KeyPairGenerator.getInstance("RSA");
        keyGen.initialize(2048);

        //generateKeyPair() creates a public-private key pair.
        KeyPair pair = keyGen.generateKeyPair();
        PrivateKey privateKey = pair.getPrivate();
        PublicKey publicKey = pair.getPublic();

        Scanner sc = new Scanner(System.in);
        System.out.print("Enter your text : ");
        String text = sc.nextLine();


        //Creates a Signature object using the SHA256withRSA algorithm.
        Signature signature = Signature.getInstance("SHA256withRSA");
        //Sign a data using private key
        signature.initSign(privateKey);
        //Feeds the input text to the signature engine.
        signature.update(text.getBytes());
        byte[] digitalSignature = signature.sign();

        System.out.println("Digital Signature (Base64): "+ Base64.getEncoder().encodeToString(digitalSignature));

        //Creates a new Signature object for verification.
        Signature verifier = Signature.getInstance("SHA256withRSA");
        //Initializes it with the public key.
        verifier.initVerify(publicKey);
        verifier.update(text.getBytes());
        //Calls verify(...) with the previously generated signature. It returns true if the signature is valid.
        boolean verify = verifier.verify(digitalSignature);
        System.out.println("Signature verified? " + verify);
    }
}
