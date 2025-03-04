Hibernate: select u1_0.email,u1_0.name,u1_0.password,u1_0.phoneno from newso.userr u1_0 where u1_0.email=?
Hibernate: select e1_0.emp_id,e1_0.department,e1_0.e_name,e1_0.phoneno,e1_0.salary,e1_0.status from newso.employee e1_0

its not delteing record its showing above error

in browser it showing this 
This application has no explicit mapping for /error, so you are seeing this as a fallback.

Tue Mar 04 19:29:49 IST 2025
There was an unexpected error (type=Not Found, status=404).
No static resource employees/delete.
fix the error



  @GetMapping("/delete")
    public String deleteEmployee(@RequestParam("EMP_ID") String empId, Model model) {
        // Fetch employee by EMP_ID
        if (repo.existsById(empId)) {
            // If employee exists, delete it
            repo.deleteById(empId);
        } else {
            model.addAttribute("error", "Employee not found!");
        }
        
        // Redirect to the employee list after deletion
        return "redirect:/employees";
    }


@@

<td>
    <a class="btn btn-primary btn-sm" th:href="@{/employees/edit(EMP_ID=${employee.EMP_ID})}">Edit</a>
    <a class="btn btn-danger btn-sm" th:href="@{/employees/delete(EMP_ID=${employee.EMP_ID})}" 
       onclick="return confirm('Are you sure you want to delete this employee?')">Delete</a>
</td>
