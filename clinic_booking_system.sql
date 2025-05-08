-- -----------------------------------------------------
-- DATABASE: Clinic Booking System
-- AUTHOR: Emmanuel Kipyegon
-- DESCRIPTION: MySQL schema for managing a small clinic
-- -----------------------------------------------------

CREATE DATABASE IF NOT EXISTS clinic_db;
USE clinic_db;

-- -------------------------
-- PATIENTS TABLE
-- -------------------------
CREATE TABLE Patients (
    PatientID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    DateOfBirth DATE,
    Gender ENUM('Male', 'Female', 'Other'),
    Phone VARCHAR(20) UNIQUE NOT NULL,
    Email VARCHAR(100),
    Address TEXT
);

-- -------------------------
-- DOCTORS TABLE
-- -------------------------
CREATE TABLE Doctors (
    DoctorID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Specialty VARCHAR(100),
    Phone VARCHAR(20) UNIQUE,
    Email VARCHAR(100),
    RoomNumber VARCHAR(10)
);

-- -------------------------
-- APPOINTMENTS TABLE
-- A Patient can have many Appointments with Doctors
-- -------------------------
CREATE TABLE Appointments (
    AppointmentID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    AppointmentDate DATETIME NOT NULL,
    Reason TEXT,
    Status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

-- -------------------------
-- TREATMENTS TABLE
-- One-to-Many with Appointments
-- -------------------------
CREATE TABLE Treatments (
    TreatmentID INT AUTO_INCREMENT PRIMARY KEY,
    AppointmentID INT NOT NULL,
    Description TEXT,
    Prescription TEXT,
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID)
);

-- -------------------------
-- PAYMENTS TABLE
-- One-to-One with Appointments (assume one payment per appointment)
-- -------------------------
CREATE TABLE Payments (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    AppointmentID INT UNIQUE NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    PaymentDate DATE NOT NULL,
    PaymentMethod ENUM('Cash', 'Credit Card', 'Insurance') NOT NULL,
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID)
);
