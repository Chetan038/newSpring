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
