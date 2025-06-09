-- Tạo Database
CREATE DATABASE MedicalSystem;
GO

USE MedicalSystem;
GO

set dateformat dmy

-- USERS & ROLES
CREATE TABLE Roles (
    RoleID VARCHAR(10) PRIMARY KEY,
    RoleName NVARCHAR(50) NOT NULL
);

CREATE TABLE Users (
    UserID VARCHAR(10) PRIMARY KEY,
    RoleID VARCHAR(10) FOREIGN KEY REFERENCES Roles(RoleID),
    Fullname NVARCHAR(100) NOT NULL,
    Password VARCHAR(255) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
	Image VARCHAR(100)
);

-- PATIENTS
CREATE TABLE Patients (
    PatientID VARCHAR(10) PRIMARY KEY,
    UserID VARCHAR(10) FOREIGN KEY REFERENCES Users(UserID),
    DateOfBirth DATE,
    Gender NVARCHAR(20),
    Phone VARCHAR(20),
    BloodType VARCHAR(10),
    Allergy NVARCHAR(MAX)
);

-- DOCTORS
CREATE TABLE Doctors (
    DoctorID VARCHAR(10) PRIMARY KEY,
    UserID VARCHAR(10) FOREIGN KEY REFERENCES Users(UserID),
    Specialization NVARCHAR(100),
    LicenseNumber NVARCHAR(50) UNIQUE,
    ExperienceYears INT
);

-- SERVICES
CREATE TABLE Services (
    ServiceID VARCHAR(10) PRIMARY KEY,
    ServiceName NVARCHAR(100) NOT NULL,
    Type NVARCHAR(50),
    Price DECIMAL(10,2)
);

CREATE TABLE DoctorServices (
    DoctorServiceID VARCHAR(10) PRIMARY KEY,
    DoctorID VARCHAR(10) FOREIGN KEY REFERENCES Doctors(DoctorID),
    ServiceID VARCHAR(10) FOREIGN KEY REFERENCES Services(ServiceID),
    CONSTRAINT UK_DoctorService UNIQUE (DoctorID, ServiceID)
);

-- SLOTS
CREATE TABLE Slot (
    SlotID VARCHAR(10) PRIMARY KEY,
    SlotNumber INT,
    StartTime TIME NOT NULL,
    EndTime TIME NOT NULL
);

-- DOCTOR SCHEDULE
CREATE TABLE DoctorWorkSchedule (
    ScheduleID VARCHAR(10) PRIMARY KEY,
    DoctorID VARCHAR(10) FOREIGN KEY REFERENCES Doctors(DoctorID),
    SlotID VARCHAR(10) FOREIGN KEY REFERENCES Slot(SlotID),
    DayOfWeek NVARCHAR(10),
    Status NVARCHAR(20)
);

-- SCHEDULING & APPOINTMENTS
CREATE TABLE Books (
    BookID VARCHAR(10) PRIMARY KEY,
    PatientID VARCHAR(10) FOREIGN KEY REFERENCES Patients(PatientID),
    DoctorID VARCHAR(10) FOREIGN KEY REFERENCES Doctors(DoctorID),
    ServiceID VARCHAR(10) FOREIGN KEY REFERENCES Services(ServiceID),
    BookDate DATETIME NOT NULL,
    Status NVARCHAR(20),
    Note NVARCHAR(MAX)
);

CREATE TABLE Appointment (
    AppointmentID VARCHAR(10) PRIMARY KEY,
    BookID VARCHAR(10) FOREIGN KEY REFERENCES Books(BookID),
    AppointmentDate DATE NOT NULL,
    Status NVARCHAR(20)
);

CREATE TABLE Consultation (
    ConsultationID VARCHAR(10) PRIMARY KEY,
    BookID VARCHAR(10) FOREIGN KEY REFERENCES Books(BookID),
    Diagnosis NVARCHAR(MAX),
    LinkMeet NVARCHAR(255),
    ConsultationDate DATETIME
);

-- MEDICAL RECORDS
CREATE TABLE MedicalRecord (
    MedicalRecordID VARCHAR(10) PRIMARY KEY,
    PatientID VARCHAR(10) FOREIGN KEY REFERENCES Patients(PatientID),
    DoctorID VARCHAR(10) FOREIGN KEY REFERENCES Doctors(DoctorID),
    Diagnosis NVARCHAR(MAX),
    CreatedDate DATETIME,
    TreatmentResult NVARCHAR(MAX)
);

-- MEDICATION & PRESCRIPTIONS
CREATE TABLE Medication (
    MedicationID VARCHAR(10) PRIMARY KEY,
    MedicationName NVARCHAR(100) NOT NULL,
    DosageForm NVARCHAR(50),
    Strength NVARCHAR(50),
    TargetGroup NVARCHAR(50),
    CreatedAt DATETIME
);

CREATE TABLE Prescription (
    PrescriptionID VARCHAR(10) PRIMARY KEY,
    MedicalRecordID VARCHAR(10) FOREIGN KEY REFERENCES MedicalRecord(MedicalRecordID),
    MedicationID VARCHAR(10) FOREIGN KEY REFERENCES Medication(MedicationID),
    DoctorID VARCHAR(10) FOREIGN KEY REFERENCES Doctors(DoctorID),
    StartDate DATE NOT NULL,
    EndDate DATE,
    Dosage NVARCHAR(100),
    LineOfTreatment NVARCHAR(50),
    CreatedAt DATETIME
);

-- ARV REGIMEN
CREATE TABLE ARVRegimen (
    ARVRegimenID VARCHAR(10) PRIMARY KEY,
    MedicalRecordID VARCHAR(10) FOREIGN KEY REFERENCES MedicalRecord(MedicalRecordID),
    DoctorID VARCHAR(10) FOREIGN KEY REFERENCES Doctors(DoctorID),
    RegimenCode NVARCHAR(50),
    ARVName NVARCHAR(100),
    Description NVARCHAR(MAX),
    AgeRange NVARCHAR(50),
    ForGroup NVARCHAR(50),
    CreatedAt DATETIME
);

-- HIV TESTS
CREATE TABLE HIVTest (
    TestResultID VARCHAR(10) PRIMARY KEY,
    MedicalRecordID VARCHAR(10) FOREIGN KEY REFERENCES MedicalRecord(MedicalRecordID),
    TestDate DATE NOT NULL,
    CD4Count INT,
    ViralLoad INT,
    Notes NVARCHAR(MAX)
);

-- REMINDERS
CREATE TABLE Reminder (
    ReminderCheckID VARCHAR(10) PRIMARY KEY,
    PatientID VARCHAR(10) FOREIGN KEY REFERENCES Patients(PatientID),
    AppointmentID VARCHAR(10) FOREIGN KEY REFERENCES Appointment(AppointmentID),
    ReminderTime DATETIME NOT NULL,
    Message NVARCHAR(MAX)
);

CREATE TABLE ReminderMedication (
    ReminderMedicationID VARCHAR(10) PRIMARY KEY,
    PatientID VARCHAR(10) FOREIGN KEY REFERENCES Patients(PatientID),
    PrescriptionID VARCHAR(10) FOREIGN KEY REFERENCES Prescription(PrescriptionID),
    DosageTime TIME NOT NULL,
    Instruction NVARCHAR(MAX),
    MedicationInUse NVARCHAR(255)
);
GO
/*
-- Thêm các chỉ mục để tối ưu hiệu suất
CREATE INDEX IX_Users_RoleID ON Users(RoleID);
CREATE INDEX IX_Patients_UserID ON Patients(UserID);
CREATE INDEX IX_Doctors_UserID ON Doctors(UserID);
CREATE INDEX IX_Books_PatientID ON Books(PatientID);
CREATE INDEX IX_Books_DoctorID ON Books(DoctorID);
CREATE INDEX IX_Books_ServiceID ON Books(ServiceID);
CREATE INDEX IX_MedicalRecord_PatientID ON MedicalRecord(PatientID);
CREATE INDEX IX_MedicalRecord_DoctorID ON MedicalRecord(DoctorID);
CREATE INDEX IX_Prescription_MedicalRecordID ON Prescription(MedicalRecordID);
CREATE INDEX IX_Prescription_MedicationID ON Prescription(MedicationID);
GO

-- Thêm các ràng buộc và giá trị mặc định
ALTER TABLE Books
ADD CONSTRAINT DF_Books_Status DEFAULT 'Pending' FOR Status;

ALTER TABLE Appointment
ADD CONSTRAINT DF_Appointment_Status DEFAULT 'Scheduled' FOR Status;

ALTER TABLE MedicalRecord
ADD CONSTRAINT DF_MedicalRecord_CreatedDate DEFAULT GETDATE() FOR CreatedDate;

ALTER TABLE Prescription
ADD CONSTRAINT DF_Prescription_CreatedAt DEFAULT GETDATE() FOR CreatedAt;

ALTER TABLE ARVRegimen
ADD CONSTRAINT DF_ARVRegimen_CreatedAt DEFAULT GETDATE() FOR CreatedAt;

ALTER TABLE Medication
ADD CONSTRAINT DF_Medication_CreatedAt DEFAULT GETDATE() FOR CreatedAt;
GO

-- Thêm hàm để tạo ID tự động theo định dạng
CREATE FUNCTION GenerateID(@prefix NVARCHAR(3), @lastID INT)
RETURNS VARCHAR(10)
AS
BEGIN
    RETURN @prefix + RIGHT('0000000' + CAST(@lastID + 1 AS VARCHAR(7)), 7)
END
GO

-- Stored procedure để thêm mới Role
CREATE PROCEDURE sp_InsertRole
    @RoleName NVARCHAR(50)
AS
BEGIN
    DECLARE @LastID INT
    DECLARE @NewRoleID VARCHAR(10)
    
    -- Lấy ID lớn nhất hiện tại
    SELECT @LastID = ISNULL(MAX(CAST(SUBSTRING(RoleID, 4, 7) AS INT)), 0) FROM Roles WHERE RoleID LIKE 'ROL%'
    
    -- Tạo ID mới
    SET @NewRoleID = dbo.GenerateID('ROL', @LastID)
    
    -- Thêm Role mới
    INSERT INTO Roles (RoleID, RoleName) VALUES (@NewRoleID, @RoleName)
    
    -- Trả về ID mới
    SELECT @NewRoleID AS RoleID
END
GO

-- Stored procedure để thêm mới User
CREATE PROCEDURE sp_InsertUser
    @RoleID VARCHAR(10),
    @Fullname NVARCHAR(100),
    @Password NVARCHAR(255),
    @Email NVARCHAR(100)
AS
BEGIN
    DECLARE @LastID INT
    DECLARE @NewUserID VARCHAR(10)
    
    -- Lấy ID lớn nhất hiện tại
    SELECT @LastID = ISNULL(MAX(CAST(SUBSTRING(UserID, 4, 7) AS INT)), 0) FROM Users WHERE UserID LIKE 'USR%'
    
    -- Tạo ID mới
    SET @NewUserID = dbo.GenerateID('USR', @LastID)
    
    -- Thêm User mới
    INSERT INTO Users (UserID, RoleID, Fullname, Password, Email) 
    VALUES (@NewUserID, @RoleID, @Fullname, @Password, @Email)
    
    -- Trả về ID mới
    SELECT @NewUserID AS UserID
END
GO

-- Stored procedure để đặt lịch hẹn
CREATE PROCEDURE sp_CreateBookingAndAppointment
    @PatientID VARCHAR(10),
    @DoctorID VARCHAR(10),
    @ServiceID VARCHAR(10),
    @BookDate DATETIME,
    @AppointmentDate DATE,
    @Note NVARCHAR(MAX) = NULL
AS
BEGIN
    DECLARE @LastBookID INT
    DECLARE @NewBookID VARCHAR(10)
    DECLARE @LastAppointmentID INT
    DECLARE @NewAppointmentID VARCHAR(10)
    
    BEGIN TRANSACTION;
    
    -- Tạo ID mới cho Books
    SELECT @LastBookID = ISNULL(MAX(CAST(SUBSTRING(BookID, 4, 7) AS INT)), 0) FROM Books WHERE BookID LIKE 'BOK%'
    SET @NewBookID = dbo.GenerateID('BOK', @LastBookID)
    
    -- Tạo Books
    INSERT INTO Books (BookID, PatientID, DoctorID, ServiceID, BookDate, Status, Note)
    VALUES (@NewBookID, @PatientID, @DoctorID, @ServiceID, @BookDate, 'Pending', @Note);
    
    -- Tạo ID mới cho Appointment
    SELECT @LastAppointmentID = ISNULL(MAX(CAST(SUBSTRING(AppointmentID, 4, 7) AS INT)), 0) FROM Appointment WHERE AppointmentID LIKE 'APT%'
    SET @NewAppointmentID = dbo.GenerateID('APT', @LastAppointmentID)
    
    -- Tạo Appointment
    INSERT INTO Appointment (AppointmentID, BookID, AppointmentDate, Status)
    VALUES (@NewAppointmentID, @NewBookID, @AppointmentDate, 'Scheduled');
    
    COMMIT TRANSACTION;
    
    -- Trả về BookID và AppointmentID cho client
    SELECT @NewBookID AS BookID, @NewAppointmentID AS AppointmentID;
END
GO

-- Stored procedure để đặt lịch tư vấn trực tuyến
CREATE PROCEDURE sp_CreateBookingAndConsultation
    @PatientID VARCHAR(10),
    @DoctorID VARCHAR(10),
    @ServiceID VARCHAR(10),
    @BookDate DATETIME,
    @ConsultationDate DATETIME,
    @LinkMeet NVARCHAR(255),
    @Note NVARCHAR(MAX) = NULL
AS
BEGIN
    DECLARE @LastBookID INT
    DECLARE @NewBookID VARCHAR(10)
    DECLARE @LastConsultationID INT
    DECLARE @NewConsultationID VARCHAR(10)
    
    BEGIN TRANSACTION;
    
    -- Tạo ID mới cho Books
    SELECT @LastBookID = ISNULL(MAX(CAST(SUBSTRING(BookID, 4, 7) AS INT)), 0) FROM Books WHERE BookID LIKE 'BOK%'
    SET @NewBookID = dbo.GenerateID('BOK', @LastBookID)
    
    -- Tạo Books
    INSERT INTO Books (BookID, PatientID, DoctorID, ServiceID, BookDate, Status, Note)
    VALUES (@NewBookID, @PatientID, @DoctorID, @ServiceID, @BookDate, 'Pending', @Note);
    
    -- Tạo ID mới cho Consultation
    SELECT @LastConsultationID = ISNULL(MAX(CAST(SUBSTRING(ConsultationID, 4, 7) AS INT)), 0) FROM Consultation WHERE ConsultationID LIKE 'CON%'
    SET @NewConsultationID = dbo.GenerateID('CON', @LastConsultationID)
    
    -- Tạo Consultation
    INSERT INTO Consultation (ConsultationID, BookID, LinkMeet, ConsultationDate)
    VALUES (@NewConsultationID, @NewBookID, @LinkMeet, @ConsultationDate);
    
    COMMIT TRANSACTION;
    
    -- Trả về BookID và ConsultationID cho client
    SELECT @NewBookID AS BookID, @NewConsultationID AS ConsultationID;
END
GO

**/

-- Thêm dữ liệu vào bảng Roles (sử dụng stored procedure)
insert into Roles values ('R001', 'Admin');
insert into Roles values ('R002', 'Manager');
insert into Roles values ('R003', 'Doctor');
insert into Roles values ('R004', 'Staff');
insert into Roles values ('R005', 'Patient');
--select * from Roles


-- Tạo tài khoản quản trị viên
INSERT INTO Users (UserID, RoleID, Fullname, Password, Email) 
VALUES ('UID000001', 'R001', N'Lê Quốc Việt', 'lequocviet123', 'lequocviet@gmail.com');
INSERT INTO Users (UserID, RoleID, Fullname, Password, Email) 
VALUES ('UID000002', 'R001', N'Nguyễn Văn Nguyên', 'nguyenvannguyen123', 'nguyenvannguyen@gmail.com');
INSERT INTO Users (UserID, RoleID, Fullname, Password, Email) 
VALUES ('UID000003', 'R001', N'Nguyễn Quản Trị 1', 'nguyenquantri123', 'nguyenquantri@gmail.com');
INSERT INTO Users (UserID, RoleID, Fullname, Password, Email) 
VALUES ('UID000004', 'R001', N'Nguyễn Quản Trị 2', 'nguyenquantri123', 'nguyenquantri2@gmail.com');
INSERT INTO Users (UserID, RoleID, Fullname, Password, Email) 
VALUES ('UID000005', 'R001', N'Nguyễn Quản Trị 3', 'nguyenquantri123', 'nguyenquantri3@gmail.com');




-- Tạo tài khoản quản lý
INSERT INTO Users (UserID, RoleID, Fullname, Password, Email) 
VALUES ('UID000006', 'R002', N'Nguyễn Quản LÝ', 'nguyenquanly123', 'nguyenquanly@gmail.com');
INSERT INTO Users (UserID, RoleID, Fullname, Password, Email) 
VALUES ('UID000007', 'R002', N'Nguyễn Quản LÝ 2', 'nguyenquanly123', 'nguyenquanly2@gmail.com');
INSERT INTO Users (UserID, RoleID, Fullname, Password, Email) 
VALUES ('UID000008', 'R002', N'Nguyễn Quản LÝ 3', 'nguyenquanly123', 'nguyenquanly3@gmail.com');
INSERT INTO Users (UserID, RoleID, Fullname, Password, Email) 
VALUES ('UID000009', 'R002', N'Nguyễn Quản LÝ 4', 'nguyenquanly123', 'nguyenquanly4@gmail.com');
INSERT INTO Users (UserID, RoleID, Fullname, Password, Email) 
VALUES ('UID000010', 'R002', N'Nguyễn Quản LÝ 5', 'nguyenquanly123', 'nguyenquanly5@gmail.com');

--tạo tk bác sĩ
INSERT INTO Users (UserID, RoleID, Fullname, Password, Email) 
VALUES ('UID000011', 'R003', N'Nguyễn Bác sĩ', 'nguyenbacsi123', 'nguyenbacsi@gmail.com');
INSERT INTO Users (UserID, RoleID, Fullname, Password, Email) 
VALUES ('UID000012', 'R003', N'Nguyễn Bác sĩ 2', 'nguyenbacsi123', 'nguyenbacsi2@gmail.com');
INSERT INTO Users (UserID, RoleID, Fullname, Password, Email) 
VALUES ('UID000013', 'R003', N'Nguyễn Bác sĩ 3', 'nguyenbacsi123', 'nguyenbacsi3@gmail.com');
INSERT INTO Users (UserID, RoleID, Fullname, Password, Email) 
VALUES ('UID000014', 'R003', N'Nguyễn Bác sĩ 4', 'nguyenbacsi123', 'nguyenbacsi4@gmail.com');
INSERT INTO Users (UserID, RoleID, Fullname, Password, Email) 
VALUES ('UID000015', 'R003', N'Nguyễn Bác sĩ 5', 'nguyenbacsi123', 'nguyenbacsi5@gmail.com');


--tạo tk staff
INSERT INTO Users (UserID, RoleID, Fullname, Password, Email) 
VALUES ('UID000016', 'R004', N'Nguyễn Nhân Viên', 'nguyennhanvien123', 'nguyennhanvien@gmail.com');
INSERT INTO Users (UserID, RoleID, Fullname, Password, Email) 
VALUES ('UID000017', 'R004', N'Nguyễn Nhân Viên 2', 'nguyennhanvien123', 'nguyennhanvien2@gmail.com');
INSERT INTO Users (UserID, RoleID, Fullname, Password, Email) 
VALUES ('UID000018', 'R004', N'Nguyễn Nhân Viên 3', 'nguyennhanvien123', 'nguyennhanvien3@gmail.com');
INSERT INTO Users (UserID, RoleID, Fullname, Password, Email) 
VALUES ('UID000019', 'R004', N'Nguyễn Nhân Viên 4', 'nguyennhanvien123', 'nguyennhanvien4@gmail.com');
INSERT INTO Users (UserID, RoleID, Fullname, Password, Email) 
VALUES ('UID000020', 'R004', N'Nguyễn Nhân Viên 5', 'nguyennhanvien123', 'nguyennhanvien5@gmail.com');



--tạo tk patient
INSERT INTO Users (UserID, RoleID, Fullname, Password, Email) 
VALUES ('UID000021', 'R005', N'Nguyễn Bệnh Nhân 1', 'nguyenbenhnhan123', 'nguyenbenhnhan@gmail.com');
INSERT INTO Users (UserID, RoleID, Fullname, Password, Email)
VALUES ('UID000022', 'R005', N'Nguyễn Bệnh Nhân 2', 'nguyenbenhnhan123', 'nguyenbenhnhan2@gmail.com');
INSERT INTO Users (UserID, RoleID, Fullname, Password, Email)
VALUES ('UID000023', 'R005', N'Nguyễn Bệnh Nhân 3', 'nguyenbenhnhan123', 'nguyenbenhnhan3@gmail.com');
INSERT INTO Users (UserID, RoleID, Fullname, Password, Email)
VALUES ('UID000024', 'R005', N'Nguyễn Bệnh Nhân 4', 'nguyenbenhnhan123', 'nguyenbenhnhan4@gmail.com');
INSERT INTO Users (UserID, RoleID, Fullname, Password, Email)
VALUES ('UID000025', 'R005', N'Nguyễn Bệnh Nhân 5', 'nguyenbenhnhan123', 'nguyenbenhnhan5@gmail.com');


-- Thêm dữ liệu vào bảng Doctors
INSERT INTO Doctors (DoctorID, UserID, Specialization, LicenseNumber, ExperienceYears) 
VALUES ('DT000001', 'UID011', N'Miễn dịch', 'LIC123456', 10);
INSERT INTO Doctors (DoctorID, UserID, Specialization, LicenseNumber, ExperienceYears) 
VALUES ('DT000002', 'UID012', N'Bệnh truyền nhiễm', 'LIC789012', 15);



/*select * from Roles
select * from Doctors
select * from Patients
select * from Users where RoleID = 'R005'
select * from Services
select * from Doctors
*/


-- Thêm dữ liệu vào bảng Patients
INSERT INTO Patients (PatientID, UserID, DateOfBirth, Gender, Phone, BloodType, Allergy) 
VALUES ('PT000001', 'UID021', '15-05-1980', N'Nam', '0901234567', 'O+', N'Không có');
INSERT INTO Patients (PatientID, UserID, DateOfBirth, Gender, Phone, BloodType, Allergy) 
VALUES ('PT000002', 'UID022', '20-10-1990', N'Nữ', '0912345678', 'A+', N'Dị ứng với penicillin');
INSERT INTO Patients (PatientID, UserID, DateOfBirth, Gender, Phone, BloodType, Allergy) 
VALUES ('PT000003', 'UID023', '08-03-1975', N'Nam', '0923456789', 'B-', N'Dị ứng với hải sản');

-- Thêm dữ liệu vào bảng Services
INSERT INTO Services (ServiceID, ServiceName, Type, Price) 
VALUES ('SV000001', N'Khám tổng quát', N'Khám bệnh', 700000);
INSERT INTO Services (ServiceID, ServiceName, Type, Price) 
VALUES ('SV000002', N'Tư vấn điều trị', N'Tư vấn', 300000);
INSERT INTO Services (ServiceID, ServiceName, Type, Price) 
VALUES ('SV000003', N'Xét nghiệm HIV', N'Xét nghiệm', 1500000);
INSERT INTO Services (ServiceID, ServiceName, Type, Price) 
VALUES ('SV000004', N'Xét nghiệm CD4', N'Xét nghiệm', 850000);
INSERT INTO Services (ServiceID, ServiceName, Type, Price) 
VALUES ('SV000005', N'Tư vấn điều trị ARV', N'Tư vấn', 400000);
INSERT INTO Services (ServiceID, ServiceName, Type, Price) 
VALUES ('SV000006', N'Xét nghiệm tải lượng virus', N'Xét nghiệm', 1000000);

-- Thêm dữ liệu vào bảng DoctorServices
INSERT INTO DoctorServices (DoctorServiceID, DoctorID, ServiceID) 
VALUES ('DSV000001', 'DT001', 'SV000004');
INSERT INTO DoctorServices (DoctorServiceID, DoctorID, ServiceID) 
VALUES ('DSV000002', 'DT001', 'SV000005');
INSERT INTO DoctorServices (DoctorServiceID, DoctorID, ServiceID) 
VALUES ('DSV000003', 'DT002', 'SV000005');
INSERT INTO DoctorServices (DoctorServiceID, DoctorID, ServiceID) 
VALUES ('DSV000004', 'DT002', 'SV000004');
INSERT INTO DoctorServices (DoctorServiceID, DoctorID, ServiceID) 
VALUES ('DSV000005', 'DT002', 'SV000005');

-- Thêm dữ liệu vào bảng Slot
INSERT INTO Slot (SlotID, SlotNumber, StartTime, EndTime) 
VALUES ('SL000001', 1, '07:00', '9:30');
INSERT INTO Slot (SlotID, SlotNumber, StartTime, EndTime) 
VALUES ('SL000002', 2, '09:30', '12:00');
INSERT INTO Slot (SlotID, SlotNumber, StartTime, EndTime) 
VALUES ('SL000003', 3, '12:00', '14:30');
INSERT INTO Slot (SlotID, SlotNumber, StartTime, EndTime) 
VALUES ('SL000004', 4, '14:30', '17:00');
INSERT INTO Slot (SlotID, SlotNumber, StartTime, EndTime) 
VALUES ('SL000005', 5, '17:00', '19:30');
INSERT INTO Slot (SlotID, SlotNumber, StartTime, EndTime) 
VALUES ('SL000006', 6, '19:30', '22:00');

-- Thêm dữ liệu vào bảng DoctorWorkSchedule
INSERT INTO DoctorWorkSchedule (ScheduleID, DoctorID, SlotID, DayOfWeek, Status) 
VALUES ('SCH000001', 'DT000001', 'SL000001', N'Thứ hai', N'Khả dụng');
INSERT INTO DoctorWorkSchedule (ScheduleID, DoctorID, SlotID, DayOfWeek, Status) 
VALUES ('SCH000002', 'DT000001', 'SL000002', N'Thứ hai', N'Khả dụng');
INSERT INTO DoctorWorkSchedule (ScheduleID, DoctorID, SlotID, DayOfWeek, Status) 
VALUES ('SCH000003', 'DT000002', 'SL000003', N'Thứ ba', N'Khả dụng');
INSERT INTO DoctorWorkSchedule (ScheduleID, DoctorID, SlotID, DayOfWeek, Status) 
VALUES ('SCH000004', 'DT000002', 'SL000004', N'Thứ ba', N'Khả dụng');
INSERT INTO DoctorWorkSchedule (ScheduleID, DoctorID, SlotID, DayOfWeek, Status) 
VALUES ('SCH000005', 'DT000002', 'SL000005', N'Thứ tư', N'Không khả dụng');


-- Thêm dữ liệu vào bảng Books
INSERT INTO Books (BookID, PatientID, DoctorID, ServiceID, BookDate, Status, Note) 
VALUES ('BK000001', 'PT000001', 'DT000001', 'SV000001', '2025-06-10 08:00:00', N'Đã xác nhận', N'Khám định kỳ');
INSERT INTO Books (BookID, PatientID, DoctorID, ServiceID, BookDate, Status, Note) 
VALUES ('BK000002', 'PT000002', 'DT000002', 'SV000003', '2025-06-12 09:00:00', N'Đã xác nhận', N'Xét nghiệm thường niên');
INSERT INTO Books (BookID, PatientID, DoctorID, ServiceID, BookDate, Status, Note) 
VALUES ('BK000003', 'PT000003', 'DT000002', 'SV000004', '2025-06-15 10:00:00', N'Đang chờ', N'Tư vấn lần đầu');

-- Thêm dữ liệu vào bảng Appointment (lịch khám trực tiếp)
INSERT INTO Appointment (AppointmentID, BookID, AppointmentDate, Status) 
VALUES ('AP000001', 'BK000001', '2025-06-10 09:00:00', N'Đã lên lịch');
INSERT INTO Appointment (AppointmentID, BookID, AppointmentDate, Status) 
VALUES ('AP000002', 'BK000002', '2025-06-12 07:00:00', N'Đã lên lịch');

-- Thêm dữ liệu vào bảng Consultation (lịch tư vấn online)
INSERT INTO Consultation (ConsultationID, BookID, Diagnosis, LinkMeet, ConsultationDate) 
VALUES ('CN000001', 'BK000003', NULL, 'https://meet.google.com/abc-defg-hij', '2025-06-15 10:00:00');

-- Thêm dữ liệu vào bảng MedicalRecord
INSERT INTO MedicalRecord (MedicalRecordID, PatientID, DoctorID, Diagnosis, CreatedDate, TreatmentResult) 
VALUES ('MR000001', 'PT000001', 'DT000001', N'Tình trạng sức khỏe ổn định', '2025-05-10 09:15:00', N'Tiếp tục theo dõi');
INSERT INTO MedicalRecord (MedicalRecordID, PatientID, DoctorID, Diagnosis, CreatedDate, TreatmentResult) 
VALUES ('MR000002', 'PT000002', 'DT000002', N'Nhiễm HIV giai đoạn đầu', '2025-05-15 10:30:00', N'Bắt đầu điều trị ARV');

-- Thêm dữ liệu vào bảng Medication
INSERT INTO Medication (MedicationID, MedicationName, DosageForm, Strength, TargetGroup, CreatedAt) 
VALUES ('MD000001', N'Tenofovir', N'Viên nén', '300mg', N'Người trưởng thành', '2025-02-01 12:20:16');
INSERT INTO Medication (MedicationID, MedicationName, DosageForm, Strength, TargetGroup, CreatedAt) 
VALUES ('MD000002', N'Lamivudine', N'Viên nén', '150mg', N'Người trưởng thành', '2025-02-01 10:02:00');
INSERT INTO Medication (MedicationID, MedicationName, DosageForm, Strength, TargetGroup, CreatedAt) 
VALUES ('MD000003', N'Efavirenz', N'Viên nén', '600mg', N'Người trưởng thành', '2025-02-01 10:03:00');

-- Thêm dữ liệu vào bảng Prescription
INSERT INTO Prescription (PrescriptionID, MedicalRecordID, MedicationID, DoctorID, StartDate, EndDate, Dosage, LineOfTreatment, CreatedAt) 
VALUES ('PR000001', 'MR000002', 'MD000001', 'DT000002', '2025-05-15', '2025-08-15', N'1 viên mỗi ngày', N'Đầu tiên', '2025-05-15 10:45:00');
INSERT INTO Prescription (PrescriptionID, MedicalRecordID, MedicationID, DoctorID, StartDate, EndDate, Dosage, LineOfTreatment, CreatedAt) 
VALUES ('PR000002', 'MR000002', 'MD000002', 'DT000002', '2025-05-15', '2025-08-15', N'1 viên mỗi ngày', N'Đầu tiên', '2025-05-15 10:45:00');

-- Thêm dữ liệu vào bảng ARVRegimen
INSERT INTO ARVRegimen (ARVRegimenID, MedicalRecordID, DoctorID, RegimenCode, ARVName, Description, AgeRange, ForGroup, CreatedAt) 
VALUES ('ARV000001', 'MR000002', 'DT000002', 'TDF+3TC+EFV', N'Tenofovir + Lamivudine + Efavirenz', N'Phác đồ bậc 1 cho người mới điều trị', N'Trên 15 tuổi', N'Người lớn', '2025-05-15 10:50:00');

-- Thêm dữ liệu vào bảng HIVTest
INSERT INTO HIVTest (TestResultID, MedicalRecordID, TestDate, CD4Count, ViralLoad, Notes) 
VALUES ('HT000001', 'MR000002', '2025-05-14', 450, 10000, N'Xét nghiệm trước khi bắt đầu điều trị');

-- Thêm dữ liệu vào bảng Reminder
INSERT INTO Reminder (ReminderCheckID, PatientID, AppointmentID, ReminderTime, Message) 
VALUES ('REC000001', 'PT000001', 'AP000001', '2025-06-09 09:09:00', N'Nhắc nhở: Lịch khám ngày mai lúc 07:00');
INSERT INTO Reminder (ReminderCheckID, PatientID, AppointmentID, ReminderTime, Message) 
VALUES ('REC000002', 'PT000002', 'AP000002', '2025-06-11 10:15:00', N'Nhắc nhở: Lịch xét nghiệm CD4 ngày mai lúc 09:00');

-- Thêm dữ liệu vào bảng ReminderMedication
INSERT INTO ReminderMedication (ReminderMedicationID, PatientID, PrescriptionID, DosageTime, Instruction, MedicationInUse) 
VALUES ('REM000001', 'PT000002', 'PR000001', '08:00', N'Uống sau bữa sáng', N'Tenofovir đang sử dụng');
INSERT INTO ReminderMedication (ReminderMedicationID, PatientID, PrescriptionID, DosageTime, Instruction, MedicationInUse) 
VALUES ('REM000002', 'PT000002', 'PR000002', '08:00', N'Uống sau bữa sáng', N'Lamivudine đang sử dụng');


/*
-- Xác nhận số lượng dữ liệu đã thêm vào mỗi bảng
SELECT 'Roles' AS TableName, COUNT(*) AS RecordCount FROM Roles
UNION ALL
SELECT 'Users', COUNT(*) FROM Users
UNION ALL
SELECT 'Patients', COUNT(*) FROM Patients
UNION ALL
SELECT 'Doctors', COUNT(*) FROM Doctors
UNION ALL
SELECT 'Services', COUNT(*) FROM Services
UNION ALL
SELECT 'DoctorServices', COUNT(*) FROM DoctorServices
UNION ALL
SELECT 'Slot', COUNT(*) FROM Slot
UNION ALL
SELECT 'DoctorWorkSchedule', COUNT(*) FROM DoctorWorkSchedule
UNION ALL
SELECT 'Books', COUNT(*) FROM Books
UNION ALL
SELECT 'Appointment', COUNT(*) FROM Appointment
UNION ALL
SELECT 'Consultation', COUNT(*) FROM Consultation
UNION ALL
SELECT 'MedicalRecord', COUNT(*) FROM MedicalRecord
UNION ALL
SELECT 'Medication', COUNT(*) FROM Medication
UNION ALL
SELECT 'Prescription', COUNT(*) FROM Prescription
UNION ALL
SELECT 'ARVRegimen', COUNT(*) FROM ARVRegimen
UNION ALL
SELECT 'HIVTest', COUNT(*) FROM HIVTest
UNION ALL
SELECT 'Reminder', COUNT(*) FROM Reminder
UNION ALL
SELECT 'ReminderMedication', COUNT(*) FROM ReminderMedication;*/