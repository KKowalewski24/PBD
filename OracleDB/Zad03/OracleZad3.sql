-- MICHAŁ KIDAWA    216796 --
-- KAMIL KOWALEWSKI 216806 --

----------------------------------------------------------------------------------------------------------------
--
-- 1. Podłącz się do bazy jako sysdba.
--
-- 2. Utwórz dwa konta użytkowników do testów: test_a i test_b z hasłem test. Domyślna przestrzeń
-- tabel: users, limity 10m dla przestrzeni users.
--
-- 3. Nadaj obu użytkownikom prawo przyłączenia się do bazy danych oraz tworzenia podstawowych
-- obiektów, dodatkowo użytkownik test_b ma otrzymać prawo RESTRICTED SESSION.
--
-- 4. Przyłącz się do bazy w nowym oknie jako użytkownik test_a. Utwórz w schemacie tego
-- użytkownika tabelę test z jedną kolumną typu znakowego do 100 znaków o nazwie tekst.
-- Następnie wstaw do tabeli test jeden rekord z wartością atrybutu „pierwszy rekord”
--
-- 5. Nie kończ sesji ani transakcji użytkownika test_a. W oknie swojego użytkownika (administratora)
-- spróbuj dokonać zamknięcia bazy danych w trybie transakcyjnym. Co zaobserwowałeś?
--
-- 6. Uruchom trzecie okno linii poleceń i spróbuj przyłączyć się w nim jako użytkownik test_b. Czy
-- próba przyłączenia zakończyła się sukcesem?
--
-- 7. Zatwierdź transakcję w drugim oknie (użytkownika test_a). Czy baza danych została zamknięta?
--
-- 8. Ponownie uruchom bazę danych. Po uruchomieniu bazy danych w drugim oknie przyłącz się
-- ponownie jako użytkownik test_a i wstaw drugi rekord do tabeli test.
--
-- 9. W pierwszym oknie dokonaj zamknięcia bazy danych w trybie natychmiastowym. Co się dzieje
-- z sesją test_a?
--
-- 10. W pierwszym oknie uruchom ponownie bazę danych, w drugim oknie przyłącz się ponownie jako
-- użytkownik test_a i sprawdź zawartość tabeli test. Czy rekord dodany w poleceniu istnieje?
--
-- 11. Zakończ sesję użytkownika test_a (drugie okno). Zamknij bazę danych, wykonując odpowiednie
-- polecenie w pierwszym oknie.
--
-- 12. W pierwszym oknie uruchom bazę danych w trybie „bez montowania”. W drugim oknie spróbuj
-- przyłączyć się do bazy danych jako użytkownik test_a.
--
-- 13. W pierwszym oknie zmień tryb pracy bazy danych na „zamontowana”. Ponownie spróbuj w drugim
-- oknie przyłączyć się jako użytkownik test_a.
--
-- 14. W pierwszym oknie zmień tryb pracy bazy danych na „otwarta”. Ponownie spróbuj w drugim oknie
-- przyłączyć się jako użytkownik test_a.
--
-- 15. Wyloguj użytkownika test_a. W pierwszym oknie zmień tryb pracy bazy danych na „logowanie
-- zabronione” (podpowiedź: alter system enable restricted session; )
--
-- 16. Ponownie spróbuj w drugim oknie przyłączyć się jako użytkownik test_a. Następnie spróbuj
-- przyłączyć się jako użytkownik test_b. Co zaobserwowałeś?
--
-- 17. Wyloguj wszystkich użytkowników testowych i usuń ich używając odpowiedniego polecenia.
-- Upewnij się, że zostali usunięci.
--
----------------------------------------------------------------------------------------------------------------

-- PODPUNKT 1 --


-- PODPUNKT 2 --
CREATE USER test_a IDENTIFIED BY TEST DEFAULT TABLESPACE users QUOTA 10 m ON users;
CREATE USER test_b IDENTIFIED BY TEST DEFAULT TABLESPACE users QUOTA 10 m ON users;

-- PODPUNKT 3 --
GRANT CONNECT TO test_a, test_b;
GRANT RESOURCE TO test_a, test_b;
GRANT RESTRICTED SESSION TO test_b;

-- PODPUNKT 4 --
CREATE TABLE test (
    tekst VARCHAR(100)
);
INSERT INTO test
VALUES ('pierwszy rekord');

-- PODPUNKT 5 --
SHUTDOWN transactional;
-- baza czeka na zakończenie transakcji

-- PODPUNKT 6 --
-- nie, ponieważ "immediate shutdown in progress - no operations are permitted"

-- PODPUNKT 7 --
COMMIT;
--Database closed.
--Database dismounted.
--ORACLE instance shut down.
--baza została zamknięta

-- PODPUNKT 8 --
STARTUP;
INSERT INTO test
VALUES ('drugi rekord');

-- PODPUNKT 9 --
SHUTDOWN immediate;
--ORA-03135: connection lost contact
-- nie ma połączenia

-- PODPUNKT 10 --
SELECT *
FROM test;
--TEKST
--------------------------------------------------------------------------------
--pierwszy rekord

-- jest tylko rekord dodany w punkcie nr 4 lecz rekordu dodanego w punkcie nr 8 nie ma

-- PODPUNKT 11 --
DISCONNECT;
SHUTDOWN normal;

-- PODPUNKT 12 --
STARTUP nomount;
-- nie jest to wykonalne "ORA-01033: ORACLE initialization or shutdown in progress"

-- PODPUNKT 13 --
ALTER DATABASE MOUNT;
--  nie jest to wykonalne "ORA-01033: ORACLE initialization or shutdown in progress"

-- PODPUNKT 14 --
ALTER DATABASE OPEN;
-- zalogowanie się jest możliwe 
--Connected to:
--Oracle Database 11g Enterprise Edition Release 11.2.0.2.0 - Production
--With the Partitioning, OLAP, Data Mining and Real Application Testing options

-- PODPUNKT 15 --
DISCONNECT;
ALTER SYSTEM ENABLE RESTRICTED SESSION;

-- PODPUNKT 16 --
-- test_a "ORA-01035: ORACLE only available to users with RESTRICTED SESSION privilege"
-- test_b "connected"

-- PODPUNKT 17 --
DROP USER test_a CASCADE;
DROP USER test_b CASCADE;
