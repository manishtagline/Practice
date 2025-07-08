        package com.example.questionbanksite.controller;

        import lombok.RequiredArgsConstructor;
        import org.springframework.stereotype.Controller;
        import org.springframework.web.bind.annotation.GetMapping;


        @Controller
        @RequiredArgsConstructor
        public class TeacherController{

            @GetMapping("/teacherExamList")
            public String teacherExamList(){
                return "teacher/manageExam";
            }

        }
