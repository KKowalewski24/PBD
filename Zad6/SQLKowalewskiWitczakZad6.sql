-- UZYCIE BAZY HR--
use HR

-- PODPUNKT 1 --
select A.last_name, B.department_name, C.city, D.job_title,A.salary 
from employees A,departments B,locations C,jobs D
where city='Toronto' and A.department_id=B.department_id 
and B.location_id=C.location_id and A.job_id=D.job_id

-- PODPUNKT 2 --
select count (*) as n_employ from employees where last_name like '%n'

-- PODPUNKT 3 --
select B.department_name, C.city, count (*) as employ_num 
from employees A, departments B, locations C
where A.department_id=B.department_id and B.location_id=C.location_id
group by B.department_name, city

-- PODPUNKT 4 --
select A.first_name,A.last_name, A.department_id,A.hire_date,A.salary,A.manager_id 
from employees A where datename(dd,A.hire_date)<16

-- PODPUNKT 5 --
select distinct B.department_id,B.department_name,C.city 
from employees A, departments B, locations C, jobs D
where B.location_id=C.location_id and A.job_id=D.job_id 
and D.job_title!='sales representative' and B.department_id is not null

-- PODPUNKT 6A --


-- PODPUNKT 6B --


-- PODPUNKT 6C --


-- PODPUNKT 7 --


-- PODPUNKT 8 --
select E.country_name, count(*) as location_number from locations C, countries E
where C.country_id=E.country_id group by E.country_name
