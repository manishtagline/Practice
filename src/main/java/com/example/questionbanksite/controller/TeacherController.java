package com.example.questionbanksite.controller;

import com.example.questionbanksite.dto.SubjectDto;
import com.example.questionbanksite.entity.Subject;
import com.example.questionbanksite.entity.Teacher;
import com.example.questionbanksite.service.SubjectService;
import com.example.questionbanksite.service.TeacherService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.List;


@Controller
@RequestMapping("/teacher")
@RequiredArgsConstructor
public class TeacherController{

    private final TeacherService teacherService;

    private final SubjectService subjectService;

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
            return "errorPage";
        }

        Teacher teacher = teacherService.getTeacherByName(teacherName);
        if (teacher == null) {
            model.addAttribute("errorMsg", "Teacher not found.");
            return "errorPage";
        }

        List<Subject> subjects = teacher.getSubjects();
        if (subjects == null || subjects.isEmpty()) {
            model.addAttribute("errorMsg", "No subjects assigned to this teacher.");
            return "errorPage";
        }

        // Now fetch subjects with their teachers fully initialized
        List<SubjectDto> loadedSubjects = subjects.stream()
                .map(s -> subjectService.getSubjectWithTeachers(s.getId()))
                .toList();

        model.addAttribute("subjects", loadedSubjects);
        return "teacher/teacherSubject";
    }

}
