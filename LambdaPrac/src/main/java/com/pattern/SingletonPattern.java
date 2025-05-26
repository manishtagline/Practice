package com.pattern;

class Logger{
    private static Logger instance;

    private Logger(){
        System.out.println("Logger is instantiated...");
    }

    public static Logger getInstance(){
        if(instance == null){
            instance = new Logger();
        }
        return instance;
    }

    public void log(String message){
        System.out.println("Log message : "+message);
    }
}

public class SingletonPattern {
    public static void main(String[] args) {
        Logger logger1 = Logger.getInstance();
        Logger logger2 = Logger.getInstance();

        logger1.log("Application fro Logger 1 app.");
        logger1.log("Application fro Logger 2 app.");

        System.out.println("Is logger 1 == logger 2 "+(logger1==logger2));
    }
}
