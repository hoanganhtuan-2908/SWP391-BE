using HIVTreatment.Models;

namespace HIVTreatment.Repositories
{
    public interface IUserRepository
    {
        User GetByEmail(string email);
        User GetLastUser();
        void Add(User user);
        bool EmailExists(string email);
        void Update(User user);
    }
}
