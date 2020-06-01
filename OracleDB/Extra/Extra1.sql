-- Kamil Kowalewski 216806 --
-- Wtorek 2.06.2020r Kolokwium ABDO

-- ---------------------------------------------------------------------------------------------- --
--     TRESCI ZADAN - ROZWIAZANIA SA PONIZEJ W KOLENOSCI ROSNACEJ

-- ZADANIE 1:STWORZYĆ BLOK ANONIMOWY, KTÓRY PRZY UŻYCIU KURSORA DLA KAŻDEGO
-- PRACOWNIKA Z TABELI PRACOWNICY WYPISUJE NA EKRANIE TEKST:
-- 'PRACOWNIK NAZWISKO PRACUJE NA STANOWISKU STANOWISKO', GDZIE NAZWISKO ORAZ
-- STANOWISKO POCHODZĄ Z TABELI PRACOWNICY
--
-- ZADANIE 2: STWORZYĆ PROCEDURĘ, KTÓRA POBIERA NAZWISKO PRACOWNIKA JAKO PARAMETR,
-- ZWIĘKSZA MU PENSJĘ O 10% I WYPISUJE KOMUNIKAT INFORMUJĄCY O TYM, ŻE OPERACJA SIĘ POWIODŁA.
-- JEZELI NIE ZNAJDZIE TAKIEGO PRACOWNIKA, TO WYPISUJE ODPOWIEDNI KOMUNIKAT POPRZEZ OBSLUGĘ BŁĘDÓW.
-- W SEKCJI DEKLARATYWNEJ PROCEDURY MUSI ZOSTAĆ ZDEFINIOWANY WYJĄTEK, KTÓRY MUSI
-- ZOSTAĆ WYGENEROWANY W CIELE PROCEDURY I OBSŁUŻONY W SEKCJI EXCEPTION PROCEDURY.
--
--
-- ZADANIE 3: STWORZYĆ FUNKCJĘ, KTÓRA POBIERA NAZWĘ DZIAŁU JAKO PARAMETR,
-- OBLICZA WARTOŚĆ MINIMALNEJ PŁACY DLA PODANEGO DZIAŁU, WYPISUJE ORAZ ZWRACA OBLICZONĄ WARTOŚĆ.
-- JEZELI NIE ZNAJDZIE TAKIEGO DZIAŁU, TO WYPISUJE ODPOWIEDNI KOMUNIKAT POPRZEZ OBSLUGĘ BŁĘDÓW.
--
--
-- ZADANIE 4: STWORZYĆ TRIGER, KTÓRY MONITORUJE WSZYSTKIE ZMIANY W TABELI
-- DZIALY I ZAPISUJE STARE WARTOŚCI (WARTOŚCI ZMIENIANE LUB USUWANE) Z TEJ
-- TABELI DO INNEJ TABELI O TAKIEJ SAMEJ STRUKTURZE CO TABELA DZIALY.
-- TABELĘ DANYCH HISTORYCZNYCH MOŻNA WYGENEROWAĆ PRZY UŻYCIU POLECENIA
-- CREATE TABLE DZIALY_ARCHIWUM AS SELECT * FROM DZIALY;
-- DELETE FROM SDZIALY_ARCHIWUM;

-- ---------------------------------------------------------------------------------------------- --


SET SERVEROUTPUT ON;

-- 1 ---------------------------------------------------------------------------------------------- --

DECLARE
    CURSOR kursor_1 IS
        SELECT nazwisko, stanowisko
        FROM pracownicy;
--    zmienne
    var_nazwisko   pracownicy.nazwisko%TYPE ;
    var_stanowisko pracownicy.stanowisko%TYPE ;
BEGIN
    OPEN kursor_1;
    LOOP
        FETCH kursor_1 INTO var_nazwisko,var_stanowisko;
        IF kursor_1%NOTFOUND
        THEN
            EXIT;
        END IF;
        dbms_output.put_line(
                    'Pracownik ' || var_nazwisko || ' pracuje na stanowisku ' || var_stanowisko);
    END LOOP;
    CLOSE kursor_1;
END;


-- 2 ---------------------------------------------------------------------------------------------- --

CREATE OR REPLACE PROCEDURE procedura_2(param_nazwisko pracownicy.nazwisko%TYPE) IS
    wyjatek EXCEPTION;
-- todo zmienna
    var_licznik NUMBER;
BEGIN
    SELECT count(*) INTO var_licznik FROM pracownicy WHERE nazwisko = param_nazwisko;
    IF var_licznik = 0
    THEN
        RAISE wyjatek;
    ELSE
        UPDATE pracownicy SET placa = placa * 1.1 WHERE nazwisko = param_nazwisko;
        dbms_output.put_line('Nazwisko ' || param_nazwisko || ' ma zwiekszona pensje o 10%');
    END IF;
EXCEPTION
    WHEN wyjatek
        THEN
            dbms_output.put_line('Nazwisko ' || param_nazwisko || ' nie zostalo znalezione ');
END;

-- wywolanie
SELECT placa
FROM pracownicy
WHERE nazwisko = 'KROL';

CALL procedura_2('KROL');
CALL procedura_2('abc');

SELECT placa
FROM pracownicy
WHERE nazwisko = 'KROL';

ROLLBACK;


-- 3 ---------------------------------------------------------------------------------------------- --

CREATE OR REPLACE FUNCTION funkcja_3(param_nazwa dzialy.nazwa%TYPE)
    RETURN NUMBER IS
-- ZMIENNE
    var_id_dzialu dzialy.id_dzialu%TYPE ;
    var_minimum   NUMBER;
BEGIN
    SELECT id_dzialu INTO var_id_dzialu FROM dzialy WHERE nazwa = param_nazwa;
    SELECT min(placa) INTO var_minimum FROM pracownicy WHERE id_dzialu = var_id_dzialu;

    RETURN var_minimum;
EXCEPTION
    WHEN no_data_found
        THEN
            dbms_output.put_line('Dzial ' || param_nazwa || ' nie zostal znaleziony');
            RETURN 0;
END;

-- wywolanie
CALL dbms_output.put_line(funkcja_3('ZARZAD'));
CALL dbms_output.put_line(funkcja_3('abc'));

ROLLBACK;

-- 4 ---------------------------------------------------------------------------------------------- --

CREATE TABLE dzialy_archiwum AS
SELECT *
FROM dzialy;
DELETE
FROM dzialy_archiwum;

CREATE OR REPLACE TRIGGER wyzwalacz_4
    BEFORE UPDATE OR DELETE
    ON dzialy
    FOR EACH ROW
BEGIN
    INSERT INTO dzialy_archiwum
    VALUES (:old.id_dzialu,
            :old.nazwa,
            :old.siedziba);
END;

SELECT *
FROM dzialy
WHERE nazwa = 'ZARZAD';

UPDATE dzialy
SET siedziba='abc'
WHERE nazwa = 'ZARZAD';

SELECT *
FROM dzialy
WHERE nazwa = 'ZARZAD';

SELECT *
FROM dzialy_archiwum
WHERE nazwa = 'ZARZAD';

ROLLBACK;


-- DROP TABLE pracownicy;
-- DROP TABLE stanowiska;
-- DROP TABLE dzialy;
