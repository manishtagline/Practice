package com.assessment1;

class Person{

    private String studentName;
    private int stId;

    public Person(String studentName, int stId) {
        this.studentName = studentName;
        this.stId = stId;
    }

    public void showDetails(){
        System.out.println("Id : "+ stId);
        System.out.println("Name : "+studentName);
    }

}

class Student extends Person{


    private int[] marks;

    public Student(String studentName, int stId, int[] marks) {
        super(studentName, stId);
        this.marks = marks;
    }

    public void calculateGrade(){
        int arr = 0;
        for (int mark : marks) {
            arr += mark;
        }

        if(arr>100){
            System.out.println("Please enter valid marks");
        }else {
            System.out.println("Your average marks is "+(arr/marks.length));
            System.out.println("Total marks is "+arr);
            if(arr >= 90 && arr <= 100){
                System.out.println("Your grade is A+.");
            }else if(arr >= 80 && arr <= 89 ){
                System.out.println("Your grade is A.");
            }else if(arr >= 50 && arr <= 79 ){
                System.out.println("Your grade is B.");
            }else if(arr >= 33 && arr <= 49 ){
                System.out.println("Your grade is C.");
            }else{
                System.out.println("Your grade is F.");
            }
        }
    }

    @Override
    public void showDetails(){
        super.showDetails();

    }



}

public class StudentGrading {
    public static void main(String[] args) {
//        Question :- 3
//        Requirements:
//        Create a Person base class with common attributes.
//        Student inherits Person and adds marks[].
//        Calculate average and assign grade (A/B/C/F)
//        Override method to display complete details.

        Student st = new Student("abc",1, new int[]{15, 2, 22, 11});

        st.showDetails();
        st.calculateGrade();
    }
}
