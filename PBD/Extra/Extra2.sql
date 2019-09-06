USE hr

--PODPUNKT 1 --
SELECT a.last_name, a.first_name, a.salary, b.job_title
FROM employees a, jobs b
WHERE a.job_id = b.job_id
  AND a.salary = b.min_salary

--PODPUNKT 2 --
SELECT d.country_name
FROM regions c, countries d
WHERE c.region_id = d.region_id
  AND c.region_name = 'Europe'
  AND d.country_name NOT IN (
    SELECT country_name
    FROM departments
             JOIN locations ON locations.location_id = departments.location_id
             JOIN countries ON countries.country_id = locations.country_id)

--PODPUNKT 3 --
SELECT c.country_name, c.country_id
FROM countries c
WHERE c.country_id = substring(c.country_name, 1, 2)

--PODPUNKT 4 --
SELECT b.job_title, count(*) AS employnum
FROM employees a, jobs b
WHERE a.job_id = b.job_id
  AND b.job_title NOT LIKE '%Sales%'
  AND b.job_title NOT LIKE '%Clerk%'
GROUP BY b.job_title
ORDER BY employnum DESC

--PODPUNKT 5 --
SELECT a.first_name + ' ' + a.last_name AS pracownicy
FROM employees a
WHERE a.last_name LIKE '%a%'
  AND a.last_name LIKE '%e%'

--PODPUNKT 6 --
SELECT b.job_title, a.hire_date
FROM employees a, jobs b
WHERE a.job_id = b.job_id
  AND hire_date = (SELECT min(hire_date) FROM employees)

--------------------------------------------------------------------------
/*
1.Wyswietl nazwiska(last_name), imiona(first_name) i wynagrodzenie tych 
 pracownikow, ktorzy zarabiaja najnizsza stawke na danym stanowisku(dane 
 stanowisk w tabeli jobs).
2.Podaj nazwy panstw europejskich, w ktorych nie ma siedziby(locations) zaden oddzial.
3.Podaj nazwy tych krajow, ktorych identyfikator stanowia dwie piersze litery z nazwy kraju.
4.Ilu pracownikow zatrudnionych na stanowiskach nie zawierajacych slow 'Sales' i 'Clerk'.
 Wynik posortowac malejaco wedlug liczby pracownikow.
5.Podaj imiona i nazwiska pracownikow, ktorzy maja litery a i e w nazwisku . Wynik nazwij 
 pracownicy i przedstaw w postaci jednego ciagu Np. Jan Kowalski
6.Jakie stanowisko zajmowal pierwszy zatrudniony pracownik(na podstawie tabeli employees)
*/
--------------------------------------------------------------------------

