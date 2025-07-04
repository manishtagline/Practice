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

            if(user != null && user.getPassword().equals(password)){
                session.setAttribute("username", user.getUsername());
                session.setAttribute("role", user.getRole());

                if("ADMIN".equalsIgnoreCase(user.getRole())){
                    return "admin/adminPage";
                }else if("USER".equalsIgnoreCase(user.getRole())){
                    return "user/home";
                }
            }

            if(teacher != null && teacher.getPassword().equals(password)){
                session.setAttribute("teacher", teacher.getUsername());
                session.setAttribute("role", teacher.getRole());

                return "teacher/home";
            }

            model.addAttribute("error", "Invalid password!!!");
            return "loginPage";

            /*User user = userService.getUserByName(username);

            Teacher teacher = teacherService.getTeacherByName(username);

            String interceptorError = (String) session.getAttribute("error");

            session.setAttribute("zoneId", zoneId);

            if (user == null || teacher == null) {
                if (interceptorError != null && !interceptorError.isEmpty()) {
                    model.addAttribute("error", interceptorError);
                    session.removeAttribute("error");
                } else {
                    model.addAttribute("error", "Invalid  credentials!!!!");
                }
                return "loginPage";
            } else if (!user.getPassword().equals(password) || !teacher.getPassword().equals(password)) {
                model.addAttribute("error", "Invalid  password!!!!");
                return "loginPage";
            }

            session.removeAttribute("error");

            session.setAttribute("username", user.getUsername());
            session.setAttribute("role", user.getRole());
            session.setAttribute("teacher", teacher.getUsername());


            if ("ADMIN".equalsIgnoreCase(user.getRole())) {
                return "admin/adminPage";
            } else if("USER".equalsIgnoreCase(user.getRole())) {
                return "user/home";
            } else{
                return "teacher/home";
            }*/
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

            model.addAttribute("role", userDto.getRole());

            if (bindingResult.hasErrors()) {
                return "registration/baseUserRegisterPage";
            }

            if (!userDto.getConfirmPassword().equals(userDto.getPassword())) {
                bindingResult.rejectValue("confirmPassword", "ConfirmPassword.Error", "Passwords do not match");
                return "registration/baseUserRegisterPage";
            }

            if ("Teacher".equalsIgnoreCase(userDto.getRole())) {
                Teacher teacherByName = teacherService.getTeacherByName(userDto.getUsername());
                Teacher teacherByEmail = teacherService.getTeacherByEmail(userDto.getEmail());

                if (teacherByName != null) {
                    bindingResult.rejectValue("username", "Username.Invalid", "Username already exists!!!");
                    return "registration/baseUserRegisterPage";
                }

                if (teacherByEmail != null) {
                    bindingResult.rejectValue("email", "Email.Invalid", "Email already exists!!!");
                    return "registration/baseUserRegisterPage";
                }

                int result = teacherService.saveTeacher(userDto);
                if (result > 0) {
                    redirectAttributes.addFlashAttribute("successMsg", "Teacher registered successfully.");
                    return "redirect:/baseUserRegistration?role=" + userDto.getRole();
                } else {
                    model.addAttribute("errorMsg", "Registration failed. Please try again.");
                    return "registration/baseUserRegisterPage";
                }

            } else if ("User".equalsIgnoreCase(userDto.getRole())) {
                User userByName = userService.getUserByName(userDto.getUsername());
                User userByEmail = userService.getUserByEmail(userDto.getEmail());

                if(userByName != null){
                    bindingResult.rejectValue("username", "Username.Invalid", "Username already exists!!!");
                    return "registration/baseUserRegisterPage";
                }

                if(userByEmail != null){
                    bindingResult.rejectValue("email", "Email.Invalid", "Email already exists!!!");
                    return "registration/baseUserRegisterPage";
                }

                int result = userService.saveUser(userDto);
                if (result > 0) {
                    redirectAttributes.addFlashAttribute("successMsg", "User registered successfully.");
                    return "redirect:/baseUserRegistration?role=" + userDto.getRole();
                } else {
                    model.addAttribute("errorMsg", "Registration failed. Please try again.");
                    return "registration/baseUserRegisterPage";
                }
            }

            return "redirect:/login";
        }

    }
