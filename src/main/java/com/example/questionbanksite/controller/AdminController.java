package com.example.questionbanksite.controller;

import com.example.questionbanksite.dto.*;
import com.example.questionbanksite.entity.Exam;
import com.example.questionbanksite.entity.Question;
import com.example.questionbanksite.entity.Subject;
import com.example.questionbanksite.entity.User;
import com.example.questionbanksite.service.*;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequiredArgsConstructor
public class AdminController {

    private final SubjectService subjectService;

    private final QuestionService questionService;

    private final ExamService examService;

    private final UserService userService;


    @GetMapping("/adminPage")
    public String adminPage(HttpSession session, Model model){
        String username = (String) session.getAttribute("username");
        model.addAttribute("username", username);
        String role = (String) session.getAttribute("role");
        if(username == null || role.equalsIgnoreCase("User")){
            model.addAttribute("error","Please, Login first, as a Admin...");
            return "loginPage";
        }
        return "adminPage";
    }

    //**************************** Subject API *************************//
    // Create a new subject
    @PostMapping("/saveSubject")
    public String addSubject(@ModelAttribute Subject subject, Model model, HttpSession session) {
        String username = (String) session.getAttribute("username");
        model.addAttribute("username", username);
        String role = (String) session.getAttribute("role");
        if(username == null || role.equalsIgnoreCase("User")){
            model.addAttribute("error","Please, Login first!!!");
            return "loginPage";
        }

        int i = subjectService.saveSubject(subject);
        if (i > 0) {
            model.addAttribute("successMsg", "Subject added successfully...");
        } else {
            model.addAttribute("errorMsg", "Something went wrong!!!");
        }
        return "adminAddSubject";
    }

    // Get subject by id
    @GetMapping("/editSubject")
    public String getSubjectById(@RequestParam Long id, Model model,HttpSession session) {

        String username = (String) session.getAttribute("username");
        model.addAttribute("username", username);
        String role = (String) session.getAttribute("role");
        if(username == null || role.equalsIgnoreCase("User")){
            model.addAttribute("error","Please, Login first!!!");
            return "loginPage";
        }

        Subject subject = subjectService.getSubjectById(id);
        model.addAttribute("subject", subject);
        return "adminEditSubject";
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



    @GetMapping("/subjectList")
    @Transactional(readOnly = true)
    public String showSubjectList(Model model, HttpSession session) {

        String username = (String) session.getAttribute("username");
        model.addAttribute("username", username);
        String role = (String) session.getAttribute("role");
        if(username == null || role.equalsIgnoreCase("User")){
            model.addAttribute("error","Please, Login first!!!");
            return "loginPage";
        }

        List<Subject> subjects = subjectService.getAllSubjects();

        subjects.forEach(subject -> {
            subject.getQuestions().size();
            subject.getExams().size();
        });

        List<SubjectDto> subjectDtos = subjects.stream().map(s -> new SubjectDto(
                s.getId(),
                s.getName(),
                s.getQuestions() != null ? s.getQuestions().size() : 0,
                s.getExams() != null ? s.getExams().size() : 0
        )).collect(Collectors.toList());

        model.addAttribute("subjects", subjectDtos);
        return "adminSubjectList";
    }

    // Update subject by id
    @PostMapping("/updateSubject")
    public String updateSubjectForm(@ModelAttribute Subject subject) {
        subjectService.updateSubject(subject.getId(), subject);
        return "adminSubjectList";
    }


    // Delete subject by id
    @GetMapping("/deleteSubject/{id}")
    public String deleteSubject(@PathVariable Long id) {
        subjectService.deleteSubject(id);
        return "adminSubjectList";
    }
    //**************************** Subject API Ends *************************//


    //**************************** Question API  *************************//

    @GetMapping("/addQuestionPage")
    public String addQuestionPage(@RequestParam Long subjectId, Model model, HttpSession session) {
        String username = (String) session.getAttribute("username");
        model.addAttribute("username", username);
        String role = (String) session.getAttribute("role");
        if(username == null || role.equalsIgnoreCase("User")){
            model.addAttribute("error","Please, Login first!!!");
            return "loginPage";
        }

        model.addAttribute("subjectId", subjectId);
        model.addAttribute("question", new Question());  // empty Question object for form binding
        return "adminAddQuestionPage";
    }

    @PostMapping("/saveQuestion")
    public String saveQuestion(
            @RequestParam Long subjectId,
            @RequestParam("options") String[] optionsArray,
            @ModelAttribute("question") Question question) {

        List<String> options = Arrays.stream(optionsArray)
                .filter(opt -> opt != null && !opt.trim().isEmpty())
                .collect(Collectors.toList());

        question.setOptions(options);

        Subject subject = subjectService.getSubjectById(subjectId);
        question.setSubject(subject);

        questionService.saveQuestion(question);

        return "redirect:/manageQuestions?subjectId=" + subjectId;
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

    @GetMapping("/manageQuestions")
    @Transactional(readOnly = true)
    public String manageQuestions(@RequestParam Long subjectId, Model model, HttpSession session){
        String username = (String) session.getAttribute("username");
        model.addAttribute("username", username);
        String role = (String) session.getAttribute("role");
        if(username == null || role.equalsIgnoreCase("User")){
            model.addAttribute("error","Please, Login first!!!");
            return "loginPage";
        }

        Subject subject = subjectService.getSubjectById(subjectId);

        subject.getQuestions().size();

        model.addAttribute("subject", subject);
        return "adminManageQuestions";
    }

    @GetMapping("/deleteQuestion")
    public String deleteQuestion(@RequestParam Long id,@RequestParam Long subjectId){
        questionService.softDeleteQuestion(id);
        return "redirect:/manageQuestions?subjectId=" + subjectId;
    }

    @GetMapping("/editQuestion")
    public String editQuestionPage(@RequestParam Long id, Model model){

        Question question = questionService.getQuestionById(id);

        List<String> options = question.getOptions();
        while (options.size() < 4) {
            options.add("");
        }
        question.setOptions(options);

        model.addAttribute("question", question);
        return "adminEditQuestion";
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

        examService.createExamForSubject(subjectId, description, totalMarks);
        return new ResponseEntity<>("Exam created based on total marks.", HttpStatus.OK);
    }


    @GetMapping("/addSubjectPage")
    public String addSubjectPage(){
        return "adminAddSubject";
    }


}
