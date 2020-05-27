-- 1
-- Stworzyć blok anonimowy, który przy użyciu kursora dla każdego pracownika
-- z tabeli pracownicy wypisuje na ekranie tekst:
-- 'Pracownik NAZWISKO pracuje w dziale NAZWA_DZIALU', gdzie NAZWISKO pochodzi
-- z tabeli pracownicy, natomiast NAZWA_DZIALU pochodzi z tabeli działy

-- 2
-- Stworzyć procedurę, która pobiera nazwisko pracownika jako parametr, zwiększa mu pensję
-- o 10% i wypisuje komunikat informujący o tym, ze operacja się powiodła
-- Jeżeli nie znajdzie takiego pracownika, to wypisuje odpowiedni komunikat poprzez obsługę błędów.
-- W sekcji deklaratywnej procedury musi zostać zdefiniowany wyjątek, który musi zostać
-- wygenerowany w ciele procedury i obsłużony w sekcji EXCEPTION procedury.


-- 3
-- Stworzyć funkcję, która pobiera nazwę działu jako parametr, oblicza sumę zarobków dla
-- podanego działu, wypisuje oraz zwraca obliczoną wartość.
-- Jeżeli nie znajdzie takiego działu, to wypisuje odpowiedni komunikat poprzez obsługę błędów.


-- 4
-- Stworzyć trigger, który monitoruje wszystkie zmiany w tabeli pracownicy i zapisuje stare
-- wartości (wartości zmieniane lub usuwane) z tej tabeli do innej tabeli o takiej samej
-- strukturze co tabela pracownicy
-- Tabelę danych historycznych można wygenerować za pomocą polecenia:
-- CREATE TABLE PRACOWNICY_ARCHIWUM AS SELECT * FROM HR.employees;
-- DELETE FROM PRACOWNICY_ARCHIWUM;

SET SERVEROUTPUT ON;

-- ---------------------------------------------------------------------------------------------- --

DECLARE
    CURSOR kursor_1 IS
        SELECT pra.nazwisko, dzia.nazwa
        FROM pracownicy pra, dzialy dzia
        WHERE pra.id_dzialu = dzia.id_dzialu;
    nazwisko_1    pracownicy.nazwisko%TYPE;
    dzial_nazwa_1 dzialy.nazwa%TYPE;
BEGIN
    OPEN kursor_1;
    LOOP
        FETCH kursor_1 INTO nazwisko_1, dzial_nazwa_1;
        IF kursor_1%NOTFOUND
        THEN
            EXIT;
        END IF;
        dbms_output.put_line(
                    'Pracownik ' || nazwisko_1 || ' pracuje w dziale ' || dzial_nazwa_1);
    END LOOP;
    CLOSE kursor_1;
END;

-- ---------------------------------------------------------------------------------------------- --

CREATE OR REPLACE PROCEDURE procedura_1(nazwisko_param pracownicy.nazwisko%TYPE) IS
    wyjatek_2 EXCEPTION;
    licznik NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO licznik
    FROM pracownicy
    WHERE nazwisko = nazwisko_param;
    IF licznik = 0
    THEN
        RAISE wyjatek_2;
    ELSE
        UPDATE pracownicy
        SET placa=1.1 * placa
        WHERE nazwisko = nazwisko_param;
        dbms_output.put_line('Pracownik ' || nazwisko_param || ' ma zwiekszona pensje o 10%.');
    END IF;
EXCEPTION
    WHEN wyjatek_2
        THEN
            dbms_output.put_line('Pracownik ' || nazwisko_param || ' nie zostal odnaleziony.');
END;

-- TODO EXECUTE procedura_1('MALYSZ');
CALL procedura_1('MALYSZ');

SELECT placa
FROM pracownicy
WHERE nazwisko = 'MALYSZ';

ROLLBACK;

-- ---------------------------------------------------------------------------------------------- --

CREATE OR REPLACE FUNCTION funkcja_3(dzial_nazwa_param dzialy.nazwa%TYPE)
    RETURN NUMBER IS
    var_nr_dzialu dzialy.id_dzialu%TYPE;
    var_suma      pracownicy.placa%TYPE := 0;
BEGIN
    SELECT id_dzialu INTO var_nr_dzialu FROM dzialy WHERE nazwa = dzial_nazwa_param;
    SELECT sum(placa) INTO var_suma FROM pracownicy WHERE id_dzialu = var_nr_dzialu;
    dbms_output.put_line('Suma zarobkow oddzialu ' || dzial_nazwa_param || ' wynosi ' || var_suma);
    RETURN var_suma;
EXCEPTION
    WHEN no_data_found
        THEN dbms_output.put_line('Dzial ' || dzial_nazwa_param || ' nie zostal odnaleziony.');
        RETURN 0;
END;

-- EXECUTE dbms_output.put_line(funkcja_3('ABCDE'));
-- EXECUTE dbms_output.put_line(funkcja_3('ZARZAD'));
CALL dbms_output.put_line(funkcja_3('ABCDE'));
CALL dbms_output.put_line(funkcja_3('ZARZAD'));

ROLLBACK;

-- ---------------------------------------------------------------------------------------------- --

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

SELECT nr_akt, nazwisko
FROM pracownicy
WHERE nr_akt = 9121;

UPDATE pracownicy
SET nazwisko='abc'
WHERE nr_akt = 9121;

SELECT nr_akt, nazwisko
FROM pracownicy
WHERE nr_akt = 9121;

SELECT nr_akt, nazwisko
FROM pracownicy_archiwum
WHERE nr_akt = 9121;

ROLLBACK;
