-- MICHAŁ KIDAWA    216796 --
-- KAMIL KOWALEWSKI 216806 --

----------------------------------------------------------------------------------------------------------------
-- Wywołując procedurę z argumentami, można stosować dwie notacje:
--
-- pozycyjna: TESTOWA(12, zm_ident); (musi być zachowana kolejność argumentów)
-- nazewnicza: TESTOWA(identyfikator => zm_ident, numer_oddzialu => 12);
-- (nie musi być zachowana kolejność argumentów)
-- 1. Utwórz prostą procedurę składowaną PIERWSZA, która wyświetli wartość pobranego argumentu w postaci:
--
-- Wartosc prarametru wynosila: ......
--
-- Wywołaj procedurę z bloku anonimowego.
--
-- 2. Utwórz procedurę DRUGA o następujących własnościach:
--
-- trzy argumenty: wejściowy ciąg znaków domyślnie NULL, wyjściowy ciąg znaków oraz
-- wejściowy numer z przypisaną wartością początkową 1.
-- zadeklarowana zmienna lokalna znakowa niezerowa z przypisaną wartością ‘DRUGA’.
-- ciąg zwracany to łańcuch składający się z: wartości zmiennej lokalnej, ciągu wejściowego
-- oraz numeru wejściowego
-- Utwórz blok anonimowy o następujących własnościach, w którym znajdzie się:
--
-- zadeklarowany ciąg lokalny
-- wywołana procedura DRUGA z parametrami: ‘CZESC ’ i ciąg lokalny
-- wypisanie ciągu lokalnego
-- wywołana procedura DRUGA z parametrami: do ciągu wejściowego ‘CZESC’, do numeru wejściowego 2,
-- do ciągu wyjściowego zmienna lokalna
-- wypisanie ciągu lokalnego
-- wywołana procedura DRUGA z parametrem ciąg lokalny
-- wypisanie ciągu lokalnego
-- 3. Utwórz procedurę, podwyższającą płacę dla danego argumentem działu o określony drugim
-- argumentem procent. Wprowadź domyślne wartości dla argumentów, a także odpowiedni komentarz
-- do tabeli Dziennik (tabela o trzech kolumnach: identyfikator, data zmiany i komunikat o zmianie).
-- W procedurze zaktualizuj atrybut placa i wstaw komunikat do dziennika w postaci:
-- W dziale .... wprowadzono podwyzke o … procent) Jeśli numer działu to zero, podnieś płacę
-- wszystkim pracownikom i wstaw odpowiedni komunikat do tabeli Dziennik.
--
-- 4. Zdefiniuj funkcję zwracającą udział procentowy działu w budżecie firmy. Wywołaj ją wewnątrz
-- zapytania dającego wynik w postaci dwóch kolumn: id_dzialu, udzial_w_budzecie.
--
-- 5. Utwórz procedurę monitorującą, czy pracownicy nie przekroczyli średnich zarobków na swoich
-- stanowiskach. W tym celu:
--
-- a. Wyłącz wyzwalacz SECURE_EMPLOYEES (jeśli istnieje)
--
-- b. W tabeli EMPLOYEES dodaj kolumnę EXCEED_AVGSAL, która będzie przechowywała do trzech znaków z
-- domyślną wartością NO. Uwzględnij ograniczenie CHECK, pozwalające na wprowadzanie tylko dwóch
-- możliwych wartości YES i NO.
--
-- c. Napisz procedurę CHECK_AVGSAL, która sprawdzi, czy wynagrodzenie każdego pracownika nie
-- przekracza średniego wynagrodzenia dla jego stanowiska. Średnie wynagrodzenie dla stanowiska
-- jest obliczane jako średnia arytmetyczna z wynagrodzenia minimalnego i maksymalnego w tabeli
-- JOBS. Jeśli przekracza, to wartość w kolumnie EXCEED_AVGSAL tabeli EMPLOYEES powinna być ustawiana
-- na YES, w przeciwnym wypadku - NO. Użyj kursora z klauzulą FOR UPDATE (sprawdź w dokumentacji
-- jej opis i zastosowanie).
--
-- d. Wykonaj procedurę i sprawdź poprawność jej działania.
----------------------------------------------------------------------------------------------------------------

-- wyswietlanie komunikatow
DESC DBMS_OUTPUT;
SET SERVEROUTPUT ON;

-- PODPUNKT 1 --
CREATE OR REPLACE PROCEDURE PIERWSZA(parametr NUMBER) IS
BEGIN
    DBMS_OUTPUT.put_line('Wartosc prarametru wynosila: '||parametr);
END;
/

CALL pierwsza(5);
EXECUTE pierwsza(5);

-- PODPUNKT 2 --
CREATE OR REPLACE PROCEDURE DRUGA(we_znaki IN VARCHAR := null,
                                  wy_znaki OUT VARCHAR,
                                  we_nr IN NUMBER := 1) IS
    lokal VARCHAR(10) := 'DRUGA';
BEGIN
    wy_znaki := lokal || ' ' || we_znaki || ' ' || we_nr;
END;
/

DECLARE
    LOKAL VARCHAR(50);
BEGIN
    druga('CZESC', LOKAL);
    DBMS_OUTPUT.put_line(LOKAL);

    druga('CZESC', LOKAL, 2);
    DBMS_OUTPUT.put_line(LOKAL);

    druga(LOKAL, LOKAL);
    DBMS_OUTPUT.put_line(LOKAL);
END;
/

-- PODPUNKT 3 --
DROP TABLE DZIENNIK;
CREATE TABLE DZIENNIK (
    IDENTYFIKATOR NUMBER(5),
    DATA_ZMIANY   DATE,
    KOMUNIKAT     VARCHAR2(300)
);
/

CREATE OR REPLACE PROCEDURE TRZECIA
(nr_dzialu hr.employees.department_id%type := 10,
 procent NUMBER := 10) IS
BEGIN
    IF nr_dzialu = 0
    THEN
        UPDATE hr.employees SET salary = salary + salary * (procent/100);
        INSERT INTO dziennik VALUES (nr_dzialu, (SELECT current_date FROM dual), 'Kazdy pracownik otrzymal podwyzke o ' || procent || ' procent');
    ELSE
        UPDATE hr.employees SET salary = salary + salary * (procent/100) WHERE department_id=nr_dzialu;
        INSERT INTO dziennik VALUES (nr_dzialu, (SELECT current_date FROM dual), 'W dziale ' || nr_dzialu || ' wprowadzono podwyzke o ' || procent || ' procent');
    END IF;
END;
/

-- PODPUNKT 4 --
CREATE OR REPLACE PROCEDURE CZWARTA(NR_DZIALU HR.EMPLOYEES.DEPARTMENT_ID%TYPE)
    RETURN NUMBER IS
    budzet_dzialu NUMBER;
budzet_wszystkich NUMBER;
BEGIN
    SELECT SUM(SALARY) INTO BUDZET_DZIALU FROM HR.EMPLOYEES WHERE DEPARTMENT_ID = NR_DZIALU;
    SELECT SUM(SALARY) INTO BUDZET_WSZYSTKICH FROM HR.EMPLOYEES;
    RETURN 100 * BUDZET_DZIALU / BUDZET_WSZYSTKICH;
END;
/

SELECT DEPARTMENT_ID, CZWARTA(DEPARTMENT_ID)
FROM HR.DEPARTMENTS;

-- PODPUNKT 5 --

-- a)
ALTER TRIGGER SECURE_EMPLOYEES DISABLE;

-- b)
ALTER TABLE HR.EMPLOYEES
    ADD EXCEED_AVGSAL VARCHAR(3) DEFAULT 'NO'
        CONSTRAINT EXCEED_AVGSAL_CHECK CHECK ( EXCEED_AVGSAL = 'YES' OR EXCEED_AVGSAL = 'NO');

-- c)
CREATE OR REPLACE PROCEDURE CHECK_AVGSAL IS
    CURSOR MY_CUR IS
        SELECT EMPLOYEE_ID, JOB_ID, SALARY
        FROM HR.EMPLOYEES FOR UPDATE OF EXCEED_AVGSAL;
    E_ID    HR.EMPLOYEES.EMPLOYEE_ID%TYPE;
    J_ID    HR.EMPLOYEES.JOB_ID%TYPE;
    E_SAL   HR.EMPLOYEES.SALARY%TYPE;
    AVG_SAL HR.EMPLOYEES.SALARY%TYPE;

BEGIN
    OPEN MY_CUR;
    LOOP
        FETCH MY_CUR INTO E_ID, J_ID, E_SAL;
        EXIT WHEN MY_CUR%NOTFOUND;

        SELECT (MIN_SALARY + MAX_SALARY) / 2 INTO AVG_SAL FROM HR.JOBS WHERE J_ID = JOB_ID;

        IF (E_SAL > AVG_SAL)
        THEN
            UPDATE HR.EMPLOYEES SET EXCEED_AVGSAL='YES' WHERE EMPLOYEE_ID = E_ID;
        ELSE
            UPDATE HR.EMPLOYEES SET EXCEED_AVGSAL='NO' WHERE EMPLOYEE_ID = E_ID;
        END IF;
    END LOOP;
    CLOSE MY_CUR;
END;
/

-- d)
SELECT *
FROM HR.EMPLOYEES;
EXECUTE CHECK_AVGSAL;
SELECT *
FROM HR.EMPLOYEES;
