-- Kamil Kowalewski 216806 --
-- Wtorek 2.06.2020r Kolokwium ABDO

-- ---------------------------------------------------------------------------------------------- --
--     TRESCI ZADAN - ROZWIAZANIA SA PONIZEJ W KOLENOSCI ROSNACEJ


-- ---------------------------------------------------------------------------------------------- --


SET SERVEROUTPUT ON;

-- 1 ---------------------------------------------------------------------------------------------- --

-- DECLARE
--     CURSOR kursor_1 IS
--         SELECT
--         FROM where;
-- --    zmienne
--     var ;
-- BEGIN
--     OPEN kursor_1;
--     LOOP
--         FETCH kursor_1 INTO /*vars*/;
--         IF kursor_1%NOTFOUND
--         THEN
--             EXIT;
--         END IF;
--         dbms_output.put_line();
--     END LOOP;
--     CLOSE kursor_1;
-- END;


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

-- CREATE TABLE /*TODO*/ as
-- SELECT *
-- FROM /*TODO*/;
-- DELETE
-- FROM /*TODO*/;
--
-- CREATE OR REPLACE TRIGGER wyzwalacz_4
--     BEFORE UPDATE OR DELETE
--     ON /*TODO*/
--         for EACH ROW
-- BEGIN
--     INSERT INTO /*TODO*/
--         values (:old.
--     );
-- END;
--
-- SELECT /*TODO*/
-- FROM /*TODO*/
--     where /*TODO*/;
--
-- UPDATE /*TODO*/
--     set /*TODO*/
-- WHERE /*TODO*/;
--
-- SELECT /*TODO*/
-- FROM /*TODO*/
--     where;
--
-- SELECT /*TODO*/
-- FROM /*TODO*/_archiwum
-- WHERE /*TODO*/;
--
-- ROLLBACK;


-- DROP TABLE pracownicy;
-- DROP TABLE stanowiska;
-- DROP TABLE dzialy;
