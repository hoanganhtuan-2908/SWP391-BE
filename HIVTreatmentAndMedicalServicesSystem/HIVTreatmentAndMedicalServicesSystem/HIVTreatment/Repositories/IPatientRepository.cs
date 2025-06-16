using HIVTreatment.Models;

namespace HIVTreatment.Repositories
{
    public interface IPatientRepository
    {
<<<<<<< Updated upstream
        Patient GetByUserId(string userId);
=======
        Patient GetByPatientId(string patientID);
        List<PatientDTO> GetAllPatient();

        Patient GetLastPatientId();
>>>>>>> Stashed changes
        void Add(Patient patient);
        void Update(Patient patient);
        Patient GetLastPatient(); // Add this method to resolve the error  
    }
}
