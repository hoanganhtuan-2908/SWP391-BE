﻿using HIVTreatment.DTOs;
using HIVTreatment.Models;

namespace HIVTreatment.Repositories
{
    public interface IPatientRepository
    {
        Patient GetByPatientId(string patientID);
        List<EditProfileUserDTO> GetAllPatient();

        Patient GetLastPatientId();
        void Add(Patient patient);
        void Update(Patient patient);
    }
}
