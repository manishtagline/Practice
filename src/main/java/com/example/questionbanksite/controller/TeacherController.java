package com.example.questionbanksite.controller;

import com.example.questionbanksite.dto.SubjectDto;
import com.example.questionbanksite.entity.Question;
import com.example.questionbanksite.entity.Subject;
import com.example.questionbanksite.entity.Teacher;
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
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;


@Controller
@RequestMapping("/teacher")
@RequiredArgsConstructor
public class TeacherController{

    private final TeacherService teacherService;

    private final SubjectService subjectService;

    private final QuestionService questionService;

    @GetMapping("/teacherExamList")
    public String teacherExamList(){
        return "teacher/manageExam";
    }

    @GetMapping("/teacherDashboard")
    public String showTeacherDashboard(){
        return "teacher/home";
    }

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

        model.addAttribute("subjects", loadedSubjects);
        return "teacher/teacherSubject";
    }

    @GetMapping("/viewQuestions")
    @Transactional(readOnly = true)
    public String viewSubjectQuestions(
        @RequestParam Long subjectId, @RequestParam(defaultValue = "1") int page, @RequestParam(required = false) String sortBy,
        @RequestParam(required = false) String complexity, Model model, HttpSession session
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
            RedirectAttributes redirectAttributes){

        List<String> options = Arrays.stream(optionsArrays)
                .filter(opt -> opt != null && !opt.trim().isEmpty())
                .collect(Collectors.toList());
        question.setOptions(options);

        String correctOptionLetter = question.getCorrectAnswer();
        String correctAnswer = "";

        correctAnswer = switch (correctOptionLetter){
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

        redirectAttributes.addFlashAttribute("successToast", "Question added successfully!");
        return "redirect:/teacher/teacherSubject";
    }

}
