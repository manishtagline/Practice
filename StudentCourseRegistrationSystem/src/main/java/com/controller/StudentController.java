package com.controller;

import com.dao.StudentDao;
import com.model.Course;
import com.model.Student;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import java.beans.PropertyEditorSupport;
import java.util.List;

@Controller
public class StudentController {

    @Autowired
    private StudentDao dao;

    @GetMapping("/studentForm")
    public String studentForm(Model model){
        model.addAttribute("student",new Student());
        model.addAttribute("courseList",dao.getAllCourse());

        return "studentform";
    }

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(Course.class, new PropertyEditorSupport() {
            @Override
            public void setAsText(String text) {
                int courseId = Integer.parseInt(text);
                Course course = dao.courseById(courseId); // Make sure dao method exists
                setValue(course);
            }
        });
    }

    @PostMapping("/addStudent")
    public String addStudent(@ModelAttribute("student")Student student){
        dao.addStudent(student);
        return "redirect:/studentform";
    }


    @GetMapping("/studentList")
    public String enrollStudent(Model model){
        model.addAttribute("courses", dao.getAllCourse());
        model.addAttribute("students", dao.getAllStudent());
        return "enroll";
    }

    @GetMapping("/deleteStudent")
    public String deleteStudent(@RequestParam("id")int id){
        dao.deleteStudent(id);
        return "redirect:/studentList";
    }


}
