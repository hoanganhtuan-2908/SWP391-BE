using HIVTreatment.Data;
<<<<<<< HEAD
using HIVTreatment.DTOs;
=======
>>>>>>> lequocviet
using HIVTreatment.Models;
using Microsoft.EntityFrameworkCore;

namespace HIVTreatment.Repositories
{
    public class PatientRepository : IPatientRepository
    {
        private readonly ApplicationDbContext context;
<<<<<<< HEAD

=======
>>>>>>> lequocviet
        public PatientRepository(ApplicationDbContext context)
        {
            this.context = context;
        }

<<<<<<< HEAD
        public Patient GetByPatientId(string patientId)
        {
            return context.Patients.FirstOrDefault(p => p.UserID == patientId);
        }



=======
        public Patient? GetByUserId(string userId)
        {
            return context.Patients.FirstOrDefault(p => p.UserId == userId);
        }

>>>>>>> lequocviet
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

<<<<<<< HEAD
        public Patient GetLastPatientId()
        {
            return context.Patients
                .OrderByDescending(p => Convert.ToInt32(p.PatientID.Substring(3)))
                .FirstOrDefault();
        }
=======
        public Patient? GetLastPatient()
        {
            return context.Patients
                .OrderByDescending(p => Convert.ToInt32(p.PatientId.Substring(3)))
                .FirstOrDefault();
        }
<<<<<<< Updated upstream
=======
>>>>>>> lequocviet

        public List<PatientDTO> GetAllPatient()
        {
            var result = (from p in context.Patients
                          join u in context.Users on p.UserID equals u.UserId
                          select new PatientDTO
                          {
                              UserId = u.UserId,
                              Fullname = u.Fullname,
                              Email = u.Email,
                              PatientID = p.PatientID,
                              DateOfBirth = p.DateOfBirth,
                              Phone = p.Phone,
                              Gender = p.Gender,
                              BloodType = p.BloodType,
                              Allergy = p.Allergy
                          }).ToList();

            return result;
        }
<<<<<<< HEAD
=======

        
>>>>>>> Stashed changes
>>>>>>> lequocviet
    }
}
