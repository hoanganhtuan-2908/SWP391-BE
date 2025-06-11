namespace HIVTreatment.Models
{
    public class Patient
    {
        public string PatientId { get; set; } // Unique identifier for the patient
        public string UserId { get; set; } // Foreign key to the User table
        public DateTime DateOfBirth { get; set; } // Date of birth of the patient
        public string Gender{ get; set;}
        public string Phone { get; set; } // Phone number of the patient
        public string BloodType { get; set; }
        public string Allergy { get; set; } // Allergies of the patient
    }
}
