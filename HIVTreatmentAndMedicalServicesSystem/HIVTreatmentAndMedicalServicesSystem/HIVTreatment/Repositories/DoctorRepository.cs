using HIVTreatment.Data;
using HIVTreatment.Models;

namespace HIVTreatment.Repositories
{
    public class DoctorRepository : IDoctorRepository
    {
        private readonly ApplicationDbContext context;
        public DoctorRepository(ApplicationDbContext context)
        {
            this.context = context;
        }

        public void Add(Doctor doctor)
        {
            context.Add(doctor);
            context.SaveChanges();
        }

        public Doctor GetByDoctorId(string doctorId)
        {
            return context.Doctors.FirstOrDefault(d => d.DoctorId == doctorId);
        }

        public Doctor GetLastDoctorId()
        {
            return context.Doctors.OrderByDescending(d => Convert.ToInt32(d.DoctorId.Substring(3))).FirstOrDefault();
        }

        public void Update(Doctor doctor)
        {
            context.Update(doctor);
            context.SaveChanges();
        }
    }
}
