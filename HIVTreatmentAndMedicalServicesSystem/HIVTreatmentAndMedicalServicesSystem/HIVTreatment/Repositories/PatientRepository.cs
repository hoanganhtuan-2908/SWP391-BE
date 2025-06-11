using HIVTreatment.Data;
using HIVTreatment.Models;
using Microsoft.EntityFrameworkCore;

namespace HIVTreatment.Repositories
{
    public class PatientRepository : IPatientRepository
    {
        private readonly ApplicationDbContext context;
        public PatientRepository(ApplicationDbContext context)
        {
            this.context = context;
        }

        public Patient? GetByUserId(string userId)
        {
            return context.Patients.FirstOrDefault(p => p.UserId == userId);
        }

        public void Add(Patient patient)
        {
            context.Patients.Add(patient);
            context.SaveChanges();
        }

        public void Update(Patient patient)
        {
            context.Patients.Update(patient);
            context.SaveChanges();
        }

        public Patient? GetLastPatient()
        {
            return context.Patients
                .OrderByDescending(p => Convert.ToInt32(p.PatientId.Substring(3)))
                .FirstOrDefault();
        }
    }
}
