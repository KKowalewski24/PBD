-- KAMIL KOWALEWSKI 216806 --

USE biblioteka
GO

SELECT * FROM czytelnicy;

SELECT * FROM ksiazki;

SELECT * FROM pracownicy;

SELECT * FROM wydawnictwa;

SELECT * FROM wypozyczenia

-- PODPUNKT 1. Przepisz i wykonaj poszczególne bloki. Sprawdź rezultaty wykonania. Część bloków działa w oparciu o baze biblioteka (skrypty: biblioteka_schemat.sql oraz biblioteka_dane.sql). --
DECLARE @x INT, @s VARCHAR(10)

SET @x = 10
SET @s = 'napis'

PRINT @x + 2
PRINT @s

-- Z którego wiersza zostaną przepisane dane? --
DECLARE @imiep VARCHAR(20), @nazwiskop VARCHAR(20)
SELECT @imiep = imie, @nazwiskop = nazwisko
FROM pracownicy
WHERE id = 7
PRINT @imiep + ' ' + @nazwiskop

-- ODP. Z WIERSZA OSTATNIEJ OSOBY W BAZIE

-- PODPUNKT 2. Co zostanie zwrócone? --
DECLARE @imiep VARCHAR(20), @nazwiskop VARCHAR(20)
SET @imiep = 'Teofil'
SET @nazwiskop = 'Szczerbaty'

SELECT @imiep = imie, @nazwiskop = nazwisko
FROM pracownicy
WHERE id = 1

PRINT @imiep + ' ' + @nazwiskop
-- ODP. ZOSTANIE ZWROCONA PIERWSZA OSOBA

DECLARE @imiep VARCHAR(20), @nazwiskop VARCHAR(20)
SET @imiep = 'Teofil'
SET @nazwiskop = 'Szczerbaty'

SELECT @imiep = imie, @nazwiskop = nazwisko
FROM pracownicy
WHERE id = 20

PRINT @imiep + ' ' + @nazwiskop
-- ODP. BAZA DANYCH NIE POSIADA 20 OSOBY WIEC ZOSTANIE WYPISANE TEOFIL SZCZERBATY

-- PODPUNKT 3. WAITFOR --
CREATE TABLE liczby (
    licz1 INT,
    czas  DATETIME DEFAULT getdate()
);

GO

DECLARE @x INT
SET @x = 2

INSERT INTO liczby (licz1)
VALUES (@x);

WAITFOR DELAY '00:00:10'

INSERT INTO liczby (licz1)
VALUES (@x + 2);

SELECT *
FROM liczby;

-- PODPUNKT 4. IF..ELSE --
IF exists(SELECT *
          FROM wypozyczenia)
    PRINT ('Byly wyporzyczania')
ELSE
    PRINT ('Nie bylo zadnych wypozyczen')


-- PODPUNKT 5. WHILE --
DECLARE @y INT
SET @y = 0
WHILE (@y < 10)
    BEGIN
        PRINT @y
        IF (@y = 5) BREAK
        SET @y = @y + 1
    END

-- PODPUNKT 6. CASE --
SELECT tytul AS tytulk, cena AS cenak,
       [cena jest]=CASE
                       WHEN cena < 20.00 THEN 'Niska'
                       WHEN cena BETWEEN 20.00 AND 40.00 THEN 'Przystepna'
                       WHEN cena > 40 THEN 'Wysoka'
                       ELSE 'Nieznana'
           END
FROM ksiazki

-- PODPUNKT 7. NULLIF --
SELECT avg(nullif(year(getdate()) - year(data_ur), 0)) AS [srednia wiek],
       min(nullif(year(getdate()) - year(data_ur), 0)) AS [wiek minimalny],
       max(nullif(year(getdate()) - year(data_ur), 0)) AS [wiek maksymalny]
FROM czytelnicy

-- PODPUNKT 8. ISNULL --
SELECT nazwa, ISNULL(telefon, 123 - 456 - 789) AS telefon
FROM wydawnictwa

-- PODPUNKT 9. Komunikaty o błędzie --
RAISERROR (21000,10,1)
PRINT @@error

RAISERROR (21000, 10,1) WITH SETERROR
PRINT @@error

RAISERROR (21000, 11,1)
PRINT @@error

RAISERROR ('Ala ma kota',11,1)
PRINT @@error

-- PODPUNKT 10. Daty --
DECLARE @d1 DATETIME, @d2 DATETIME
SET @d1 = '20091020'
SET @d2 = '20091025'

SELECT dateadd(HOUR, 112, @d1)
SELECT dateadd(DAY, 112, @d1)

SELECT datediff(MINUTE, @d1, @d2)
SELECT datediff(DAY, @d1, @d2)

SELECT datename(MONTH, @d1)
SELECT datepart(MONTH, @d1)

SELECT CAST(day(@d1) AS VARCHAR)
           + '-' + cast(month(@d1) AS VARCHAR)
           + '-' + cast(year(@d1) AS VARCHAR)

-- PODPUNKT 11 --
SELECT col_length('pracownicy', 'imie')
SELECT datalength(2 + 3.4)
SELECT db_id('master')
SELECT db_name(1)
SELECT user_id()
SELECT user_name()
SELECT host_id()
SELECT host_name()
SELECT object_id('Pracownicy')
SELECT object_name(object_id('Pracownicy'))

-- PODPUNKT 12 --
IF exists(SELECT 1
          FROM master.dbo.sysdatabases
          WHERE name = 'test_cwiczenia')
    DROP DATABASE test_cwiczenia
GO

CREATE DATABASE test_cwiczenia
GO

CREATE TABLE test_cwiczenia..liczby (
    liczba INT
)
GO

DECLARE @i INT
SET @i = 1
WHILE @i < 100
    BEGIN
        INSERT test_cwiczenia..liczby VALUES (@i)
        SET @i = @i + 1
    END

SELECT *
FROM test_cwiczenia..liczby

-- PODPUNKT 13 --
IF exists(SELECT 1
          FROM sys.objects
          WHERE type = 'P'
            AND name 'test_cwiczenia..proc_liczby')
    DROP PROCEDURE test_cwiczenia..proc_liczby
GO

CREATE PROCEDURE test_cwiczenia..proc_liczby @max INT = 10
AS
BEGIN
    SELECT liczba
    FROM test_cwiczenia..liczby
    WHERE liczba <= @max
END
GO

EXEC test_cwiczenia..proc_liczby 3
EXEC test_cwiczenia..proc_liczby
GO

-- PODPUNKT 14 --
IF exists(SELECT 1
          FROM sys.objects
          WHERE type = 'P'
            AND name = 'test_cwiczenia..proc_statystyka')
    DROP PROCEDURE test_cwiczenia..proc_statystyka
GO

CREATE PROCEDURE test_cwiczenia..proc_statystyka @max INT OUTPUT, @min INT OUTPUT, @aux INT OUTPUT
AS
BEGIN
    SET @max = (SELECT max(liczba) FROM test_cwiczenia..liczby)
    SET @min = (SELECT min(liczba) FROM test_cwiczenia..liczby)
    SET @aux = 10
END
GO

DECLARE
    @max INT, @min INT, @aux2 INT
EXEC test_cwiczenia..proc_statystyka @max OUTPUT, @min OUTPUT, @aux=@aux2 OUTPUT
SELECT @max 'max', @min 'min', @aux2

-- PODPUNKT 15 --

--DROP FUNCTION pobierzpesel

GO
CREATE FUNCTION pobierzpesel(@nazwisko VARCHAR(15))
    RETURNS CHAR(11)
BEGIN
    RETURN (SELECT pesel FROM czytelnicy WHERE nazwisko = @nazwisko)
END
GO

SELECT dbo.pobierzpesel('Krawczyk')


-- PODPUNKT 16 --

DROP FUNCTION funkcja

GO
CREATE FUNCTION funkcja(@max INT)
    RETURNS TABLE
        RETURN (
        SELECT *
        FROM czytelnicy
        WHERE (year(getdate()) - year(data_ur)) < @max
    )
GO

SELECT *
FROM funkcja(60)
