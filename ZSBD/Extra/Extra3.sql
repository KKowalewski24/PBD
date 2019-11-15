USE hr
GO

-- PODPUNKT 1 --
SELECT emp.employee_id, emp.first_name, emp.last_name, emp.hire_date, jo_hi.start_date,
       jo_hi.end_date
FROM employees emp, job_history jo_hi
WHERE emp.employee_id = jo_hi.employee_id

-- PODPUNKT 1.1 --
SELECT emp.employee_id, emp.first_name, emp.last_name, jh.end_date
FROM employees emp
         LEFT JOIN job_history jh ON emp.employee_id = jh.employee_id
WHERE jh.employee_id IS NULL

-- PODPUNKT 2 --
SELECT emp.last_name, emp.job_id, jb.job_title
FROM employees emp, jobs jb
WHERE emp.job_id = jb.job_id
  AND emp.hire_date = (SELECT min(hire_date) FROM employees)

-- PODPUNKT 3 --
DECLARE @kursor CURSOR,
    @id_stanowiska VARCHAR(10),
    @okreslona_stawka MONEY=5000,
    @licznik INT=0

SET @kursor = CURSOR FOR
    SELECT DISTINCT job_id
    FROM employees
    WHERE salary > @okreslona_stawka

OPEN @kursor
FETCH NEXT FROM @kursor INTO @id_stanowiska

WHILE @@fetch_status = 0
    BEGIN
        SET @licznik = @licznik + 1
        PRINT @id_stanowiska
        FETCH NEXT FROM @kursor INTO @id_stanowiska
    END

IF (@licznik < 1)
    PRINT 'Na zadnym stanowisku nie zarabia sie tak duzo'
ELSE
    PRINT 'Wiecej zarabia sie na ' + convert(VARCHAR(10), @licznik) + ' stanowiskach'

CLOSE @kursor
DEALLOCATE @kursor

-- PODPUNKT 4 --


-- PODPUNKT 5 --


--------------------------------------------------------------------------
/*
 TRESCI BRAK - PONIZEJ TYLKO DOMYSLY
 1. Wyswietl pracownikow ktorzy juz nie pracuja
 1.1. Wyswietl pracownikow aktualnie zatrudnionych - wszystkich pracownikow
        bez tych w tabeli job_history

 2. Wyswielt najwczesniej zatrudnionego pracownika

 3. TO SAMO CO W EXTRA2.SQL - Utworz blok z zastosowaniem kursora, w ktorym:
    a) wypisane zostana stanowiska (job_id) wszystkich pracownikow (tabela employees)
        zarabiajacych powyzej okreslonej stawki (podanej w definicji kursora)
    b) wypisujacy na koniec komunikat: Wiecej zarabia sie na ..[liczba] stanowiskach
        lub na zadnym stanowisku nie zarabia sie tak duzo.

4.
*/
--------------------------------------------------------------------------
