package com.generis;

import java.util.ArrayList;
import java.util.List;

abstract class Payment{
    double amount;
    Payment(double amount){
        this.amount = amount;
    }
    abstract void process();
}

class CreditCardPayment extends Payment{

    CreditCardPayment(double amount){
        super(amount);
    }

    @Override
    void process() {
        System.out.println("Processing credit card payment of ₹"+amount);
    }
}

class PaypalPayment extends Payment{

    PaypalPayment(double amount) {
        super(amount);
    }

    @Override
    void process() {
        System.out.println("Processing Paypal payment of ₹"+amount);
    }
}

class PaymentProcessor{

    // Upper Bounded Wildcard: Read payments
    public static void processPayment(List<? extends Payment> process){
        for (Payment p : process) {
              p.process();
        }
    }

    // Lower Bounded Wildcard: Add payments
    public static void creditPayment(List<? super CreditCardPayment> payments){
            payments.add(new CreditCardPayment(1523.54)); 
    }

    // Unbounded Wildcard: Print any list
    public static void printList(List<?> list){
        for (Object obj: list) {
            System.out.println("Payments : "+obj);
        }
    }
}

public class RealExampleOfWildCard {
    public static void main(String[] args) {
        List<CreditCardPayment> ccPayment = new ArrayList<>();
        PaymentProcessor.creditPayment(ccPayment);

        List<Payment> allPayments = new ArrayList<>();
        allPayments.add(new PaypalPayment(450.2));
        allPayments.add(new CreditCardPayment(12000));

        allPayments.addAll(ccPayment);

        System.out.println("Processing all payments...");
        PaymentProcessor.processPayment(allPayments);

        System.out.println("\nPrinting all payments list...");
        PaymentProcessor.printList(allPayments);
    }
}
