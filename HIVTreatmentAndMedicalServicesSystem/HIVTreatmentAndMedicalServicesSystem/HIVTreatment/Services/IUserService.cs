using HIVTreatment.Models;

namespace HIVTreatment.Services
{
    public interface IUserService
    {
        User Login(String email, String password);
    }
}
