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
CLOSE @kursor
DEALLOCATE @kursor
IF (@licznik < 1)
    PRINT 'Na zadnym stanowisku nie zarabia sie tak duzo'
ELSE
    PRINT 'Wiecej zarabia sie na ' + convert(VARCHAR(10), @licznik) + ' stanowiskach'


-- PODPUNKT 4 --


-- PODPUNKT 5 --


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
