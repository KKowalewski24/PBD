USE hr
GO

-- PODPUNKT 1 --
SELECT emp.last_name, emp.first_name, emp.salary, jo.job_title
FROM employees emp, jobs jo
WHERE emp.job_id = jo.job_id
  AND emp.salary = jo.min_salary
GO

-- PODPUNKT 2 --
SELECT dep.department_id, dep.department_name, count(*) AS liczba_pracownikow
FROM departments dep, employees emp
WHERE dep.department_id = emp.department_id
GROUP BY dep.department_id, dep.department_name
HAVING count(*) < 3
ORDER BY liczba_pracownikow
GO

-- PODPUNKT 3 --
DECLARE @kursor CURSOR,
    @imie VARCHAR(30),
    @nazwisko VARCHAR(30),
    @data_zatr DATETIME,
    @pensja MONEY
--     ,@iter INT

SET @kursor = CURSOR FOR
    SELECT first_name, last_name, hire_date, salary
    FROM employees
    WHERE (GETDATE() - year(hire_date)) > 25
-- SET @iter = 0
OPEN @kursor
FETCH NEXT FROM @kursor INTO @imie, @nazwisko,@data_zatr,@pensja
WHILE @@fetch_status = 0
    BEGIN
        DECLARE @podwyzka MONEY, @lata_pracy INT
        SET @lata_pracy = YEAR(GETDATE()) - YEAR(@data_zatr)
        IF @pensja < 10000
            SET @podwyzka = @pensja * 0.15
        IF @pensja >= 10000 AND @pensja <= 20000
            SET @podwyzka = @pensja * 0.1
        IF @pensja > 20000
            SET @podwyzka = @pensja * 0.05

        PRINT 'Pracownikowi' + @imie + ' ' + @nazwisko + ' zatrudnionemu od '
            + convert(VARCHAR(10), @lata_pracy) + ' lat nalezy sie podwyzka w wysokosci ' +
              convert(VARCHAR(20), @podwyzka)
--         SET @iter = iter + 1;
        FETCH NEXT FROM @kursor INTO @imie, @nazwisko,@data_zatr,@pensja
    END
-- PRINT @iter
CLOSE @kursor
DEALLOCATE @kursor
GO

-- PODPUNKT 4 --

GO

-- PODPUNKT 5 --

GO

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
