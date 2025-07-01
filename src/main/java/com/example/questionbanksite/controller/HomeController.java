package com.example.questionbanksite.controller;

import com.example.questionbanksite.entity.User;
import com.example.questionbanksite.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

@Controller
@RequiredArgsConstructor
public class HomeController {

    private final UserService userService;

    @GetMapping("/")
    public String index() {
        return "loginPage";
    }

    @PostMapping("/login")
    public String authenticateUser(@RequestParam String username,
                                   @RequestParam String password,
                                   Model model,
                                   HttpSession session) {

        User user = userService.getUserByName(username);

        String interceptorError = (String) session.getAttribute("error");

        if (user == null) {
            if (interceptorError != null && !interceptorError.isEmpty()) {
                model.addAttribute("error", interceptorError);
                session.removeAttribute("error");
            } else {
                model.addAttribute("error", "Invalid credentials!!!!");
            }
            return "loginPage";
        } else if (!user.getPassword().equals(password)) {
            model.addAttribute("error", "Invalid credentials!!!!");
            return "loginPage";
        }

        session.removeAttribute("error");

        session.setAttribute("username", user.getUsername());
        session.setAttribute("role", user.getRole());

        if ("ADMIN".equalsIgnoreCase(user.getRole())) {
            return "admin/adminPage";
        } else {
            return "user/home";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }



}
