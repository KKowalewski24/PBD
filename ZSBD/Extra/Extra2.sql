USE hr
GO

-- PODPUNKT 1 --
SELECT dep.department_id, dep.department_name, count(*) AS liczba_pracownikow
FROM departments dep, employees emp
WHERE dep.department_id = emp.department_id
GROUP BY dep.department_id, dep.department_name
HAVING count(*) < 3
ORDER BY liczba_pracownikow

-- PODPUNKT 2 --
SELECT dep.department_name, round(avg(emp.salary), 1) AS srednie_wynagrodzenie
FROM departments dep, employees emp
WHERE dep.department_id = emp.department_id
GROUP BY dep.department_name
ORDER BY srednie_wynagrodzenie DESC

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
IF EXISTS(SELECT 1
          FROM sys.objects
          WHERE type = 'FN'
            AND name = 'procent_oddzialow')
    DROP FUNCTION procent_oddzialow
GO

CREATE FUNCTION procent_oddzialow(@id VARCHAR(2)) RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @liczba_oddzialow FLOAT, @wybrany FLOAT
    SET @liczba_oddzialow = (
                                SELECT COUNT(cou.country_id)
                                FROM countries cou, locations loc, departments dep
                                WHERE cou.country_id = loc.country_id
                                  AND loc.location_id = dep.location_id
                            )

    SET @wybrany = (
                       SELECT COUNT(cou.country_id)
                       FROM countries cou, locations loc, departments dep
                       WHERE cou.country_id = loc.country_id
                         AND loc.location_id = dep.location_id
                         AND cou.country_id = @id
                   )
    RETURN (@wybrany / @liczba_oddzialow) * 100
END
GO

SELECT DISTINCT cou.country_name, dbo.procent_oddzialow(cou.country_id)
FROM countries cou, locations loc, departments dep
WHERE cou.country_id = loc.country_id
  AND loc.location_id = dep.location_id

-- PODPUNKT 5 --
IF EXISTS(SELECT *
          FROM sys.objects
          WHERE type = 'TR'
            AND name = 'bledna_nazwa')
    DROP TRIGGER bledna_nazwa
GO

CREATE TRIGGER bledna_nazwa
    ON countries
    FOR INSERT
    AS
BEGIN
    IF ((SELECT country_name FROM countries) IS NULL)
        BEGIN
            INSERT INTO countries
            SELECT country_id, 'Nowa nazwa', region_id
            FROM countries
        END
END
GO

DELETE
FROM countries

WHERE country_id = 'PL'
SELECT *
FROM countries

INSERT INTO countries
VALUES ('PL', NULL, 1)

SELECT *
FROM countries
WHERE country_id = 'PL'
--------------------------------------------------------------------------
/*
1. Wyswietl identyfikatory oddzialow (department_id), nazwy oddzialow (department_name)
i liczbe pracownikow, dla tych oddzialow, w ktoych pracuje mniej niz 3 pracownikow.

2. Wyswietl nazwy oddzialow (department_name) oraz srednie wynagrodzenie (salary)
w tych oddzialach. Wyniki posortuj malejaco wzgledem kwoty i wykonaj jej zaokraglenie
do 1 miejsca po przecinku.

3. Utworz blok z zastosowaniem kursora, w ktorym:
    a) wypisane zostana stanowiska (job_id) wszystkich pracownikow (tabela employees)
        zarabiajacych powyzej okreslonej stawki (podanej w definicji kursora)
    b) wypisujacy na koniec komunikat: Wiecej zarabia sie na ..[liczba] stanowiskach
        lub na zadnym stanowisku nie zarabia sie tak duzo.

4. Napisz funkcje podajaca dla kazdego kraju, ile procent wszystkich oddzialow znajduja sie
w tym kraju. Wywolaj ja wewnatrz zapytania dajacego wynik w postaci dwoch kolumn:
country_name, nazwa_funkcji

5. Utworz wyzwalacz, ktory przy wstawianiu nowego rekordu do tabeli countries, jesli
uzytkownik nie poda nazwy panstwa (country_name), bedzie wpisywal pod nazwe panstwa
wartosc "Nowa nazwa". Napisz rowniez polecenia uruchamiajace wyzwalacz.
 */
--------------------------------------------------------------------------
