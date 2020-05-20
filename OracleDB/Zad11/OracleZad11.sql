-- MICHAŁ KIDAWA    216796 --
-- KAMIL KOWALEWSKI 216806 --

----------------------------------------------------------------------------------------------------------------
-- 1. Napisz procedurę usuwającą z tabeli pracownika o podanym numerze lub wszystkich pracowników z
-- podanego działu (podawane jako parametry). Następnie policz ile zmieniono wierszy i wstaw
-- odpowiedni komentarz do tabeli dziennik (definicja w instrukcji z zajęć 10.). Wyłap ewentualne
-- błędy i wstaw odpowiedni komentarz do tabeli dziennik.
--
-- 2. Napisz procedurę wstawiającą do dziennika komentarz o ilości pracowników zatrudnionych we
-- wskazanym roku na bazie obsługi błędów
-- (Zatrudniono … / Nikogo nie zatrudniono. / Zatrudniono więcej niż jednego. / Błąd nr … ).
--
-- 3. Utwórz wyzwalacz do_archiwum, który przenosi dane pracownika do tabeli archiwalnej w razie
-- jego zwolnienia (usunięcia z tabeli pracownicy). Dodaj komentarz do tablicy
-- dziennik: Zwolniono pracownika numer: …..
--
-- 4. Utwórz wyzwalacz, który w razie wstawiania danych do tablicy pracownicy bez podania
-- numeru, wstawi ten numer wykorzystując odpowiednią sekwencję.
----------------------------------------------------------------------------------------------------------------

-- PODPUNKT 1 --
DESC DBMS_OUTPUT;
SET SERVEROUTPUT ON;

DROP TABLE DZIENNIK;
CREATE TABLE DZIENNIK (
    IDENTYFIKATOR NUMBER(5),
    DATA_ZMIANY   DATE,
    KOMUNIKAT     VARCHAR2(300)
);
/

CREATE OR REPLACE PROCEDURE pierwsza( e_id HR.employees.employee_id%TYPE := -1,
  d_id HR.employees.department_id%TYPE := -1) IS
    liczba_wierszy NUMBER(5);
BEGIN
    IF e_id != -1
    THEN
        DELETE FROM HR.employees WHERE employee_id=e_id;
        liczba_wierszy := SQL%ROWCOUNT;
        INSERT INTO dziennik VALUES (liczba_wierszy, (SELECT current_date FROM dual), 'Usunieto pracownika o numerze id: '||e_id);
    END IF;
    IF d_id != -1
    THEN
        DELETE FROM HR.employees WHERE department_id=d_id;
        liczba_wierszy := SQL%ROWCOUNT;
        INSERT INTO dziennik VALUES (liczba_wierszy, (SELECT current_date FROM dual), 'Usunieto pracownikow dzialu o numerze id: '||d_id);
    END IF;
END;
/

ALTER TABLE HR.DEPARTMENTS
    DISABLE CONSTRAINT DEPT_MGR_FK;
ALTER TABLE HR.JOB_HISTORY
    DISABLE CONSTRAINT JHIST_EMP_FK;

EXECUTE pierwsza(e_id => 200);
EXECUTE pierwsza(d_id => 40);

SELECT *
FROM DZIENNIK;

-- PODPUNKT 2 --
CREATE OR REPLACE PROCEDURE druga
(rok NUMBER) IS
    pracownik HR.employees%ROWTYPE;
    liczba_wierszy number(5);
BEGIN
    SELECT * INTO pracownik FROM hr.employees WHERE EXTRACT(year FROM hire_date) = rok;
    INSERT INTO dziennik VALUES (1, (SELECT current_date FROM dual), 'W roku ' || rok || ' zatrudniono pracownika ' || pracownik.first_name || ' ' || pracownik.last_name );
EXCEPTION
    WHEN NO_DATA_FOUND
        THEN
            INSERT INTO dziennik VALUES (0, (SELECT current_date FROM dual), 'W roku ' || rok || ' nikogo nie zatrudniono');
    WHEN TOO_MANY_ROWS
        THEN
            SELECT COUNT(*) INTO liczba_wierszy FROM hr.employees WHERE EXTRACT(year FROM hire_date) = rok;
            INSERT INTO dziennik VALUES (liczba_wierszy, (SELECT current_date FROM dual), 'W roku ' || rok || ' zatrudniono ' || liczba_wierszy || ' osob(y).');
END;
/

EXECUTE druga(1980);
EXECUTE druga(1990);
EXECUTE druga(1995);

SELECT * FROM dziennik;
/

-- PODPUNKT 3 --
CREATE OR REPLACE TRIGGER do_archiwum
    BEFORE delete ON HR.employees FOR EACH ROW
BEGIN
    INSERT INTO HR.job_history VALUES (:old.employee_id, :old.hire_date, (SELECT current_date FROM dual), :old.job_id, :old.department_id);
    INSERT INTO dziennik VALUES (1, (SELECT current_date FROM dual), 'Zwolniono pracownika ' || :old.first_name || ' ' || :old.last_name );
END;
/

ALTER TABLE HR.job_history DISABLE CONSTRAINT jhist_emp_fk;

DELETE FROM HR.employees WHERE employee_id=196;

SELECT * FROM HR.job_history;
SELECT * FROM dziennik;

-- PODPUNKT 4 --
SELECT MAX(employee_id) FROM
    (SELECT employee_id FROM HR.employees UNION ALL SELECT employee_id FROM HR.job_history);

CREATE SEQUENCE hr_employee_number
    INCREMENT BY 1
    START WITH 207
    MINVALUE 100
    MAXVALUE 300 CYCLE;

CREATE OR REPLACE TRIGGER nowy_pracownik_bez_numeru
    BEFORE insert ON HR.employees FOR EACH ROW
    WHEN (new.employee_id IS NULL)
BEGIN
    :new.employee_id := hr_employee_number.nextval;
END;
/

INSERT INTO HR.employees VALUES (NULL, 'imie', 'nazwisko', 'email', 'telefon', (SELECT current_date FROM dual), 'AD_PRES', 24000, null, null, 90);


SELECT * FROM HR.employees WHERE employee_id=207;