
-- PODPUNKT 1 --
use HR

-- PODPUNKT 2 --
select * from regions
select * from countries
select * from locations
select * from departments
select * from jobs
select * from employees
select * from job_history

-- PODPUNKT 3 --
select last_name,job_id, hire_date from employees 
where last_name='Matos' or last_name='Taylor' order by hire_date, last_name

-- PODPUNKT 4 --
select last_name, hire_date, dateadd(MONTH,6,hire_date) as kiedy from employees

-- PODPUNKT 5 --
select last_name, job_id, employees.department_id, department_name 
from employees, departments, locations where city='Toronto' 

-- PODPUNKT 6 --
select A.last_name, A.department_id, B.last_name as coworker
from employees A, employees B 
where A.department_id=B.department_id and A.employee_id!=B.employee_id
order by department_id

-- PODPUNKT 7 --
select A.first_name, A.last_name, B.last_name as manager_name 
from employees A, employees B where B.employee_id=A.manager_id and B.last_name='King'

-- PODPUNKT 8 --


-- PODPUNKT 9 --


-- PODPUNKT 10 --


-- PODPUNKT 11 --


-- PODPUNKT 12 --


-- PODPUNKT 12 --

