using HIVTreatment.Models.Entities;
using Microsoft.EntityFrameworkCore;

namespace HIVTreatment.Data
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions options) : base(options)
        {

        }

        public DbSet<Employee> Employees { get; set; }


    }
}
