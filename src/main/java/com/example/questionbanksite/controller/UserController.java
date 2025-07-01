package com.example.questionbanksite.controller;

import com.example.questionbanksite.entity.Exam;
import com.example.questionbanksite.entity.Question;
import com.example.questionbanksite.entity.User;
import com.example.questionbanksite.entity.UserResult;
import com.example.questionbanksite.service.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;

    private final ExamService examService;

    private final UserResultService userResultService;


    @GetMapping("/")
    public String index() {
        return "loginPage";
    }

    //<-------------- Authentication Method -------------->//
    private boolean Auth(Model model, HttpSession session) {
        String username = (String) session.getAttribute("username");
        model.addAttribute("username", username);
        String role = (String) session.getAttribute("role");
        if (username == null || role.equalsIgnoreCase("Admin")) {
            model.addAttribute("error", "Please, Login first!!!");
            return true;
        }
        return false;
    }


    //Handler for login and authenticate user
    @PostMapping("/login")
    public String authenticateUser(@RequestParam String username, @RequestParam String password, Model model, HttpSession session) {

        User user = userService.getUserByName(username);

        if (user == null || !user.getPassword().equals(password)) {
            model.addAttribute("error", "Invalid username or password");
            return "loginPage";
        }

        session.setAttribute("username", user.getUsername());
        session.setAttribute("role", user.getRole());

        // Set session attributes based on role
        if ("ADMIN".equalsIgnoreCase(user.getRole())) {
            return "admin/adminPage";
        } else {
            return "user/home";
        }
    }


    //Handler for hom page
    @GetMapping("/home")
    public String homePage(HttpSession session, Model model) {
        if (Auth(model, session)) return "loginPage";

        return "user/home";
    }


    //Handler for opening exam available for user
    @GetMapping("/exam")
    public String examPage(HttpSession session, Model model) {
        if (Auth(model, session)) return "loginPage";

        List<Exam> examDescriptions = examService.getAllExam();
        model.addAttribute("examList", examDescriptions);

        return "user/exam";
    }


    //Handler for opening particular question paper
    @GetMapping("/questionPaper")
    public String questionPaper(@RequestParam("examId") Long examId, Model model, HttpSession session) {
        if (Auth(model, session)) return "loginPage";

        Exam exam = examService.getExamById(examId);

        model.addAttribute("exam", exam);
        model.addAttribute("questions", exam.getQuestions());

        return "user/questionpaper";
    }




    //Handler for submit the question paper
    @PostMapping("/submitExam")
    public String submitExam(@RequestParam Long examId,
                             @RequestParam Map<String, String> paramMap,
                             HttpSession session,
                             Model model) {

        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");
        if (username == null || role.equalsIgnoreCase("Admin")) {
            model.addAttribute("error", "Please, Login first!!!");
            return "loginPage";
        }

        paramMap.remove("examId");

        UserResult result = examService.evaluateAndSaveResult(username, examId, paramMap);

        session.setAttribute("result", result);

        return "user/submissionMessage";
    }


    @GetMapping("/submissionMessage")
    public String submission(Model model, HttpSession session) {
        if (Auth(model, session)) return "loginPage";

        return "user/submissionMessage";
    }


    //Handler for Checking exam history / Result
    @GetMapping("/result")
    public String showResult(HttpSession session, Model model) {
        String username = (String) session.getAttribute("username");
        if (Auth(model, session)) return "loginPage";

        User user = userService.getUserByName(username);
        long userId = user.getId();

        List<UserResult> resultList = userResultService.getResultsByUserId(userId);
        model.addAttribute("resultList", resultList);

        return "user/result";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }


    //Handler for checking
    @GetMapping("/examResultDetails")
    public String examResultDetails(@RequestParam("resultId") Long resultId, Model model, HttpSession session) {
        UserResult userResult = userResultService.getResultDetailsById(resultId);

        if (Auth(model, session)) return "loginPage";

        if (userResult == null) {
            model.addAttribute("errorMessage", "Result not found");
            return "user/errorPage";
        }

        Exam exam = userResult.getExam();
        List<Question> questions = exam.getQuestions();

        Map<String, String> userAnswers = new HashMap<>();

        try {
            String answerRaw = userResult.getAnswer();

            if (answerRaw != null && !answerRaw.trim().isEmpty()) {
                String[] entries = answerRaw.split("\\|");

                for (String entry : entries) {
                    String[] parts = entry.split(":", 2);
                    if (parts.length == 2) {
                        String key = parts[0].trim();
                        String value = parts[1].trim();
                        userAnswers.put(key, value);
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("errorMessage", "Failed to parse stored answers.");
            return "user/errorPage";
        }

        Map<String, String> correctAnswers = new HashMap<>();
        for (Question q : questions) {
            correctAnswers.put("Q" + q.getId(), q.getCorrectAnswer());
        }

        model.addAttribute("exam", exam);
        model.addAttribute("questions", questions);
        model.addAttribute("userAnswers", userAnswers);
        model.addAttribute("correctAnswers", correctAnswers);

        return "user/resultDetails";
    }

    @GetMapping("/errorPage")
    public String errorPage() {
        return "user/errorPage";
    }

}
