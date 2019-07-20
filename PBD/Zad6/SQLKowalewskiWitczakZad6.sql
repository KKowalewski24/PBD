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

select B.department_name from departments B

-- PODPUNKT 4 --
select A.first_name,A.last_name, A.department_id,A.hire_date,A.salary,A.manager_id 
from employees A where datename(dd,A.hire_date)<16

-- PODPUNKT 5 --
select B.department_id,B.department_name,C.city 
from departments B, locations C
where B.location_id=C.location_id and department_id not in
(select department_id from employees A, jobs D 
where A.job_id=D.job_id and D.job_title='sales representative'
and A.department_id is not null group by A.department_id)

-- PODPUNKT 6A --
select B.department_id,B.department_name, count (*) as employ_num 
from employees A, departments B where A.department_id=B.department_id
group by B.department_id, B.department_name
having count (*)=(select top 1 count (*) as employ_num 
from employees A, departments B where A.department_id=B.department_id
group by B.department_id, B.department_name order by employ_num desc)

-- PODPUNKT 6B --
select B.department_id,B.department_name, count (*) as employ_num 
from employees A, departments B where A.department_id=B.department_id
group by B.department_id, B.department_name
having count (*)=(select top 1 count (*) as employ_num 
from employees A, departments B where A.department_id=B.department_id
group by B.department_id, B.department_name order by employ_num asc)

-- PODPUNKT 6C --
select B.department_id,B.department_name, count (*) as employ_num 
from employees A, departments B where A.department_id=B.department_id
group by B.department_id, B.department_name
having count (*)<3

-- PODPUNKT 7 --
select count (*) as employ, datename(yyyy,hire_date) as years 
from employees group by datename(yyyy,hire_date)

-- PODPUNKT 8 --
select E.country_name, count (*) as location_number from locations C, countries E
where C.country_id=E.country_id group by E.country_name
