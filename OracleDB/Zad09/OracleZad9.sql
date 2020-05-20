-- MICHAŁ KIDAWA    216796 --
-- KAMIL KOWALEWSKI 216806 --

----------------------------------------------------------------------------------------------------------------
-- Obejrzyj (DESC) polecenia pakietu DBMS_OUTPUT.
--
-- Ustaw zmienną SERVEROUTPUT, która umożliwi wyświetlanie komunikatów.
--
-- 1. Utwórz blok anonimowy wypisujący na ekranie „Czesc, to ja” (wypisywać można łańcuch znaków,
-- DATE i NUMBER, pozostałe: TO_CHAR(.....)). Wykorzystaj w tym celu pakiet DBMS_OUTPUT.
--
-- 2. Utwórz blok anonimowy, który zawiera:   deklarację zmiennej numerycznej, przypisanie jej
-- wartości, wypisanie jej na ekranie (ZMIENNA = ......)
--
-- 3. Utwórz prosty blok anonimowy z zadeklarowaną zmienną wykorzystujący najbardziej złożoną
-- postać wyrażenia warunkowego i wypisujący rezultat na ekranie.
--
-- 4. Wykorzystując pętlę LOOP, FOR  oraz WHILE , utwórz blok anonimowy wypisujący w pętli:
--
-- zmienna ma wartosc 1
-- zmienna ma wartosc 2
-- zmienna ma wartosc 3
-- zmienna ma wartosc 4
--
-- Utwórz tabelę ODDZIALY o dwóch polach: NR_ODD (number (10)) i NAZWA_ODD (varchar(30)).
--
-- Wprowadź do tej tabeli nazwy 4 działów: księgowość, zbyt, płace oraz transport.
--
-- 5. Utwórz blok anonimowy wypisujący na ekranie nazwę wybranego oddziału
-- (np. o numerze 4 - KSIEGOWOSC) w postaci: Nazwa oddzialu to: .................
--
--  W tym celu:
--
-- zadeklaruj zmienną NAZWA_ODDZIALU (taki sam typ jak w tabeli) ,
-- wynik zapytania SELECT prześlij do tej zmiennej (SELECT ... INTO ... FROM ... WHERE ...),
--                        wypisz linię za pomocą odpowiedniego polecenia.
-- 6. Wykorzystując atrybuty kursora niejawnego SQL%FOUND i SQL%ROWCOUNT utwórz blok anonimowy,
-- który usuwa z tabeli ODDZIALY te rekordy których numer jest większy od dwóch (przy założeniu,
-- że oddziały ponumerowane są kolejno i jest ich więcej niż 2), i następnie jeśli usunął jakieś
-- oddziały, to wypisuje ich liczbę (liczba usuniętych rekordow to: ....)
--
-- 7. Wykorzystując atrybut kursora niejawnego SQL%NOTFOUND utwórz blok anonimowy, który zmienia
-- nazwę oddziału o numerze 3, a jeśli taki numer nie istnieje (ma nie istnieć !!!!), to dodaje
-- nowy wiersz do tabeli o tym numerze oddziału i nazwie.
--
-- 8. Zdefiniuj sekwencję liczba_seq (definicja poniżej) oraz tabelę numer o jednym polu
-- typu NUMBER(3), zadeklaruj blok anonimowy wstawiający 20 kolejnych wartości sekwencji do tabeli numer.
--
-- CREATE SEQUENCE liczba_seq
--     INCREMENT BY 5
--     START WITH 100
--     MINVALUE 0
--     MAXVALUE 125 CYCLE;
--
-- Przydatne również:
-- SELECT * FROM USER_SEQUENCES; SELECT liczba_seq.currval FROM DUAL; SELECT liczba_seq.nextval FROM DUAL;
--
-- Utwórz tabelę dziennik składającą się z pól: tabela (piętnastoznakowe), data, l_wierszy
-- (czterocyfrowe), komunikat (trzystuznakowe).
--
-- CREATE TABLE dziennik(
--     tabela VARCHAR2(15),
--     data DATE,
--     l_wierszy NUMERIC(4),
--     komunikat VARCHAR2(300)
-- );
--
-- 9. Zadeklaruj blok anonimowy aktualizujący tabelę EMPLOYEES poprzez dodanie kierownikom
-- działów premii, której wartość przechowana jest w zmiennej. Następnie policz ile zmieniono
-- wierszy i wstaw odpowiedni komentarz do tabeli dziennik.
--
-- 10. Wykorzystaj istniejącą tabelę ODDZIALY lub utwórz jeszcze raz. Napisz blok anonimowy
-- który poprzez kursor pozwoli na wypisanie w pętli:
--
-- NUMER ODDZIALU TO: ......, NAZWA ODDZIALU TO: ......
-- NUMER ODDZIALU TO: ......, NAZWA ODDZIALU TO: ......
-- ...
--
-- Jeśli tabela jest pusta, należy również wypisać stosowny komunikat.
--
-- 11. Utwórz blok anonimowy z kursorem pobierającym jako parametr numer oddziału od którego ma
-- zacząć wypisywanie nazw oddziałów. Wartość parametru ma być podawana jawnie w kodzie podczas
-- jego otwierania.
----------------------------------------------------------------------------------------------------------------

DESC DBMS_OUTPUT;
SET SERVEROUTPUT ON;

-- PODPUNKT 1 --
BEGIN
    dbms_output.put_line('Czesc, to ja');
END;
/
-- PODPUNKT 2 --
DECLARE
    zmienna NUMBER(10);
BEGIN
    zmienna := 24;
    dbms_output.put_line('ZMIENNA = ' || zmienna);
END;
/

-- PODPUNKT 3 --
DECLARE
    log_zmienna BOOLEAN;
BEGIN
    IF (5 < 10 OR 15 < 25)
    THEN
        log_zmienna := TRUE;
    ELSE
        log_zmienna := FALSE;
    END IF;

    dbms_output.put_line('ZMIENNA = ' || log_zmienna);
END;
/

-- PODPUNKT 4 --
DECLARE
    loop_zm NUMBER(10);
BEGIN
    loop_zm := 1;
    LOOP
        dbms_output.put_line('zmienna ma wartosc ' || loop_zm);
        loop_zm := loop_zm + 1;
        EXIT WHEN loop_zm > 4;
    END LOOP;
END;
/

DECLARE
    loop_zm1 NUMBER(10);
BEGIN
    FOR loop_zm1 IN 1..4
        LOOP
            dbms_output.put_line('zmienna ma wartosc ' || loop_zm1);
        END LOOP;
END;
/

DECLARE
    loop_zm2 NUMBER(10);
BEGIN
    loop_zm2 := 1;
    WHILE loop_zm2 <= 4
        LOOP
            dbms_output.put_line('zmienna ma wartosc ' || loop_zm2);
            loop_zm2 := loop_zm2 + 1;
        END LOOP;
END;
/

CREATE TABLE oddzialy (
    nr_odd    NUMBER(10),
    nazwa_odd VARCHAR(30)
);
/

INSERT INTO oddzialy
VALUES (1, 'ksiegowosc');
INSERT INTO oddzialy
VALUES (2, 'zbyt');
INSERT INTO oddzialy
VALUES (3, 'place');
INSERT INTO oddzialy
VALUES (4, 'transport');

-- PODPUNKT 5 --
DECLARE
    nazwa_oddzialu oddzialy.nazwa_odd%TYPE;
BEGIN
    SELECT nazwa_odd INTO nazwa_oddzialu FROM oddzialy WHERE nr_odd = 1;
    dbms_output.put_line(nazwa_oddzialu);
END;
/

-- PODPUNKT 6 --
BEGIN
    DELETE FROM oddzialy WHERE nr_odd > 2;
    IF SQL%FOUND
    THEN
        dbms_output.put_line('liczba usunietych rekordow to:' || SQL%ROWCOUNT);
    END IF;
END;
/

-- PODPUNKT 7 --
BEGIN
    UPDATE oddzialy SET nazwa_odd='hr' WHERE nr_odd = 3;
    IF SQL%NOTFOUND
    THEN
        INSERT INTO oddzialy VALUES (3, 'place');
    END IF;
END;
/

-- PODPUNKT 8 --
CREATE SEQUENCE liczba_seq
    INCREMENT BY 5
    START WITH 100
    MINVALUE 0
    MAXVALUE 125 CYCLE;
/

SELECT *
FROM user_sequences;
SELECT liczba_seq.currval
FROM dual;
SELECT liczba_seq.nextval
FROM dual;

CREATE TABLE dziennik (
    tabela    VARCHAR2(15),
    data      DATE,
    l_wierszy NUMERIC(4),
    komunikat VARCHAR2(300)
);

-- PODPUNKT 9 --
DECLARE
    premia         hr.employees.salary%TYPE := 500;
    liczba_wierszy NUMERIC(4);
BEGIN
    UPDATE hr.employees
    SET salary = salary + premia
    WHERE employee_id IN (
                             SELECT DISTINCT manager_id
                             FROM hr.departments
                         );
    IF SQL%FOUND
    THEN
        liczba_wierszy := SQL%ROWCOUNT;
        INSERT INTO dziennik
        VALUES ('hr.employees', (
                                    SELECT current_date
                                    FROM dual
                                ), liczba_wierszy,
                'Kierownicy dzialu otrzymali premie w wysokosci ' || premia);
    END IF;
END;
/

SELECT *
FROM dziennik;

-- PODPUNKT 10 --
DECLARE
    CURSOR kursor_1 IS
        SELECT nr_odd, nazwa_odd
        FROM oddzialy;
    nazwa oddzialy.nazwa_odd%TYPE;
    nr    oddzialy.nr_odd%TYPE;
BEGIN
    OPEN kursor_1;
    LOOP
        FETCH kursor_1 INTO nr, nazwa;
        IF kursor_1%NOTFOUND
        THEN
            IF kursor_1%ROWCOUNT = 0
            THEN
                dbms_output.put_line('Nie istnieja zadne oddzialy');
            END IF;
            EXIT;
        END IF;
        dbms_output.put_line('NUMER ODDZIALU TO: ' || nr || ', NAZWA ODDZIALU TO: ' || nazwa);
    END LOOP;
    CLOSE kursor_1;
END;
/

-- PODPUNKT 11 --
DECLARE
    CURSOR kursor_1 (start_nr NUMBER) IS
        SELECT nr_odd, nazwa_odd
        FROM oddzialy
        WHERE nr_odd >= start_nr;
    nazwa oddzialy.nazwa_odd%TYPE;
    nr    oddzialy.nr_odd%TYPE;
BEGIN
    OPEN kursor_1(2);
    LOOP
        FETCH kursor_1 INTO nr, nazwa;
        IF kursor_1%NOTFOUND
        THEN
            IF kursor_1%ROWCOUNT = 0
            THEN
                dbms_output.put_line('Nie istnieja zadne oddzialy');
            END IF;
            EXIT;
        END IF;
        dbms_output.put_line('NUMER ODDZIALU TO: ' || nr || ', NAZWA ODDZIALU TO: ' || nazwa);
    END LOOP;
    CLOSE kursor_1;
END;
/
