using HIVTreatment.DTOs;
using HIVTreatment.Models;
using HIVTreatment.Repositories;

namespace HIVTreatment.Services
{
    public class ProfileService : IProfileService
    {
        private readonly IUserRepository iUserRepository;
        private readonly IPatientRepository iPatientRepository;

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
            if (user == null)
            {
                return false; // User not found
            }
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
                    if (int.TryParse(numberPart, out int parsed))
                    {
                        nextId = parsed + 1;
                    }
                }

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
