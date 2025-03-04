package com.boostmytool.empstore.controllers;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.boostmytool.empstore.models.Employee;
import com.boostmytool.empstore.services.EmployeeRepository;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/employees")
public class EmployeesController {
    
    @Autowired
    private EmployeeRepository repo;

    @ModelAttribute
    public void setResponseHeaders(HttpServletResponse response) {
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);
    }

    @GetMapping({"", "/"})
    public String showEmployeeList(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            return "redirect:/login";
        }

        List<Employee> employees = repo.findAll();
        model.addAttribute("employees", employees);
        return "employees/index";
    }

    @GetMapping("/create")
    public String showCreatePage(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            return "redirect:/login";
        }

        model.addAttribute("employee", new Employee());
        return "employees/create";
    }

    @PostMapping("/save")
    public String saveEmployee(@ModelAttribute Employee employee, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            return "redirect:/login";
        }

        repo.save(employee);
        return "redirect:/employees";
    }

    @GetMapping("/edit/{id}")
    public String editEmployee(@PathVariable("id") String id, Model model, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            return "redirect:/login";
        }

        Optional<Employee> employee = repo.findById(id);
        if (employee.isPresent()) {
            model.addAttribute("employee", employee.get());
            return "employees/edit";
        }

        return "redirect:/employees";
    }

    @PostMapping("/update/{id}")
    public String updateEmployee(@PathVariable("id") String id, @ModelAttribute Employee employee, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            return "redirect:/login";
        }

        repo.save(employee);
        return "redirect:/employees";
    }

    @GetMapping("/delete/{id}")
    public String deleteEmployee(@PathVariable("id") String id, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            return "redirect:/login";
        }

        repo.deleteById(id);
        return "redirect:/employees";
    }
}
