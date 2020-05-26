-- Kamil Kowalewski 216806 --
-- Wtorek 2.06.2020r Kolokwium ABDO

DESC DBMS_OUTPUT;
SET SERVEROUTPUT ON;

-- $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ --

DECLARE
    CURSOR kursor_1 IS
        SELECT
        FROM where;
--     zmienne
    var
BEGIN
    OPEN kursor_1;
    LOOP
        FETCH kursor_1 INTO /*vars*/;
        IF kursor_1%NOTFOUND
        THEN
            EXIT;
        END IF;
        dbms_output.put_line();
    END LOOP;
    CLOSE kursor_1;
END;


-- $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ --
CREATE
    OR
    REPLACE PROCEDURE procedura_2(param_/*todo*/) IS
    -- todo wyjatek
-- todo zmienna
    var;
BEGIN

END;

-- wywolanie
--     select
EXECUTE procedura_2(/*todo*/)
--     select

ROLLBACK;


-- $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ --
CREATE OR REPLACE FUNCTION funkcja_3(param_/*todo*/)
    RETURN /*todo eg. number*/ IS
--     ZMIENNE
    var;
BEGIN


    RETURN /*TODO*/;
EXCEPTION
    WHEN /*todo*/
        then;

RETURN /*todo*/;
END;

-- wywolanie
EXECUTE DBMS_OUTPUT.put_line(funkcja_3(/*todo*/));
EXECUTE DBMS_OUTPUT.put_line(funkcja_3(/*todo*/));

ROLLBACK;

-- $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ --
CREATE TABLE /*TODO*/ AS
SELECT *
FROM /*TODO*/;
DELETE
FROM /*TODO*/;

CREATE OR REPLACE TRIGGER wyzwalacz_4
    BEFORE UPDATE OR DELETE
    ON /*TODO*/
    FOR EACH ROW
BEGIN
    INSERT INTO /*TODO*/
    VALUES (:old.
            :OLD.
            :OLD.
            :OLD.
            :OLD.
            :OLD.
            :OLD.
            :OLD.
            :OLD.
            :OLD.
    );
END;

SELECT /*TODO*/
FROM /*TODO*/
WHERE /*TODO*/;

UPDATE /*TODO*/
SET /*TODO*/
WHERE /*TODO*/;

SELECT /*TODO*/
FROM /*TODO*/
    WHERE ;

SELECT /*TODO*/
FROM /*TODO*/_archiwum
    WHERE /*TODO*/;

ROLLBACK;
