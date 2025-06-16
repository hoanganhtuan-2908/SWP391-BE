using HIVTreatment.Models;

namespace HIVTreatment.Repositories
{
    public interface IUserRepository
    {
        User GetByEmail(string email);
        User GetLastUser();
        void Add(User user);
        bool EmailExists(string email);
<<<<<<< HEAD
        User GetByUserId(string UserId);
=======
        User GetUserById(string userId);
>>>>>>> lequocviet
        void Update(User user);

    }
}
