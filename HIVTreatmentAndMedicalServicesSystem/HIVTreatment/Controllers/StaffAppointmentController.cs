using HIVTreatment.Models;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;
using System;
using HIVTreatment.Data;

[ApiController]
[Route("api/staff/appointments")]
public class StaffAppointmentController : ControllerBase
{
    private readonly ApplicationDbContext _context;

    public StaffAppointmentController(ApplicationDbContext context)
    {
        _context = context;
    }

    private User GetCurrentUser()
    {
        // Ví dụ lấy UserID từ JWT hoặc session
        var userId = HttpContext.User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        return _context.Users.FirstOrDefault(u => u.UserId == userId);
    }

    private bool IsStaff(User user) => user.RoleId == "R004";

    [HttpGet("pending")]
    public IActionResult GetPendingAppointments()
    {
        var user = GetCurrentUser();
        if (user == null || !IsStaff(user))
            return Forbid();

        var pendingAppointments = _context.BooksAppointments
            .Where(a => a.Status == "Pending")
            .ToList();

        return Ok(pendingAppointments);
    }

    [HttpPut("approve/{id}")]
    public IActionResult ApproveAppointment(int id)
    {
        var user = GetCurrentUser();
        if (user == null || !IsStaff(user))
            return Forbid();

        var appointment = _context.BooksAppointments.Find(id);
        if (appointment == null)
            return NotFound();

        appointment.Status = "Approved";
        _context.SaveChanges();

        return Ok("Appointment approved");
    }

    [HttpPut("reject/{id}")]
    public IActionResult RejectAppointment(int id)
    {
        var user = GetCurrentUser();
        if (user == null || !IsStaff(user))
            return Forbid();

        var appointment = _context.BooksAppointments.Find(id);
        if (appointment == null)
            return NotFound();

        appointment.Status = "Rejected";
        _context.SaveChanges();

        return Ok("Appointment rejected");
    }
}
