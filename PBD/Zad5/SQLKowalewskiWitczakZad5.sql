-- PODPUNKT 1 --
USE hr

-- PODPUNKT 2 --
SELECT *
FROM regions
SELECT *
FROM countries
SELECT *
FROM locations
SELECT *
FROM departments
SELECT *
FROM jobs
SELECT *
FROM employees
SELECT *
FROM job_history

-- PODPUNKT 3 --
SELECT last_name, job_id, hire_date
FROM employees
WHERE last_name = 'Matos'
   OR last_name = 'Taylor'
ORDER BY hire_date, last_name

-- PODPUNKT 4 --
SELECT last_name, hire_date, dateadd(MONTH, 6, hire_date) AS kiedy
FROM employees

-- PODPUNKT 5 --
SELECT a.last_name, a.job_id, a.department_id, b.department_name, c.city
FROM employees a, departments b, locations c
WHERE a.department_id = b.department_id
  AND b.location_id = c.location_id
  AND city = 'Toronto'

-- PODPUNKT 6 --
SELECT a.last_name, a.department_id, b.last_name AS coworker
FROM employees a, employees b
WHERE a.department_id = b.department_id
  AND a.employee_id != b.employee_id
ORDER BY department_id

-- PODPUNKT 7 --
SELECT a.first_name, a.last_name, b.last_name AS manager_name
FROM employees a, employees b
WHERE b.employee_id = a.manager_id
  AND b.last_name = 'King'

-- PODPUNKT 8 --
SELECT a.last_name, a.salary, a.commission_pct
FROM employees a
WHERE a.commission_pct IS NOT NULL

-- PODPUNKT 9 --
SELECT (first_name + ' ' + last_name) "pracownicy"
FROM employees
WHERE last_name LIKE '__a%'

-- PODPUNKT 10 --
SELECT a.first_name, a.last_name, a.department_id, a.job_id, c.city
FROM employees a, departments b, locations c
WHERE a.department_id = b.department_id
  AND b.location_id = c.location_id
  AND city = 'Seattle'

-- PODPUNKT 11 --
SELECT department_id, min(salary) AS min_salary
FROM employees
WHERE department_id = (SELECT TOP 1 department_id
                       FROM employees
                       GROUP BY department_id
                       ORDER BY avg(salary) DESC)
GROUP BY department_id

-- PODPUNKT 12 --
SELECT first_name, last_name, hire_date, datename(DW, hire_date) AS weekday
FROM employees
WHERE datename(DW, hire_date) = (SELECT TOP 1 datename(DW, hire_date)
                                 FROM employees
                                 GROUP BY datename(DW, hire_date)
                                 ORDER BY count(*) DESC)

-- PODPUNKT 13 --
SELECT TOP 3 last_name, first_name, salary
FROM employees
ORDER BY salary DESC

-- PODPUNKT 14 --
CREATE TABLE dept (
    department_id   DECIMAL(7, 0) PRIMARY KEY NOT NULL,
    department_name VARCHAR(25)
);

-- PODPUNKT 15 --
INSERT INTO dept (department_id, department_name)
SELECT department_id, department_name
FROM departments


--#########################--
--select * from DEPT
--drop table DEPT
--#########################--

