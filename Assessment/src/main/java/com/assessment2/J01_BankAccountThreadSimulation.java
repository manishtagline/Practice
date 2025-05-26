package com.assessment2;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

class BankAccount1{
    public double balance = 10000;

    public synchronized void deposit(String user, double amount){
        balance += amount;
        System.out.println("Deposit by user is "+user +" of amount "+amount+". Current balance is "+balance);
    }

    public synchronized void withdraw(String user, double amount){
        if(amount<=balance){
            balance -= amount;
            System.out.println("Withdrawal by user is "+user +" of amount "+amount+". Current balance is "+balance);
        }else{
            System.out.println("Insufficient amount for withdrawal. Your current balance is "+balance );
        }
    }

    public double getBalance() {
        return balance;
    }
}

public class J01_BankAccountThreadSimulation {
    public static void main(String[] args) {
//        Requirements:
//        Simulate multiple users accessing a shared bank account (deposit/withdraw) simultaneously.
//        Use Thread, Runnable, and synchronized/ReentrantLock for thread safety.
//        Demonstrate usage of ExecutorService.

        ExecutorService executor = Executors.newFixedThreadPool(2);

        BankAccount1 bank = new BankAccount1();

        for (int i = 1; i < 4 ; i++) {
            executor.execute(() ->{
                bank.withdraw("user" , 500);
                bank.deposit("user2",300);
            });
        }

        executor.shutdown();
    }
}
