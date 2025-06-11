using HIVTreatment.DTOs;
using HIVTreatment.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace HIVTreatment.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class EditProfileUserController : ControllerBase
    {
        private readonly IProfileService iProfileService;
        public EditProfileUserController(IProfileService profileService)
        {
            iProfileService = profileService;
        }
        [HttpPut("edit-profile")]
        public IActionResult EditProfile([FromBody] EditProfileUserDTO editProfileUserDTO)
        {
            if (editProfileUserDTO == null)
            {
                return BadRequest("Dữ liệu không hợp lệ");
            }
            var result = iProfileService.UpdateProfile(editProfileUserDTO);
            if (result)
            {
                return Ok("Cập nhật hồ sơ thành công");
            }
            else
            {
                return NotFound("Không tìm thấy người dùng để cập nhật");
            }
        }
    }
}
