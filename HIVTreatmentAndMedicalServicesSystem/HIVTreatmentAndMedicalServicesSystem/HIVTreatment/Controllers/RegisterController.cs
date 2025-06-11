using HIVTreatment.DTOs;
using HIVTreatment.Models;
using HIVTreatment.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace HIVTreatment.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RegisterController : ControllerBase
    {

        private readonly IUserService _userService;
        public RegisterController(IUserService userService)
        {
            _userService = userService;
        }
        [HttpPost("register")]
        public IActionResult Register([FromBody] RegisterDTO registerDTO)
        {
            // Convert DTO to User model
            var user = new User
            {
                RoleId = registerDTO.RoleId,
                Fullname = registerDTO.Fullname,
                Password = registerDTO.Password,
                Email = registerDTO.Email
                // UserId will be assigned in the service
            };

            var result = _userService.Register(user);
            if (result == null)
            {
                return BadRequest("Email đã tồn tại hoặc thông tin không hợp lệ");
            }

            return Ok(result);
        }

    }
}
