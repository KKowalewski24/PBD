use HR

--PODPUNKT 1 --
select A.last_name, B.last_name from employees A, employees B, jobs C
where A.manager_id=B.employee_id and A.job_id=C.job_id
and A.job_id in (select job_id from jobs 
where max_salary-min_salary=(select min(max_salary-min_salary) from jobs))

--PODPUNKT 2 --
select C.job_title from jobs C
where C.job_id not in (select job_id from job_history)

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
select D.department_name from departments D
where D.department_name not in (
select department_name from employees
join departments on employees.department_id=departments.department_id)

/*select D.department_name from employees A, departments D
where A.department_id=D.department_id and A.salary is null*/

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

