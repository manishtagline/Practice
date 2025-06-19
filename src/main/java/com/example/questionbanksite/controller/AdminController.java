package com.example.questionbanksite.controller;

import com.example.questionbanksite.dto.GetAllExamDto;
import com.example.questionbanksite.dto.GetAllQuestionDto;
import com.example.questionbanksite.dto.GetAllSubjectDto;
import com.example.questionbanksite.dto.GetAllUserDto;
import com.example.questionbanksite.entity.Exam;
import com.example.questionbanksite.entity.Question;
import com.example.questionbanksite.entity.Subject;
import com.example.questionbanksite.entity.User;
import com.example.questionbanksite.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api")
public class AdminController {

    @Autowired
    private SubjectService subjectService;

    @Autowired
    private QuestionService questionService;

    @Autowired
    private ExamService examService;

    @Autowired
    private UserService userService;

    @Autowired
    private CreateExamService createExamService;

    //**************************** Subject API *************************//
    // Create a new subject
    @PostMapping
    public ResponseEntity<?> addSubject(@RequestBody List<Subject> subjects) {
        List<Subject> savedSubject = subjectService.saveSubject(subjects);
        return new ResponseEntity<>(savedSubject, HttpStatus.CREATED);
    }

    // Get subject by id
    @GetMapping("/{id}")
    public ResponseEntity<Subject> getSubjectById(@PathVariable Long id) {
        Subject subject = subjectService.getSubjectById(id);
        if (subject == null) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity<>(subject, HttpStatus.OK);
    }

    // Get all subjects
    @GetMapping("/getSubject")
    public ResponseEntity<GetAllSubjectDto> getAllSubjects() {
       return ResponseEntity
                .status(HttpStatus.OK)
                .body(GetAllSubjectDto.builder()
                        .subjectList(subjectService.getAllSubjects().stream()
                                .map(subject -> subject.getName())
                                .collect(Collectors.toList()))
                        .build()
                );
    }

    // Update subject by id
    @PutMapping("/{id}")
    public ResponseEntity<Subject> updateSubject(@PathVariable Long id, @RequestBody Subject subject) {
        Subject updatedSubject = subjectService.updateSubject(id, subject);
        if (updatedSubject == null) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity<>(updatedSubject, HttpStatus.OK);
    }

    // Delete subject by id
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteSubject(@PathVariable Long id) {
        Subject subject = subjectService.getSubjectById(id);
        if (subject == null) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
        subjectService.deleteSubject(id);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }
    //**************************** Subject API Ends *************************//


    //**************************** Question API  *************************//
    // Create a new question
    @PostMapping("/question")
    public ResponseEntity<?> addQuestion(@RequestBody List<Question> questions) {
        questionService.saveQuestion(questions);
        return new ResponseEntity<>("Done", HttpStatus.CREATED);
    }

    // Get all question
    @GetMapping("/getQuestion")
    public ResponseEntity<GetAllQuestionDto> getAllQuestions() {
        return ResponseEntity
                .status(HttpStatus.OK)
                .body(GetAllQuestionDto.builder()
                        .questionList(questionService.getAllQuestion().stream()
                                .map(question -> question.getQuestiondDesc())
                                .collect(Collectors.toList()))
                        .build()
                );
    }
    //**************************** Question API Ends *************************//


    //**************************** Exam API  *************************//
    @PostMapping("/exam")
    public ResponseEntity<Exam> addExam(@RequestBody Exam exam) {
        Exam savedExam = examService.saveExam(exam);
        return new ResponseEntity<>(savedExam, HttpStatus.CREATED);
    }

    @GetMapping("/getExam")
    public ResponseEntity<GetAllExamDto> getAllExam() {
        return ResponseEntity
                .status(HttpStatus.OK)
                .body(GetAllExamDto.builder()
                        .examList(examService.getAllExam().stream()
                                .map(exam -> exam.getDescription())
                                .collect(Collectors.toList()))
                        .build()
                );
    }
    //**************************** Exam API Ends *************************//

    //**************************** User API  *************************//
    @PostMapping("/user")
    public ResponseEntity<User> addUser(@RequestBody User user) {
        User savedUser = userService.saveUser(user);
        return new ResponseEntity<>(savedUser, HttpStatus.CREATED);
    }

    @GetMapping("/getUser")
    public ResponseEntity<GetAllUserDto> getAllUser() {
        return ResponseEntity
                .status(HttpStatus.OK)
                .body(GetAllUserDto.builder()
                        .userList(userService.getAllUser().stream()
                                .map(user -> user.getUsername())
                                .collect(Collectors.toList()))
                        .build()
                );
    }
    //**************************** User API Ends  *************************//


    //This for to create exam
    @PostMapping("/generate")
    public ResponseEntity<?> createExam(
            @RequestParam Long subjectId,
            @RequestParam String description,
            @RequestParam int totalMarks) {

        createExamService.createExamForSubject(subjectId, description, totalMarks);
        return new ResponseEntity<>("Exam created based on total marks.", HttpStatus.OK);
    }


}
