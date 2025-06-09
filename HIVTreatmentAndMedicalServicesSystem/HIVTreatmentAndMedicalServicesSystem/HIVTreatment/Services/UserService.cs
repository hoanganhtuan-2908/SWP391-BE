using HIVTreatment.Models;
using HIVTreatment.Repositories;

namespace HIVTreatment.Services
{
    public class UserService : IUserService
    {
        private readonly IUserRepository iuserRepository;
        public UserService(IUserRepository userRepository)
        {
            iuserRepository = userRepository;
        }
        //public UserService Login(string email, string password)
        //{
        //    var user = iuserRepository.GetByEmail(email);
        //    if (user == null || user.Password != password)
        //    {
        //        return null;
        //    }
        //    return user;
        //}

        User IUserService.Login(string email, string password)
        {
            var user = iuserRepository.GetByEmail(email);
            if (user == null || user.Password != password)
            {
                return null;
            }
            return user;
        }
    }
}
