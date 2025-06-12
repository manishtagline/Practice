package com.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.dao.PersonDao;
import com.model.Person;

@Controller
public class HomeController {

	@Autowired
	PersonDao dao;	
	
	@GetMapping("/")
	public String index(Model model) {
		System.out.println("From controller");
		model.addAttribute("person", new Person());

		model.addAttribute("persons", dao.viewAllPerson());
		return "index";
	}
	
}
