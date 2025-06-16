﻿using HIVTreatment.Data;
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

<<<<<<< HEAD
        

        public User GetByUserId(string UserId)
        {
            return _context.Users.FirstOrDefault(u => u.UserId == UserId);
        }

=======
        public User GetUserById(string userId)
        {
            return _context.Users.FirstOrDefault(u => u.UserId == userId);
        }
>>>>>>> lequocviet
        public void Update(User user)
        {
            _context.Users.Update(user);
            _context.SaveChanges();
<<<<<<< HEAD
=======

>>>>>>> lequocviet
        }
    }
}