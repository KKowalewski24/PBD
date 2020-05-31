-- Kamil Kowalewski 216806 --
-- Wtorek 2.06.2020r Kolokwium ABDO

-- ---------------------------------------------------------------------------------------------- --
--     TRESCI ZADAN - ROZWIAZANIA SA PONIZEJ W KOLENOSCI ROSNACEJ


-- ---------------------------------------------------------------------------------------------- --


SET SERVEROUTPUT ON;

-- 1 ---------------------------------------------------------------------------------------------- --

DECLARE
    CURSOR kursor_1 IS
        SELECT prac.nazwisko, dz.nazwa
        FROM pracownicy prac, dzialy dz
        WHERE prac.id_dzialu = dz.id_dzialu;
--     zmienne
    var_nazwisko pracownicy.nazwisko%TYPE ;
    var_nazwa    dzialy.nazwa%TYPE ;
BEGIN
    OPEN kursor_1;
    LOOP
        FETCH kursor_1 INTO var_nazwisko, var_nazwa;
        IF kursor_1%NOTFOUND
        THEN
            EXIT;
        END IF;
        dbms_output.put_line('Pracownik ' || var_nazwisko || ' pracuje w dziale ' || var_nazwa);
    END LOOP;
    CLOSE kursor_1;
END;


-- 2 ---------------------------------------------------------------------------------------------- --

CREATE OR REPLACE PROCEDURE procedura_2(param_nazwisko pracownicy.nazwisko%TYPE) IS
    wyjatek_2 EXCEPTION ;
    var_licznik NUMBER;
BEGIN
    SELECT count(*) INTO var_licznik FROM pracownicy WHERE nazwisko = param_nazwisko;
    IF var_licznik = 0
    THEN
        RAISE wyjatek_2;
    ELSE
        UPDATE pracownicy SET placa = placa * 1.1 WHERE nazwisko = param_nazwisko;
        dbms_output.put_line('Pracownik ' || param_nazwisko || ' ma zwiekszona pensje o 10%');
    END IF;
EXCEPTION
    WHEN wyjatek_2
        THEN
            dbms_output.put_line('Pracownik ' || param_nazwisko || ' nie zostal znaleziony');
END;

-- wywolanie
SELECT placa
FROM pracownicy
WHERE nazwisko = 'MALYSZ';

CALL procedura_2('MALYSZ');

SELECT placa
FROM pracownicy
WHERE nazwisko = 'MALYSZ';

ROLLBACK;


-- 3 ---------------------------------------------------------------------------------------------- --

CREATE OR REPLACE FUNCTION funkcja_3(param_nazwa dzialy.nazwa%TYPE)
    RETURN NUMBER IS
-- ZMIENNE
    var_nr_dzialu dzialy.id_dzialu%TYPE;
    var_suma      NUMBER := 0;
BEGIN
    SELECT id_dzialu INTO var_nr_dzialu FROM dzialy WHERE nazwa = param_nazwa;
    SELECT sum(placa) INTO var_suma FROM pracownicy WHERE id_dzialu = var_nr_dzialu;
    dbms_output.put_line('dzial ' || param_nazwa || ' suma zarobkow ' || var_suma);
    RETURN var_suma;
EXCEPTION
    WHEN no_data_found
        THEN
            dbms_output.put_line('dzial ' || param_nazwa || 'nie zostal znaleziony');
            RETURN 0;
END;

-- wywolanie
CALL dbms_output.put_line(funkcja_3('ZARZAD'));
CALL dbms_output.put_line(funkcja_3('abc'));

ROLLBACK;

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
--

DROP TABLE hr.pracownicy;
DROP TABLE hr.stanowiska;
DROP TABLE dzialy;
