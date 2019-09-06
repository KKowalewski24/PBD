USE hr

--PODPUNKT 1 --
SELECT a.last_name, b.job_title, a.salary
FROM employees a, jobs b
WHERE b.job_title NOT LIKE 's%'
  AND b.job_title NOT LIKE '%d%'
  AND a.job_id = b.job_id
  AND (a.salary < 2600 OR a.salary > 11000)
ORDER BY a.salary

--PODPUNKT 2 --
SELECT count(*) AS przedzial_100_107
FROM employees a
WHERE a.manager_id >= 100
  AND a.manager_id <= 107
ORDER BY przedzial_100_107

SELECT count(*) AS bezmanagera
FROM employees a
WHERE a.manager_id IS NULL
ORDER BY bezmanagera

--PODPUNKT 3 --
SELECT b.job_title, count(*) AS liczbaprac
FROM employees a, jobs b
WHERE a.job_id = b.job_id
  AND b.job_title NOT LIKE '%Clerk%'
  AND datename(YYYY, a.hire_date) >= 1997
  AND datename(YYYY, a.hire_date) <= 1999
GROUP BY b.job_title
ORDER BY liczbaprac DESC

--PODPUNKT 4 --
SELECT e.city
FROM regions c, countries d, locations e
WHERE c.region_id = d.region_id
  AND d.country_id = e.country_id
  AND c.region_name = 'Asia'
  AND e.state_province IS NULL

--PODPUNKT 5 --
SELECT TOP 5 f.department_name, sum(a.salary) AS departsalary
FROM employees a, departments f
WHERE a.department_id = f.department_id
GROUP BY f.department_name
ORDER BY departsalary DESC

--PODPUNKT 6 --
SELECT d.country_name, e.city, count(e.city) AS departnum
FROM countries d, locations e, departments f
WHERE d.country_id = e.country_id
  AND e.location_id = f.location_id
GROUP BY d.country_name, e.city
ORDER BY d.country_name

--PODPUNKT 7 --
SELECT d.country_name
FROM countries d, regions c
WHERE c.region_id = d.region_id
  AND c.region_name = 'Europe'
  AND d.country_name NOT IN (
    SELECT countries.country_name
    FROM departments
             JOIN locations ON departments.location_id = locations.location_id
             JOIN countries ON locations.country_id = countries.country_id)

--PODPUNKT 8 --
SELECT f.department_name
FROM employees a, departments f
WHERE a.department_id = f.department_id
  AND a.salary < (SELECT avg(salary) AS average FROM employees)
GROUP BY f.department_name

--------------------------------------------------------------------------
/*
1. Wyswietl nazwisko,stanowisko oraz wysokosc pensji pracownika, ktorzy nie pracuja
 na stanowisku zaczynajacym sie na litere s ani na zadnym ze stanowisk posiadajacych 
 w swojej nazwie litere d oraz ktorych zarobki nie naleza do przedzialu od 2600 do 11000.
 Wyswietlane dane uporzadkuj rosnaco wedlug kolejnosci wysokosci pensji
2. Ilu pracownikow podlega managerom posiadajacych identyfikatory z przedzialu:[100,107]
 a ilu nie przypisano manegara. Wyniki posortuj malejaco w zaleznosci od liczby pracownikow
3.Ilu pracownikow zatrudniono w latach 1997-1999 na poszczegolnych stanowiskach nie 
 zawierajacych w nazwie slowa 'Clerk'. Dane posortuj malejaco wedlug liczby zatrudnionych pracownikow
4. Wypisz miasta z Azji, dla ktorych nie okreslono 'state_province'
5.Podaj nazwy oddzialow oraz kwoty jakie kazdy z oddzialow wydaje na pensje swoich 
 pracownikow (wypisac 5 oddzialow, ktore wydaja najwiecej)
6.Wyswietl nazwy krajow, miasta oraz liczbe departamentow w danym kraju i miescie. Zapytanie
 powinno uwzglednic tylko te panstwa i miasta, ktore posiadaja depertament
7.Podaj nazwy panstw europejskich, w ktorych nie ma siedziby(locations) zaden oddzial
8.Wyswietl tylko te oddzialy (department), ktore zatrudniaja pracownikow, ktorych zarobki nie
 przekraczaja 50% srednich zarobkow (wszystkich pracownikow)
*/
--------------------------------------------------------------------------

