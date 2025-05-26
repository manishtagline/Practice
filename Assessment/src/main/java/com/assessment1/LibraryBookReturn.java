package com.assessment1;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Scanner;

class BookOverdueException extends Exception{
    public BookOverdueException(String msg) {
        super(msg);
    }
}

class Book{
    private int bookId;
    private String bookName;
    private String issueDate;
    private String submissionDate;
    private String submitDate;

    SimpleDateFormat format = new SimpleDateFormat("dd-MM-yyyy");

    public Book() {
    }

    public Book(int bookId, String bookName, String issueDate, String submissionDate, String submitDate) {
        this.bookId = bookId;
        this.bookName = bookName;
        this.issueDate = issueDate;
        this.submissionDate = submissionDate;
        this.submitDate = submitDate;
    }

    public int getBookId() {
        return bookId;
    }

    public void setBookId(int bookId) {
        this.bookId = bookId;
    }

    public String getBookName() {
        return bookName;
    }

    public void setBookName(String bookName) {
        this.bookName = bookName;
    }

    public String getIssueDate() {
        return issueDate;
    }

    public void setIssueDate(String issueDate) {
        this.issueDate = issueDate;
    }

    public String getSubmissionDate() {
        return submissionDate;
    }

    public void setSubmissionDate(String submissionDate) {
        this.submissionDate = submissionDate;
    }

    public String getSubmitDate() {
        return submitDate;
    }

    public void setSubmitDate(String submitDate) {
        this.submitDate = submitDate;
    }


    public void checkingOverdue() throws BookOverdueException, ParseException {
//            Date issue = format.parse(issueDate);
            Date submission = format.parse(submissionDate);
            Date submit = format.parse(submitDate);

            if(submit.after(submission)){
                throw new BookOverdueException("You submission is "+submissionDate+" but you submit on "+submitDate+", it's as overdue so you have to pay penalty.");
            } else{
                System.out.println("You take the book "+bookName+" on "+issueDate+" and submit it on time.");
            }

    }
}

public class LibraryBookReturn {
    public static void main(String[] args){
//        Question :- 7
//        Requirements:
//        Create BookOverdueException class (custom).
//        If the return date exceeds due date, throw exception.
//        Catch and display an overdue warning.

        Scanner sc = new Scanner(System.in);

        System.out.println("Library Management.");
        System.out.print("Enter the id of book :");
        int bookId = sc.nextInt();
        sc.nextLine();
        System.out.print("Enter the name of book :");
        String bookName = sc.nextLine();
        System.out.print("Enter the issue date dd-mm-yyyy format :");
        String issueDate = sc.next();
        System.out.print("Enter the submission date :");
        String submissionDate = sc.next();
        System.out.print("Enter the submit date :");
        String submitDate = sc.next();

        Book book = new Book();
        book.setBookId(bookId);
        book.setBookName(bookName);
        book.setIssueDate(issueDate);
        book.setSubmissionDate(submissionDate);
        book.setSubmitDate(submitDate);

        try {
            book.checkingOverdue();
        } catch (BookOverdueException | ParseException e) {
            e.printStackTrace();
        }
    }
}
