package com.generis;

class Place<T>{
    private T item;

    public T getItem() {
        return item;
    }

    public void setItem(T item) {
        this.item = item;
    }
}

public class GenericClass {
    public static void main(String[] args) {
        Place<String> p1 = new Place<>();
        p1.setItem("Hello");
        System.out.println(p1.getItem());

        Place<Integer> p2 = new Place<>();
        p2.setItem(45454);
        System.out.println(p2.getItem());
    }
}
