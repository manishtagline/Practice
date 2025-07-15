package com.example.questionbanksite.controller;

import com.example.questionbanksite.dto.*;
import com.example.questionbanksite.entity.*;
import com.example.questionbanksite.service.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/admin")
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
        return "redirect:/admin/subjectList";
    }


    // Delete subject by id
    @GetMapping("/deleteSubject/{id}")
    public String deleteSubject(@PathVariable Long id) {
        subjectService.deleteSubject(id);
        return "redirect:/admin/subjectList";
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

        Set<String> optionSet = Arrays.stream(optionsArray)
                .filter(opt -> opt != null && !opt.trim().isEmpty())
                .collect(Collectors.toCollection(LinkedHashSet::new));

        question.setOptions(optionSet);

        List<String> options = new ArrayList<>(optionSet);

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

        return "redirect:/admin/manageQuestions?subjectId=" + subjectId;
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
        return "redirect:/admin/manageQuestions?subjectId=" + subjectId;
    }

    @GetMapping("/editQuestion")
    public String editQuestionPage(@RequestParam Long id, Model model) {

        Question question = questionService.getQuestionById(id);

        Set<String> options = question.getOptions();
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

        questionService.updateQuestion(id, question);
        return "redirect:/admin/manageQuestions?subjectId=" + subjectId;
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
    public String viewTeacherList(Model model,HttpSession session){
        List<TeacherDto> teachers =  teacherService.getAllTeachers();

        model.addAttribute("teachers", teachers);
        return "admin/teacherList";
    }

    @GetMapping("/assignSubjectPage")
    public String assignSubjectPage(@RequestParam("facultyId") Long teacherId, Model model) {
        List<Subject> subjects = subjectService.getAllSubjects();
        Teacher teacher = teacherService.getTeacherById(teacherId);

        List<Long> assignedSubjectsId = teacher.getSubjects().stream().map(Subject::getId).collect(Collectors.toList());

        model.addAttribute("teacher", teacher);
        model.addAttribute("subjects", subjects);
        model.addAttribute("assignedSubjectIds", assignedSubjectsId);
        return "admin/assignSubject";
    }

    @PostMapping("/assignSubject")
    public String assignSubject(
            @RequestParam("teacherId") Long teacherId,
            @RequestParam("subjectId") List<Long> subjectId,
            RedirectAttributes redirectAttributes) {

        Teacher teacher = teacherService.getTeacherById(teacherId);
        List<Subject> subjects = subjectService.getSubjectByListOfId(subjectId);

        if (teacher != null && subjects != null) {
            teacher.setSubjects(subjects);
            teacherService.updateTeacher(teacher);
            redirectAttributes.addFlashAttribute("successMsg", "Subject assigned successfully!");
            return "redirect:/admin/teacherList";
        } else {
            redirectAttributes.addFlashAttribute("errorMsg", "Invalid teacher or subject.");
        }

        return "redirect:/admin/teacherList";
    }

    @GetMapping("/viewTeacherQuestions")
    public String viewTeacherQuestionList(@RequestParam("facultyId") Long facultyId, Model model){
        List<QuestionDto> questions = teacherService.getQuestionOfTeacher(facultyId);

        model.addAttribute("questions", questions);
        model.addAttribute("facultyId", facultyId);
        return "admin/teacherQuestionList";
    }

    @GetMapping("/viewExamDetailsOfTeacher")
    public String viewTeacherExamList(@RequestParam("facultyId") Long facultyId, Model model){
        List<ExamDto> exams = examService.getAllExamOfTeacher(facultyId);

        model.addAttribute("exams", exams);
        model.addAttribute("facultyId", facultyId);
        return "admin/teacherExamList";
    }

    @GetMapping("/deleteQuestionOfTeacher")
    public String deleteQuestionOfTeacher(@RequestParam("questionId") Long id,
                                          @RequestParam("facultyId")Long facultyId){
        questionService.softDeleteQuestion(id);
        return "redirect:/admin/viewTeacherQuestions?facultyId=" + facultyId;
    }

    //**************************** Teacher Handlers Ends  *************************//




    //**************************** Exam Handlers  *************************//

    @GetMapping("/examList")
    public String examList(Model model, HttpSession session){
        List<ExamDto> exam = examService.getAllExam();
        model.addAttribute("exams", exam);
        return "admin/examList";
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
            return "redirect:/admin/addExamPage";
        } else if(!exam.getEnrolledEndDate().atZone(zoneId).isAfter(now)){

            redirectAttributes.addFlashAttribute("errorMsg", "Enrollment end date must be future.");
            return "redirect:/admin/addExamPage";
        } else if(!exam.getExamStartDate().atZone(zoneId).isAfter(now)){

            redirectAttributes.addFlashAttribute("errorMsg", "Exam start date must be future.");
            return "redirect:/admin/addExamPage";
        } else if(!exam.getExamEndDate().atZone(zoneId).isAfter(now)){

            redirectAttributes.addFlashAttribute("errorMsg", "Exam end date must be future.");
            return "redirect:/admin/addExamPage";
        }

        if (exam.getEnrolledStartDate().isAfter(exam.getEnrolledEndDate())) {
            redirectAttributes.addFlashAttribute("errorMsg", "Enrollment start date must be before enrollment end date.");
            return "redirect:/admin/addExamPage";
        }

        if (exam.getExamStartDate().isAfter(exam.getExamEndDate())) {
            redirectAttributes.addFlashAttribute("errorMsg", "Exam start date must be before exam end date.");
            return "redirect:/admin/addExamPage";
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
        return "redirect:/admin/addExamPage";
    }


    @GetMapping("/viewExamDetails")
    public String viewExamDetails(@RequestParam Long id, @RequestParam(required = false) String source,
                                  @RequestParam(required = false) Long facultyId, Model model){

        Exam exam = examService.getExamById(id);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
        String formattedDate = exam.getDateCreated().format(formatter);

        model.addAttribute("exam", exam);
        model.addAttribute("formattedDate", formattedDate);
        model.addAttribute("source", source);
        model.addAttribute("facultyId", facultyId);
        return "admin/viewExamDetails";
    }

    //**************************** Exam Handlers Ends *************************//

}
