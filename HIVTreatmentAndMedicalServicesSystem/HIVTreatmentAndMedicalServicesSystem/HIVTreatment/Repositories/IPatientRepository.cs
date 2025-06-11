using HIVTreatment.Models;

namespace HIVTreatment.Repositories
{
    public interface IPatientRepository
    {
        Patient GetByUserId(string userId);
        void Add(Patient patient);
        void Update(Patient patient);
        Patient GetLastPatient(); // Add this method to resolve the error  
    }
}
