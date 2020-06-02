-- Kamil Kowalewski 216806 --
-- Wtorek 2.06.2020r Kolokwium ABDO

-- ---------------------------------------------------------------------------------------------- --
--     TRESCI ZADAN - ROZWIAZANIA SA PONIZEJ W KOLENOSCI ROSNACEJ

-- ZADANIE 1:STWORZYĆ BLOK ANONIMOWY, KTÓRY PRZY UŻYCIU KURSORA DLA KAŻDEGO PRACOWNIKA
-- Z TABELI PRACOWNICY WYPISUJE NA EKRANIE TEKST:
-- 'SZEFEM PRACOWNIKA NAZWISKO JEST NAZWISKO_SZEFA', GDZIE NAZWISKO ORAZ
-- NAZWISKO_SZEFA POCHODZĄ Z TABELI PRACOWNICY
--
-- ZADANIE 2: STWORZYĆ PROCEDURĘ, KTÓRA POBIERA NAZWISKO PRACOWNIKA JAKO
-- PARAMETR, ZWIĘKSZA PŁACĘ MINIMALNĄ DLA STANOWISKA TEGO PRACOWNIKA O 10%
-- I WYPISUJE KOMUNIKAT INFORMUJĄCY O TYM, ŻE OPERACJA SIĘ POWIODŁA.
-- JEZELI NIE ZNAJDZIE TAKIEGO PRACOWNIKA, TO WYPISUJE ODPOWIEDNI KOMUNIKAT
-- POPRZEZ OBSLUGĘ BŁĘDÓW.
-- W SEKCJI DEKLARATYWNEJ PROCEDURY MUSI ZOSTAĆ ZDEFINIOWANY WYJĄTEK,
-- KTÓRY MUSI ZOSTAĆ WYGENEROWANY W CIELE PROCEDURY I OBSŁUŻONY W SEKCJI EXCEPTION PROCEDURY
--
--
-- ZADANIE 3: STWORZYĆ FUNKCJĘ, KTÓRA POBIERA NAZWĘ DZIAŁU JAKO PARAMETR,
-- OBLICZA WARTOŚĆ MINIMALNEJ PŁACY DLA PODANEGO DZIAŁU, WYPISUJE ORAZ ZWRACA OBLICZONĄ WARTOŚĆ.
-- JEZELI NIE ZNAJDZIE TAKIEGO DZIAŁU, TO WYPISUJE ODPOWIEDNI KOMUNIKAT POPRZEZ OBSLUGĘ BŁĘDÓW.
--
--
-- ZADANIE 4: STWORZYĆ TRIGER, KTÓRY MONITORUJE WSZYSTKIE ZMIANY W TABELI
-- PRACOWNICY I ZAPISUJE STARE WARTOŚCI (WARTOŚCI ZMIENIANE LUB USUWANE)
-- Z TEJ TABELI DO INNEJ TABELI O TAKIEJ SAMEJ STRUKTURZE CO TABELA PRACOWNICY.
-- TABELĘ DANYCH HISTORYCZNYCH MOŻNA WYGENEROWAĆ PRZY UŻYCIU POLECENIA
-- CREATE TABLE PRACOWNICY_ARCHIWUM AS SELECT * FROM PRACOWNICY;
-- DELETE FROM PRACOWNICY_ARCHIWUM;

-- ---------------------------------------------------------------------------------------------- --
-- SELECT * FROM pracownicy;
-- SELECT * FROM stanowiska;
-- SELECT * FROM dzialy;

SET SERVEROUTPUT ON;

-- 1 ---------------------------------------------------------------------------------------------- --

DECLARE
    CURSOR kursor_1 IS
        SELECT nazwisko, kierownik
        FROM pracownicy;
--    zmienne
    var_licznik            NUMBER := 0 ;
    var_pracownik_nazwisko pracownicy.nazwisko%TYPE;
    var_szef_nazwisko      pracownicy.nazwisko%TYPE;
    var_szef_id            pracownicy.nr_akt%TYPE;
BEGIN
    OPEN kursor_1;
    LOOP
        FETCH kursor_1 INTO var_pracownik_nazwisko, var_szef_id;
        IF kursor_1%NOTFOUND
        THEN
            EXIT;
        END IF;
        SELECT count(*) INTO var_licznik FROM pracownicy WHERE nr_akt = var_szef_id;

        IF var_licznik = 0
        THEN
            dbms_output.put_line('PRACOWNIK ' || var_pracownik_nazwisko || ' NIE MA SZEFA');
        ELSE
            SELECT nazwisko INTO var_szef_nazwisko FROM pracownicy WHERE nr_akt = var_szef_id;
            dbms_output.put_line('SZEFEM PRACOWNIKA ' || var_pracownik_nazwisko || ' JEST ' ||
                                 var_szef_nazwisko);
        END IF;
    END LOOP;
    CLOSE kursor_1;
END;


-- 2 ---------------------------------------------------------------------------------------------- --

-- CREATE OR REPLACE PROCEDURE procedura_2(param_ /*todo*/) IS
--     wyjatek EXCEPTION;
-- -- todo zmienna
--     var_licznik NUMBER;
-- BEGIN
--     IF var_licznik = 0
--     THEN
--         RAISE wyjatek;
--     ELSE
--
--     END IF;
-- EXCEPTION
--     WHEN wyjatek
--         THEN
--             dbms_output.put_line('');
-- END;
--
-- -- wywolanie
-- --     select
-- CALL procedura_2(/*todo*/)
-- --     select
--
-- ROLLBACK;


-- 3 ---------------------------------------------------------------------------------------------- --

-- CREATE OR REPLACE FUNCTION funkcja_3(param_ /*todo*/)
--     RETURN /*todo eg. number*/ IS
-- -- ZMIENNE
--     var;
-- BEGIN
--
--
--     RETURN /*TODO*/;
-- EXCEPTION
--     WHEN no_data_found
--         then
--dbms_output.put_line('');
-- RETURN /*todo*/;
-- END;
--
-- -- wywolanie
-- CALL DBMS_OUTPUT.put_line(funkcja_3(/*todo*/));
-- CALL DBMS_OUTPUT.put_line(funkcja_3(/*todo*/));
--
-- ROLLBACK;

-- 4 ---------------------------------------------------------------------------------------------- --

CREATE TABLE pracownicy_archiwum AS
SELECT *
FROM pracownicy;
DELETE
FROM pracownicy_archiwum;

CREATE OR REPLACE TRIGGER wyzwalacz_4
    BEFORE UPDATE OR DELETE
    ON pracownicy
    FOR EACH ROW
BEGIN
    INSERT INTO pracownicy_archiwum
    VALUES (:old.nr_akt,
            :old.nazwisko,
            :old.stanowisko,
            :old.kierownik,
            :old.data_zatr,
            :old.data_zwol,
            :old.placa,
            :old.dod_funkcyjny,
            :old.prowizja,
            :old.id_dzialu);
END;

SELECT placa
FROM pracownicy
WHERE nazwisko = 'MALYSZ';

UPDATE pracownicy
SET placa=10
WHERE nazwisko = 'MALYSZ';

SELECT placa
FROM pracownicy
WHERE nazwisko = 'MALYSZ';

SELECT placa
FROM pracownicy_archiwum
WHERE nazwisko = 'MALYSZ';

ROLLBACK;


-- DROP TABLE pracownicy;
-- DROP TABLE stanowiska;
-- DROP TABLE dzialy;
