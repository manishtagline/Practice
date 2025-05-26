package com.Security.socket;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;

public class ClientSide {
    public static void main(String[] args) throws IOException {
        Socket socket = new Socket("localhost",5000);

        PrintWriter writer = new PrintWriter(socket.getOutputStream(), true);
        writer.println("Hello server");

        BufferedReader reader = new BufferedReader(new InputStreamReader(socket.getInputStream()));
        String text = reader.readLine();

        System.out.println(text);
    }
}
