-- KAMIL KOWALEWSKI 216806 --

USE biuro
GO

-- PODPUNKT 1. Napisz procedurę, która: dodaje nowego wlasciciela; wywoływana jest z 4 parametrami: imie, nazwisko, adres, telefon; numer wlasciciela bedzie generowany automatycznie (nalezy sprawdzic numery w tabeli; wybrac brakujacy i dopisac przedrostek); Napisz wywolanie procedury --

-- DROP PROCEDURE dodaj_wlasciciela
CREATE PROCEDURE dodaj_wlasciciela(@imie VARCHAR(15), @nazwisko VARCHAR(25),
                                   @adres VARCHAR(40), @telefon VARCHAR(15)) AS
BEGIN
    DECLARE @numer INT=01

    WHILE (concat('CO', convert(VARCHAR(3), @numer)) IN
           (SELECT wlascicielnr FROM biuro.dbo.wlasciciele))
        BEGIN
            SET @numer+=1
        END;
    INSERT INTO biuro.dbo.wlasciciele
    VALUES (concat('CO', convert(VARCHAR(2), @numer)), @imie, @nazwisko, @adres, @telefon)
END
GO

        dodaj_wlasciciela 'Kamil', 'Kowalewski',
        'Wolczanska 21, 91-237 Lodz', '123-456-789'

SELECT *
FROM biuro.dbo.wlasciciele;
GO

-- PODPUNKT 2. Napisz funkcję, która dla kaŜdego biura poda jego przychody z wynajmu. --
CREATE FUNCTION podaj_przychody_wynajmu()
    RETURNS @udzial TABLE (
        biuronr VARCHAR(4),
        udzial  FLOAT
    )
BEGIN
    INSERT INTO @udzial
    SELECT biuronr, sum(czynsz) AS suma_czynszu
    FROM biuro.dbo.nieruchomosci
    GROUP BY biuronr
    RETURN
END
GO

SELECT *
FROM podaj_przychody_wynajmu();
GO

-- PODPUNKT 3. Napisz wyzwalacz, który podczas wstawiania nowego rekordu do tabeli wynajecia, w przypadku, gdy podany czynsz jest wyzszy od maksymalnego podanego przez klienta: wprowadzi maksymalny czysz dla tego klienta; wypisze stosowny komunikat --

-- DROP TRIGGER czynsz_wynajecia
CREATE TRIGGER czynsz_wynajecia
    ON biuro.dbo.wynajecia
    FOR INSERT AS
BEGIN
    DECLARE @max_czynsz SMALLINT = (
                                       SELECT klien.max_czynsz
                                       FROM biuro.dbo.klienci klien, inserted inser
                                       WHERE klien.klientnr = inser.klientnr
                                   )

    IF ((SELECT czynsz FROM inserted) > @max_czynsz)
        BEGIN
            UPDATE biuro.dbo.wynajecia
            SET czynsz=@max_czynsz
            WHERE umowanr = (SELECT umowanr FROM inserted)
        END;
END;
GO

INSERT INTO biuro.dbo.wynajecia
VALUES (1118, 'B16', 'CO18', 1200, 'karta', 1200, 0, getdate(), getdate())

SELECT *
FROM biuro.dbo.wynajecia
WHERE umowanr = 1118;
GO

-- PODPUNKT 4. Napisz wyzwalacz, który przy wprowadzeniu nowego klienta, dodaje dla niego rejestrację z wybranym numerem pracownika. --

-- DROP TRIGGER wprowadz_nowego_klienta
CREATE TRIGGER wprowadz_nowego_klienta
    ON biuro.dbo.klienci
    FOR INSERT AS
BEGIN
    DECLARE @numer VARCHAR(4) = (
                                    SELECT
                                    TOP 1
                                    personelnr
                                    FROM biuro.dbo.personel
                                    ORDER BY newid()
                                )
    INSERT INTO biuro.dbo.rejestracje
    SELECT klientnr, biuronr, @numer, getdate()
    FROM inserted, biuro.dbo.personel
    WHERE personelnr = @numer
END;
GO


INSERT INTO biuro.dbo.klienci
VALUES ('CO20', 'Kamil', 'Kowalewski', 'Wolczanska 21, 91-237 Lodz',
        '123-456-789', 'mieszkanie', 700)

SELECT *
FROM biuro.dbo.rejestracje;

-- PODPUNKT 5. Napisz funkcję obliczającą prowizję dla każdego pracownika przyjmując następujące założenia: prowizja liczna jest w zakresie podanym przez uzytkownika (data_od data_do); za wizytę pracownik otrzymuje 2% pensji, za wynajęcie 10% --

-- DROP FUNCTION oblicz_prowizje
CREATE FUNCTION oblicz_prowizje(@data_od DATETIME, @data_do DATETIME)
    RETURNS @tabela TABLE (
        pracownik VARCHAR(4),
        prowwizja FLOAT
    )
BEGIN
    INSERT INTO @tabela
    SELECT pers.personelnr,
           count(wynaj.umowanr) * 0.10 * pers.pensja
               + count(wiz.data_wizyty) * 0.02 * pers.pensja
    FROM biuro.dbo.personel pers, biuro.dbo.wynajecia wynaj,
         biuro.dbo.nieruchomosci nieruchom, biuro.dbo.wizyty wiz
    WHERE nieruchom.personelnr = pers.personelnr
      AND wiz.nieruchomoscnr = nieruchom.nieruchomoscnr
      AND data_wizyty >= @data_od
      AND data_wizyty <= @data_do
      AND wynaj.nieruchomoscnr = nieruchom.nieruchomoscnr
      AND wynaj.od_kiedy <= @data_do
      AND wynaj.od_kiedy >= @data_od
    GROUP BY pers.personelnr, pers.pensja

    RETURN
END
GO

SELECT *
FROM oblicz_prowizje('1999 - 01 - 01', '2004 - 08 - 24');
GO

-- PODPUNKT 6. Napisz pracedurę, która wypisuje wszystkie niezaplacone nieruchomosci w postaci: Brak wplaty od .... (nazwisko najemcy) za nieruchomosc nr .... za okres .... miesiecy. Uporzadkuj je od najstarszej niezaplaconej. --

-- DROP PROCEDURE niezaplacone_nieruchomosci
CREATE PROCEDURE niezaplacone_nieruchomosci AS
BEGIN
    SELECT 'Brak wplaty od ' + klien.nazwisko + ' za nieruchomosc nr '
               + wynaj.nieruchomoscnr + ' za okres ' + convert(VARCHAR(3),
                   datediff(MONTH, wynaj.od_kiedy, wynaj.do_kiedy) + 1) + ' miesiecy'
    FROM biuro.dbo.klienci klien,
         (
             SELECT *
             FROM biuro.dbo.wynajecia
             WHERE zaplacona = 0
         ) AS wynaj
    WHERE wynaj.klientnr = klien.klientnr
    ORDER BY wynaj.od_kiedy ASC
END
GO

EXEC niezaplacone_nieruchomosci
GO
