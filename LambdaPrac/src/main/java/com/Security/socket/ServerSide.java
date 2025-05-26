package com.Security.socket;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.ServerSocket;
import java.net.Socket;

public class ServerSide {
    public static void main(String[] args) throws IOException {
        ServerSocket serverSocket = new ServerSocket(5000);
        System.out.println("Server waiting for client...");

        Socket socket = serverSocket.accept();
        System.out.println("Client connected...");

        BufferedReader reader = new BufferedReader(new InputStreamReader(socket.getInputStream()));
        String message = reader.readLine();
        System.out.println("Message : "+message);

        PrintWriter writer = new PrintWriter(socket.getOutputStream(),true);
        writer.println("Hello from server...");
    }
}
