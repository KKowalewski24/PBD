USE hr

--PODPUNKT 1 --
SELECT a.last_name, b.last_name
FROM employees a, employees b, jobs c
WHERE a.manager_id = b.employee_id
  AND a.job_id = c.job_id
  AND a.job_id IN (SELECT job_id
                   FROM jobs
                   WHERE max_salary - min_salary = (SELECT min(max_salary - min_salary) FROM jobs))

--PODPUNKT 2 --
SELECT c.job_title
FROM jobs c
WHERE c.job_id NOT IN (SELECT job_id FROM job_history)

--PODPUNKT 3 --
SELECT d.country_name, e.city, count(e.city) AS liczbadepartamentow
FROM countries d, locations e, departments f
WHERE d.country_id = e.country_id
  AND e.location_id = f.location_id
GROUP BY d.country_name, e.city
ORDER BY d.country_name

--PODPUNKT 4 --
SELECT a.manager_id, count(*) AS przedzial_100_110
FROM employees a
WHERE (a.manager_id > 100 AND a.manager_id < 110)
   OR a.manager_id IS NULL
GROUP BY a.manager_id
ORDER BY przedzial_100_110 DESC

--PODPUNKT 5 --
SELECT DISTINCT a.first_name, a.last_name
FROM employees a, job_history j
WHERE j.employee_id = a.employee_id
  AND j.department_id = a.department_id

--PODPUNKT 6 --
SELECT d.department_name
FROM departments d
WHERE d.department_name NOT IN (
    SELECT department_name
    FROM employees
             JOIN departments ON employees.department_id = departments.department_id)

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

