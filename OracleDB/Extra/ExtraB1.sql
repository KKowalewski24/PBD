-- Kamil Kowalewski 216806 --
-- Wtorek 2.06.2020r Kolokwium ABDO

-- ---------------------------------------------------------------------------------------------- --
--     TRESCI ZADAN - ROZWIAZANIA SA PONIZEJ W KOLENOSCI ROSNACEJ


-- ---------------------------------------------------------------------------------------------- --


SET SERVEROUTPUT ON;

-- 1 ---------------------------------------------------------------------------------------------- --

DECLARE
    CURSOR kursor_1 IS
        SELECT nazwisko, stanowisko
        FROM pracownicy;
--    zmienne
    var_nazwisko   pracownicy.nazwisko%TYPE;
    var_stanowisko pracownicy.stanowisko%TYPE;
BEGIN
    OPEN kursor_1;
    LOOP
        FETCH kursor_1 INTO var_nazwisko, var_stanowisko;
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

CREATE OR REPLACE PROCEDURE procedura_2(param_nazwa dzialy.nazwa%TYPE) IS
    wyjatek EXCEPTION;
-- todo zmienna
    var_licznik   NUMBER;
    var_id_dzialu dzialy.id_dzialu%TYPE;
BEGIN
    SELECT id_dzialu INTO var_id_dzialu FROM dzialy WHERE nazwa = param_nazwa;
    SELECT count(*) INTO var_licznik FROM dzialy WHERE nazwa = param_nazwa;
    IF var_licznik = 0
    THEN
        RAISE wyjatek;
    ELSE
        UPDATE pracownicy SET placa = placa * 1.1 WHERE id_dzialu = var_id_dzialu;
    END IF;
EXCEPTION
    WHEN wyjatek
        THEN
            dbms_output.put_line('Dzial ' || param_nazwa || ' nie zostal odnaleziony');
END;

-- wywolanie
SELECT placa
FROM pracownicy prac, dzialy dzi
WHERE prac.id_dzialu = dzi.id_dzialu
  AND dzi.nazwa = 'ZARZAD';

CALL procedura_2('ZARZAD');

SELECT placa
FROM pracownicy prac, dzialy dzi
WHERE prac.id_dzialu = dzi.id_dzialu
  AND dzi.nazwa = 'ZARZAD';

ROLLBACK;

-- 3 ---------------------------------------------------------------------------------------------- --

CREATE OR REPLACE FUNCTION funkcja_3(param_nazwa dzialy.nazwa%TYPE)
    RETURN NUMBER IS
-- ZMIENNE
    var_maximum   NUMBER := 0;
    var_id_dzialy dzialy.id_dzialu%TYPE;
BEGIN
    SELECT id_dzialu INTO var_id_dzialy FROM dzialy WHERE nazwa = param_nazwa;
    SELECT max(placa) INTO var_maximum FROM pracownicy WHERE id_dzialu = var_id_dzialy;
    dbms_output.put_line('Dzial ' || param_nazwa || ' max placa ' || var_maximum);
    RETURN var_maximum;
EXCEPTION
    WHEN no_data_found
        THEN
            dbms_output.put_line('dzial ' || param_nazwa || ' nie zostal znalezione');
            RETURN 0;
END;

-- wywolanie
CALL dbms_output.put_line(funkcja_3('ZARZAD'));
CALL dbms_output.put_line(funkcja_3('abc'));

ROLLBACK;

-- 4 ---------------------------------------------------------------------------------------------- --

CREATE TABLE stanowiska_archiwum AS
SELECT *
FROM stanowiska;
DELETE
FROM stanowiska_archiwum;

CREATE OR REPLACE TRIGGER wyzwalacz_4
    BEFORE UPDATE OR DELETE
    ON stanowiska
    FOR EACH ROW
BEGIN
    INSERT INTO stanowiska_archiwum
    VALUES (:old.stanowisko,
            :old.placa_min,
            :old.placa_max);
END;

SELECT placa_min
FROM stanowiska
WHERE stanowisko = 'PREZES';

UPDATE stanowiska
SET placa_min=100
WHERE stanowisko = 'PREZES';

SELECT placa_min
FROM stanowiska
WHERE stanowisko = 'PREZES';

SELECT placa_min
FROM stanowiska_archiwum
WHERE stanowisko = 'PREZES';

ROLLBACK;


-- DROP TABLE pracownicy;
-- DROP TABLE stanowiska;
-- DROP TABLE dzialy;
