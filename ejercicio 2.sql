--Brian Carabantes
--Section 2
--Number of employees hired for each job and department in 2021 divided by quarter. 
--The table must be ordered alphabetically by department and job.


SELECT
    d.department ,
    j.job ,
    SUM(CASE WHEN DATEPART(QUARTER, e.datetime) = 1 THEN 1 ELSE 0 END) AS Q1, --counter for the first quarter 
    SUM(CASE WHEN DATEPART(QUARTER, e.datetime) = 2 THEN 1 ELSE 0 END) AS Q2, --counter for the second quarter
    SUM(CASE WHEN DATEPART(QUARTER, e.datetime) = 3 THEN 1 ELSE 0 END) AS Q3, --counter for the third quarter
    SUM(CASE WHEN DATEPART(QUARTER, e.datetime) = 4 THEN 1 ELSE 0 END) AS Q4  --counter for the fourth quarter
FROM
    employees AS e
INNER JOIN
    departments AS d 
	ON e.department_id = d.id
INNER JOIN
    jobs AS j 
	ON e.job_id = j.id
WHERE
    e.datetime BETWEEN '2021-01-01' AND '2021-12-31'
GROUP BY
    d.department, j.job
ORDER BY
    d.department, j.job


----------------------------------------------------------------------------------------------------
--List of ids, name and number of employees hired of each department that hired more
--employees than the mean of employees hired in 2021 for all the departments, ordered
--by the number of employees hired (descending).

WITH 
CTE_Department_Hires --CTE creation for department hires
AS (
    SELECT
        e.department_id AS department_id,
        d.department AS department_name,
        COUNT(*) AS num_employees_hired
    FROM
        employees e
    JOIN
        departments d 
		ON e.department_id = d.id
    WHERE
        e.datetime BETWEEN '2021-01-01' AND '2021-12-31'
    GROUP BY
        e.department_id, d.department
),
CTE_Mean_Hires_2021 --CTE creation for mean hires in year 2021  
AS (
    SELECT
        AVG(num_employees_hired) AS mean_hires
    FROM
        CTE_Department_Hires
)

SELECT
    department_id,
    department_name,
    num_employees_hired
FROM
    CTE_Department_Hires
INNER JOIN
    CTE_Mean_Hires_2021 
	ON CTE_Department_Hires.num_employees_hired > CTE_Mean_Hires_2021.mean_hires
ORDER BY
    num_employees_hired DESC

























