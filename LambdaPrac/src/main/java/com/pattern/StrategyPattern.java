package com.pattern;

interface Payment{
    void pay(int amount);
}

class CreditCardPayment implements Payment{
    @Override
    public void pay(int amount) {
        System.out.println("Paid "+amount+" using credit card.");
    }
}

class PayPalPayment implements Payment{
    @Override
    public void pay(int amount) {
        System.out.println("Paid "+amount+" using paypal.");
    }
}

class ShoppingCart{
    Payment payment;

    public void setPayment(Payment payment){
        this.payment = payment;
    }

    public void checkout(int amount){
        payment.pay(amount);
    }
}

public class StrategyPattern {
    public static void main(String[] args) {
        ShoppingCart cart = new ShoppingCart();

        cart.setPayment(new CreditCardPayment());
        cart.checkout(4500);

        cart.setPayment(new PayPalPayment());
        cart.checkout(500);
    }
}
