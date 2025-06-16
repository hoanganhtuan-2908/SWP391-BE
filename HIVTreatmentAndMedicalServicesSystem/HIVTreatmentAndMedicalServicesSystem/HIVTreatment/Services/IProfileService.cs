using HIVTreatment.DTOs;

namespace HIVTreatment.Services
{
    public interface IProfileService
    {
<<<<<<< Updated upstream
        bool UpdateProfile(EditProfileUserDTO editProfileDTO);
=======
        bool UpdateProfile(EditProfileUserDTO editProfileUserDTO);

        bool UpdateDoctorProfile(EditprofileDoctorDTO editProfileDoctorDTO);
        List<PatientDTO> GetAllPatient();
>>>>>>> Stashed changes
    }
}
