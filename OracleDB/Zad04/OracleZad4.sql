-- MICHAŁ KIDAWA    216796 --
-- KAMIL KOWALEWSKI 216806 --

----------------------------------------------------------------------------------------------------------------
-- 1. Przyłączyć się do bazy danych jako administrator.
--
-- 2. Wyświetlić następujące informacje o wszystkich użytkownikach bazy:
--
-- nazwę użytkownika,
-- hasło (w postaci zakodowanej),
-- datę utworzenia użytkownika,
-- nazwę domyślnej przestrzeni tabel,
-- nazwę tymczasowej przestrzeni tabel,
-- status użytkownika,
-- nazwę profilu, który przydzielono użytkownikowi.
-- 3. Utworzyć dwóch nowych użytkowników o następujących parametrach:
--
-- nazwa użytkownika: uzytk_1 | hasło: test_uzytk_1 | domyślna przestrzeń tabel: users |
-- tymczasowa przestrzeń tabel: temp | profil: default
--
-- nazwa użytkownika: uzytk_2 | hasło: test_uzytk_2 | domyślna przestrzeń tabel: users |
-- tymczasowa przestrzeń tabel: temp | profil: default.
--
-- 4. Sprawdzić, jakie ograniczenia na użycie miejsca w przestrzeniach tabel mają obaj
-- użytkownicy (Podpowiedź: Widok dba_ts_quotas zawiera informacje o ograniczeniach,
-- czyli jeśli nie ma tam wpisu dotyczącego określonego użytkownika, oznacza to, że
-- użytkownik ten nie ma nałożonych ograniczeń). Następnie zdefiniować dla nich następujące
-- ograniczenia: dla przestrzeni SYSTEM: 10M, dla przestrzeni USERS: 50M.
--
-- 5. Uruchomić w drugim oknie Sql*Plus  i spróbować przyłączyć się do bazy danych jako
-- użytkownik uzytk_1.
--
-- 6. Z okna administratora wydać polecenie umożliwiające użytkownikowi uzytk_1 przyłączenie
-- się do bazy danych.
--
-- 7. Ponownie spróbować przyłączyć się do bazy jako uzytk_1.
--
-- 8. Ten sam przywilej nadać również użytkownikowi uzytk_2.
--
-- 9. Jako użytk_1 spróbować utworzyć tabelę test o następującym schemacie: Id number(4),
-- Nazwa varchar2(100)
--
-- 10. Sprawdzić w odpowiednich widokach słownika danych, jakie przywileje obiektowe i systemowe
-- posiada użytkownik uzytk_1. Podpowiedź: dba_role_privs | dba_sys_privs | dba_tab_privs
--
-- 11. Jako administrator (konsola administracyjna) nadać użytkownikowi uzytk_1 odpowiedni
-- przywilej systemowy i spróbować ponownie z konsoli tego użytkownika utworzyć tabelę test.
--
-- 12. Jako użytkownik uzytk_1 spróbować wstawić do tabeli test dwa rekordy o wartościach:
-- {1, pierwszy rekord} i {2, drugi rekord}. Zatwierdzić wprowadzone dane.
--
-- 13. W trzecim oknie przyłączyć się do bazy jako użytkownik uzytk_2 i spróbować odczytać
-- wszystkie rekordy tabeli test użytkownika uzytk_1.
--
-- 14. Jako użytkownik uzytk_1 wydać polecenie umożliwiające użytkownikowi uzytk_2 wykonać
-- poprzednią operację.
--
-- 15. Jako użytkownik uzytk_1 nadać użytkownikowi uzytk_2 możliwość dodawania rekordów do
-- tabeli test w schemacie użytkownika uzytk_1. Przywilej ma być nadany z opcją administracyjną
-- (możliwość dalszego przekazania przywileju). Sprawdzić działanie poprzez wstawienie jako
-- użytkownik uzytk_2 kolejnego rekordu {3, trzeci rekord} do tabeli test.
--
-- 16. Jako uzytk_2 przekazać poprzedni przywilej nowemu użytkownikowi test_a (ma już prawa do
-- podłączenia się do bazy i tworzenia podstawowych zasobów), jednak bez opcji administracyjnej.
--
-- 17. W czwartym oknie przyłączyć się do bazy jako użytkownik test_a i spróbować wstawić do
-- tabeli test kolejny rekord {4, czwarty rekord}.
--
-- 18. Jako administrator wyświetlić informacje o wszystkich przywilejach (zarówno systemowych
-- jak i obiektowych), posiadanych przez użytkowników: uzytk_1, uzytk_2 i test_a.
--
-- 19. Jako użytkownik uzytk_1 odebrać użytkownikowi uzytk_2 prawo wstawiania rekordów do
-- tabeli test. Sprawdzić, czy użytkownik uzytk_2 może jeszcze wstawiać rekordy do tabeli
-- test. Sprawdzić, czy użytkownik test_a zachował prawo wstawiania rekordów do tabeli test.
--
-- 20. Jako użytkownik uzytk_1 odebrać użytkownikowi uzytk_2 wszystkie prawa do tabeli
-- test (jednym poleceniem).
--
-- 21. Jako administrator nadać użytkownikowi uzytk_1 prawo tworzenia ról.
--
-- 22. Jako użytkownik uzytk_1 utworzyć rolę o następujących własnościach:
--
-- nazwa roli: zmiana_danych | przywileje w roli: odczytywanie, wstawianie, usuwanie
-- i modyfikowanie danych tabeli test.
--
-- 23. Nadać rolę użytkownikowi uzytk_2.
--
-- 24. Sprawdzić w oknie użytkownika uzytk_2, czy może modyfikować dane tabeli test
-- (np. usuwać rekordy) Dlaczego operacja modyfikacji kończy się niepowodzeniem mimo
-- tego, że uzytk_2 otrzymał rolę zmiana_danych?
--
-- 25. Wylogować użytkownika uzytk_2 i przyłączyć go ponownie do bazy. Sprawdzić, czy
-- teraz przywileje, związane z rolą zmiana_danych działają.
--
-- 26. Jako użytkownik uzytk_1 utworzyć kolejną rolę o następujących własnościach:
--
-- nazwa roli: zmiana_struktury | przywileje w roli: zmiana struktury (alter) tabeli
-- test | rola identyfikowana przez hasło zmiana
--
-- 27. Nadać rolę użytkownikowi uzytk_2.
--
-- 28. Sprawdzić, czy użytkownik uzytk_2 ma prawo modyfikowania struktury tabeli test
-- użytkownika uzytk_1. W tym celu spróbować dodać do tabeli test nową kolumnę liczba
-- number(5,2). Co uzytk_2 powinien zrobić, aby mógł wykonać tę operację bez konieczności
-- ponownego przyłączenia się do bazy danych?
--
-- 29. Jako użytkownik uzytk_1 odebrać obie role użytkownikowi uzytk_2. Sprawdzić, czy
-- użytk_2 ma nadal prawa zmiany danych i struktury relacji test (bez ponownego zalogowania).
--
-- 30. Jako administrator sprawdzić w widoku słownika danych, jakie profile zostały zdefiniowane w bazie.
--
-- 31. Utworzyć nowy profil o nazwie moj_profil i następujących parametrach:
--
-- maksymalny czas trwania sesji: 15 minut | maksymalny czas bezczynności sesji: 1 minuta |
-- maksymalna liczba równoległych sesji użytkownika: 2 | Pozostałe parametry mają zachować
-- wartości domyślne.
--
-- 32. Sprawdzić, czy baza danych jest skonfigurowana w kierunku sprawdzania limitów zasobowych.
-- W tym celu odczytać wartość parametru RESOURCE_LIMIT z widoku dynamicznego gv$parameter.
-- Jeśli wartość parametru to FALSE, zmienić ją na TRUE.
--
-- 33. Przydzielić nowy profil użytkownikowi uzytk_2.
--
-- 34. Sprawdzić działanie nowego profilu. W tym celu spróbować uruchomić dodatkowe sesje
-- użytkownika uzytk_2. Sprawdzić, jak długo sesja użytkownika uzytk_2 może pozostać bezczynna.
--
-- 35. Przywrócić użytkownikowi uzytk_2 profil domyślny (default).
--
-- 36. Jako administrator sprawdzić, jacy użytkownicy są przyłączeni aktualnie do bazy danych.
-- Sprawdzić statusy ich sesji. Podpowiedź: widok dynamiczny v$session
--
-- 37. Wykonać polecenia, które usuną sesję użytkownika uzytk_1.
--
-- 38. Sprawdzić, co dzieje się z sesją użytkownika uzytk_1 po jej usunięciu.
--
--  39. Przy założeniu, że użytkownik uzytk_2 nadal pozostaje przyłączony do bazy (jeśli tak nie
--  jest, przyłączyć go), spróbować usunąć użytkownika uzytk_2. Dlaczego operacja nie kończy
--  się powodzeniem?
--
-- 40. Usunąć sesję użytkownika uzytk_2 i spróbować ponownie dokonać usunięcia użytkownika.
--
-- 41. Spróbować usunąć konto użytkownika uzytk_1. Dlaczego trzeba użyć opcji CASCADE?
--
-- 42. Jeśli w poleceniu 32 (zmiana w RESOUCE_LIMIT) została wykonana modyfikacja, przywrócić
-- poprzedni stan.
----------------------------------------------------------------------------------------------------------------

-- PODPUNKT 1 --

-- PODPUNKT 2 --
SELECT username, password, created, default_tablespace,
       temporary_tablespace, account_status, profile
FROM dba_users;

-- PODPUNKT 3 --
CREATE USER uzytk_1 IDENTIFIED BY test_uzytk_1
    DEFAULT TABLESPACE users TEMPORARY TABLESPACE temp PROFILE default;

CREATE USER uzytk_2 IDENTIFIED BY test_uzytk_2
    DEFAULT TABLESPACE users TEMPORARY TABLESPACE temp PROFILE default;

-- PODPUNKT 4 --
SELECT *
FROM dba_ts_quotas
WHERE username IN ('UZYTK_1', 'UZYTK_2');
-- "no rows selected"
ALTER USER uzytk_1 QUOTA 10 M ON system QUOTA 50 M ON users;

ALTER USER uzytk_2 QUOTA 10 M ON system QUOTA 50 M ON users;

-- PODPUNKT 5 --
-- "ORA-01045: user UZYTK_1 lacks CREATE SESSION privilege; logon denied"

-- PODPUNKT 6 --
GRANT CONNECT TO uzytk_1;

-- PODPUNKT 7 --
--Operacja zakonczona sukcesem

-- PODPUNKT 8 --
GRANT CONNECT TO uzytk_2;

-- PODPUNKT 9 --
CREATE TABLE test (
    id    NUMBER(4),
    nazwa VARCHAR2(100)
);
-- ORA-01031: insufficient privileges

-- PODPUNKT 10 --
SELECT *
FROM dba_role_privs
WHERE grantee = 'UZYTK_1';

SELECT *
FROM dba_sys_privs
WHERE grantee = 'UZYTK_1';

SELECT *
FROM dba_tab_privs
WHERE grantee = 'UZYTK_1';

-- PODPUNKT 11 --
GRANT CREATE TABLE TO uzytk_1;

CREATE TABLE test (
    id    NUMBER(4),
    nazwa VARCHAR2(100)
);
--Table created.

-- PODPUNKT 12 --
INSERT ALL
    INTO test
VALUES (1, 'pierwszy rekord')
INTO test
VALUES (2, 'drugi rekord')

SELECT *
FROM dual;

COMMIT;

-- PODPUNKT 13 --
SELECT *
FROM uzytk_1.test;
-- ORA-00942: table or view doeSELEs not exist

-- PODPUNKT 14 --
GRANT SELECT ON test TO uzytk_2;

SELECT *
FROM uzytk_1.test;

-- PODPUNKT 15 --
GRANT INSERT ON test TO uzytk_2 WITH GRANT OPTION;

INSERT INTO uzytk_1.test
VALUES (3, 'trzeci rekord');

-- PODPUNKT 16 --
CREATE USER test_a IDENTIFIED BY TEST DEFAULT TABLESPACE users QUOTA 10 m ON users;

GRANT CONNECT TO test_a;

GRANT RESOURCE TO test_a;

GRANT INSERT ON uzytk_1.test TO test_a;

-- PODPUNKT 17 --
INSERT INTO uzytk_1.test
VALUES (4, 'czwarty rekord');

-- PODPUNKT 18 --
SELECT *
FROM dba_role_privs
WHERE grantee IN ('UZYTK_1', 'UZYTK_2', 'TEST_A');

SELECT *
FROM dba_sys_privs
WHERE grantee IN ('UZYTK_1', 'UZYTK_2', 'TEST_A');

SELECT *
FROM dba_tab_privs
WHERE grantee IN ('UZYTK_1', 'UZYTK_2', 'TEST_A');

-- PODPUNKT 19 --
REVOKE INSERT ON test FROM uzytk_2;

INSERT INTO uzytk_1.test
VALUES (5, 'piąty rekord');
-- nie może wykonąć tej operacji

-- PODPUNKT 20 --
REVOKE ALL ON test FROM uzytk_2;

-- PODPUNKT 21 --
GRANT CREATE ROLE TO uzytk_1;

-- PODPUNKT 22 --
CREATE ROLE zmiana_danych;

GRANT SELECT, INSERT, DELETE, UPDATE ON test TO zmiana_danych;

-- PODPUNKT 23 --
GRANT zmiana_danych TO uzytk_2;

-- PODPUNKT 24 --
DELETE
FROM uzytk_1.test;
-- rola nie jest aktywna dla danej sesji: table or view does not exist

-- PODPUNKT 25 --
DISCONNECT

CONNECT

SELECT *
FROM uzytk_1.test;
-- przywileje działają i usuniecie jest możliwe

-- PODPUNKT 26 --
CREATE ROLE zmiana_struktury IDENTIFIED BY zmiana;

GRANT ALTER ON test TO zmiana_struktury;

-- PODPUNKT 27 --
GRANT zmiana_struktury TO uzytk_2;

-- PODPUNKT 28 --
--należy wykonac poniższy polecenie aby nie trzeba było sie rozłączać z bazą
SET ROLE zmiana_struktury IDENTIFIED BY zmiana;

ALTER TABLE uzytk_1.test
    ADD liczba NUMBER(5, 2);

-- PODPUNKT 29 --
REVOKE zmiana_struktury, zmiana_danych FROM uzytk_2;
-- wciąż może

-- PODPUNKT 30 --
SELECT *
FROM dba_profiles;

-- PODPUNKT 31 --
CREATE PROFILE moj_profil LIMIT CONNECT_TIME 15 IDLE_TIME 1 SESSIONS_PER_USER 2;

-- PODPUNKT 32 --
SELECT value
FROM v$parameter
WHERE name = 'resource_limit';

ALTER SYSTEM SET resource_limit= TRUE SCOPE = BOTH;

-- PODPUNKT 33 --
ALTER USER uzytk_2 PROFILE moj_profil;

-- PODPUNKT 34 --
-- maksymalnie 2 sesje
-- po 1 bezczynności wylogowanie

-- PODPUNKT 35 --
ALTER USER uzytk_2 PROFILE default;

-- PODPUNKT 36 --
SELECT username, status
FROM v$session;

-- PODPUNKT 37 --
SELECT sid, serial#
FROM v$session
WHERE username = 'UZYTK_1';

ALTER SYSTEM KILL SESSION '12, 7' IMMEDIATE;
-- SESSION 'sid, serial#'

-- PODPUNKT 38 --
-- connection lost contact

-- PODPUNKT 39 --
DROP USER uzytk_2;
--dlatego ze użytkownik jest aktualnie podłączony

-- PODPUNKT 40 --
SELECT sid, serial#
FROM v$session
WHERE username = 'UZYTK_2';

ALTER SYSTEM KILL SESSION '17, 189' IMMEDIATE;

DROP USER uzytk_2;
--usuniecie zakonczone powodzeniem

-- PODPUNKT 41 --
DROP USER uzytk_1 CASCADE;
-- bo posiada tabele 'test', więc trzeba się też jej pozbyć

-- PODPUNKT 42 --
ALTER SYSTEM SET resource_limit= FALSE SCOPE = BOTH;
