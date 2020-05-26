-- 1
-- Stworzyć blok anonimowy, który przy użyciu kursora dla każdego pracownika z tabeli
-- pracownicy wypisuje na ekranie tekst:
-- 'Pracownik NAZWISKO pracuje na stanowisku STANOWISKO'
-- Gdze nazwisko oraz stanowisko pochodzą z tabeli pracownicy

-- 2
-- Stworzyć procedurę, która pobiera nazwę działu jako parametr, zwiększa pensję każdego
-- pracownika w tym dziale o 10% i wypisuje ilu pracownikom zmieniła
-- Jeżeli nie znajdzie takiego działu, to wypisuje odpowiedni komunikat poprzez obsługę błędów.
-- W sekcji deklaratywnej procedury procedury musi zostać zdefiniowany wyjątek, który musi
-- zostać wygenerowany w ciele procedury i obsłużony w sekcji exception procedury

-- 3
-- Stworzyć funkcję, któa pobiera nazwę działu jako parametr, oblicza wartość maksymalnej
-- płacy dla podanego działu, wypisuje oraz zwraca obliczoną wartość.
-- Jeżeli nie znajdzie takiego działu, to wypisuje odpowiedni komunikat poprzez obsługę błędów.

-- 4
-- Stworzyć trigger, który monitoruje wszystkie zmiany w tabeli stanowiska i zapisuje stare
-- wartości (wartości zmienianie lub usuwane) z tej tabeli do innej tabeli o takiej samej
-- strukturze co tabela stanowiska.
-- Tabelę danych historyzcznych można wygenerować przy użyciu polecenia
-- CREATE TABLE STANOWISKA_ARCHIWUM AS SELECT * FROM HR.jobs;
-- DELETE FROM STANOWISKA_ARCHIWUM;

DESC DBMS_OUTPUT;
SET SERVEROUTPUT ON;

-- $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ --
DECLARE
    CURSOR kursor_1 IS
        SELECT nazwisko, stanowisko
        FROM pracownicy;
--     zmienne
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
                    'Pracownik ' || var_nazwisko || 'pracuje na stanowisku ' || var_stanowisko);
    END LOOP;
    CLOSE kursor_1;
END;


-- $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ --

CREATE OR REPLACE PROCEDURE procedura_2(param_nazwa dzialy.nazwa%TYPE) IS
    wyjatek EXCEPTION;
    var_licznik   NUMBER;
    var_id_dzialu NUMBER;
BEGIN
    SELECT id_dzialu INTO var_id_dzialu FROM dzialy WHERE nazwa = param_nazwa;
    SELECT count(*) INTO var_licznik FROM dzialy WHERE dzialy.nazwa = param_nazwa;
    IF var_licznik = 0
    THEN
        RAISE wyjatek;
    ELSE
        UPDATE pracownicy SET placa=1.1 * placa WHERE var_id_dzialu = id_dzialu;
    END IF;
EXCEPTION
    WHEN wyjatek
        THEN
            dbms_output.put_line('Dzial ' || var_id_dzialu || ' nie zostal odnaleziony.');
END;

-- wywolanie
SELECT placa
FROM pracownicy, dzialy
WHERE pracownicy.id_dzialu = dzialy.id_dzialu
  AND dzialy.nazwa = 'ZARZAD';

CALL procedura_2('ZARZAD');

SELECT placa
FROM pracownicy, dzialy
WHERE pracownicy.id_dzialu = dzialy.id_dzialu
  AND dzialy.nazwa = 'ZARZAD';

ROLLBACK;


-- $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ --
-- CREATE OR REPLACE FUNCTION funkcja_3(param_/*todo*/)
--     RETURN /*todo eg. number*/ IS
-- --     ZMIENNE
--     var;
-- BEGIN
--
--
--     RETURN /*TODO*/;
-- EXCEPTION
--     WHEN /*todo*/
--         then;
--
-- RETURN /*todo*/;
-- END;
--
-- -- wywolanie
-- EXECUTE DBMS_OUTPUT.put_line(funkcja_3(/*todo*/));
-- EXECUTE DBMS_OUTPUT.put_line(funkcja_3(/*todo*/));
--
-- ROLLBACK;

-- $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ --
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

SELECT stanowisko, placa_min
FROM stanowiska
WHERE stanowisko = 'PREZES';

UPDATE stanowiska
SET placa_min=15
WHERE stanowisko = 'PREZES';

SELECT stanowisko, placa_min
FROM stanowiska
WHERE stanowisko = 'PREZES';

SELECT stanowisko, placa_min
FROM stanowiska_archiwum
WHERE stanowisko = 'PREZES';

ROLLBACK;
