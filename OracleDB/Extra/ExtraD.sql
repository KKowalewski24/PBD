-- ---------------------------------------------------------------------------------------------- --
--     TRESCI ZADAN - ROZWIAZANIA SA PONIZEJ W KOLENOSCI ROSNACEJ

-- 1
-- Utworz blok anonimowy, w ktorym przy uzyciu kursora:
-- > wypisane zostana stanowiska (job_id) wszystkich pracownikow (tabela employees)
-- zarabiajacych powyzej okreslonej stawki (podanej w bloku jako parametr kursora),
-- wypisujacy na koniec komunikat
-- `Przynajmniej tyle zarabia sie na ...(liczba)... stanowiskach` lub
-- `Na zadnym stanowisku nie zarabia sie tak duzo.`

-- 2
-- Utworz procedure która;
-- > dzialom bez podanego managera przypisze numer tego managera, ktory ma najmniejsza
-- liczbe przypisanych pracownikow.
-- > Nastepnie wypisze komunikat postaci: Managerowi o numerze ... (numer managera)
-- przydzielono ... (liczba nowych dzialow) nowych dzialow.
-- > Jesli nie dokonano zadnych zmian, wypisze komunikat: wszystkie dzialy maja managera.
-- > Napisz blok z wywolaniem procedury. Po wykonaniu bloku testujacego procedure, wycofaj zmiany.

-- 3
-- Utwórz funkcje podajaca dla kazdego dzialu, ile procent wszystkich zatrudnionych
-- stanowia pracownicy tego dzialu. Wywolaj ja wewnatrz zapytania dajacego wynik w
-- posaci dwoch kolumn: id_dzialu, rozklad_prac.

-- 4
-- Utwórz wyzwalacz ktory po zmodyfikowaniu placy minimalnej (MIN_SALARY) w tabeli
-- JOBS, zmieni place (SALARY) kazdemu pracownikowi o taka wartosc, o jaka zmienila
-- sie placa minimalna dla jego stanowiska.

-- ---------------------------------------------------------------------------------------------- --


SET SERVEROUTPUT ON;

-- 1 ---------------------------------------------------------------------------------------------- --

DECLARE
    CURSOR kursor_1_d(param_salary pracownicy.placa%TYPE) IS
        SELECT DISTINCT stanowisko
        FROM pracownicy
        WHERE placa > param_salary;
--     zmienne
    var_stanowisko pracownicy.stanowisko%TYPE ;
BEGIN
    OPEN kursor_1_d(4000);
    LOOP
        FETCH kursor_1_d INTO var_stanowisko;
        IF kursor_1_d%NOTFOUND
        THEN
            IF kursor_1_d%ROWCOUNT = 0
            THEN
                dbms_output.put_line('Na zadnym stanowisku nie zarabia sie tak duzo');
            ELSE
                dbms_output.put_line(
                            'Przynajmniej tyle zarabia sie na ' || kursor_1_d%ROWCOUNT ||
                            ' stanowiskach');
            END IF;

            EXIT;
        END IF;
        dbms_output.put_line(var_stanowisko);
    END LOOP;
    CLOSE kursor_1_d;
END;


SELECT *
FROM pracownicy;

-- 2 ---------------------------------------------------------------------------------------------- --

-- CREATE OR REPLACE PROCEDURE procedura_2(param_ /*todo*/) IS
--     -- todo wyjatek
-- -- todo zmienna
--     var;
-- BEGIN
--
-- END;
--
-- -- wywolanie
-- --     select
-- CALL procedura_2(/*todo*/)
-- --     select
--
-- ROLLBACK;


-- 3 ---------------------------------------------------------------------------------------------- --

CREATE OR REPLACE FUNCTION funkcja_3_e(param_id_dzialu dzialy.id_dzialu%TYPE)
    RETURN NUMBER IS
    var_procent NUMBER;
    var_liczba  NUMBER;
    var_ogolem  NUMBER;
BEGIN
    SELECT count(*) INTO var_liczba FROM pracownicy WHERE id_dzialu = param_id_dzialu;
    SELECT count(*) INTO var_ogolem FROM pracownicy;
    var_procent := (var_liczba / var_ogolem) * 100;

    RETURN var_procent;
EXCEPTION
    WHEN no_data_found
        THEN
            dbms_output.PUT_LINE('Dzial ' || param_id_dzialu || ' nie zostal odnaleziony.');
            RETURN 0;
END;

SELECT id_dzialu, funkcja_3_e(id_dzialu)
FROM dzialy;
ROLLBACK;


-- 4 ---------------------------------------------------------------------------------------------- --

CREATE OR REPLACE TRIGGER wyzwalacz_4_e
    BEFORE UPDATE OF
        placa_min
    ON stanowiska
    FOR EACH ROW
BEGIN
    UPDATE hr.pracownicy
    SET placa = placa - :old.placa_min + :new.placa_min
    WHERE stanowisko = :old.stanowisko;
END;


SELECT *
FROM hr.stanowiska
WHERE stanowisko = 'PREZES';

UPDATE hr.stanowiska
SET hr.stanowiska.placa_min=6900
WHERE hr.stanowiska.stanowisko = 'PREZES';

SELECT *
FROM hr.stanowiska
WHERE stanowisko = 'PREZES';
--

ROLLBACK;

DROP TABLE hr.pracownicy;
DROP TABLE hr.stanowiska;
DROP TABLE dzialy;
