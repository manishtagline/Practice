package com.optional;

import java.util.Optional;

public class OptionalExample {

    public static Optional<String> findByUserId(int id){
        if(id == 1){
            return Optional.of("Harvey");
        }else if(id == 2){
            return Optional.of("Mike");
        }else{
            return Optional.empty();
        }
    }
    public static void main(String[] args) {
        Optional<String> user = findByUserId(3);
        if (user.isPresent()) {
            System.out.println("Name : " + user.get());
        }

        try {
            String result3 = user.orElseThrow(() -> new RuntimeException("User not found"));
            System.out.println("User: " + result3);
        } catch (RuntimeException e) {
            System.out.println("Exception: " + e.getMessage());


        }
    }
}
