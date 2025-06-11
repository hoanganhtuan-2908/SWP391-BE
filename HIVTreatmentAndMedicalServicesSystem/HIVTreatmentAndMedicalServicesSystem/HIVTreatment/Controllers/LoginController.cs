using Azure.Core;
using HIVTreatment.DTOs;
using HIVTreatment.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;

namespace HIVTreatment.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class LoginController : ControllerBase
    {
        private readonly IUserService _userService;

        public LoginController(IUserService userService)
        {
            _userService = userService;
        }

        [HttpPost("login")]
        public IActionResult Login([FromBody] LoginDTO loginDTO)
        {
            try
            {
                if (loginDTO == null || string.IsNullOrEmpty(loginDTO.Email) || string.IsNullOrEmpty(loginDTO.Password))
                {
                    return BadRequest("Email và mật khẩu không được để trống");
                }

                var user = _userService.Login(loginDTO.Email, loginDTO.Password);
                if (user == null)
                {
                    return Unauthorized("Sai email hoặc mật khẩu");
                }

                return Ok(user);
            }
            catch (Exception ex)
            {
                // Log the exception here
                return StatusCode(500, "Đã xảy ra lỗi trong quá trình đăng nhập. Vui lòng thử lại sau.");
            }
        }
    }
}
