-- Kamil Kowalewski 216806 --
-- Wtorek 2.06.2020r Kolokwium ABDO

-- ---------------------------------------------------------------------------------------------- --
--     TRESCI ZADAN - ROZWIAZANIA SA PONIZEJ W KOLENOSCI ROSNACEJ

-- ZADANIE 1:STWORZYĆ BLOK ANONIMOWY, KTÓRY PRZY UŻYCIU KURSORA DLA KAŻDEGO
-- PRACOWNIKA Z TABELI PRACOWNICY WYPISUJE NA EKRANIE TEKST:
-- 'PRACOWNIK NAZWISKO PRACUJE W DZIALE NAZWA_DZIALU',
-- GDZIE NAZWISKO POCHODZI Z TABELI PRACOWNICY. NAZWA_DZIALU Z TABELI DZIALY
--
-- ZADANIE 2: STWORZYĆ PROCEDURĘ, KTÓRA POBIERA NAZWISKO PRACOWNIKA JAKO PARAMETR, ZWIEKSZA
-- PLACE MINIMALNA DLA STANOWISKA TEGO PRACOWNIKA O 10% I WYPISUJE KOMUNIKAT INFORMUJACY O TYM,
-- ZE OPERACJA SIE POWIODLA. JEZELI NIE ZNAJDZIE TAKIEGO PRACOWNIKA, TO WYPISUJE ODPOWIEDNI KOMUNIKAT
-- POPRZEZ OBSLUGE BLEDOW. W SEKCJI DEKLARATYWNEJ PROCEDURY MUSI ZOSTAC ZDEFINIOWANY WYJATEK KTORY MUSI
-- ZOSTAC WYGENEROWANY W CIELE PROCEDURY I OBSLUZONY W SEKCJI EXCEPTION PROCEDURY
--
-- ZADANIE 3: STWORZYĆ FUNKCJĘ, KTÓRA POBIERA KTORA POBIERA NAZWE DZIALU JAKO PARAMETR OBLICZA
-- SUME ZAROBKOW DLA PODANEGO DZIALU WYPISJE ORAZ ZWRACA OBLICZONA WARTOSC. JEZELI NIE ZNAJDZIE TAKIEGO
-- DZIALU TO WYPISUJE ODPOWIEDNI KOMUNIKAT POPRZEZ OBSLUGE BLEDOW
--
-- ZADANIE 4: STWORZYĆ TRIGER, KTÓRY MONITORUJE WSZYSTKIE ZMIANY W TABELI STANOWISKA
-- I ZAPISUJE STARE WARTOSCI (ZMIENIANE LUB USUWANE) Z TEJ TABELI DO INNEJ TABELI O TAKIEJ SAMEJ
-- STRUKTURZE CO TABELA STANOWISKA
-- GENEROWANIE TABELI
-- CREATE TABLE stanowiska_archiwum as select * from stanowiska;
-- delete from stanowiska_archiwum;
--

-- ---------------------------------------------------------------------------------------------- --


SET SERVEROUTPUT ON;

-- 1 ---------------------------------------------------------------------------------------------- --

-- DUPLIKAT ExtraA.SQL

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
        UPDATE stanowiska SET placa_min = placa_min * 1.1 WHERE stanowisko = var_stanowisko;
        dbms_output.put_line(
                    'Placa min na stanowisku ' || var_stanowisko || ' zostala podsniesona o 10%');
    END IF;
EXCEPTION
    WHEN wyjatek
        THEN
            dbms_output.put_line('Nazwisko ' || param_nazwisko || ' nie zostalo znalezione ');
END;

-- wywolanie
SELECT a.nazwisko, b.stanowisko, b.placa_min
FROM pracownicy a, stanowiska b
WHERE a.stanowisko = b.stanowisko
  AND a.nazwisko = 'KROL';

CALL procedura_2('KROL');

SELECT a.nazwisko, b.stanowisko, b.placa_min
FROM pracownicy a, stanowiska b
WHERE a.stanowisko = b.stanowisko
  AND a.nazwisko = 'KROL';

ROLLBACK;



-- 3 ---------------------------------------------------------------------------------------------- --

-- DUPLIKAT Extra1.SQL

-- 4 ---------------------------------------------------------------------------------------------- --

-- DUPLIKAT ExtraB.SQL


-- DROP TABLE pracownicy;
-- DROP TABLE stanowiska;
-- DROP TABLE dzialy;
