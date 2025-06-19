package com.example.questionbanksite.controller;

import com.example.questionbanksite.entity.Exam;
import com.example.questionbanksite.entity.User;
import com.example.questionbanksite.entity.UserResult;
import com.example.questionbanksite.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private ExamService examService;

    @Autowired
    private CreateExamService createExamService;

    @Autowired
    private ExamSubmissionService examSubmissionService;

    @Autowired
    private UserResultService userResultService;

    @GetMapping("/")
    public String index(){
        return "loginPage";
    }


    //Handler for login and authenticate user
    @PostMapping("/login")
    public String authenticateUser(@RequestParam String username, @RequestParam String password, Model model, HttpSession session ) {
        User user = userService.getUserByName(username);

        session.setAttribute("username", username);

        if (user == null) {
            model.addAttribute("error", "Invalid username or password");
            return "loginPage";
        }

        if (!user.getPassword().equals(password)) {
            model.addAttribute("error", "Invalid username or password");
            return "loginPage";
        }

        return "redirect:/home";
    }


    //Handler for hom page
    @GetMapping("/home")
    public String homePage(HttpSession session, Model model){

        String username = (String) session.getAttribute("username");
        model.addAttribute("username", username);

        if(username == null){
            model.addAttribute("error","Please, Login first!!!");
            return "loginPage";
        }

        return "home";
    }


    //Handler for opening exam available for user
    @GetMapping("/exam")
    public String examPage(HttpSession session, Model model){

        String username = (String) session.getAttribute("username");
        model.addAttribute("username", username);

        if(username == null){
            model.addAttribute("error","Please, Login first!!!");
            return "loginPage";
        }

        List<Exam> examDescriptions = examService.getAllExam();
        model.addAttribute("examList", examDescriptions);


        return "exam";
    }


    //Handler for opening particular question paper
    @GetMapping("/questionPaper")
    public String questionPaper(@RequestParam("examId") Long examId, Model model){
        Exam exam = examService.getExamById(examId);

        model.addAttribute("exam", exam);
        model.addAttribute("questions", exam.getQuestions());

        return "questionpaper";
    }


    //Handler for submit the question paper
    @PostMapping("/submitExam")
    public String submitExam(@RequestParam Long examId,
                             @RequestParam Map<String, String> paramMap,
                             HttpSession session,
                             Model model) {

        String username = (String) session.getAttribute("username");
        if (username == null) {
            return "redirect:/login";
        }

        User user = userService.getUserByName(username);
        paramMap.remove("examId");

        UserResult result = examSubmissionService.evaluateAndSaveResult(user, examId, paramMap);

        session.setAttribute("result", result);

        return "submissionMessage";
    }


    @GetMapping("/submissionMessage")
    public String submission(){
        return "submissionMessage";
    }


    //Handler for Checking exam history / Result
    @GetMapping("/result")
    public String showResult(HttpSession session, Model model){
        String username = (String) session.getAttribute("username");
        model.addAttribute("username", username);

        if(username == null){
            model.addAttribute("error","Please, Login first!!!");
            return "loginPage";
        }

        User user = userService.getUserByName(username);
        long userId = user.getId();

        List<UserResult> resultList =  userResultService.getResultsByUserId(userId);
        model.addAttribute("resultList", resultList);

        return "result";
    }


    @GetMapping("/logout")
    public String logout(HttpSession session){
        session.invalidate();
        return "redirect:/";
    }

}
