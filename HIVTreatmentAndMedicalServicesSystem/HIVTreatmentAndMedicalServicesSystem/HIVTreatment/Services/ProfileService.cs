using HIVTreatment.DTOs;
using HIVTreatment.Models;
using HIVTreatment.Repositories;

namespace HIVTreatment.Services
{
    public class ProfileService : IProfileService
    {
        private readonly IUserRepository iUserRepository;
        private readonly IPatientRepository iPatientRepository;
<<<<<<< HEAD
        private readonly IDoctorRepository iDoctorRepository;

        public ProfileService(IUserRepository userRepository, IPatientRepository patientRepository, IDoctorRepository iDoctorRepository)
        {
            iUserRepository = userRepository;
            iPatientRepository = patientRepository;
            this.iDoctorRepository = iDoctorRepository;
        }

        public List<PatientDTO> GetAllPatient()
        {
            return iPatientRepository.GetAllPatient();
            }

        public bool UpdateDoctorProfile(EditprofileDoctorDTO editProfileDoctorDTO)
        {
            var user = iUserRepository.GetByUserId(editProfileDoctorDTO.UserId);
=======

        public ProfileService(IUserRepository userRepository, IPatientRepository patientRepository)
        {
            iUserRepository = userRepository;
            iPatientRepository = patientRepository;
        }

<<<<<<< Updated upstream
        public bool UpdateProfile(EditProfileUserDTO editProfileDTO)
=======
        public List<PatientDTO> GetAllPatient()
>>>>>>> Stashed changes
        {
            var user = iUserRepository.GetUserById(editProfileDTO.UserId);
>>>>>>> lequocviet
            if (user == null)
            {
                return false; // User not found
            }
<<<<<<< HEAD
            var doctor = iDoctorRepository.GetByDoctorId(editProfileDoctorDTO.UserId);
            user.Fullname = editProfileDoctorDTO.Fullname;
            iUserRepository.Update(user);
            if (doctor == null)
            {
                var lastDoctor = iDoctorRepository.GetLastDoctorId();
                int nextId = 1;
                if (lastDoctor != null && lastDoctor.DoctorId?.Length >= 8)
                {
                    string numberPart = lastDoctor.DoctorId.Substring(2);
                    if (int.TryParse(numberPart, out int parsed))
                    {
                        nextId = parsed + 1;
                    }
                }
                string newDoctorID = "DT" + nextId.ToString("D6");
                doctor = new Doctor
                {
                    DoctorId = newDoctorID,
                    UserId = editProfileDoctorDTO.UserId,
                    Specialization = editProfileDoctorDTO.Specialization,
                    LicenseNumber = editProfileDoctorDTO.LicenseNumber,
                    ExperienceYears = editProfileDoctorDTO.ExperienceYears,
                };
                // Use Add instead of Update for new entities
                iDoctorRepository.Add(doctor);
            }
            else
            {
                // Update existing doctor data
                doctor.Specialization = editProfileDoctorDTO.Specialization;
                doctor.LicenseNumber = editProfileDoctorDTO.LicenseNumber;
                doctor.ExperienceYears = editProfileDoctorDTO.ExperienceYears;
                iDoctorRepository.Update(doctor);
            }
            return true;
        }

        public bool UpdateProfile(EditProfileUserDTO editProfileUserDTO)
        {
            var user = iUserRepository.GetByUserId(editProfileUserDTO.UserId);
            if (user == null)
            {
                return false; // User not found
            }

            user.Fullname = editProfileUserDTO.Fullname;
            iUserRepository.Update(user);

            var patient = iPatientRepository.GetByPatientId(editProfileUserDTO.UserId);
            if (patient == null)
            {
                var lastPatient = iPatientRepository.GetLastPatientId();
                int nextId = 1;
                if (lastPatient != null && lastPatient.PatientID?.Length >= 8)
                {
                    string numberPart = lastPatient.PatientID.Substring(2);
=======
            user.Fullname = editProfileDTO.Fullname;
            iUserRepository.Update(user);

            var patient = iPatientRepository.GetByUserId(editProfileDTO.UserId);
            if (patient == null)
            {
                var lastPatient = iPatientRepository.GetLastPatient();
                int nextId = 1;
                if (lastPatient != null && lastPatient.PatientId?.Length >= 8)
                {
                    string numberPart = lastPatient.PatientId.Substring(2); // lấy phần số
>>>>>>> lequocviet
                    if (int.TryParse(numberPart, out int parsed))
                    {
                        nextId = parsed + 1;
                    }
                }
<<<<<<< HEAD
                string newPatientID = "PT" + nextId.ToString("D6");
                patient = new Patient
                {
                    PatientID = newPatientID,
                    UserID = editProfileUserDTO.UserId,
                    DateOfBirth = editProfileUserDTO.DateOfBirth,
                    Gender = editProfileUserDTO.Gender,
                    Phone = editProfileUserDTO.Phone,
                    BloodType = editProfileUserDTO.BloodType,
                    Allergy = editProfileUserDTO.Allergy,
                };
                // Use Add instead of Update for new entities
                iPatientRepository.Add(patient);
            }
            else
            {
                // Update existing patient data
                patient.DateOfBirth = editProfileUserDTO.DateOfBirth;
                patient.Gender = editProfileUserDTO.Gender;
                patient.Phone = editProfileUserDTO.Phone;
                patient.BloodType = editProfileUserDTO.BloodType;
                patient.Allergy = editProfileUserDTO.Allergy;
                iPatientRepository.Update(patient);
            }
            return true;
        }

    }
}
=======

                // Ensure patient is initialized before setting PatientId
                patient = new Patient
                {
                    UserId = editProfileDTO.UserId,
                    PatientId = "PT" + nextId.ToString("D6") // Format the new user ID
                };
                iPatientRepository.Add(patient);
            }

            patient.DateOfBirth = editProfileDTO.DayOfBirth;
            patient.Gender = editProfileDTO.Gender;
            patient.Phone = editProfileDTO.Phone;
            patient.BloodType = editProfileDTO.BloodType;
            patient.Allergy = editProfileDTO.Allergy;

            iPatientRepository.Update(patient);
            return true;
        }
    }
}
>>>>>>> lequocviet
