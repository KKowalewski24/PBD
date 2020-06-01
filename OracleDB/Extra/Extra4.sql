-- Kamil Kowalewski 216806 --
-- Wtorek 2.06.2020r Kolokwium ABDO

-- ---------------------------------------------------------------------------------------------- --
--     TRESCI ZADAN - ROZWIAZANIA SA PONIZEJ W KOLENOSCI ROSNACEJ

-- ZADANIE 3: STWORZYĆ FUNKCJĘ, KTÓRA POBIERA NAZWĘ DZIAŁU JAKO PARAMETR, OBLICZA ŚREDNIĄ
-- WARTOŚĆ PŁACY DLA PODANEGO DZIAŁU, WYPISUJE ORAZ ZWRACA OBLICZONĄ WARTOŚĆ.
-- JEZELI NIE ZNAJDZIE TAKIEGO DZIAŁU, TO WYPISUJE ODPOWIEDNI KOMUNIKAT POPRZEZ OBSLUGĘ BŁĘDÓW.

-- ---------------------------------------------------------------------------------------------- --


SET SERVEROUTPUT ON;

-- 1 ---------------------------------------------------------------------------------------------- --

-- 2 ---------------------------------------------------------------------------------------------- --

-- 3 ---------------------------------------------------------------------------------------------- --

CREATE OR REPLACE FUNCTION funkcja_3(param_nazwa dzialy.nazwa%TYPE)
    RETURN NUMBER IS
-- ZMIENNE
    var_srednia   NUMBER;
    var_id_dzialu dzialy.id_dzialu%TYPE;
BEGIN
    SELECT id_dzialu INTO var_id_dzialu FROM dzialy WHERE nazwa = param_nazwa;
    SELECT avg(placa) INTO var_srednia FROM pracownicy WHERE id_dzialu = var_id_dzialu;
    dbms_output.put_line(
                'Srednia wartosc placy dla dzialu ' || param_nazwa || ' to ' || var_srednia);
    RETURN var_srednia;
EXCEPTION
    WHEN no_data_found
        THEN
            dbms_output.put_line('Dzial ' || param_nazwa || ' nie zostal znaleziony');
            RETURN 0;
END;

-- wywolanie
CALL dbms_output.put_line(funkcja_3('ZARZAD'));
CALL dbms_output.put_line(funkcja_3('ABC'));

ROLLBACK;

-- 4 ---------------------------------------------------------------------------------------------- --

