package com.rmi;

import java.rmi.Remote;
import java.rmi.RemoteException;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;
import java.rmi.server.UnicastRemoteObject;

interface HelloService extends Remote {
    String sayHello() throws RemoteException;
}

class HelloServiceImpl extends UnicastRemoteObject implements HelloService {
    protected HelloServiceImpl() throws RemoteException {
        super();
    }

    @Override
    public String sayHello() {
        return "Hello from Manish";
    }
}

public class RMIServer {
    public static void main(String[] args) {
        try {
            HelloService service = new HelloServiceImpl();
            Registry registry = LocateRegistry.createRegistry(1099); // Start local RMI registry
            registry.rebind("HelloService", service);
            System.out.println("RMI Server running on PC1...");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
