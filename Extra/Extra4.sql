use HR

--PODPUNKT 1 --
select A.last_name, B.last_name from employees A, employees B, jobs C
where A.manager_id=B.employee_id and C.job_id=A.job_id
group by C.max_salary,C.min_salary,A.last_name,B.last_name
having C.max_salary-C.min_salary=(select min(max_salary-min_salary))

/*TODO*/
SELECT A.last_name, A.hire_date, j.job_title FROM employees A
JOIN jobs as j ON j.job_id=A.job_id
WHERE j.max_salary-j.min_salary = (select MIN(max_salary-min_salary)
from jobs)

--PODPUNKT 2 --
select C.job_title from employees A, job_history B,jobs C
where A.job_id=C.job_id 
and C.job_title not in(
select from 
join on 
)
order by C.job_title

select  C.job_title from jobs C

--PODPUNKT 3 --
select D.country_name,E.city, count(E.city) as LiczbaDepartamentow
from countries D, locations E, departments F 
where D.country_id=E.country_id and E.location_id=F.location_id
group by D.country_name,E.city
order by D.country_name

--PODPUNKT 4 --
select A.manager_id, count(*) as przedzial_100_110 from employees A
where (A.manager_id>100 and A.manager_id<110) or A.manager_id is null
group by A.manager_id
order by przedzial_100_110 desc

--PODPUNKT 5 --
select distinct A.first_name, A.last_name from employees A, job_history j
where j.employee_id=A.employee_id and j.department_id=A.department_id

--PODPUNKT 6 --
select D.department_name from employees A, departments D
where A.department_id=D.department_id and A.salary is null

--------------------------------------------------------------------------
/*
1.Podaj nazwiska pracownikow, ktorzy pracuja na stanowisku o najmniejszych widelkach 
 placowych oraz podaj nazwisko ich szefa
2.Podaj nazwy stanowisk, z ktorych nikt nie zostal zwolniony(nie ma wpisow w job_history)
 Wynik posortuj rosnaco
3.Dla kazdego kraju i miasta podac liczbe departamentow tam zlokalizowanych. Uwzglednic
 tylko te panstwa i miasta, ktore posiadaja departament. Dla liczby departamentow zastosowac
 alias 'Liczba departamentow'
4.Ilu pracownikow podlega pracownikow o identyfikatorze wiekszym niz 100 i mniejszym niz 110
 lub ktorym nie przepisano zwierzchnika. Wynik posortuj malejaco w zaleznosci od liczby pracownikow
5.Podaj imiona i nazwiska pracownikow ktorzy wczesniej pracowali w tych samych oddzialach
6.Podaj nazwy odddzialow w ktorych sa zatrudnieni pracownicy nie majacy pensji.
*/
--------------------------------------------------------------------------
