package com.ExecutorService;

import java.util.concurrent.*;

public class ExecutorServiceExample {
    public static void main(String[] args) {
        ExecutorService executor = Executors.newFixedThreadPool(2);

        executor.execute(() -> System.out.println("Task 1 running..."));

        Future<Integer> future = executor.submit(() -> {
            Thread.sleep(4000);
            return 42;
        });

        try {
            // Get result from future
            Integer result = future.get(); // waits if necessary
            System.out.println("Result from Callable: " + result);
        } catch (InterruptedException | ExecutionException e) {
            e.printStackTrace();
        }

        executor.shutdown();
    }
}
