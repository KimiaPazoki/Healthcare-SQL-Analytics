-- Advanced Healthcare Analytics using Window Functions

-- 1. Rank doctors by salary within each department
SELECT
    d.doctor_id,
    d.name AS doctor_name,
    dep.department_name,
    d.salary,
    DENSE_RANK() OVER (
        PARTITION BY dep.department_name
        ORDER BY d.salary DESC
    ) AS salary_rank
FROM doctors d
JOIN departments dep
ON d.department_id = dep.department_id;

-- 2. Last 3 appointments for each doctor
SELECT *
FROM (
    SELECT
        doctor_id,
        appointment_id,
        appointment_date,
        fee,
        ROW_NUMBER() OVER (
            PARTITION BY doctor_id
            ORDER BY appointment_date DESC
        ) AS appointment_rank
    FROM appointments
) ranked_appointments
WHERE appointment_rank <= 3;

-- 3. 7-day moving average of appointment fees for each doctor
SELECT
    doctor_id,
    appointment_date,
    fee,
    AVG(fee) OVER (
        PARTITION BY doctor_id
        ORDER BY appointment_date
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS moving_avg_7_appointments
FROM appointments;

-- 4. Percentage contribution of each treatment to appointment total cost
SELECT
    appointment_id,
    treatment_id,
    cost,
    ROUND(
        cost * 100.0 / SUM(cost) OVER (
            PARTITION BY appointment_id
        ),
        2
    ) AS treatment_cost_percentage
FROM treatments;

-- 5. Most recent appointment date for each patient
SELECT
    patient_id,
    appointment_id,
    appointment_date,
    MAX(appointment_date) OVER (
        PARTITION BY patient_id
    ) AS most_recent_appointment_date
FROM appointments;
