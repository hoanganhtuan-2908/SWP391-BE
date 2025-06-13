﻿using HIVTreatment.Data;
using HIVTreatment.Models;
using HIVTreatment.Models.Entities;
using HIVTreatment.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace HIVTreatment.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AppointmentController : ControllerBase
    {
        private readonly IAppointmentRepository _repository;
        private readonly ApplicationDbContext _context;

        public AppointmentController(ApplicationDbContext context, IAppointmentRepository repository)
        {
            _context = context;
            _repository = repository;
        }

        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            var list = await _repository.GetAllAsync();
            return Ok(list);
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetById(string id)
        {
            var item = await _repository.GetByIdAsync(id);
            if (item == null) return NotFound();
            return Ok(item);
        }

        [HttpPost]
        public async Task<IActionResult> Create([FromBody] BookAppointmentDTO dto)
        {
            // lay id khi benh nhan dang nhap
            var patientId = "PT000003";

            if (string.IsNullOrEmpty(patientId))
                return Unauthorized("Patient not logged in");

            var book = new BooksAppointment
            {
                BookID = "BK" + Guid.NewGuid().ToString("N").Substring(0, 6).ToUpper(),
                PatientID = patientId,  // ? phai gan dung o day
                DoctorID = dto.DoctorID,
                ServiceID = dto.ServiceID,
                BookDate = dto.BookDate,
                Status = "Đang chờ",
                Note = dto.Note,
                
            };

            _context.BooksAppointments.Add(book);
            await _context.SaveChangesAsync();

            return Ok(new { message = "Appointment created successfully", book.BookID });
        }
    }
}


