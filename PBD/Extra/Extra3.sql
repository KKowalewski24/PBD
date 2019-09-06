USE hr

--PODPUNKT 1 --
SELECT b.department_name, count(*) AS employnum
FROM employees a, departments b
WHERE a.department_id = b.department_id
GROUP BY b.department_name
HAVING count(*) > 10
ORDER BY employnum

--PODPUNKT 2 --
SELECT a.last_name, a.first_name, a.salary
FROM employees a, employees b, jobs c
WHERE b.employee_id = a.manager_id
  AND b.job_id = c.job_id
  AND c.max_salary * 0.9 < b.salary
ORDER BY a.salary

--PODPUNKT 3 --
SELECT a.last_name, a.salary, b.last_name, b.salary
FROM employees a, employees b
WHERE a.manager_id = b.employee_id
  AND b.salary * 0.25 > a.salary

--PODPUNKT 4 --
SELECT c.city, c.state_province
FROM locations c
WHERE substring(c.city, 1, 2) = substring(c.state_province, 1, 2)
ORDER BY c.city, c.state_province

--PODPUNKT 5 --
SELECT b.job_title, avg(a.salary) AS average
FROM employees a, jobs b
WHERE a.job_id = b.job_id
GROUP BY b.job_title
ORDER BY average DESC

--PODPUNKT 6 --
SELECT b.last_name, count(*) AS employnum
FROM employees a, employees b
WHERE a.manager_id = b.employee_id
GROUP BY b.last_name
HAVING count(*) < 5
    OR count(*) > 10

--------------------------------------------------------------------------
/*
1.Podaj nazwy dzialow zatrudniajacych wiecej niz 10 pracownikow
2.Podaj nazwiska, imiona, wynagraodzenia tych pracownikow, ktorych szefowie zarabiaja
 wiecej niz 90% maksymalnej stawki na swoim stanowisku(dane stanowisk w tabeli jobs)
3.Podaj nazwiska i zarobki tych pracownikow, ktorych wynagrodzenie jest mniejsze 
 niz 25% wynagrodzenia szefa
4.Podaj miasta i prowincje(state_province), ktorych pierwsza litera nazwy miasta
i prowincji sa takie same. Posortuj wyniki rosnaco wedlug miasta i prowincji
5.Podaj nazwy stanowisk i srednie zarobki pracownikow na nich pracujacych w kolejnosci
 malejacych zarobkow
6.Podaj nazwiska oraz liczbe podw�adnych dla tych managerow ktorzy ich maja wiecej niz 
 dziesieciu lub mniej niz 5
*/
--------------------------------------------------------------------------

