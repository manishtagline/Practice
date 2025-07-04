    package com.example.questionbanksite.controller;

    import com.example.questionbanksite.dto.BaseUserRegisterDto;
    import com.example.questionbanksite.entity.Teacher;
    import com.example.questionbanksite.entity.User;
    import com.example.questionbanksite.service.TeacherService;
    import com.example.questionbanksite.service.UserService;
    import lombok.RequiredArgsConstructor;
    import org.springframework.stereotype.Controller;
    import org.springframework.ui.Model;
    import org.springframework.validation.BindingResult;
    import org.springframework.web.bind.annotation.GetMapping;
    import org.springframework.web.bind.annotation.ModelAttribute;
    import org.springframework.web.bind.annotation.PostMapping;
    import org.springframework.web.bind.annotation.RequestParam;
    import org.springframework.web.servlet.mvc.support.RedirectAttributes;

    import javax.servlet.http.HttpSession;
    import javax.validation.Valid;

    @Controller
    @RequiredArgsConstructor
    public class HomeController {

        private final UserService userService;

        private final TeacherService teacherService;

        @GetMapping("/")
        public String index() {
            return "loginPage";
        }

        @PostMapping("/login")
        public String authenticateUser(@RequestParam String username,
                                       @RequestParam String password,
                                       @RequestParam String zoneId,
                                       Model model,
                                       HttpSession session) {

            session.setAttribute("zoneId", zoneId);

            String interceptorError = (String) session.getAttribute("error");
            if(interceptorError != null){
                model.addAttribute("error", interceptorError);
                session.removeAttribute("error");
            }

            User user = userService.getUserByName(username);
            Teacher teacher = teacherService.getTeacherByName(username);

            if(user == null && teacher == null){
                model.addAttribute("error", "Invalid credentials!!!");
                return "loginPage";
            }

            if(user != null){
                if(!user.getPassword().equals(password)){
                    model.addAttribute("error", "Invalid Password!!!");
                    return "loginPage";
                }

                session.setAttribute("username", user.getUsername());
                session.setAttribute("role", user.getRole());

                if("ADIMN".equalsIgnoreCase(user.getRole())){
                    return "admin/adminPage";
                }else if("USER".equalsIgnoreCase(user.getRole())){
                    return "user/home";
                }
            }

            if(teacher != null){
                if(!teacher.getPassword().equals(password)){
                    model.addAttribute("error", "Invalid Password!!!");
                    return "loginPage";
                }

                session.setAttribute("teacher", teacher.getUsername());
                session.setAttribute("role", teacher.getRole());

                return "teacher/home";
            }

            model.addAttribute("error", "Something went wrong!!!");
            return "loginPage";

//            User user = userService.getUserByName(username);
//
//            Teacher teacher = teacherService.getTeacherByName(username);
//
//            String interceptorError = (String) session.getAttribute("error");
//
//            session.setAttribute("zoneId", zoneId);
//
//            if (user == null || teacher == null) {
//                if (interceptorError != null && !interceptorError.isEmpty()) {
//                    model.addAttribute("error", interceptorError);
//                    session.removeAttribute("error");
//                } else {
//                    model.addAttribute("error", "Invalid  credentials!!!!");
//                }
//                return "loginPage";
//            } else if (!user.getPassword().equals(password) || !teacher.getPassword().equals(password)) {
//                model.addAttribute("error", "Invalid  password!!!!");
//                return "loginPage";
//            }
//
//            session.removeAttribute("error");
//
//            session.setAttribute("username", user.getUsername());
//            session.setAttribute("role", user.getRole());
//            session.setAttribute("teacher", teacher.getUsername());
//
//
//            if ("ADMIN".equalsIgnoreCase(user.getRole())) {
//                return "admin/adminPage";
//            } else if("USER".equalsIgnoreCase(user.getRole())) {
//                return "user/home";
//            } else{
//                return "teacher/home";
//            }
        }

        @GetMapping("/logout")
        public String logout(HttpSession session) {
            session.invalidate();
            return "redirect:/";
        }

        @GetMapping("/baseUserRegistration")
        public String userRegister(@RequestParam("role") String role, Model model) {
            BaseUserRegisterDto userDto = new BaseUserRegisterDto();
            userDto.setRole(role);
            model.addAttribute("user", userDto);
            model.addAttribute("role", role);
            return "registration/baseUserRegisterPage";
        }


        @PostMapping("/baseUserRegister")
        public String registerUser(
                @Valid @ModelAttribute("user") BaseUserRegisterDto userDto,
                BindingResult bindingResult,
                Model model,
                RedirectAttributes redirectAttributes) {

            if (bindingResult.hasErrors()) {
                return "registration/baseUserRegisterPage";
            }

            if(!userDto.getConfirmPassword().equals(userDto.getPassword())){
                bindingResult.rejectValue("confirmPassword", "ConfirmPassword.Error","Passwords do not match");
                model.addAttribute("role", userDto.getRole());
                return "registration/baseUserRegisterPage";
            }

            if ("Teacher".equalsIgnoreCase(userDto.getRole())) {
                int i = teacherService.saveTeacher(userDto);
                if(i > 0){
                    redirectAttributes.addFlashAttribute("successMsg","Teacher Register Successfully...");
                    return "redirect:/baseUserRegistration?role="+ userDto.getRole();
                }

            } else if("User".equalsIgnoreCase(userDto.getRole())) {
                int i = userService.saveUser(userDto);
                if(i > 0){
                    redirectAttributes.addFlashAttribute("successMsg","User Register Successfully...");
                    return "redirect:/baseUserRegistration?role="+ userDto.getRole();
                }
            }

            return "redirect:/login";
        }

    }
