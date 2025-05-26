package com.Security;

import javax.net.ssl.HttpsURLConnection;
import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;

public class httpUrlExample {
    public static void main(String[] args) throws IOException {
        URL url =  new URL("https://www.instagram.com");
        HttpsURLConnection connection = (HttpsURLConnection) url.openConnection();

        connection.setRequestMethod("GET");
        connection.connect();

        System.out.println("Connected to : "+url);
        System.out.println("Response code : "+connection.getResponseCode());
        System.out.println("Cipher suite : "+connection.getCipherSuite());

        System.out.println("\nHeaders : ");
//        connection.getHeaderFields().forEach((key,value) ->{
//            System.out.println(key+" : " +value);
//        });

        System.out.println("\nResponse Body:");
        BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));

        String line = null;
//        while ((line = reader.readLine()) != null){
//            System.out.println(line);
//        }

        reader.close();
        connection.disconnect();
    }
}
