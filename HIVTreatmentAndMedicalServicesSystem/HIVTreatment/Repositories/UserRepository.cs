using HIVTreatment.Data;
using HIVTreatment.Models;

namespace HIVTreatment.Repositories
{
    public class UserRepository : IUserRepository
    {
        private readonly ApplicationDbContext _context;
        public UserRepository(ApplicationDbContext context)
        {
            _context = context;
        }
        public User GetByEmail(string email)
        {
            return _context.Users.FirstOrDefault(u => u.Email == email);
        }

        public User GetLastUser()
        {
            return _context.Users
                .OrderByDescending(u => Convert.ToInt32(u.UserId.Substring(3)))
                .FirstOrDefault();
        }

        public void Add(User user)
        {
            _context.Users.Add(user);
            _context.SaveChanges();
        }

        public bool EmailExists(string email)
        {
            return _context.Users.Any(u => u.Email == email);
        }

        public void Update(User user)
        {
            var existingUser = _context.Users.FirstOrDefault(u => u.UserId == user.UserId);
            if (existingUser != null)
            {
                existingUser.Fullname = user.Fullname;
                existingUser.Email = user.Email;
                //existingUser.DayOfBirth = user.DayOfBirth;
                //existingUser.Gender = user.Gender;
                //existingUser.Phone = user.Phone;
                //existingUser.BloodType = user.BloodType;
                //existingUser.Allergy = user.Allergy;
                _context.SaveChanges();
            }
        }
    }
}