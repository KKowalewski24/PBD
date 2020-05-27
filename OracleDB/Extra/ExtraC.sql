-- 1
-- Utwórz blok anonimowy, w którym za pomocą kursora z parametrem w postaci numeru działu
-- > wypisane zostaną nazwiska wszystkich pracowników z podanego działu
-- > na koniec zostanie wypisany komunikat "Dział .. zatrudnia .. pracowników" lub "Podany
-- dział nie zatrudnia pracowników"

-- 2
-- Napisz procedurę, która:
-- > w dziale o numerze podanym jako parametr, zwiększy wszystkim jego pracownikom pensję o 10%
-- > na koniec wypisany zostanie komunikat, że pracownikom została zmieniona pensja.
-- > Dodaj obsługę błędów dla przypadku, gdy numer działu nie zostanie odnaleziony.
-- > Napisz blok z wywołaniem tej procedury

-- 3
-- Napisz funkcję, która dla podanego działu obliczy różnicę pomiędzy maksymalnym i minimalnym
-- wynagrodzeniem w tym dziale. Funkcję wywołaj w zapytaniu dającym wynik w postaci dwóch
-- kolum: id_działu, różnica

-- 4
-- Utwórz wyzwalacz, który przy wstawaniu nowego rekordu dla tabeli countries, jeśli
-- użytkownik nie poda nazwy państwa (country_name), będzie wpisywał pod nazwę
-- państwa wartość 'Nowa nazwa'


SET SERVEROUTPUT ON;

-- ---------------------------------------------------------------------------------------------- --

DECLARE
    CURSOR kursor_1_c(param_id_dzialu dzialy.id_dzialu%TYPE) IS
        SELECT nazwisko
        FROM pracownicy
        WHERE id_dzialu = param_id_dzialu;
    var_nazwisko  pracownicy.nazwisko%TYPE;
    var_id_dzialu pracownicy.id_dzialu%TYPE := 10;
BEGIN
    OPEN kursor_1_c(var_id_dzialu);
    LOOP
        FETCH kursor_1_c INTO var_nazwisko;
        IF kursor_1_c%NOTFOUND
        THEN
            IF kursor_1_c%ROWCOUNT = 0
            THEN
                dbms_output.put_line('Podany dzial nie zatrudnia pracownikow');
            ELSE
                dbms_output.put_line(
                            'Dzial ' || var_id_dzialu || ' zatrudnia ' || kursor_1_c%ROWCOUNT ||
                            ' pracownikow.');
            END IF;
            EXIT;
        END IF;
        dbms_output.put_line(var_nazwisko);
    END LOOP;
    CLOSE kursor_1_c;
END;


-- ---------------------------------------------------------------------------------------------- --

CREATE OR REPLACE PROCEDURE procedura_2_c(param_id_dzialu dzialy.id_dzialu%TYPE) IS
    wyjatek EXCEPTION;
    var_licznik NUMBER;
BEGIN
    SELECT count(*) INTO var_licznik FROM dzialy WHERE id_dzialu = param_id_dzialu;
    IF var_licznik = 0
    THEN
        RAISE wyjatek;
    ELSE
        UPDATE pracownicy SET placa=1.1 * placa WHERE id_dzialu = param_id_dzialu;
        dbms_output.put_line('Dzial ' || param_id_dzialu || ' ma zwiekszone pensje o 10%.');
    END IF;
EXCEPTION
    WHEN wyjatek
        THEN
            dbms_output.put_line('Dzial ' || param_id_dzialu || ' nie zostal odnaleziony.');
END;

-- wywolanie
SELECT placa
FROM pracownicy
WHERE id_dzialu = '10';

CALL procedura_2_c(15);
CALL procedura_2_c(10);

SELECT placa
FROM pracownicy
WHERE id_dzialu = '10';

ROLLBACK;


-- ---------------------------------------------------------------------------------------------- --



-- ---------------------------------------------------------------------------------------------- --
CREATE OR REPLACE TRIGGER wyzwalacz_4_c
    BEFORE INSERT
    ON stanowiska
    FOR EACH ROW
    WHEN ( new.stanowisko IS NULL )
BEGIN
    :new.stanowisko := 'sample';
END;

SELECT *
FROM stanowiska
WHERE stanowisko = 'sample';

INSERT INTO stanowiska
VALUES (NULL, 12, 18);

SELECT *
FROM stanowiska
WHERE stanowisko = 'sample';


ROLLBACK;
