-- Basic Patient & Appointment Queries

-- 1. List all patients
SELECT *
FROM patients;

-- 2. Show patient names and cities from Calgary
SELECT
    name,
    city
FROM patients
WHERE city = 'Calgary';

-- 3. Find distinct insurance providers
SELECT DISTINCT insurance_provider
FROM patients;

-- 4. Upcoming appointments after January 1, 2024
SELECT
    patient_id,
    doctor_id,
    appointment_id,
    appointment_date
FROM appointments
WHERE appointment_date > '2024-01-01';

-- 5. List all appointment statuses
SELECT DISTINCT status
FROM appointments;

-- 6. Find patients aged between 30 and 40
SELECT
    patient_id,
    name,
    age
FROM patients
WHERE age BETWEEN 30 AND 40;

-- 7. Count patients by city
SELECT
    city,
    COUNT(*) AS total_patients
FROM patients
GROUP BY city;

-- 8. Top five most frequent diagnoses
SELECT
    diagnosis,
    COUNT(*) AS diagnosis_count
FROM appointments
GROUP BY diagnosis
ORDER BY diagnosis_count DESC
LIMIT 5;
