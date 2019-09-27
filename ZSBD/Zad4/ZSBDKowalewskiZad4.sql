-- KAMIL KOWALEWSKI 216806 --

-- PODPUNKT 1 --
DECLARE @greeting VARCHAR(25) ='Czesc, to ja'
PRINT @greeting

-- PODPUNKT 2 --
DECLARE @number INT=5
PRINT 'Zmienna = ' + convert(VARCHAR(25), @number)

-- PODPUNKT 3 --
DECLARE @num_value INT=15

IF (@num_value = 15)
    PRINT 'Wartosc zmiennej to 15'
ELSE
    PRINT 'wartosc zmiennej jest rozna od 15'

-- PODPUNKT 4 --
DECLARE @iterator_1 INT=1

WHILE (@iterator_1 < 5)
    BEGIN
        PRINT 'Zmienna ma wartosc ' + convert(VARCHAR(2), @iterator_1)
        SET @iterator_1 = @iterator_1 + 1
    END;

-- PODPUNKT 5 --
DECLARE @iterator_2 INT=3

WHILE (@iterator_2 <= 7)
    BEGIN
        IF (@iterator_2 = 3)
            PRINT 'Poczatek'

        IF (@iterator_2 = 5)
            PRINT 'Srodek'

        IF (@iterator_2 = 7)
            PRINT 'Koniec'

        PRINT @iterator_2
        SET @iterator_2 = @iterator_2 + 1
    END;

-- PODPUNKT 6 --
IF EXISTS(SELECT 1
          FROM master.dbo.sysdatabases
          WHERE name = 'sample_datebase')
    DROP DATABASE sample_datebase
GO

CREATE DATABASE sample_datebase
GO

CREATE TABLE sample_datebase.dbo.oddzialy (
    nr_odd    INT,
    nazwa_odd VARCHAR(30)
)
GO

-- PODPUNKT 7 --
INSERT INTO sample_datebase.dbo.oddzialy
VALUES (1, 'Ksiegowosc')

DECLARE @id INT=1, @nazwa VARCHAR(40)

BEGIN
    SELECT @nazwa = nazwa_odd FROM sample_datebase.dbo.oddzialy WHERE nr_odd = @id
    PRINT @nazwa
END;

-- PODPUNKT 8 --
DECLARE @iterator_3 INT=0, @nazwa_3 VARCHAR(40)

WHILE exists(SELECT *
             FROM sample_datebase.dbo.oddzialy
             WHERE nr_odd > @iterator_3)
    BEGIN
        SET @iterator_3 = @iterator_3 + 1
        IF exists(SELECT * FROM sample_datebase.dbo.oddzialy WHERE nr_odd = @iterator_3)
            BEGIN
                SELECT @nazwa_3 = nazwa_odd
                FROM sample_datebase.dbo.oddzialy
                WHERE nr_odd = @iterator_3
                PRINT 'Numer odzialu to: ' + convert(VARCHAR(10), @iterator_3)
                    + ', Nazwa odzialu to: ' + @nazwa_3
            END;
    END;

-- PODPUNKT 9 --
DECLARE @iterator_4 INT=2, @numer_4 INT=2
BEGIN
    WHILE exists(SELECT * FROM sample_datebase.dbo.oddzialy WHERE nr_odd > @numer_4)
        BEGIN
            SET @iterator_4 = @iterator_4 + 1
            DELETE FROM sample_datebase.dbo.oddzialy WHERE nr_odd = @iterator_4
        END;
    PRINT 'Liczba usunietych rekordow to: ' + convert(VARCHAR(10), (@iterator_4 - @numer_4))
END;

-- PODPUNKT 10 --
DECLARE @numer_5 INT=3

BEGIN
    IF exists(SELECT * FROM sample_datebase.dbo.oddzialy WHERE nr_odd = @numer_5)
        UPDATE sample_datebase.dbo.oddzialy SET nazwa_odd='Magazyn' WHERE nr_odd = @numer_5
    ELSE
        INSERT INTO sample_datebase.dbo.oddzialy VALUES (3, 'Budowlanka')
END;

SELECT *
FROM sample_datebase.dbo.oddzialy
WHERE nr_odd = 3;
