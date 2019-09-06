-- UZYCIE BAZY HR--
USE hr

-- PODPUNKT 1 --
SELECT a.last_name, b.department_name, c.city, d.job_title, a.salary
FROM employees a, departments b, locations c, jobs d
WHERE city = 'Toronto'
  AND a.department_id = b.department_id
  AND b.location_id = c.location_id
  AND a.job_id = d.job_id

-- PODPUNKT 2 --
SELECT count(*) AS n_employ
FROM employees
WHERE last_name LIKE '%n'

-- PODPUNKT 3 --
SELECT b.department_name, c.city, count(*) AS employ_num
FROM employees a, departments b, locations c
WHERE a.department_id = b.department_id
  AND b.location_id = c.location_id
GROUP BY b.department_name, city

SELECT b.department_name
FROM departments b

-- PODPUNKT 4 --
SELECT a.first_name, a.last_name, a.department_id, a.hire_date, a.salary, a.manager_id
FROM employees a
WHERE datename(DD, a.hire_date) < 16

-- PODPUNKT 5 --
SELECT b.department_id, b.department_name, c.city
FROM departments b, locations c
WHERE b.location_id = c.location_id
  AND department_id NOT IN
      (SELECT department_id
       FROM employees a, jobs d
       WHERE a.job_id = d.job_id
         AND d.job_title = 'sales representative'
         AND a.department_id IS NOT NULL
       GROUP BY a.department_id)

-- PODPUNKT 6A --
SELECT b.department_id, b.department_name, count(*) AS employ_num
FROM employees a, departments b
WHERE a.department_id = b.department_id
GROUP BY b.department_id, b.department_name
HAVING count(*) = (SELECT TOP 1 count(*) AS employ_num
                   FROM employees a, departments b
                   WHERE a.department_id = b.department_id
                   GROUP BY b.department_id, b.department_name
                   ORDER BY employ_num DESC)

-- PODPUNKT 6B --
SELECT b.department_id, b.department_name, count(*) AS employ_num
FROM employees a, departments b
WHERE a.department_id = b.department_id
GROUP BY b.department_id, b.department_name
HAVING count(*) = (SELECT TOP 1 count(*) AS employ_num
                   FROM employees a, departments b
                   WHERE a.department_id = b.department_id
                   GROUP BY b.department_id, b.department_name
                   ORDER BY employ_num ASC)

-- PODPUNKT 6C --
SELECT b.department_id, b.department_name, count(*) AS employ_num
FROM employees a, departments b
WHERE a.department_id = b.department_id
GROUP BY b.department_id, b.department_name
HAVING count(*) < 3

-- PODPUNKT 7 --
SELECT count(*) AS employ, datename(YYYY, hire_date) AS years
FROM employees
GROUP BY datename(YYYY, hire_date)

-- PODPUNKT 8 --
SELECT e.country_name, count(*) AS location_number
FROM locations c, countries e
WHERE c.country_id = e.country_id
GROUP BY e.country_name
