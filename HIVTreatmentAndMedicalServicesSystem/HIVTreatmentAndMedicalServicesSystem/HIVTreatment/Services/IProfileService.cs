using HIVTreatment.DTOs;

namespace HIVTreatment.Services
{
    public interface IProfileService
    {
<<<<<<< HEAD
=======
<<<<<<< Updated upstream
        bool UpdateProfile(EditProfileUserDTO editProfileDTO);
=======
>>>>>>> lequocviet
        bool UpdateProfile(EditProfileUserDTO editProfileUserDTO);

        bool UpdateDoctorProfile(EditprofileDoctorDTO editProfileDoctorDTO);
        List<PatientDTO> GetAllPatient();
<<<<<<< HEAD
=======
>>>>>>> Stashed changes
>>>>>>> lequocviet
    }
}
