package com.controller;

import com.dao.EmpDao;
import com.model.Employee;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class HomeController {

    @Autowired
    private EmpDao dao;

    @GetMapping("/empform")
    public String showForm(Model model) {
        model.addAttribute("employee", new Employee());
        return "empform";
    }

    @PostMapping("/save")
    public String saveEmployee(@ModelAttribute("employee")Employee e){
        dao.saveEmployee(e);
        return "redirect:/viewemp";
    }

    @RequestMapping("/viewemp")
    public String viewEmployee(Model model){
        List<Employee> list = dao.getAllEmployee();
        model.addAttribute("listOfEmployee", list);
        return "viewemp";
    }

    @GetMapping("/delete/{id}")
    public String deleteEmployee(@PathVariable("id")int id){
        dao.deleteEmployee(id);
        return "redirect:/viewemp";
    }

    @GetMapping("/edit/{id}")
    public String editEmployee(@PathVariable("id")int id, Model model){
        Employee emp = dao.getEmployeeById(id);
        model.addAttribute("employee",emp);
        return "editform";
    }

    @PostMapping("/editsave")
    public String updateEmployee(@ModelAttribute("employee")Employee employee){
        dao.updateEmployee(employee);
        return "redirect:/viewemp";
    }

}
