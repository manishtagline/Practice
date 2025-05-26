package com.assessment1;

class Account{

    private int accountNumber;
    private String holderName;
    private int balance;

    public Account() {
    }

    public Account(int accountNumber, String holderName, int balance) {
        this.accountNumber = accountNumber;
        this.holderName = holderName;
        this.balance = balance;
    }

    public int getAccountNumber() {
        return accountNumber;
    }

    public void setAccountNumber(int accountNumber) {
        this.accountNumber = accountNumber;
    }

    public String getHolderName() {
        return holderName;
    }

    public void setHolderName(String holderName) {
        this.holderName = holderName;
    }

    public int getBalance() {
        System.out.println("\nYour current balance is ");
        return balance;
    }

    public void setBalance(int balance) {
        this.balance = balance;
    }

    public void deposit(int amount){
        balance += amount;
        System.out.println("You deposit the amount "+ amount +" and your current bank balance is "+ balance);
    }

    public void withdraw(int amount){
        if(balance > 0 && amount <= balance){
            balance -= amount;
            System.out.println("Your current balance after withdrawal is  "+balance);
        }else{
            System.out.println("Insufficient balance!!!!");
        }
    }

}

public class BankAccount {
    public static void main(String[] args) {
//        Question :- 2
//        Requirements:
//        Create a BankAccount class with private fields: accountNumber, holderName, balance.
//        Implement methods: deposit(), withdraw(), getBalance().
//        Use setters/getters and constructor for object creation.

        Account account = new Account(125445, "Abc", 150000);
        account.deposit(5000);
        account.deposit(10000);

        account.withdraw(1400);

        System.out.println(account.getBalance());
    }
}
