-- Healthcare Joins & Subqueries

-- 1. Show all doctors and their department names
SELECT
    d.doctor_id,
    d.name AS doctor_name,
    dep.department_name
FROM doctors d
LEFT JOIN departments dep
ON d.department_id = dep.department_id;

-- 2. Determine total treatment cost for each appointment
SELECT
    appointment_id,
    SUM(cost) AS total_treatment_cost
FROM treatments
GROUP BY appointment_id;

-- 3. Patients who never had an appointment
SELECT
    patient_id,
    name
FROM patients
WHERE patient_id NOT IN (
    SELECT patient_id
    FROM appointments
);

-- 4. Count distinct patients seen by each doctor
SELECT
    doctor_id,
    COUNT(DISTINCT patient_id) AS total_patients_seen
FROM appointments
GROUP BY doctor_id;

-- 5. Top 3 departments with highest number of doctors
SELECT
    dep.department_name,
    COUNT(d.doctor_id) AS total_doctors
FROM doctors d
JOIN departments dep
ON d.department_id = dep.department_id
GROUP BY dep.department_name
ORDER BY total_doctors DESC
LIMIT 3;

-- 6. Patients with at least 3 different medications
SELECT
    patient_id,
    COUNT(DISTINCT medication) AS medication_count
FROM prescriptions
GROUP BY patient_id
HAVING COUNT(DISTINCT medication) >= 3;
