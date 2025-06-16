<<<<<<< HEAD
﻿using HIVTreatment.DTOs;
using HIVTreatment.Models;
=======
﻿using HIVTreatment.Models;
>>>>>>> lequocviet

namespace HIVTreatment.Repositories
{
    public interface IPatientRepository
    {
<<<<<<< HEAD
=======
<<<<<<< Updated upstream
        Patient GetByUserId(string userId);
=======
>>>>>>> lequocviet
        Patient GetByPatientId(string patientID);
        List<PatientDTO> GetAllPatient();

        Patient GetLastPatientId();
<<<<<<< HEAD
        void Add(Patient patient);
        void Update(Patient patient);
=======
>>>>>>> Stashed changes
        void Add(Patient patient);
        void Update(Patient patient);
        Patient GetLastPatient(); // Add this method to resolve the error  
>>>>>>> lequocviet
    }
}
