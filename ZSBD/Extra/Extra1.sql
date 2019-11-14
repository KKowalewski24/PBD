USE hr
GO

-- PODPUNKT 1 --
SELECT emp.last_name, emp.first_name, emp.salary, jo.job_title
FROM employees emp, jobs jo
WHERE emp.job_id = jo.job_id
  AND emp.salary = jo.min_salary

-- PODPUNKT 2 --
SELECT dep.department_id, dep.department_name, count(*) AS liczba_pracownikow
FROM departments dep, employees emp
WHERE dep.department_id = emp.department_id
GROUP BY dep.department_id, dep.department_name
HAVING count(*) < 3
ORDER BY liczba_pracownikow

-- PODPUNKT 3 --


-- PODPUNKT 4 --


-- PODPUNKT 5 --



--------------------------------------------------------------------------
/*
1. Wyswietl nazwiska (last_name), imiona(first_name) i wynagrodzenia tych pracownikow,
ktorzy zarabiaja najnizsza stawke na danym stanowisku (dane stanowisk w tabeli jobs).

2. Wyswietl identyfikatory oddzialow (department_id), nazwy oddzialow (department_name)
i liczbe pracownikow, dla tych oddzialow, w ktoych pracuje mniej niz 3 pracownikow.

3. Utworz blok z zastosowaniem kursora, w ktorym:
    a) dla kazdego pracownika, ktory pracuje wiecej niz 25 lat zostaje obliczona podwyzka
        15% przy zarobkach ponizej 10000, 10% przy zarobkach miedzy 10000 i 20000,
        5% przy zarobkach powyzej 20000
    b) Zostanie wypisany komunikat: Pracownikowi imie, nazwisko zatrudnionemu od liczba_lat
        nalezy sie podwyzka w wysokosci obliczona_podwyzka

4.Napisz funkcje, ktora podaje trzykroktnosc wynagrodzenia dla podanego pracownika. Napisz
wywołanie funkcji w zapytaniem dajacego wyniku w postaci czterech kolumn: employee_id,
employee(polaczenie imienia i nazwiska), salary, high_salary

5. Utworz wyzwalacz, ktory po zmodyfikowaniu placy minimalnej (MIN_SALARY) w tabeli JOBS,
zmieni place (SALARY) kazdemu pracownikowi o taka wartosc o jaka zmieniala sie placa minimalna
dla jego stanowiska. Napisz polecenia uruchamiajace wyzwalacz.
 */
--------------------------------------------------------------------------
