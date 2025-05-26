package com.generis;

class Method{
    public static <T> void printArr(T[] arr){
        for (T ele: arr) {
            System.out.println(ele);
        }
    }
}

class MathUtil{
    public static <T extends Number> double square(T num){
        return num.doubleValue() * num.doubleValue();
    }
}

public class GenericMethod {
    public static void main(String[] args) {

        String[] strArray = {"Java", "Python", "C++"};
        Integer[] intArray = {1, 2, 3};

        Method.printArr(strArray);
        Method.printArr(intArray);

        System.out.println(  MathUtil.square(45.5));
        System.out.println(MathUtil.square(45));
    }
}
