package com.Security;

import java.net.InetAddress;
import java.net.UnknownHostException;

public class InetAddressExample {
    public static void main(String[] args) throws UnknownHostException {
        InetAddress website = InetAddress.getByName("www.instagram.com");
        System.out.println("Website HostName : "+website.getHostName());
        System.out.println("Website IpAddress : "+website.getHostAddress());

        InetAddress local = InetAddress.getLocalHost();
        System.out.println("\nLocal HostName : "+local.getHostName());
        System.out.println("Local IpAddress : "+local.getHostAddress());


    }
}
