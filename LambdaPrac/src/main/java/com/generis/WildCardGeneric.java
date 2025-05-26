package com.generis;

import java.util.ArrayList;
import java.util.List;

class WildCars{
    public static void print(List<? super Integer> list){
        list.add(45454);
    }
}

public class WildCardGeneric {
    public static void main(String[] args) {
//        List<String> strList = List.of("Manish","Rohit","Ronny");
//        List<Integer> intList = List.of(545,65,26,565,2,365,5);
//
//        WildCars.print(strList);
//        WildCars.print(intList);

        List<Integer> intList = new ArrayList<>();
        List<Object> objList = new ArrayList<>();

        WildCars.print(intList);
        WildCars.print(objList);

        System.out.println(intList);
        System.out.println(objList);

    }
}
