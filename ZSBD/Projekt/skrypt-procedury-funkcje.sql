-- AUTORZY: --
-- MICHAŁ KIDAWA    216796 --
-- KAMIL KOWALEWSKI 216806 --

------------------------------------------------------------
/*
-- SPIS PROCEDUR I FUNKCJI

-- PROCEDURY
-- 1. przenosi archwailne rezerwacje do tabeli byle_rezerwacje
-- 2. usuwa konkretnego (wskazanego przez numer przy wywolaniu) pracownika z tabeli pracownicy
-- 3. poprawia rejestracje, ktore nie byly poprawnie zarejestwoane (zbyt duza liczba osob)
        oraz drukuje komunikat, które z nich są niepoprawne
-- 4. najczesciej rezerwowany pokoj na danym pietrze
-- 5. oplaty dla pracownikow w danym miesiacu z danego roku

-- FUNKCJE
-- 1. oblicza cenę danej rezerwacji
-- 2. sprawdzenie czy pokoj jest wolny w danym czasie

-- WYZWALACZE
-- 1. po zarchiwizowaniu wypozyczenia sprawdzane jest, czy klient nie awansowal do nowego typu
-- 2. rozpatrywanie dodawanych rezerwacji i akcetowanie tylko tych o dostepnych pokojach w zadanym czasie
-- 3. podczas rezerwacji proponuje lepsze pokoje które lepiej spełniają wymagania (posiadają
        przynajmniej te same cechy,

 */
------------------------------------------------------------

USE hotel
GO

-- PROCEDURA 1 --
IF EXISTS(SELECT 1
          FROM sysobjects
          WHERE name = 'rezerwacje_archiwalne')
    DROP PROCEDURE rezerwacje_archiwalne
GO

CREATE PROCEDURE rezerwacje_archiwalne
AS
BEGIN
    INSERT INTO byle_rezerwacje
    SELECT nr_rezerwacji, nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji,
           DATEADD(DAY, dni, poczatek_rezerwacji)
    FROM rezerwacje
    WHERE DAY(GETDATE()) > DAY(poczatek_rezerwacji) + dni

    DELETE FROM rezerwacje WHERE DAY(GETDATE()) > DAY(poczatek_rezerwacji) + dni
END
GO


-- PROCEDURA 2 --
IF EXISTS(SELECT 1
          FROM sysobjects
          WHERE name = 'usun_pracownika')
    DROP PROCEDURE usun_pracownika
GO

CREATE PROCEDURE usun_pracownika(@numer INT)
AS
BEGIN
    UPDATE pracownicy SET data_zwolnienia = GETDATE() WHERE nr_pracownika = @numer
    INSERT INTO byli_pracownicy SELECT * FROM pracownicy WHERE nr_pracownika = @numer
    DELETE FROM pracownicy WHERE nr_pracownika = @numer
END
GO


-- PROCEDURA 3 --
IF EXISTS(SELECT 1
          FROM sysobjects
          WHERE name = 'poprawnosc_rejestracji_osoby')
    DROP PROCEDURE poprawnosc_rejestracji_osoby
GO

CREATE PROCEDURE poprawnosc_rejestracji_osoby
AS
BEGIN
    DECLARE kursor CURSOR FOR SELECT nr_rezerwacji, nr_pokoju, ile_osob FROM rezerwacje

    DECLARE @nr_r INT, @nr_p INT, @ile INT, @ilosc INT

    OPEN kursor
    FETCH NEXT FROM kursor INTO @nr_r, @nr_p, @ile

    WHILE @@FETCH_STATUS = 0
        BEGIN
            SET @ilosc = (SELECT ilosc_osob FROM pokoje WHERE @nr_p = nr_pokoju)

            IF (@ile > @ilosc)
                BEGIN
                    PRINT 'Poprawiam ilosc osob w rezerwacji ' + CONVERT(VARCHAR(4), @nr_r) +
                          '(pokoj ' + CONVERT(VARCHAR(3), @nr_p) + ' z ' +
                          CONVERT(VARCHAR(5), @ile) + ' na ' + CONVERT(VARCHAR(1), @ilosc) + ')'
                    UPDATE rezerwacje SET ile_osob = @ilosc WHERE nr_rezerwacji = @nr_r
                END
            FETCH NEXT FROM kursor INTO @nr_r, @nr_p, @ile
        END

    CLOSE kursor
    DEALLOCATE kursor
END
GO

-- PROCEDURA 4 --

IF exists(SELECT 1
          FROM sysobjects
          WHERE name = 'najczestszy_pokoj')
    DROP PROCEDURE najczestszy_pokoj
GO

CREATE PROCEDURE najczestszy_pokoj(@pietro INT)
AS
BEGIN
    DECLARE @pokoj INT
    SELECT @pokoj = nr_pokoju
    FROM byle_rezerwacje
    WHERE nr_pokoju / 100 = @pietro
    GROUP BY nr_pokoju
    HAVING count(nr_pokoju) =
           (
               SELECT
               TOP 1
               count(nr_pokoju) AS 'wystapienia'
               FROM byle_rezerwacje
               WHERE nr_pokoju / 100 = @pietro
               GROUP BY nr_pokoju
               ORDER BY wystapienia DESC
           )

    PRINT 'Na piętrze ' + convert(CHAR(1), @pietro) +
          ' najczesciej rezerwowanym pokojem jest pokoj o numerze ' + convert(CHAR(3), @pokoj)
END
GO

-- PROCEDURA 5 --
IF EXISTS(SELECT 1
          FROM sysobjects
          WHERE name = 'oplaty')
    DROP PROCEDURE oplaty
GO

CREATE PROCEDURE oplaty(@rok VARCHAR(4), @miesiac VARCHAR(20))
AS
BEGIN
    DECLARE @zysk INT = 0
    DECLARE @placa INT, @data_zatrudnienia DATE, @data_zwolnienia DATE

    DECLARE kursor CURSOR FOR SELECT placa, data_zatrudnienia FROM pracownicy
    OPEN kursor
    FETCH NEXT FROM kursor INTO @placa, @data_zatrudnienia

    WHILE @@FETCH_STATUS = 0
        BEGIN
            IF ((DATENAME(YY, @data_zatrudnienia) < @rok) AND
                (DATENAME(MM, @data_zatrudnienia) < @miesiac))
                SET @zysk = @zysk + @placa

            FETCH NEXT FROM kursor INTO @placa, @data_zatrudnienia
        END

    CLOSE kursor
    DEALLOCATE kursor

    DECLARE kursor CURSOR FOR SELECT placa, data_zatrudnienia, data_zwolnienia FROM byli_pracownicy
    OPEN kursor
    FETCH NEXT FROM kursor INTO @placa, @data_zatrudnienia, @data_zwolnienia

    WHILE @@FETCH_STATUS = 0
        BEGIN
            IF (@rok BETWEEN DATENAME(YY, @data_zatrudnienia) AND DATENAME(YY, @data_zwolnienia))
                AND
               (@miesiac BETWEEN DATENAME(MM, @data_zatrudnienia) AND DATENAME(MM, @data_zwolnienia))
                SET @zysk = @zysk + @placa

            FETCH NEXT FROM kursor INTO @placa, @data_zatrudnienia, @data_zwolnienia
        END

    CLOSE kursor
    DEALLOCATE kursor

    PRINT ('Oplaty dla pracownikow w roku ' + @rok + ', miesiacu ' + @miesiac + ': ' +
           CAST(@zysk AS VARCHAR(100)))
END
GO


-- FUNKCJA 1 --
IF EXISTS(SELECT 1
          FROM sysobjects
          WHERE name = 'cena_rezerwacji')
    DROP FUNCTION cena_rezerwacji
GO

CREATE FUNCTION cena_rezerwacji(@nr INT)
    RETURNS INT
AS
BEGIN
    DECLARE @suma INT
    SET @suma = 0
    IF EXISTS(SELECT nr_rezerwacji FROM rezerwacje WHERE nr_rezerwacji = @nr)
        BEGIN
            SET @suma += ((
                              SELECT cena
                              FROM rezerwacje AS r, pokoje AS p
                              WHERE r.nr_rezerwacji = @nr
                                AND r.nr_pokoju = p.nr_pokoju
                          ) *
                          (SELECT dni FROM rezerwacje WHERE nr_rezerwacji = @nr))

            IF EXISTS(SELECT typ
                      FROM klienci AS k, rezerwacje AS r
                      WHERE typ = 2
                        AND r.nr_klienta = k.nr_klienta
                        AND r.nr_rezerwacji = @nr)
                SET @suma = @suma * 0.9

            IF EXISTS(SELECT typ
                      FROM klienci AS k, rezerwacje AS r
                      WHERE typ = 3
                        AND r.nr_klienta = k.nr_klienta
                        AND r.nr_rezerwacji = @nr)
                SET @suma = @suma * 0.8

            RETURN @suma
        END

    ELSE
        SET @suma += ((
                          SELECT cena
                          FROM byle_rezerwacje AS br, pokoje AS p
                          WHERE br.nr_rezerwacji = @nr
                            AND br.nr_pokoju = p.nr_pokoju
                      ) *
                      (
                          SELECT DATEDIFF(DAY, poczatek_rezerwacji, koniec_rezerwacji)
                          FROM byle_rezerwacje
                          WHERE nr_rezerwacji = @nr
                      ))

    IF EXISTS(SELECT typ
              FROM klienci AS k, byle_rezerwacje AS br
              WHERE typ = 2
                AND br.nr_klienta = k.nr_klienta
                AND br.nr_rezerwacji = @nr)
        SET @suma = @suma * 0.9

    IF EXISTS(SELECT typ
              FROM klienci AS k, byle_rezerwacje AS br
              WHERE typ = 3
                AND br.nr_klienta = k.nr_klienta
                AND br.nr_rezerwacji = @nr)
        SET @suma = @suma * 0.8

    RETURN @suma
END
GO

-- FUNKCJA 2 --
IF exists(SELECT 1
          FROM sysobjects
          WHERE name = 'dostepnosc_pokoju')
    DROP FUNCTION dostepnosc_pokoju
GO

CREATE FUNCTION dostepnosc_pokoju(@pokoj INT, @poczatek DATE, @ile_dni INT)
    RETURNS BIT
AS
BEGIN
    IF exists
        (
            SELECT *
            FROM rezerwacje
            WHERE @pokoj = nr_pokoju
              AND (
                    (@poczatek >= poczatek_rezerwacji AND
                     @poczatek <= dateadd(DAY, dni, poczatek_rezerwacji))
                    OR
                    (dateadd(DAY, @ile_dni, @poczatek) >= poczatek_rezerwacji AND
                     dateadd(DAY, @ile_dni, @poczatek) <= dateadd(DAY, dni, poczatek_rezerwacji))
                    OR
                    (@poczatek <= poczatek_rezerwacji AND
                     dateadd(DAY, @ile_dni, @poczatek) >= dateadd(DAY, dni, poczatek_rezerwacji))
                )
        )
        RETURN 0

    RETURN 1
END
GO

-- WYZWALACZ 1 --
IF exists(SELECT 1
          FROM sysobjects
          WHERE name = 'awans_klienta')
    DROP TRIGGER awans_klienta
GO


CREATE TRIGGER awans_klienta
    ON byle_rezerwacje
    AFTER INSERT
    AS
BEGIN
    --------------tu mozna zmienic ilosc rezerwacji potrzebnych na awans-----------
    DECLARE @silver INT = 5
    DECLARE @gold INT = 10
    -------------------------------------------------------------------------------

    DECLARE awans CURSOR FOR
        SELECT nr_klienta FROM inserted
    DECLARE @id INT, @ilosc_rezerwacji INT
    OPEN awans
    FETCH NEXT FROM awans INTO @id
    WHILE @@FETCH_STATUS = 0
        BEGIN
            SELECT @ilosc_rezerwacji = count(*)
            FROM byle_rezerwacje
            WHERE nr_klienta = @id

            IF @ilosc_rezerwacji > @gold
                UPDATE klienci
                SET typ = 3
                WHERE nr_klienta = @id
            ELSE
                IF @ilosc_rezerwacji > @silver
                    UPDATE klienci
                    SET typ = 2
                    WHERE nr_klienta = @id
            FETCH NEXT FROM awans INTO @id
        END
    CLOSE awans
    DEALLOCATE awans
END
GO


-- WYZWALACZ 2 --
IF exists(SELECT 1
          FROM sysobjects
          WHERE name = 'autoryzacja_rezerwacji')
    DROP TRIGGER autoryzacja_rezerwacji
GO

CREATE TRIGGER autoryzacja_rezerwacji
    ON rezerwacje
    INSTEAD OF INSERT
    AS
BEGIN
    DECLARE autoryzacja CURSOR FOR
        SELECT nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni FROM inserted
    DECLARE @klient INT, @pokoj INT, @ile_osob INT, @poczatek_rezerwacji DATE, @dni INT
    OPEN autoryzacja
    FETCH NEXT FROM autoryzacja INTO @klient, @pokoj, @ile_osob, @poczatek_rezerwacji, @dni
    WHILE @@FETCH_STATUS = 0
        BEGIN
            BEGIN TRANSACTION
                IF (dbo.dostepnosc_pokoju(@pokoj, @poczatek_rezerwacji, @dni) = 0)
                    BEGIN
                        PRINT 'Err: Pokoj ' + convert(VARCHAR(3), @pokoj) +
                              ' jest zajety w żądanym okresie (od ' +
                              convert(VARCHAR(20), @poczatek_rezerwacji) + ' do ' +
                              convert(VARCHAR(20), dateadd(DAY, @dni, @poczatek_rezerwacji)) + ')'
                        ROLLBACK
                    END
                ELSE
                    BEGIN
                        INSERT INTO rezerwacje
                        VALUES (@klient, @pokoj, @ile_osob, @poczatek_rezerwacji, @dni)
                        COMMIT
                    END
                FETCH NEXT FROM autoryzacja INTO @klient, @pokoj, @ile_osob, @poczatek_rezerwacji, @dni
        END
    CLOSE autoryzacja
    DEALLOCATE autoryzacja
END
GO


-- WYZWALACZ 3 --
IF EXISTS(SELECT 1
          FROM sysobjects
          WHERE name = 'tansze_pokoje')
    DROP TRIGGER tansze_pokoje
GO

CREATE TRIGGER tansze_pokoje
    ON rezerwacje
    FOR INSERT
    AS
BEGIN
    DECLARE @nr_p INT, @il_o INT, @cena INT, @c_w BIT, @c_s BIT, @nr_r INT = (SELECT i.nr_rezerwacji FROM inserted AS i)

    PRINT ' Rezerwacja ' + CONVERT(VARCHAR(5), @nr_r)

    DECLARE kursor CURSOR FOR SELECT nr_pokoju, ilosc_osob, cena, czy_wanna, czy_sejf FROM pokoje
    OPEN kursor
    FETCH NEXT FROM kursor INTO @nr_p, @il_o, @cena, @c_w, @c_s

    WHILE @@FETCH_STATUS = 0
        BEGIN
            DECLARE @cceennaa INT = (
                                        SELECT p.cena
                                        FROM pokoje AS p, inserted AS i
                                        WHERE i.nr_pokoju = p.nr_pokoju
                                    )

            IF ((@cena <= @cceennaa) AND (@nr_p NOT IN (
                                                           SELECT r.nr_pokoju
                                                           FROM rezerwacje AS r, inserted AS i
                                                           WHERE ((i.poczatek_rezerwacji >
                                                                   DATEADD(DAY, r.dni, r.poczatek_rezerwacji)) OR
                                                                  (DATEADD(DAY, i.dni, i.poczatek_rezerwacji) <
                                                                   r.poczatek_rezerwacji))
                                                       )))
                BEGIN
                    DECLARE @opis VARCHAR(200) = ''

                    IF (@cena < @cceennaa)
                        SET @opis = 'pokoj jest tanszy o ' +
                                    CONVERT(VARCHAR(5), (@cceennaa - @cena))

                    IF (@il_o < (
                                    SELECT p.ilosc_osob
                                    FROM pokoje AS p, inserted AS i
                                    WHERE i.nr_pokoju = p.nr_pokoju
                                ))
                        BEGIN
                            IF @opis <> ''
                                SET @opis = @opis + ', miesci sie wiecej osob'
                            ELSE
                                SET @opis = @opis + 'miesci sie wiecej osob'
                        END


                    IF (@c_s < (
                                   SELECT p.czy_sejf
                                   FROM pokoje AS p, inserted AS i
                                   WHERE i.nr_pokoju = p.nr_pokoju
                               ))
                        BEGIN
                            IF @opis <> ''
                                SET @opis = @opis + ', jest sejf'
                            ELSE
                                SET @opis = @opis + 'jest sejf'
                        END


                    IF (@c_w < (
                                   SELECT p.czy_wanna
                                   FROM pokoje AS p, inserted AS i
                                   WHERE i.nr_pokoju = p.nr_pokoju
                               ))
                        BEGIN
                            IF @opis <> ''
                                SET @opis = @opis + ', jest wanna'
                            ELSE
                                SET @opis = @opis + 'jest wanna'
                        END


                    IF @opis <> ''
                        PRINT '   Pokoj ' + CONVERT(VARCHAR(3), @nr_p) +
                              ' jest lepszym pokojem do wynajęcia, ponieważ: ' + @opis + '.'

                END
            FETCH NEXT FROM kursor INTO @nr_p, @il_o, @cena, @c_w, @c_s
        END
    CLOSE kursor
    DEALLOCATE kursor
END
GO
