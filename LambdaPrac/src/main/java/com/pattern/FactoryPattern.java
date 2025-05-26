package com.pattern;

import java.util.Locale;

interface Notification{
    void send(String message);
}

class EmailNotification implements Notification{
    @Override
    public void send(String message) {
        System.out.println("Email : "+message);
    }
}

class SmsNotification implements Notification{
    @Override
    public void send(String message) {
        System.out.println("SMS : "+message);
    }
}

class NotificationFactory{
    public static Notification getNotification(String type){
        return switch (type.toLowerCase()){
            case "email" -> new EmailNotification();
            case "sms" -> new SmsNotification();
            default -> throw new IllegalStateException("Unexpected value: " + type.toLowerCase());
        };
    }
}

public class FactoryPattern {
    public static void main(String[] args) {
        Notification notification =  NotificationFactory.getNotification("sms");
        notification.send("Your otp is, 4596.");
    }
}
