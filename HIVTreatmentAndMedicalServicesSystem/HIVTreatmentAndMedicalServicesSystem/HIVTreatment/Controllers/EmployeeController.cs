//using HIVTreatment.Data;
//using HIVTreatment.Models;
//using HIVTreatment.Models.Entities;
//using Microsoft.AspNetCore.Components;
//using Microsoft.AspNetCore.Http;
//using Microsoft.AspNetCore.Mvc;

//namespace HIVTreatment.Controllers
//{
//    //localhost:xxxx/api/employees
//    [Microsoft.AspNetCore.Mvc.Route("api/[controller]")]
//    [ApiController]
//    public class EmployeeController : ControllerBase
//    {
//        private readonly ApplicationDbContext dbContext;
//        public EmployeeController(ApplicationDbContext dbContext)
//        {
//            this.dbContext = dbContext;
//        }
//        [HttpGet]
//        public IActionResult GetAllEmployees()
//        {
//            var allEmployees = dbContext.Employees.ToList();
//            return Ok(allEmployees);
//        }

//        [HttpGet]
//        [Microsoft.AspNetCore.Mvc.Route("{id:guid}")]
//        public IActionResult GetEmployeeById(Guid id)
//        {
//            var employee = dbContext.Employees.Find(id);
//            if (employee is null)
//            {
//                return NotFound();
//            }
//            return Ok(employee);
//        }


//        [HttpPost]
//        public IActionResult addEmployee(AddEmployeeDto addEmployeeDto)
//        {
//            var employeeEntity = new Employee()
//            {
//                Name = addEmployeeDto.Name,
//                Email = addEmployeeDto.Email,
//                Phone = addEmployeeDto.Phone,
//                Salary = addEmployeeDto.Salary
//            };

//            dbContext.Employees.Add(employeeEntity);
//            dbContext.SaveChanges();
//            return Ok(employeeEntity);
//        }

//        [HttpPut]
//        [Microsoft.AspNetCore.Mvc.Route("{id:guid}")]
//        public IActionResult UpdateEmployeee(Guid id, UpdateEmployeeDto updateEmployeeDto)
//        {
//            var employee = dbContext.Employees.Find(id);
//            if(employee is null)
//            {
//                return NotFound();
//            }
//            employee.Name = updateEmployeeDto.Name;
//            employee.Email = updateEmployeeDto.Email;
//            employee.Phone = updateEmployeeDto.Phone;
//            employee.Salary = updateEmployeeDto.Salary;
//            dbContext.SaveChanges();
//            return Ok(employee);
//        }

//        [HttpDelete]
//        [Microsoft.AspNetCore.Mvc.Route("{id:guid}")]
//        public IActionResult DeleteEmployee(Guid id) {
//            var employee = dbContext.Employees.Find(id);
//            if (employee is null)
//            {
//                return NotFound();
//            }
//            dbContext.Employees.Remove(employee);
//            dbContext.SaveChanges();
//            return Ok(employee);
//        }

//    }
//}
