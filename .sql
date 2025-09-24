-- CREATE DATABASE
CREATE DATABASE clinic_booking_system;
USE clinic_booking_system;

-- PATIENTS TABLE
CREATE TABLE Patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE,
    gender ENUM('Male', 'Female', 'Other'),
    phone VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE,
    address TEXT
);
INSERT INTO Patients (first_name, last_name, date_of_birth, gender, phone, email, address) VALUES
('John', 'Doe', '1990-05-12', 'Male', '5551234567', 'john.doe@example.com', '123 Main St'),
('Jane', 'Smith', '1985-08-23', 'Female', '5559876543', 'jane.smith@example.com', '456 Elm St');


-- DOCTORS TABLE
CREATE TABLE Doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE,
    hire_date DATE NOT NULL
);
INSERT INTO Doctors (first_name, last_name, phone, email, hire_date) VALUES
('Dr. Sarah', 'Williams', '5551112222', 'sarah.williams@example.com', '2020-01-15'),
('Dr. Mike', 'Johnson', '5553334444', 'mike.johnson@example.com', '2019-03-22');


-- SPECIALTIES TABLE
CREATE TABLE Specialties (
    specialty_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    description TEXT
);
INSERT INTO Specialties (name, description) VALUES
('Cardiology', 'Heart-related treatments'),
('Dermatology', 'Skin-related treatments'),
('Pediatrics', 'Child healthcare');


-- DOCTOR_SPECIALTIES TABLE (Many-to-Many)
CREATE TABLE Doctor_Specialties (
    doctor_id INT,
    specialty_id INT,
    PRIMARY KEY (doctor_id, specialty_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id) ON DELETE CASCADE,
    FOREIGN KEY (specialty_id) REFERENCES Specialties(specialty_id) ON DELETE CASCADE
);
INSERT INTO Doctor_Specialties (doctor_id, specialty_id) VALUES
(1, 1),  -- Dr. Sarah is a Cardiologist
(1, 3),  -- Dr. Sarah also does Pediatrics
(2, 2);  -- Dr. Mike is a Dermatologist

-- APPOINTMENTS TABLE
CREATE TABLE Appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_datetime DATETIME NOT NULL,
    reason TEXT,
    status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id) ON DELETE CASCADE
);
INSERT INTO Appointments (patient_id, doctor_id, appointment_datetime, reason, status) VALUES
(1, 1, '2025-09-25 10:00:00', 'Chest pain', 'Scheduled'),
(2, 2, '2025-09-25 11:30:00', 'Skin rash', 'Scheduled');


-- TREATMENTS TABLE
CREATE TABLE Treatments (
    treatment_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL,
    description TEXT NOT NULL,
    cost DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id) ON DELETE CASCADE
);
INSERT INTO Treatments (appointment_id, description, cost) VALUES
(1, 'EKG test and consultation', 150.00),
(2, 'Skin examination and prescription', 80.00);