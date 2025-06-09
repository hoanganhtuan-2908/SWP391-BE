using HIVTreatment.Models;

namespace HIVTreatment.Repositories
{
    public interface IUserRepository
    {
        User GetByEmail(string email);
    }
}
