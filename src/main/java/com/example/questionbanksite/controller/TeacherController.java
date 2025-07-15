package com.example.questionbanksite.controller;

import com.example.questionbanksite.dto.ExamDto;
import com.example.questionbanksite.dto.SubjectDto;
import com.example.questionbanksite.entity.Exam;
import com.example.questionbanksite.entity.Question;
import com.example.questionbanksite.entity.Subject;
import com.example.questionbanksite.entity.Teacher;
import com.example.questionbanksite.service.ExamService;
import com.example.questionbanksite.service.QuestionService;
import com.example.questionbanksite.service.SubjectService;
import com.example.questionbanksite.service.TeacherService;
import lombok.RequiredArgsConstructor;
import net.bytebuddy.matcher.StringMatcher;
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
@RequestMapping("/teacher")
@RequiredArgsConstructor
public class TeacherController{

    private final TeacherService teacherService;

    private final SubjectService subjectService;

    private final QuestionService questionService;

    private final ExamService examService;

    @GetMapping("/teacherDashboard")
    public String showTeacherDashboard(){
        return "teacher/home";
    }

    //**************************** Subject Handlers  *************************//
    @GetMapping("/teacherSubject")
    public String showTeacherSubject(Model model, HttpSession session) {
        String teacherName = (String) session.getAttribute("username");

        if (teacherName == null) {
            model.addAttribute("errorMsg", "Session expired or invalid.");
            model.addAttribute("subjects", List.of());  // empty list so JSP handles it
            return "teacher/teacherSubject";
        }

        Teacher teacher = teacherService.getTeacherByName(teacherName);
        if (teacher == null) {
            model.addAttribute("errorMsg", "Teacher not found.");
            model.addAttribute("subjects", List.of());
            return "teacher/teacherSubject";
        }

        List<Subject> subjects = teacher.getSubjects();
        if (subjects == null || subjects.isEmpty()) {
            model.addAttribute("errorMsg", "No subjects assigned to this teacher.");
            model.addAttribute("subjects", List.of());
            return "teacher/teacherSubject";
        }

        List<SubjectDto> loadedSubjects = subjects.stream()
                .map(s -> subjectService.getSubjectWithTeachers(s.getId()))
                .toList();

        long totalAddedQuestions = teacherService.countQuestionAddedByTeacher(teacher.getId());

        model.addAttribute("subjects", loadedSubjects);
        model.addAttribute("totalQuestionss", totalAddedQuestions);
        return "teacher/teacherSubject";
    }

    //**************************** Subject Handlers Ends  *************************//



    //**************************** Question Handlers  *************************//

    @GetMapping("/viewQuestions")
    @Transactional(readOnly = true)
    public String viewSubjectQuestions(
            @RequestParam Long subjectId, @RequestParam(defaultValue = "1") int page, @RequestParam(required = false) String sortBy,
            @RequestParam(required = false) String complexity, Model model
    ){
        int pageSize = 10;

        List<Question> questions = questionService.getFilteredAndSortedQuestions(subjectId, complexity, sortBy, page, pageSize);

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

        return "teacher/viewQuestions";
    }

    @GetMapping("/addQuestionPage")
    public String addQuestionPage(@RequestParam("subjectId") Long subjectId, Model model){

        Subject subject = subjectService.getSubjectById(subjectId);

        model.addAttribute("subject", subject);
        model.addAttribute("subjectId", subjectId);
        model.addAttribute("question", new Question());
        return "teacher/addTeacherQuestion";
    }

    @PostMapping("/saveQuestion")
    public String saveQuestions(
            @RequestParam Long subjectId,
            @RequestParam("options") String[] optionsArrays,
            @ModelAttribute("question") Question question,
            RedirectAttributes redirectAttributes,
            HttpSession session){

        Set<String> optionSet = Arrays.stream(optionsArrays)
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

        String teacherName = (String) session.getAttribute("username");
        Teacher teacher = teacherService.getTeacherByName(teacherName);

        Subject subject = subjectService.getSubjectById(subjectId);
        question.setSubject(subject);

        question.setTeacher(teacher);

        questionService.saveQuestion(question);


        redirectAttributes.addFlashAttribute("successToast", "Question added successfully!");
        return "redirect:/teacher/teacherSubject";
    }

    @GetMapping("/editQuestion")
    public String editQuestionPage(@RequestParam("questionId") Long questionId, Model model){
        Question question = questionService.getQuestionById(questionId);

        Set<String> option = question.getOptions();
        while (option.size() < 4){
            option.add("");
        }

        question.setOptions(option);

        model.addAttribute("question", question);
        return "teacher/questionEditPage";
    }

    @PostMapping("/updateTeacherQuestion")
    public String updateTeacherQuestion(@ModelAttribute("question") Question question){
        Long id = question.getId();
        Long subjectId = question.getSubject().getId();

        questionService.updateQuestion(id, question);
        return "redirect:/teacher/viewQuestions?subjectId="+subjectId;
    }

    //**************************** Question Handlers Ends  *************************//


    //**************************** Exam Handlers  *************************//

    @GetMapping("/teacherExamList")
    public String teacherExamList(Model model, HttpSession session){
        String teacherName = (String) session.getAttribute("username");
        Teacher teacher = teacherService.getTeacherByName(teacherName);

        List<ExamDto> examDtoList = examService.getAllExamOfTeacher(teacher.getId());
        model.addAttribute("exams", examDtoList);
        return "teacher/manageExam";
    }

    @GetMapping("/addExamPage")
    public String addExamPage(Model model){

        model.addAttribute("subjectList", subjectService.getAllSubjects());
        model.addAttribute("exam", new ExamDto());
        return "teacher/addExamOfTeacher";
    }

    @PostMapping("/saveExam")
    public String saveExamOfTeacher(@ModelAttribute("exam") ExamDto exam,
                                    Model model,
                                    HttpSession session,
                                    RedirectAttributes redirectAttributes){
        String zoneIdStr = (String) session.getAttribute("zoneId");
        ZoneId zoneId = (zoneIdStr != null) ? ZoneId.of(zoneIdStr) : ZoneId.systemDefault();

        ZonedDateTime now = ZonedDateTime.now(zoneId);

        if(!exam.getEnrolledStartDate().atZone(zoneId).isAfter(now)){

            redirectAttributes.addFlashAttribute("errorMsg", "Enrollment start date must be future.");
            return "redirect:/teacher/addExamPage";
        } else if(!exam.getEnrolledEndDate().atZone(zoneId).isAfter(now)){

            redirectAttributes.addFlashAttribute("errorMsg", "Enrollment end date must be future.");
            return "redirect:/teacher/addExamPage";
        } else if(!exam.getExamStartDate().atZone(zoneId).isAfter(now)){

            redirectAttributes.addFlashAttribute("errorMsg", "Exam start date must be future.");
            return "redirect:/teacher/addExamPage";
        } else if(!exam.getExamEndDate().atZone(zoneId).isAfter(now)){

            redirectAttributes.addFlashAttribute("errorMsg", "Exam end date must be future.");
            return "redirect:/teacher/addExamPage";
        }

        if (exam.getEnrolledStartDate().isAfter(exam.getEnrolledEndDate())) {
            redirectAttributes.addFlashAttribute("errorMsg", "Enrollment start date must be before enrollment end date.");
            return "redirect:/teacher/addExamPage";
        }

        if (exam.getExamStartDate().isAfter(exam.getExamEndDate())) {
            redirectAttributes.addFlashAttribute("errorMsg", "Exam start date must be before exam end date.");
            return "redirect:/teacher/addExamPage";
        }

        String teacherName = (String) session.getAttribute("username");
        Teacher teacher = teacherService.getTeacherByName(teacherName);

        System.out.println("Teacher name:"+teacher.getUsername()+", Id :"+teacher.getId()+", Subject id:"+exam.getSubjectId());

        int i = examService.createExamForSubjectByTeacher(teacher.getId(),
                exam.getSubjectId(),
                exam.getDescription(),
                exam.getTotalMarks(),
                exam.getEnrolledStartDate(),
                exam.getEnrolledEndDate(),
                exam.getExamStartDate(),
                exam.getExamEndDate(),
                zoneId
        );

        if (i > 0) {
            redirectAttributes.addFlashAttribute("successMsg", "Exam added successfully...");
        } else {
            redirectAttributes.addFlashAttribute("errorMsg", "Something went wrong!!!");
        }
        return "redirect:/teacher/addExamPage";
    }


    @GetMapping("/viewExamDetails")
    public String viewTeacherExamDetails(@RequestParam("examId") Long id, Model model){
        Exam exam = examService.getExamById(id);

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
        String formattedDate = exam.getDateCreated().format(formatter);

        model.addAttribute("exam", exam);
        model.addAttribute("formattedDate", formattedDate);
        return "teacher/viewTeacherExamDetails";
    }

    //**************************** Exam Handlers Ends  *************************//

}
