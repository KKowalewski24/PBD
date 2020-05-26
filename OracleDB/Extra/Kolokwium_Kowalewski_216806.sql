-- Kamil Kowalewski 216806 --
-- Wtorek 2.06.2020r Kolokwium ABDO

DESC DBMS_OUTPUT;
SET SERVEROUTPUT ON;

-- $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ --

DECLARE
    CURSOR kursor_1 IS
        SELECT
        FROM
        where;
--     zmienne
        var
BEGIN
    OPEN kursor_1;
-- todo
    CLOSE kursor_1;
END;


-- $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ --
CREATE OR REPLACE PROCEDURE procedura_2(param_/*todo*/) IS
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
    THEN;

    return /*todo*/;
END;

-- wywolanie
EXECUTE DBMS_OUTPUT.put_line(funkcja_3(/*todo*/));
EXECUTE DBMS_OUTPUT.put_line(funkcja_3(/*todo*/));

ROLLBACK;

-- $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ --
-- todo add trigger

ROLLBACK;
