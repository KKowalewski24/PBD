-- Kamil Kowalewski 216806 --
-- Wtorek 2.06.2020r Kolokwium ABDO

-- ---------------------------------------------------------------------------------------------- --
--     TRESCI ZADAN - ROZWIAZANIA SA PONIZEJ W KOLENOSCI ROSNACEJ

-- ZADANIE 1:STWORZYĆ BLOK ANONIMOWY, KTÓRY PRZY UŻYCIU KURSORA DLA KAŻDEGO PRACOWNIKA
-- Z TABELI PRACOWNICY WYPISUJE NA EKRANIE TEKST:
-- 'SZEFEM PRACOWNIKA NAZWISKO JEST NAZWISKO_SZEFA', GDZIE NAZWISKO ORAZ NAZWISKO_SZEFA
-- POCHODZĄ Z TABELI PRACOWNICY
--
-- ZADANIE 2: STWORZYĆ PROCEDURĘ, KTÓRA POBIERA NAZWISKO PRACOWNIKA JAKO PARAMETR,
-- ZWIĘKSZA PŁACĘ MAKSYMALNĄ DLA STANOWISKA TEGO PRACOWNIKA O 10% I WYPISUJE KOMUNIKAT
-- INFORMUJĄCY O TYM, ŻE OPERACJA SIĘ POWIODŁA.
-- JEZELI NIE ZNAJDZIE TAKIEGO PRACOWNIKA, TO WYPISUJE ODPOWIEDNI KOMUNIKAT POPRZEZ OBSLUGĘ BŁĘDÓW.
-- W SEKCJI DEKLARATYWNEJ PROCEDURY MUSI ZOSTAĆ ZDEFINIOWANY WYJĄTEK, KTÓRY MUSI ZOSTAĆ
-- WYGENEROWANY W CIELE PROCEDURY I OBSŁUŻONY W SEKCJI EXCEPTION PROCEDURY
--
-- ZADANIE 3: STWORZYĆ FUNKCJĘ, KTÓRA POBIERA NAZWĘ DZIAŁU JAKO PARAMETR, OBLICZA
-- WARTOŚĆ MINIMALNEJ PŁACY DLA PODANEGO DZIAŁU, WYPISUJE ORAZ ZWRACA OBLICZONĄ WARTOŚĆ.
-- JEZELI NIE ZNAJDZIE TAKIEGO DZIAŁU, TO WYPISUJE ODPOWIEDNI KOMUNIKAT POPRZEZ OBSLUGĘ BŁĘDÓW.
--
--
-- ZADANIE 4: STWORZYĆ TRIGER, KTÓRY MONITORUJE WSZYSTKIE ZMIANY W TABELI
-- PRACOWNICY I ZAPISUJE STARE WARTOŚCI (WARTOŚCI ZMIENIANE LUB USUWANE)
-- Z TEJ TABELI DO INNEJ TABELI O TAKIEJ SAMEJ STRUKTURZE CO TABELA PRACOWNICY.
-- TABELĘ DANYCH HISTORYCZNYCH MOŻNA WYGENEROWAĆ PRZY UŻYCIU POLECENIA
-- CREATE TABLE PRACOWNICY_ARCHIWUM AS SELECT * FROM PRACOWNICY;
-- DELETE FROM PRACOWNICY_ARCHIWUM;

-- ---------------------------------------------------------------------------------------------- --


SET SERVEROUTPUT ON;

-- 1 ---------------------------------------------------------------------------------------------- --
DECLARE
    nazw_kier pracownicy.nazwisko%TYPE;
BEGIN
    FOR c1 IN (SELECT * FROM pracownicy WHERE kierownik IS NOT NULL)
        LOOP
            SELECT p.nazwisko
            INTO nazw_kier
            FROM pracownicy p
            WHERE p.nr_akt = c1.kierownik;
            dbms_output.put_line(
                        'Szefem pracownika ' || c1.nazwisko || ' jest pracownik ' || nazw_kier);
        END LOOP;
END;

DECLARE
    CURSOR kursorzad1 IS
        SELECT nazwisko, kierownik
        FROM pracownicy;
    nazwiskopracownikavar pracownicy.nazwisko%TYPE;
    idkierownikavar       pracownicy.nazwisko%TYPE;
    kierownikcount        NUMBER := 0;
    nazwiskoszefavar      pracownicy.nazwisko%TYPE;
BEGIN
    OPEN kursorzad1;
    LOOP
        FETCH kursorzad1 INTO nazwiskopracownikavar, idkierownikavar;
        IF kursorzad1%NOTFOUND
        THEN
            EXIT ;
        END IF;

        SELECT count(*) INTO kierownikcount FROM pracownicy WHERE nr_akt = idkierownikavar;
        IF kierownikcount = 0
        THEN
            dbms_output.put_line('Pracownik ' || nazwiskopracownikavar || ' nie ma szefa');
        ELSE
            SELECT nazwisko INTO nazwiskoszefavar FROM pracownicy WHERE nr_akt = idkierownikavar;
            dbms_output.put_line('SZEFEM PRACOWNIKA ' || nazwiskopracownikavar || ' JEST ' ||
                                 nazwiskoszefavar);
        END IF;

    END LOOP;
    CLOSE kursorzad1;
END;

DECLARE
    CURSOR kursor_1 IS
        SELECT nazwisko, kierownik
        FROM pracownicy;
--    zmienne
    var_licznik            NUMBER := 0 ;
    var_pracownik_nazwisko pracownicy.nazwisko%TYPE;
    var_szef_nazwisko      pracownicy.nazwisko%TYPE;
    var_szef_id            pracownicy.nr_akt%TYPE;
BEGIN
    OPEN kursor_1;
    LOOP
        FETCH kursor_1 INTO var_pracownik_nazwisko, var_szef_id;
        IF kursor_1%NOTFOUND
        THEN
            EXIT;
        END IF;
        SELECT count(*) INTO var_licznik FROM pracownicy WHERE nr_akt = var_szef_id;

        IF var_licznik = 0
        THEN
            dbms_output.put_line('Pracownik ' || var_pracownik_nazwisko || ' nie ma szefa');
        ELSE
            SELECT nazwisko INTO var_szef_nazwisko FROM pracownicy WHERE nr_akt = var_szef_id;
            dbms_output.put_line('SZEFEM PRACOWNIKA ' || var_pracownik_nazwisko || ' JEST ' ||
                                 var_szef_nazwisko);
        END IF;
    END LOOP;
    CLOSE kursor_1;
END;

-- 2 ---------------------------------------------------------------------------------------------- --

CREATE OR REPLACE PROCEDURE procedura_2(param_nazwisko pracownicy.nazwisko%TYPE) IS
    wyjatek EXCEPTION;
-- todo zmienna
    var_licznik    NUMBER;
    var_stanowisko stanowiska.stanowisko%TYPE;
BEGIN
    SELECT count(*) INTO var_licznik FROM pracownicy WHERE nazwisko = param_nazwisko;
    SELECT stanowisko INTO var_stanowisko FROM pracownicy WHERE nazwisko = param_nazwisko;
    IF var_licznik = 0
    THEN
        RAISE wyjatek;
    ELSE
        UPDATE stanowiska SET placa_max = placa_max * 1.1 WHERE stanowisko = var_stanowisko;
        dbms_output.put_line(
                    'Placa max na stanowisku ' || var_stanowisko || ' zostala podsniesona o 10%');
    END IF;
EXCEPTION
    WHEN wyjatek
        THEN
            dbms_output.put_line('Nazwisko ' || param_nazwisko || ' nie zostalo znalezione ');
END;

-- wywolanie
SELECT a.nazwisko, b.stanowisko, b.placa_max
FROM pracownicy a, stanowiska b
WHERE a.stanowisko = b.stanowisko
  AND a.nazwisko = 'KROL';

CALL procedura_2('KROL');

SELECT a.nazwisko, b.stanowisko, b.placa_max
FROM pracownicy a, stanowiska b
WHERE a.stanowisko = b.stanowisko
  AND a.nazwisko = 'KROL';

ROLLBACK;


-- 3 ---------------------------------------------------------------------------------------------- --

-- DUPLIKAT EXTRA1.SQL

-- 4 ---------------------------------------------------------------------------------------------- --

CREATE TABLE pracownicy_archiwum AS
SELECT *
FROM pracownicy;
DELETE
FROM pracownicy_archiwum;

CREATE OR REPLACE TRIGGER wyzwalacz_4
    BEFORE UPDATE OR DELETE
    ON pracownicy
    FOR EACH ROW
BEGIN
    INSERT INTO pracownicy_archiwum
    VALUES (:old.nr_akt,
            :old.nazwisko,
            :old.stanowisko,
            :old.kierownik,
            :old.data_zatr,
            :old.data_zwol,
            :old.placa,
            :old.dod_funkcyjny,
            :old.prowizja,
            :old.id_dzialu);
END;

SELECT nazwisko, placa
FROM pracownicy
WHERE nazwisko = 'KROL';

UPDATE pracownicy
SET placa=10
WHERE nazwisko = 'KROL';

SELECT nazwisko, placa
FROM pracownicy
WHERE nazwisko = 'KROL';

SELECT nazwisko, placa
FROM pracownicy_archiwum
WHERE nazwisko = 'KROL';

ROLLBACK;
--
--
-- DROP TABLE pracownicy;
-- DROP TABLE stanowiska;
-- DROP TABLE dzialy;
