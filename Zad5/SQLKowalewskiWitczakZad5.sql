
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
select A.last_name, A.job_id, A.department_id, B.department_name,C.city 
from employees A, departments B, locations C 
where A.department_id=B.department_id 
and B.location_id=C.location_id and city='Toronto' 

-- PODPUNKT 6 --
select A.last_name, A.department_id, B.last_name as coworker
from employees A, employees B 
where A.department_id=B.department_id and A.employee_id!=B.employee_id
order by department_id

-- PODPUNKT 7 --
select A.first_name, A.last_name, B.last_name as manager_name 
from employees A, employees B 
where B.employee_id=A.manager_id and B.last_name='King'

-- PODPUNKT 8 --
select A.last_name, A.salary,A.commission_pct 
from employees A where A.commission_pct is not null

-- PODPUNKT 9 --
select (first_name+' '+last_name) "Pracownicy" 
from employees where last_name like '__a%' 

-- PODPUNKT 10 --
select A.first_name, A.last_name, A.department_id, A.job_id, C.city
from employees A, departments B, locations C
where A.department_id=B.department_id 
and B.location_id=C.location_id and city='Seattle'

-- PODPUNKT 11 --
select department_id, min(salary) as min_salary from employees 
where department_id=(select top 1 department_id from employees group by department_id
order by avg(salary) desc) group by department_id

-- PODPUNKT 12 --
select first_name, last_name, hire_date,datename(dw,hire_date) as weekday 
from employees where datename(dw,hire_date)=(select top 1 datename(dw,hire_date) 
from employees group by datename(dw, hire_date) order by count (*) desc)

-- PODPUNKT 13 --
select top 3 last_name, first_name, salary from employees order by salary desc

-- PODPUNKT 14 --
create table DEPT(
department_id decimal(7,0) primary key not null,
department_name varchar(25)
);

-- PODPUNKT 15 --
insert into DEPT (department_id,department_name)
select department_id,department_name from departments


--#########################--
--select * from DEPT
--drop table DEPT
--#########################--

