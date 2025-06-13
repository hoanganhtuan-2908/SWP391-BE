using HIVTreatment.Models;
using HIVTreatment.DTOs;

namespace HIVTreatment.Services
{
    public interface IUserService
    {
        User Login(String email, String password);
        User Register(User user);
        void UpdateProfile(EditProfileUserDTO dto);
    }
}
