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
        

        User IUserService.Login(string email, string password)
        {
            var user = iuserRepository.GetByEmail(email);
            if (user == null || user.Password != password)
            {
                return null;
            }
            return user;
        }

        public User Register(User user)
        {
            if(iuserRepository.EmailExists(user.Email))
            {
                return null; // Email already exists
            }
            var lastUser = iuserRepository.GetLastUser(); // Trả về user có UserId lớn nhất
            int nextId = 1;

            if (lastUser != null && lastUser.UserId?.Length >= 9)
            {
                string numberPart = lastUser.UserId.Substring(3); // lấy phần số
                if (int.TryParse(numberPart, out int parsed))
                {
                    nextId = parsed + 1;
                }
            }
            user.UserId = "UID" + nextId.ToString("D6"); // Format the new user ID
            iuserRepository.Add(user);
            return user;
        }

    }
}
