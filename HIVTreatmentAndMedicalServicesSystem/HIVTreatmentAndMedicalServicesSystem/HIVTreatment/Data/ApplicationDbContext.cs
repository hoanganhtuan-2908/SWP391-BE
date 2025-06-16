using HIVTreatment.Models;
using Microsoft.EntityFrameworkCore;

namespace HIVTreatment.Data
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions options) : base(options)
        {

        }

        public DbSet<User> Users { get; set; }
<<<<<<< HEAD
        public DbSet<BooksAppointment> BooksAppointments { get; set; }
        public DbSet<Patient> Patients { get; set; }
        public DbSet<Doctor> Doctors { get; set; }
=======
        public DbSet<Patient> Patients { get; set; }

>>>>>>> lequocviet

    }
}
