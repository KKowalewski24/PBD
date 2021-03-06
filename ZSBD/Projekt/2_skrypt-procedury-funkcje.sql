-- AUTORZY: --
-- MICHAŁ KIDAWA    216796 --
-- KAMIL KOWALEWSKI 216806 --

------------------------------------------------------------
/*
-- SPIS PROCEDUR I FUNKCJI

-- PROCEDURY
-- 1. [najpopularniejszy_pokoj_na_pietrze] - najczesciej rezerwowany pokoj na danym pietrze

-- 2. [popraw_bledna_liczbe_osob_w_rejestracji] - poprawia rejestracje, ktore nie byly poprawnie
        zarejestwoane (zbyt duza liczba osob) oraz drukuje komunikat, które z nich są niepoprawne

-- 3. [archiwizuj_rezerwacje] - przenosi archiwalne rezerwacje do tabeli rezerwacje_hist

-- 4. [oplaty_dla_pracownikow] - dla pracownikow w danym miesiacu z danego roku

-- 5. [usun_pracownika_po_numerze] - usuwa konkretnego (wskazanego przez numer przy wywolaniu)
        pracownika z tabeli pracownicy

-- FUNKCJE
-- 1. [sprawdz_dostepnosc_pokoju] - sprawdza czy pokoj o podanym numerze jest wolny od podanej daty
        przez podana liczbe dni

-- 2. [wylicz_cene_rezerwacji_po_numerze] - wylicza cenę danej rezerwacji, jako parametr jej numer

-- WYZWALACZE
-- 1. [zatwierdz_rezerwacje] - sprawdzanie poprawnosci dodawanych rezerwacji na podstawie funkcji
        sprawdz_dostepnosc_pokoju i akceptacja tylko poprawnych - wolnym pokoj w wybranych czasie

-- 2. [proponuj_lepsze_pokoje] - w czasie tworzenie rezerwacji proponuje lepsze pokoje
        (posiadaja przynajmniej te same cechy)

-- 3. [sprawdz_awans_klienta] - sprawdza czy klient nie awansował na wyzszy typ gdy wypożyczenie
        pokoju zostanie przeniesione do archiwalnych
 */
------------------------------------------------------------

USE baza_hotel
GO

-- PROCEDURA 1 --
IF exists(SELECT 1
          FROM sysobjects
          WHERE name = 'najpopularniejszy_pokoj_na_pietrze')
    DROP PROCEDURE najpopularniejszy_pokoj_na_pietrze
GO

CREATE PROCEDURE najpopularniejszy_pokoj_na_pietrze(@pietro INT)
AS
BEGIN
    DECLARE @pokoj INT
    SELECT @pokoj = pokoj_nr
    FROM rezerwacje_hist
    WHERE pokoj_nr / 100 = @pietro
    GROUP BY pokoj_nr
    HAVING count(pokoj_nr) =
           (
               SELECT
               TOP 1
               count(pokoj_nr) AS 'wystapienia'
               FROM rezerwacje_hist
               WHERE pokoj_nr / 100 = @pietro
               GROUP BY pokoj_nr
               ORDER BY wystapienia DESC
           )

    PRINT 'Na piętrze ' + convert(CHAR(1), @pietro) +
          ' najczesciej rezerwowanym pokojem jest pokoj o numerze ' + convert(CHAR(3), @pokoj)
END
GO

-- PROCEDURA 2 --
IF EXISTS(SELECT 1
          FROM sysobjects
          WHERE name = 'popraw_bledna_liczbe_osob_w_rejestracji')
    DROP PROCEDURE popraw_bledna_liczbe_osob_w_rejestracji
GO

CREATE PROCEDURE popraw_bledna_liczbe_osob_w_rejestracji
AS
BEGIN
    DECLARE kursor CURSOR FOR SELECT rezerwacja_nr, pokoj_nr, liczba_osob FROM rezerwacje

    DECLARE @nr_r INT, @nr_p INT, @ile INT, @ilosc INT

    OPEN kursor
    FETCH NEXT FROM kursor INTO @nr_r, @nr_p, @ile

    WHILE @@FETCH_STATUS = 0
        BEGIN
            SET @ilosc = (SELECT liczba_osob FROM pokoje WHERE @nr_p = pokoj_nr)

            IF (@ile > @ilosc)
                BEGIN
                    PRINT 'Poprawiam liczbe osob w rezerwacji ' + CONVERT(VARCHAR(4), @nr_r) +
                          '(pokoj ' + CONVERT(VARCHAR(3), @nr_p) + ' z ' +
                          CONVERT(VARCHAR(5), @ile) + ' na ' + CONVERT(VARCHAR(1), @ilosc) + ')'
                    UPDATE rezerwacje SET liczba_osob = @ilosc WHERE rezerwacja_nr = @nr_r
                END
            FETCH NEXT FROM kursor INTO @nr_r, @nr_p, @ile
        END

    CLOSE kursor
    DEALLOCATE kursor
END
GO

-- PROCEDURA 3 --
IF EXISTS(SELECT 1
          FROM sysobjects
          WHERE name = 'archiwizuj_rezerwacje')
    DROP PROCEDURE archiwizuj_rezerwacje
GO

CREATE PROCEDURE archiwizuj_rezerwacje
AS
BEGIN
    INSERT INTO rezerwacje_hist
    SELECT rezerwacja_nr, klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji,
           DATEADD(DAY, liczba_dni, poczatek_rezerwacji)
    FROM rezerwacje
    WHERE DAY(GETDATE()) > DAY(poczatek_rezerwacji) + liczba_dni

    DELETE FROM rezerwacje WHERE DAY(GETDATE()) > DAY(poczatek_rezerwacji) + liczba_dni
END
GO

-- PROCEDURA 4 --
IF EXISTS(SELECT 1
          FROM sysobjects
          WHERE name = 'oplaty_dla_pracownikow')
    DROP PROCEDURE oplaty_dla_pracownikow
GO

CREATE PROCEDURE oplaty_dla_pracownikow(@rok VARCHAR(4), @miesiac VARCHAR(20))
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

    DECLARE kursor CURSOR FOR SELECT placa, data_zatrudnienia, data_zwolnienia FROM pracownicy_hist
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

-- PROCEDURA 5 --
IF EXISTS(SELECT 1
          FROM sysobjects
          WHERE name = 'usun_pracownika_po_numerze')
    DROP PROCEDURE usun_pracownika_po_numerze
GO

CREATE PROCEDURE usun_pracownika_po_numerze(@numer INT)
AS
BEGIN
    UPDATE pracownicy SET data_zwolnienia = GETDATE() WHERE pracownik_nr = @numer
    INSERT INTO pracownicy_hist SELECT * FROM pracownicy WHERE pracownik_nr = @numer
    DELETE FROM pracownicy WHERE pracownik_nr = @numer
END
GO

----------------------------------------------------------------------------------------------------

-- FUNKCJA 1 --
IF exists(SELECT 1
          FROM sysobjects
          WHERE name = 'sprawdz_dostepnosc_pokoju')
    DROP FUNCTION sprawdz_dostepnosc_pokoju
GO

CREATE FUNCTION sprawdz_dostepnosc_pokoju(@pokoj INT, @poczatek DATE, @ile_dni INT)
    RETURNS BIT
AS
BEGIN
    IF exists
        (
            SELECT *
            FROM rezerwacje
            WHERE @pokoj = pokoj_nr
              AND (
                    (@poczatek >= poczatek_rezerwacji AND
                     @poczatek <= dateadd(DAY, liczba_dni, poczatek_rezerwacji))
                    OR
                    (dateadd(DAY, @ile_dni, @poczatek) >= poczatek_rezerwacji AND
                     dateadd(DAY, @ile_dni, @poczatek) <=
                     dateadd(DAY, liczba_dni, poczatek_rezerwacji))
                    OR
                    (@poczatek <= poczatek_rezerwacji AND
                     dateadd(DAY, @ile_dni, @poczatek) >=
                     dateadd(DAY, liczba_dni, poczatek_rezerwacji))
                )
        )
        RETURN 0

    RETURN 1
END
GO

-- FUNKCJA 2 --
IF EXISTS(SELECT 1
          FROM sysobjects
          WHERE name = 'wylicz_cene_rezerwacji_po_numerze')
    DROP FUNCTION wylicz_cene_rezerwacji_po_numerze
GO

CREATE FUNCTION wylicz_cene_rezerwacji_po_numerze(@nr INT)
    RETURNS INT
AS
BEGIN
    DECLARE @suma INT
    SET @suma = 0
    IF EXISTS(SELECT rezerwacja_nr FROM rezerwacje WHERE rezerwacja_nr = @nr)
        BEGIN
            SET @suma += ((
                              SELECT cena
                              FROM rezerwacje AS r, pokoje AS p
                              WHERE r.rezerwacja_nr = @nr
                                AND r.pokoj_nr = p.pokoj_nr
                          ) *
                          (SELECT liczba_dni FROM rezerwacje WHERE rezerwacja_nr = @nr))

            IF EXISTS(SELECT typ
                      FROM klienci AS k, rezerwacje AS r
                      WHERE typ = 2
                        AND r.klient_nr = k.klient_nr
                        AND r.rezerwacja_nr = @nr)
                SET @suma = @suma * 0.9

            IF EXISTS(SELECT typ
                      FROM klienci AS k, rezerwacje AS r
                      WHERE typ = 3
                        AND r.klient_nr = k.klient_nr
                        AND r.rezerwacja_nr = @nr)
                SET @suma = @suma * 0.8

            RETURN @suma
        END

    ELSE
        SET @suma += ((
                          SELECT cena
                          FROM rezerwacje_hist AS br, pokoje AS p
                          WHERE br.rezerwacja_nr = @nr
                            AND br.pokoj_nr = p.pokoj_nr
                      ) *
                      (
                          SELECT DATEDIFF(DAY, poczatek_rezerwacji, koniec_rezerwacji)
                          FROM rezerwacje_hist
                          WHERE rezerwacja_nr = @nr
                      ))

    IF EXISTS(SELECT typ
              FROM klienci AS k, rezerwacje_hist AS br
              WHERE typ = 2
                AND br.klient_nr = k.klient_nr
                AND br.rezerwacja_nr = @nr)
        SET @suma = @suma * 0.9

    IF EXISTS(SELECT typ
              FROM klienci AS k, rezerwacje_hist AS br
              WHERE typ = 3
                AND br.klient_nr = k.klient_nr
                AND br.rezerwacja_nr = @nr)
        SET @suma = @suma * 0.8

    RETURN @suma
END
GO

----------------------------------------------------------------------------------------------------

-- WYZWALACZ 1 --
IF exists(SELECT 1
          FROM sysobjects
          WHERE name = 'zatwierdz_rezerwacje')
    DROP TRIGGER zatwierdz_rezerwacje
GO

CREATE TRIGGER zatwierdz_rezerwacje
    ON rezerwacje
    INSTEAD OF INSERT
    AS
BEGIN
    DECLARE autoryzacja CURSOR FOR
        SELECT klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni FROM inserted
    DECLARE @klient INT, @pokoj INT, @liczba_osob INT, @poczatek_rezerwacji DATE, @liczba_dni INT
    OPEN autoryzacja
    FETCH NEXT FROM autoryzacja INTO @klient, @pokoj, @liczba_osob, @poczatek_rezerwacji, @liczba_dni
    WHILE @@FETCH_STATUS = 0
        BEGIN
            BEGIN TRANSACTION
                IF (dbo.sprawdz_dostepnosc_pokoju(@pokoj, @poczatek_rezerwacji, @liczba_dni) = 0)
                    BEGIN
                        PRINT 'Err: Pokoj ' + convert(VARCHAR(3), @pokoj) +
                              ' jest zajety w żądanym okresie (od ' +
                              convert(VARCHAR(20), @poczatek_rezerwacji) + ' do ' +
                              convert(VARCHAR(20),
                                      dateadd(DAY, @liczba_dni, @poczatek_rezerwacji)) + ')'
                        ROLLBACK
                    END
                ELSE
                    BEGIN
                        INSERT INTO rezerwacje
                        VALUES (@klient, @pokoj, @liczba_osob, @poczatek_rezerwacji, @liczba_dni)
                        COMMIT
                    END
                FETCH NEXT FROM autoryzacja INTO @klient, @pokoj, @liczba_osob, @poczatek_rezerwacji, @liczba_dni
        END
    CLOSE autoryzacja
    DEALLOCATE autoryzacja
END
GO


-- WYZWALACZ 2 --
IF EXISTS(SELECT 1
          FROM sysobjects
          WHERE name = 'proponuj_lepsze_pokoje')
    DROP TRIGGER proponuj_lepsze_pokoje
GO

CREATE TRIGGER proponuj_lepsze_pokoje
    ON rezerwacje
    FOR INSERT
    AS
BEGIN
    DECLARE @nr_p INT, @il_o INT, @cena INT, @c_w BIT, @c_s BIT, @nr_r INT = (SELECT i.rezerwacja_nr FROM inserted AS i)

    PRINT ' Rezerwacja ' + CONVERT(VARCHAR(5), @nr_r)

    DECLARE kursor CURSOR FOR SELECT pokoj_nr, liczba_osob, cena, czy_jest_wanna, czy_jest_sejf
                              FROM pokoje
    OPEN kursor
    FETCH NEXT FROM kursor INTO @nr_p, @il_o, @cena, @c_w, @c_s

    WHILE @@FETCH_STATUS = 0
        BEGIN
            DECLARE @cceennaa INT = (
                                        SELECT p.cena
                                        FROM pokoje AS p, inserted AS i
                                        WHERE i.pokoj_nr = p.pokoj_nr
                                    )

            IF ((@cena <= @cceennaa) AND (@nr_p NOT IN (
                                                           SELECT r.pokoj_nr
                                                           FROM rezerwacje AS r, inserted AS i
                                                           WHERE ((i.poczatek_rezerwacji >
                                                                   DATEADD(DAY, r.liczba_dni, r.poczatek_rezerwacji)) OR
                                                                  (DATEADD(DAY, i.liczba_dni, i.poczatek_rezerwacji) <
                                                                   r.poczatek_rezerwacji))
                                                       )))
                BEGIN
                    DECLARE @opis VARCHAR(200) = ''

                    IF (@cena < @cceennaa)
                        SET @opis = 'pokoj jest tanszy o ' +
                                    CONVERT(VARCHAR(5), (@cceennaa - @cena))

                    IF (@il_o < (
                                    SELECT p.liczba_osob
                                    FROM pokoje AS p, inserted AS i
                                    WHERE i.pokoj_nr = p.pokoj_nr
                                ))
                        BEGIN
                            IF @opis <> ''
                                SET @opis = @opis + ', miesci sie wiecej osob'
                            ELSE
                                SET @opis = @opis + 'miesci sie wiecej osob'
                        END


                    IF (@c_s < (
                                   SELECT p.czy_jest_sejf
                                   FROM pokoje AS p, inserted AS i
                                   WHERE i.pokoj_nr = p.pokoj_nr
                               ))
                        BEGIN
                            IF @opis <> ''
                                SET @opis = @opis + ', jest sejf'
                            ELSE
                                SET @opis = @opis + 'jest sejf'
                        END


                    IF (@c_w < (
                                   SELECT p.czy_jest_wanna
                                   FROM pokoje AS p, inserted AS i
                                   WHERE i.pokoj_nr = p.pokoj_nr
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


-- WYZWALACZ 3 --
IF exists(SELECT 1
          FROM sysobjects
          WHERE name = 'sprawdz_awans_klienta')
    DROP TRIGGER sprawdz_awans_klienta
GO


CREATE TRIGGER sprawdz_awans_klienta
    ON rezerwacje_hist
    AFTER INSERT
    AS
BEGIN
    -- STALE ODPOWIEDZIALNE ZA LICZBE REZERWACJI POTRZEBNE DO AWANSU --
    DECLARE @silver INT = 5
    DECLARE @gold INT = 10
    -------------------------------------------------------------------

    DECLARE awans CURSOR FOR
        SELECT klient_nr FROM inserted
    DECLARE @id INT, @ilosc_rezerwacji INT
    OPEN awans
    FETCH NEXT FROM awans INTO @id
    WHILE @@FETCH_STATUS = 0
        BEGIN
            SELECT @ilosc_rezerwacji = count(*)
            FROM rezerwacje_hist
            WHERE klient_nr = @id

            IF @ilosc_rezerwacji > @gold
                UPDATE klienci
                SET typ = 3
                WHERE klient_nr = @id
            ELSE
                IF @ilosc_rezerwacji > @silver
                    UPDATE klienci
                    SET typ = 2
                    WHERE klient_nr = @id
            FETCH NEXT FROM awans INTO @id
        END
    CLOSE awans
    DEALLOCATE awans
END
GO
