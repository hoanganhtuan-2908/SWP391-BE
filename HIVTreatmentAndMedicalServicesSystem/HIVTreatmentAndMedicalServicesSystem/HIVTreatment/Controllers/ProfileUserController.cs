using HIVTreatment.DTOs;
using HIVTreatment.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace HIVTreatment.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProfileUserController : ControllerBase
    {
        private readonly IProfileService iprofileService;
        public ProfileUserController(IProfileService iProfileService)
        {
            iprofileService = iProfileService;
        }

        [HttpPut("Update")]
        public IActionResult Update([FromBody] EditProfileUserDTO editProfileUserDTO)
        {

            var success = iprofileService.UpdateProfile(editProfileUserDTO);
            if (!success) return NotFound("User not found.");
            return Ok("Profile updated successfully.");
        }

    }
}
