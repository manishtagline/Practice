package com.example.questionbanksite.controller;

import com.example.questionbanksite.dto.*;
import com.example.questionbanksite.entity.*;
import com.example.questionbanksite.service.*;
import lombok.RequiredArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.time.LocalDateTime;
import java.time.ZoneId;
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

    private final TeacherService teacherService;


    @GetMapping("/adminPage")
    public String adminPage() {

        return "admin/adminPage";
    }

    //**************************** Subject Handlers *************************//
    // Create a new subject
    @PostMapping("/saveSubject")
    public String addSubject(@ModelAttribute Subject subject, Model model, HttpSession session) {

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

        Subject subject = subjectService.getSubjectById(id);
        model.addAttribute("subject", subject);
        return "admin/editSubject";
    }


    @GetMapping("/subjectList")
    @Transactional(readOnly = true)
    public String showSubjectList(Model model, HttpSession session) {

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

        String correctOptionLetter = question.getCorrectAnswer();
        String correctAnswer = "";

        correctAnswer = switch (correctOptionLetter) {
            case "A" -> options.get(0);
            case "B" -> options.get(1);
            case "C" -> options.get(2);
            case "D" -> options.get(3);
            default -> "";
        };

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

    @GetMapping("/userList")
    public String userList(Model model, HttpSession session){
        List<UserDetailsListDto> users = userService.getAllUserDetails();
        model.addAttribute("users", users);
        return "admin/userList";
    }
    //**************************** User Handlers Ends  *************************//




    //**************************** Teacher Handlers  *************************//

    @GetMapping("/teacherList")
    public String viewTeacherList(Model model){
        List<TeacherDto> teachers =  teacherService.getAllTeachers();

        model.addAttribute("teachers", teachers);
        return "admin/teacherList";
    }

    @GetMapping("/assignSubjectPage")
    public String assignSubjectPage(@RequestParam("facultyId") Long teacherId, Model model) {
        List<Subject> subjects = subjectService.getAllSubjects();
        Teacher teacher = teacherService.getTeacherById(teacherId);

        model.addAttribute("teacher", teacher);
        model.addAttribute("subjects", subjects);
        return "admin/assignSubject";
    }

    @PostMapping("/assignSubject")
    public String assignSubject(
            @RequestParam("teacherId") Long teacherId,
            @RequestParam("subjectId") Long subjectId,
            RedirectAttributes redirectAttributes,
            Model model) {

        Teacher teacher = teacherService.getTeacherById(teacherId);
        Subject subject = subjectService.getSubjectById(subjectId);

        if (teacher != null && subject != null) {
            teacher.setSubject(subject);
            teacherService.updateTeacher(teacher);
            redirectAttributes.addFlashAttribute("successMsg", "Subject assigned successfully!");
        } else {
            redirectAttributes.addFlashAttribute("errorMsg", "Invalid teacher or subject.");
        }

        return "redirect:/assignSubjectPage?facultyId=" + teacherId;
    }



    //**************************** Teacher Handlers Ends  *************************//




    //**************************** Exam Handlers  *************************//

    @GetMapping("/examList")
    public String examList(Model model, HttpSession session){
        List<ExamDto> exam = examService.getAllExam();
        model.addAttribute("exams", exam);
        return "admin/examList";
    }

    @GetMapping("/addExamPage")
    public String addExam(Model model, HttpSession session){

        model.addAttribute("subjectList", subjectService.getAllSubjects());
        model.addAttribute("exam", new ExamDto());
        return "admin/addExam";
    }


    @PostMapping("/saveExam")
    public String saveExam(@ModelAttribute("exam") ExamDto exam,
                           Model model,
                           HttpSession session,
                           RedirectAttributes redirectAttributes) {

        String zoneIdStr = (String) session.getAttribute("zoneId");
        ZoneId zoneId = (zoneIdStr != null) ? ZoneId.of(zoneIdStr) : ZoneId.systemDefault();

        ZonedDateTime now = ZonedDateTime.now(zoneId);

        if(!exam.getEnrolledStartDate().atZone(zoneId).isAfter(now)){

            redirectAttributes.addFlashAttribute("errorMsg", "Enrollment start date must be future.");
            return "redirect:/addExamPage";
        } else if(!exam.getEnrolledEndDate().atZone(zoneId).isAfter(now)){

            redirectAttributes.addFlashAttribute("errorMsg", "Enrollment end date must be future.");
            return "redirect:/addExamPage";
        } else if(!exam.getExamStartDate().atZone(zoneId).isAfter(now)){

            redirectAttributes.addFlashAttribute("errorMsg", "Exam start date must be future.");
            return "redirect:/addExamPage";
        } else if(!exam.getExamEndDate().atZone(zoneId).isAfter(now)){

            redirectAttributes.addFlashAttribute("errorMsg", "Exam end date must be future.");
            return "redirect:/addExamPage";
        }

        if (exam.getEnrolledStartDate().isAfter(exam.getEnrolledEndDate())) {
            redirectAttributes.addFlashAttribute("errorMsg", "Enrollment start date must be before enrollment end date.");
            return "redirect:/addExamPage";
        }

        if (exam.getExamStartDate().isAfter(exam.getExamEndDate())) {
            redirectAttributes.addFlashAttribute("errorMsg", "Exam start date must be before exam end date.");
            return "redirect:/addExamPage";
        }

        int i = examService.createExamForSubject(exam.getSubjectId(),
                exam.getDescription(),
                exam.getTotalMarks(),
                exam.getEnrolledStartDate(),
                exam.getEnrolledEndDate(),
                exam.getExamStartDate(),
                exam.getExamEndDate(),
                zoneId);

        if (i > 0) {
            redirectAttributes.addFlashAttribute("successMsg", "Exam added successfully...");
        } else {
            redirectAttributes.addFlashAttribute("errorMsg", "Something went wrong!!!");
        }
        return "redirect:/addExamPage";
    }


    @GetMapping("/viewExamDetails")
    public String viewExamDetails(@RequestParam Long id, Model model, HttpSession session){

        Exam exam = examService.getExamById(id);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
        String formattedDate = exam.getDateCreated().format(formatter);

        model.addAttribute("exam", exam);
        model.addAttribute("formattedDate", formattedDate);
        return "admin/viewExamDetails";
    }

    //**************************** Exam Handlers Ends *************************//

}
