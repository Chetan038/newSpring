Exception in thread "main" java.lang.Error: Unresolved compilation problem: 
	SpringApplication cannot be resolved

	at com.boostmytool.empstore.EmpstoreApplication.main(EmpstoreApplication.java:10)


// Add the necessary imports
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;

@Controller
@RequestMapping("/employees")
public class EmployeesController {

    @Autowired
    private EmployeeRepository repo;

    // Existing method for displaying the employee list
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

    // Method to display the Add Employee form
    @GetMapping("/create")
    public String showAddEmployeeForm(Model model) {
        model.addAttribute("employeeDto", new EmployeeDto());  // Send an empty DTO to the form
        return "employees/add";  // View for adding an employee
    }

    // Method to handle the form submission and save the employee
    @PostMapping("/create")
    public String addEmployee(@Validated @ModelAttribute EmployeeDto employeeDto, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            return "employees/add";  // Return to the form if validation fails
        }

        // Create Employee object and save it to the database
        Employee employee = new Employee();
        employee.setEMP_ID(employeeDto.getEMP_ID());
        employee.setE_NAME(employeeDto.getE_NAME());
        employee.setSALARY(employeeDto.getSALARY());
        employee.setDEPARTMENT(employeeDto.getDEPARTMENT());
        employee.setSTATUS(employeeDto.getSTATUS());
        employee.setPHONENO(employeeDto.getPHONENO());

        // Save to database
        repo.save(employee);

        // Redirect to employee list page
        return "redirect:/employees";
    }
}



@@@


<!DOCTYPE html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Employee</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <h2 class="text-center my-4">Add New Employee</h2>

        <form action="/employees/create" method="post" th:object="${employeeDto}">
            <div class="mb-3">
                <label for="EMP_ID" class="form-label">Employee ID</label>
                <input type="text" id="EMP_ID" class="form-control" th:field="*{EMP_ID}" required>
                <span th:if="${#fields.hasErrors('EMP_ID')}" th:errors="*{EMP_ID}" style="color: red;"></span>
            </div>

            <div class="mb-3">
                <label for="E_NAME" class="form-label">Name</label>
                <input type="text" id="E_NAME" class="form-control" th:field="*{E_NAME}" required>
                <span th:if="${#fields.hasErrors('E_NAME')}" th:errors="*{E_NAME}" style="color: red;"></span>
            </div>

            <div class="mb-3">
                <label for="SALARY" class="form-label">Salary</label>
                <input type="number" id="SALARY" class="form-control" th:field="*{SALARY}" required>
                <span th:if="${#fields.hasErrors('SALARY')}" th:errors="*{SALARY}" style="color: red;"></span>
            </div>

            <div class="mb-3">
                <label for="DEPARTMENT" class="form-label">Department</label>
                <input type="text" id="DEPARTMENT" class="form-control" th:field="*{DEPARTMENT}" required>
                <span th:if="${#fields.hasErrors('DEPARTMENT')}" th:errors="*{DEPARTMENT}" style="color: red;"></span>
            </div>

            <div class="mb-3">
                <label for="STATUS" class="form-label">Status</label>
                <input type="text" id="STATUS" class="form-control" th:field="*{STATUS}" required>
                <span th:if="${#fields.hasErrors('STATUS')}" th:errors="*{STATUS}" style="color: red;"></span>
            </div>

            <div class="mb-3">
                <label for="PHONENO" class="form-label">Phone Number</label>
                <input type="text" id="PHONENO" class="form-control" th:field="*{PHONENO}" required>
                <span th:if="${#fields.hasErrors('PHONENO')}" th:errors="*{PHONENO}" style="color: red;"></span>
            </div>

            <button type="submit" class="btn btn-primary">Save Employee</button>
        </form>
        <a href="/employees" class="btn btn-secondary mt-3">Back to Employee List</a>
    </div>

</body>
</html>


@@

