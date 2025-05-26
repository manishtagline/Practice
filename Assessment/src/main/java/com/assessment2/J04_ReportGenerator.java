package com.assessment2;

//using Factory Design pattern
interface ReportGenerator{
    void reports(int percentage);
}

class ReportsForMarks implements ReportGenerator{

    @Override
    public void reports(int percentage) {
        if(percentage >= 35 && percentage <= 100){
            System.out.println("Marks reports is OK.");
        }else{
            System.out.println("Marks report is not OK.");
        }
    }
}

class ReportsForAttendance implements ReportGenerator{

    @Override
    public void reports(int percentage) {
        if(percentage >= 75 && percentage <= 100){
            System.out.println("Attendance reports is OK.");
        }else{
            System.out.println("Attendance report is not OK.");
        }
    }
}

class GetReports{
    public ReportGenerator getReports(String reports){
        if(reports == null){
            return null;
        }else if(reports.equalsIgnoreCase("Marks")){
            return new ReportsForMarks();
        }else if(reports.equalsIgnoreCase("Attendance")){
            return new ReportsForAttendance();
        }
        return null;
    }
}


//Using Strategy design pattern
interface FileGenerator{
    void fileGen();
}

class PdfGenerator implements FileGenerator{

    @Override
    public void fileGen() {
        System.out.println("Creating PDF of file.");
    }
}

class CsvGenerator implements FileGenerator{

    @Override
    public void fileGen() {
        System.out.println("Creating CSV of file.");
    }
}

class GetFile{
    FileGenerator file;

    public GetFile(FileGenerator file) {
        this.file = file;
    }

    public void callMethod(){
        file.fileGen();
    }
}

public class J04_ReportGenerator {
    public static void main(String[] args) {
//        Report Generator using Factory & Strategy Pattern
//        Requirements:
//        Implement Factory Pattern to generate different types of reports (e.g., marks, attendance).
//        Use Strategy Pattern to switch between PDF and CSV generation logic dynamically.
//        Demonstrate good separation of concern using interfaces and patterns.

        GetReports get = new GetReports();

        //For attendance reports
        ReportGenerator reports = get.getReports("Attendance");
        reports.reports(80);

        //For marks reports
        ReportGenerator reports1 = get.getReports("Marks");
        reports1.reports(80);

        //For creating a PDF file
        GetFile file = new GetFile(new PdfGenerator());
        file.callMethod();

        //For creating a CSV file
        file = new GetFile(new CsvGenerator());
        file.callMethod();
    }
}
