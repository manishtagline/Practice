package com.assessment2;

import java.util.Arrays;
import java.util.Comparator;
import java.util.List;
import java.util.Scanner;
import java.util.stream.Collectors;

class ListOfProduct{
    int productId;
    String productName;
    int price;
    String category;

    public ListOfProduct(int productId, String productName, int price, String category) {
        this.productId = productId;
        this.productName = productName;
        this.price = price;
        this.category = category;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    @Override
    public String toString() {
        return
                "Id = " + productId +
                ", Name = '" + productName + '\'' +
                ", price = " + price +
                ", category = '" + category + '\'';
    }
}

public class J02_ProductCatalog {
    public static void main(String[] args) {
//        Product Catalog Filter System
//        Requirements:
//        Create a list of products with fields like name, price, and category.
//        Use Lambda and Stream API to filter by category, sort by price, and search by name.
//        Demonstrate use of Predicate, Function, Comparator, and Collectors.

        Scanner sc = new Scanner(System.in);

        List<ListOfProduct> products = Arrays.asList(
                new ListOfProduct(1,"Fan", 2000,"Electronics"),
                new ListOfProduct(2,"Cap", 250,"Cloths"),
                new ListOfProduct(3,"Nike", 5000,"Shoes"),
                new ListOfProduct(4,"AC", 32000,"Electronics"),
                new ListOfProduct(5,"T-Shirts", 900,"Cloths"),
                new ListOfProduct(6,"Puma", 2800,"Shoes"),
                new ListOfProduct(7,"Light", 700,"Electronics"),
                new ListOfProduct(8,"Pants", 1000,"Cloths"),
                new ListOfProduct(9,"Adidas", 1800,"Shoes")
        );



        while (true){
            System.out.println("Here are the choices:");
            System.out.println("Enter 1 for search of product by name.");
            System.out.println("Enter 2 for filter the product by category.");
            System.out.println("Enter 3 for sort the product by price.");
            System.out.println("Enter 4 for termination.");
            int choice = sc.nextInt();

            if(choice != 4){
                switch (choice){
                    case 1:
                        System.out.print("\nEnter the product name : ");
                        String nameOfProduct = sc.next();
                        List<ListOfProduct> list1 = products.stream().filter(name -> name.productName.equalsIgnoreCase(nameOfProduct)).collect(Collectors.toList());
                        for (ListOfProduct l :list1) {
                            System.out.println(l);
                        }
                        System.out.println();
                        break;

                    case 2:
                        System.out.print("\nEnter the product category : ");
                        String categoryName = sc.next();
                        List<ListOfProduct> list2 = products.stream().filter(category -> category.category.equalsIgnoreCase(categoryName)).collect(Collectors.toList());
                        for (ListOfProduct l :list2) {
                            System.out.println(l);
                        }
                        System.out.println();
                        break;

                    case 3:
                        List<ListOfProduct> list3 = products.stream().sorted(Comparator.comparing(pro -> pro.price)).distinct().collect(Collectors.toList());
                        for (ListOfProduct l :list3) {
                            System.out.println(l);
                        }
                        System.out.println();
                        break;

                    case 4:

                        break;
            }
            }else{
                System.out.println("Program terminated...");
                break;
            }

        }



    }
}
