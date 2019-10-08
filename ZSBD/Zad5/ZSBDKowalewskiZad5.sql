-- KAMIL KOWALEWSKI 216806 --

USE test_pracownicy
GO

SELECT *
FROM test_pracownicy.dbo.dzialy;

SELECT *
FROM test_pracownicy.dbo.taryfikator;

SELECT *
FROM test_pracownicy.dbo.stanowiska;

SELECT *
FROM test_pracownicy.dbo.pracownicy;

SELECT *
FROM test_pracownicy.dbo.prac_archiw;

-- PODPUNKT 1. Utwórz tabele dziennik składająca się z pół: tabela (do piętnastu znaków), data, l_wierszy (liczba całkowita), komunikat (do trzystu znaków). --
CREATE TABLE test_pracownicy.dbo.dziennik (
    tabela    VARCHAR(15)  NOT NULL,
    data      DATE         NOT NULL,
    l_wiersz  INT          NOT NULL,
    komunikat VARCHAR(300) NOT NULL,
);

-- PODPUNKT 2. Zadeklaruj blok anonimowy aktualizujący tabele pracownicy poprzez dodanie premii tym pracownikom, którzy są kierownikami. Wartość premii jest ustawiana przez zmienną zadeklarowana w bloku. Następnie policz ile zmieniono wierszy i wstaw liczbę zmian oraz odpowiedni komentarz do tabeli dziennik (Wprowadzono dodatek funkcyjny w wysokości ...). --
SELECT nr_akt, placa
FROM test_pracownicy.dbo.pracownicy
WHERE nr_akt IN (
                    SELECT DISTINCT kierownik
                    FROM test_pracownicy.dbo.pracownicy
                )

DECLARE kursor CURSOR FOR SELECT nr_akt
                          FROM test_pracownicy.dbo.pracownicy
DECLARE @premia INT=500, @numer INT, @iter INT=0
OPEN kursor FETCH NEXT FROM kursor INTO @numer

WHILE @@fetch_status = 0
    BEGIN
        IF (@numer IN (SELECT DISTINCT kierownik FROM test_pracownicy.dbo.pracownicy))
            BEGIN
                UPDATE test_pracownicy.dbo.pracownicy
                SET placa += @premia
                WHERE nr_akt = @numer
                SET @iter += 1
            END;
        FETCH NEXT FROM kursor INTO @numer
    END;

INSERT INTO test_pracownicy.dbo.dziennik
VALUES ('test_pracownicy.dbo.pracownicy', getdate(), @iter,
        'Wprowadzono dodatek funkcyjny w wysokosci '
            + convert(VARCHAR(4), @premia) + ' dla '
            + convert(VARCHAR(4), @iter) + ' pracownikow');

CLOSE kursor
DEALLOCATE kursor

SELECT nr_akt, placa
FROM test_pracownicy.dbo.pracownicy
WHERE nr_akt IN (
                    SELECT DISTINCT kierownik
                    FROM test_pracownicy.dbo.pracownicy
                )
SELECT *
FROM test_pracownicy.dbo.dziennik;
GO

-- PODPUNKT 3. Zadeklaruj blok wstawiający do dziennika komentarz o ilości zatrudnionych pracowników w wybranym roku (np. 1989) (Zatrudniono ... pracowników./Nikogo nie zatrudniono). --
DECLARE @rok INT=1989, @liczba_prac INT
BEGIN
    SET @liczba_prac = (
                           SELECT count(*)
                           FROM test_pracownicy.dbo.pracownicy
                           WHERE year(data_zatr) = @rok
                       )
    IF (@liczba_prac != 0)
        INSERT INTO test_pracownicy.dbo.dziennik
        VALUES ('pracownicy', getdate(), @liczba_prac,
                'Zatrudniono ' + convert(VARCHAR(4), @liczba_prac)
                    + ' pracowników w roku ' + convert(VARCHAR(4), @rok))
    ELSE
        INSERT INTO test_pracownicy.dbo.dziennik
        VALUES ('pracownicy', getdate(), @liczba_prac,
                'Nikogo nie zatrudniono w ' + convert(VARCHAR(4), @rok))
END;

SELECT *
FROM test_pracownicy.dbo.dziennik;
GO

-- PODPUNKT 4. Zadeklaruj blok anonimowy wstawiający do dziennika komentarz o długości zatrudnienia pracownika z numerem 8902 (dłużej, czy krócej niż 15 lat): Pracownik ... jest zatrudniony [dłużej niż / krócej niż] 15 lat. --
DECLARE @numer INT=8902
BEGIN
    IF (year(getdate()) -
        (
            SELECT year(data_zatr)
            FROM test_pracownicy.dbo.pracownicy
            WHERE nr_akt = @numer
        ) > 15)
        INSERT INTO test_pracownicy.dbo.dziennik
        VALUES ('pracownicy', getdate(), '1',
                'pracownik ' + convert(VARCHAR(4), @numer)
                    + ' jest zatrudniony dluzej niz 15 lat');
    ELSE
        INSERT INTO test_pracownicy.dbo.dziennik
        VALUES ('pracownicy', getdate(), '1',
                'pracownik ' + convert(VARCHAR(4), @numer)
                    + ' jest zatrudniony krocej niz 15 lat');
END;

SELECT *
FROM test_pracownicy.dbo.dziennik;
GO

-- PODPUNKT 5. Utwórz procedurę składowana PIERWSZA, która wyświetli wartości pobranego argumentu w postaci: wartość parametru wynosiła: ...... Wywołaj procedurę z bloku. --

-- drop PROCEDURE pierwsza
CREATE PROCEDURE pierwsza(@parametr INT) AS
BEGIN
    PRINT 'Wartosc parametru wynosila: ' + convert(VARCHAR(10), @parametr)
END
GO

EXEC pierwsza 15
GO

-- PODPUNKT 6. Utwórz procedurę DRUGA o następujących własnościach: trzy argumenty: wejściowy ciąg znaków domyślnie NULL, wyjściowy ciąg znaków oraz wejściowy numer z przypisana wartością początkowa 1; Zadeklarowana zmienna lokalna znakowa niezerowa z przypisana wartością 'DRUGA'; Ciąg zwracany to łańcuch składający się z wartości zmiennej lokalnej, ciągu wejściowego oraz numeru wejściowego. --
CREATE PROCEDURE druga(@wejscie VARCHAR(100) NULL, @wyjscie VARCHAR(100) OUTPUT, @liczba INT=1) AS
BEGIN
    DECLARE @zmienna VARCHAR(10)='nazwa'
    SET @wyjscie = @zmienna + @wejscie + convert(VARCHAR(10), @liczba)
END
GO

DECLARE @wyjscie VARCHAR(100)
EXEC druga 'Napis', @wyjscie OUTPUT, 6
SELECT @wyjscie
GO

-- PODPUNKT 7. Utwórz procedurę, podwyższająca płace dla danego argumentem działu określony drugim argumentem procent. Wprowadź domyślne wartości dla argumentów, a także odpowiedni komentarz do dziennika. Policz zmodyfikowane rekordy. (Zaktualizuj atrybut płaca, wstaw komunikat do dziennika w postaci: Wprowadzono podwyżkę o ... procent). Jeśli numer działu to zero, podnieś płace wszystkim pracownikom. --

-- TODO, ISSUE WITH CONVERTING MONEY TO INT
-- DROP PROCEDURE zmien_place
CREATE PROCEDURE zmien_place(@numer_dzialu INT = 3, @procent INT = 10) AS
BEGIN
    DECLARE @suma INT, @podwyzka DECIMAL(3, 2)= @procent * 0.01

    IF (@numer_dzialu = 0)
        BEGIN
            UPDATE test_pracownicy.dbo.pracownicy SET placa += placa * @procent
            SET @suma = (SELECT COUNT(*) FROM test_pracownicy.dbo.pracownicy)
        END
    ELSE
        BEGIN
            SET @suma = (
                            SELECT COUNT(*)
                            FROM test_pracownicy.dbo.pracownicy
                            WHERE id_dzialu = @numer_dzialu
                        )
            UPDATE test_pracownicy.dbo.pracownicy
            SET placa += placa * @procent
            WHERE id_dzialu = @numer_dzialu
        END

    IF (@suma <> 0)
        INSERT INTO test_pracownicy.dbo.dziennik
        VALUES ('pracownicy', GETDATE(), @suma,
                'Wprowadzono podwyzke o ' + CONVERT(VARCHAR(4), @procent) + ' %');
END
GO

EXEC zmien_place 20, 11
SELECT *
FROM test_pracownicy.dbo.dziennik
GO

-- PODPUNKT 8. Napisz funkcje zwracająca udział procentowy działu w budżecie firmy. Wykonaj ja wewnątrz zapytania dającego wynik w postaci dwóch kolumn: id_dzialu, udzial_w_budzecie. --

-- drop FUNCTION procentowy_budzet_firmy
CREATE FUNCTION procentowy_budzet_firmy(@numer_dzialu INT) RETURNS DECIMAL(10, 2)
BEGIN
    DECLARE @suma_dzial INT, @suma INT, @laczna_suma INT;

    SET @suma_dzial =
            (SELECT sum(placa) FROM test_pracownicy.dbo.pracownicy WHERE id_dzialu = @numer_dzialu)
    SET @suma = (SELECT sum(placa) FROM test_pracownicy.dbo.pracownicy)
    SET @laczna_suma = @suma_dzial * 10000 / @suma * 0.01

    RETURN @laczna_suma
END
GO

SELECT DISTINCT id_dzialu, dbo.procentowy_budzet_firmy(id_dzialu)
FROM test_pracownicy.dbo.pracownicy
GO

-- PODPUNKT 9. Utwórz wyzwalacz do_archiwum, który przenosi dane pracownika do tabeli prac_archiw w przypadku jego zwolnienia (usunięcia z tabeli pracownicy). Dodaj komentarz do tablicy dziennik: Zwolniono pracownika numer: ... --
CREATE TRIGGER do_archiwum
    ON test_pracownicy.dbo.pracownicy
    FOR DELETE AS
BEGIN
    ROLLBACK
    INSERT INTO test_pracownicy.dbo.prac_archiw
    SELECT nr_akt, nazwisko, stanowisko, kierownik, data_zatr, data_zwol, placa, dod_funkcyjny,
           prowizja, id_dzialu
    FROM deleted

    INSERT INTO test_pracownicy.dbo.dziennik
    VALUES ('pracownicy', getdate(), 1,
            'Zwolniono pracownika numer: ' +
            convert(VARCHAR(4), (SELECT nr_akt FROM deleted)))
END;
GO

DELETE
FROM test_pracownicy.dbo.pracownicy
WHERE nr_akt = 9731

SELECT *
FROM test_pracownicy.dbo.dziennik;
GO
