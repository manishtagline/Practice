package com.example.questionbanksite.controller;

import com.example.questionbanksite.dto.*;
import com.example.questionbanksite.entity.Exam;
import com.example.questionbanksite.entity.Question;
import com.example.questionbanksite.entity.Subject;
import com.example.questionbanksite.entity.User;
import com.example.questionbanksite.service.*;
import lombok.RequiredArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
@RequiredArgsConstructor
public class AdminController {

    private final SubjectService subjectService;

    private final QuestionService questionService;

    private final ExamService examService;

    private final UserService userService;


    @GetMapping("/adminPage")
    public String adminPage(HttpSession session, Model model) {
        String username = (String) session.getAttribute("username");
        model.addAttribute("username", username);
        String role = (String) session.getAttribute("role");
        if (username == null || role.equalsIgnoreCase("User")) {
            model.addAttribute("error", "Please, Login first, as a Admin...");
            return "loginPage";
        }
        return "admin/adminPage";
    }



    //<-------------- Authentication Method -------------->//
    private boolean Auth(Model model, HttpSession session) {
        String username = (String) session.getAttribute("username");
        model.addAttribute("username", username);
        String role = (String) session.getAttribute("role");
        if (username == null || role.equalsIgnoreCase("User")) {
            model.addAttribute("error", "Please, Login first!!!");
            return true;
        }
        return false;
    }

    //**************************** Subject Handlers *************************//
    // Create a new subject
    @PostMapping("/saveSubject")
    public String addSubject(@ModelAttribute Subject subject, Model model, HttpSession session) {
        if (Auth(model, session)) return "loginPage";

        int i = subjectService.saveSubject(subject);
        if (i > 0) {
            model.addAttribute("successMsg", "Subject added successfully...");
        } else {
            model.addAttribute("errorMsg", "Something went wrong!!!");
        }
        return "admin/addSubject";
    }

    // Get subject by id
    @GetMapping("/editSubject")
    public String getSubjectById(@RequestParam Long id, Model model, HttpSession session) {

        if (Auth(model, session)) return "loginPage";

        Subject subject = subjectService.getSubjectById(id);
        model.addAttribute("subject", subject);
        return "admin/editSubject";
    }


    @GetMapping("/subjectList")
    @Transactional(readOnly = true)
    public String showSubjectList(Model model, HttpSession session) {

        if (Auth(model, session)) return "loginPage";

        List<Subject> subjects = subjectService.getAllSubjects();

        subjects.forEach(subject -> {
            subject.getQuestions().size();
            subject.getExams().size();
        });

        List<SubjectDto> subjectDto = subjects.stream().map(s -> new SubjectDto(
                s.getId(),
                s.getName(),
                s.getQuestions() != null ? s.getQuestions().size() : 0,
                s.getExams() != null ? s.getExams().size() : 0
        )).collect(Collectors.toList());

        model.addAttribute("subjects", subjectDto);
        return "admin/subjectList";
    }


    // Update subject by id
    @PostMapping("/updateSubject")
    public String updateSubjectForm(@ModelAttribute Subject subject) {
        subjectService.updateSubject(subject.getId(), subject);
        return "redirect:/subjectList";
    }


    // Delete subject by id
    @GetMapping("/deleteSubject/{id}")
    public String deleteSubject(@PathVariable Long id) {
        subjectService.deleteSubject(id);
        return "subjectList";
    }

    @GetMapping("/addSubjectPage")
    public String addSubjectPage() {
        return "admin/addSubject";
    }
    //**************************** Subject Handlers Ends *************************//




    //**************************** Question Handlers  *************************//

    @GetMapping("/addQuestionPage")
    public String addQuestionPage(@RequestParam Long subjectId, Model model, HttpSession session) {
        if (Auth(model, session)) return "loginPage";

        model.addAttribute("subjectId", subjectId);
        model.addAttribute("question", new Question());
        return "admin/addQuestionPage";
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

        // Map A-D to actual option string
        String correctOptionLetter = question.getCorrectAnswer();
        String correctAnswer = "";

        switch (correctOptionLetter) {
            case "A":
                correctAnswer = options.get(0);
                break;
            case "B":
                correctAnswer = options.get(1);
                break;
            case "C":
                correctAnswer = options.get(2);
                break;
            case "D":
                correctAnswer = options.get(3);
                break;
            default:
                correctAnswer = "";
        }

        question.setCorrectAnswer(correctAnswer);

        Subject subject = subjectService.getSubjectById(subjectId);
        question.setSubject(subject);

        questionService.saveQuestion(question);

        return "redirect:/manageQuestions?subjectId=" + subjectId;
    }


    @GetMapping("/manageQuestions")
    @Transactional(readOnly = true)
    public String manageQuestions(
            @RequestParam Long subjectId, @RequestParam(defaultValue = "1") int page, @RequestParam(required = false) String sortBy,
            @RequestParam(required = false) String complexity, Model model, HttpSession session) {

        if (Auth(model, session)) return "loginPage";

        int pageSize = 10;

        List<Question> questions = questionService.getFilteredAndSortedQuestions(
                subjectId, complexity, sortBy, page, pageSize);

        int totalQuestions = questionService.countFilteredQuestions(subjectId, complexity);
        int totalPages = (int) Math.ceil((double) totalQuestions / pageSize);

        Subject subject = subjectService.getSubjectById(subjectId);

        model.addAttribute("subject", subject);
        model.addAttribute("questions", questions);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("subjectId", subjectId);
        model.addAttribute("sortBy", sortBy);
        model.addAttribute("complexity", complexity);

        return "admin/manageQuestions";
    }

    @GetMapping("/deleteQuestion")
    public String deleteQuestion(@RequestParam Long id, @RequestParam Long subjectId) {
        questionService.softDeleteQuestion(id);
        return "redirect:/manageQuestions?subjectId=" + subjectId;
    }

    @GetMapping("/editQuestion")
    public String editQuestionPage(@RequestParam Long id, Model model, HttpSession session) {

        if (Auth(model, session)) return "loginPage";

        Question question = questionService.getQuestionById(id);

        List<String> options = question.getOptions();
        while (options.size() < 4) {
            options.add("");
        }
        question.setOptions(options);

        model.addAttribute("question", question);
        return "admin/editQuestion";
    }

    @PostMapping("/updateQuestion")
    public String updateQuestion(@ModelAttribute("question") Question question) {
        Long id = question.getId();
        Long subjectId = question.getSubject().getId();
        System.out.println("Question id :" + id);
        System.out.println("Subject id :" + subjectId);

        questionService.updateQuestion(id, question);
        return "redirect:/manageQuestions?subjectId=" + subjectId;
    }
    //**************************** Question Handlers Ends *************************//




    //**************************** User Handlers  *************************//
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


    @GetMapping("/userList")
    public String userList(Model model, HttpSession session){
        if (Auth(model, session)) return "loginPage";

        List<UserDetailsListDto> users = userService.getAllUserDetails();
        model.addAttribute("users", users);
        return "admin/userList";
    }
    //**************************** User Handlers Ends  *************************//


    //**************************** Exam Handlers  *************************//

    @GetMapping("/examList")
    public String examList(Model model, HttpSession session){
        if (Auth(model, session)) return "loginPage";

        List<Exam> exams = examService.getAllExam();

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
        List<Map<String, Object>> exam = exams.stream().map(examList -> {
            Map<String, Object> map = new HashMap<>();
            map.put("id", examList.getId());
            map.put("description", examList.getDescription());
            map.put("totalMarks", examList.getTotalMarks());
            map.put("totalNumberOfQuestion", examList.getTotalNumberOfQuestion());
            map.put("subjectName", examList.getSubject().getName());
            map.put("formattedDate", examList.getDateCreated().format(formatter));
            return map;
        }).collect(Collectors.toList());

        model.addAttribute("exams", exam);
        return "admin/examList";
    }

    @GetMapping("/addExamPage")
    public String addExam(Model model, HttpSession session){
        if (Auth(model, session)) return "loginPage";

        model.addAttribute("subjectList", subjectService.getAllSubjects());
        model.addAttribute("exam", new Exam());
        return "admin/addExam";
    }


    @PostMapping("/saveExam")
    public String saveExam(@ModelAttribute("exam") Exam exam, Model model, HttpSession session, RedirectAttributes redirectAttributes) {
        if (Auth(model, session)) return "loginPage";

        Long subjectId = exam.getSubject().getId();
        String description = exam.getDescription();
        Long totalMark = exam.getTotalMarks();

//        ZonedDateTime enrolledStartDate = exam.getEnrolledStartDate();
//        ZonedDateTime enrolledEndDate = exam.getEnrolledEndDate();
//        ZonedDateTime examStartDate = exam.getExamStartDate();
//        ZonedDateTime examEndDate = exam.getExamEndDate();

        int i = examService.createExamForSubject(subjectId, description, totalMark);

        if (i > 0) {
            redirectAttributes.addFlashAttribute("successMsg", "Exam added successfully...");
        } else {
            redirectAttributes.addFlashAttribute("errorMsg", "Something went wrong!!!");
        }
        return "redirect:/addExamPage";
    }


    @GetMapping("/viewExamDetails")
    public String viewExamDetails(@RequestParam Long id, Model model, HttpSession session){
        if (Auth(model, session)) return "loginPage";

        Exam exam = examService.getExamById(id);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
        String formattedDate = exam.getDateCreated().format(formatter);

        model.addAttribute("exam", exam);
        model.addAttribute("formattedDate", formattedDate);
        return "admin/viewExamDetails";
    }

    //**************************** Exam Handlers Ends *************************//

}
