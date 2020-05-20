-- MICHAŁ KIDAWA    216796 --
-- KAMIL KOWALEWSKI 216806 --

-- PUSTE MIEJSCA W PONIŻSZYCH PODPUNKTACH OZNACZAJĄ, ŻE BYŁO TO WYKONYWANE W ENTERPRICE MANAGER

----------------------------------------------------------------------------------------------------------------
-- Część 1 - Blokady
--
-- Opis: W ramach ćwiczenia, za pomocą dwóch oddzielnych sesji SQL*Plus spowodujesz konflikt blokad.
-- Następnie za pomocą Enterprise Managera wykryjesz i rozwiążesz konflikt .
--
-- 1. Podłącz się do bazy jako administrator.
--
-- 2. Sprawdź, czy w systemie istnieje rola o nazwie hremployee. Jeśli tak, to ją usuń.
--
-- 3. Sprawdź, czy w systemie istnieją użytkownicy o nazwach: smavris i NGREENBERG. Jeśli tak,
-- to ich usuń.
--
-- 4. Utwórz rolę hremployee i nadaj jej przywilej do podłączania się do bazy.
--
-- 5. Nadaj roli przywileje select oraz update na tabeli employees w schemacie użytkownika hr
--
-- 6. Nadaj rolę hremployee identyfikowaną przez hasło oracle_4U użytkownikom SMARVIS oraz
-- NGREENBERG. Zauważ, że polecenie grant spowoduje utworzenie nowego użytkownika (!).
--
-- Przykład: grant hremployee to smavris identified by oracle_4U;
--
-- 7. Podłącz się do bazy jako użytkownik NGREENBERG i zaktualizuj w tabeli hr.employees  numer
-- telefonu pracownikowi o numerze 110 (John Chen). Pozostaw w tym stanie sesję otwartą.
--
-- 8. Otwórz nowe okienko terminala SQL*Plus. Jako administrator wykonaj polecenie uśpienia
-- (w ten sposób będziesz pewien, że sesja NGREENBERG jako pierwsza uzyskała blokadę. Kod:
--
-- begin
-- sys.dbms_lock.sleep(20);
-- end;
-- /
--
-- 9. Poczekaj na koniec uśpienia i przeloguj się na użytkownika SMARVIS. Z jego sesji wykonaj
-- taką samą aktualizację w tabeli użytkownicy (employee_id=110). Co zauważyłeś?
--
-- 10. Za pomocą opcji Blocking Sessions Enterprise Managera, stwierdź, która sesja powoduje
-- konflikt blokad (opcja Performance | Additional Monitoring Links | Blocking Sessions).
--
-- 11. Sprawdź, jakie polecenie spowodowało konflikt blokad. W tym celu Zaznacz sesję
-- NGREENBERG i wybierze opcję View Session. Następnie kliknij link z wartością mieszania
-- dla Previous SQL.
--
-- 12. Wróć do poprzedniego widoku i zabij sesję użytkownika NGREENBERG.
--
-- 13. Powróć do sesji SQL*Plus dla użytkownika SMARVIS i zaobserwuj, co się zmieniło.
--
-- 14. Spróbuj w oknie sesji użytkownika NGREENBERG wykonać jakiekolwiek polecenie SQL. Co widzisz?
--
-- 15. Zamknij wszystkie sesje.
--
--
-- Część 2 - Monitoring czynności użytkowników
--
-- Opis: Stwierdziłeś "podejrzane" zmiany w tabeli HR.JOBS - maksymalne wynagrodzenia ulegają
-- wahaniom w dziwny sposób. Jako administrator zdecydowałeś się na włączenie standardowego
-- monitoringu poleceń DML na tej tabeli.
--
-- 16. Uruchom Enterprise Managera i zaloguj się jako administrator z rolą SYSDBA. W zakładce
-- Server wybierz opcję Audit Settings z sekcji Security.
--
-- 17. Kliknij link DB z opcji Audit Trail, następnie zakładkę SPFile.
--
-- 18. W pole Name wpisz audit i kliknij Go
--
-- 19. Z listy parametrów wyświetlonych jako rezultaty przeszukiwania wybierz audit_trail i zmień
-- jego wartość na XML. Obejrzyj kod SQL odpowiadający poleceniu poprzez wybranie opcji Show SQL -
-- powrót za pomocą przycisku Return. Na stronie z parametrami wybierz opcję Apply.
--
-- 20. Zrestartuj bazę - czynność konieczna, gdyż zmienił się parametr statyczny bazy danych.
-- Poczekaj, aż uruchomione zostaną wszystkie procesy i jeszcze raz zaloguj się do Enterprise Managera.
--
-- 21. W Audit Settings zakładki Server wybierz opcję Audite Objects, następnie Add.
--
-- 22. Upewnij się, że wybranym typem obiektów jest Table, następnie wprowadź w polu Table field
-- wartość HR.JOBS (lub użyj "latarki").
--
-- 23. Przenieś czynności DELETE, INSERT oraz UPDATE za pomocą dwukrotnego kliknięcia z panelu
-- lewego do prawego. Sprawdź odpowiadający kod SQL za pomocą opcji Show SQL. Kliknij OK, żeby
-- aktywować audyt.
--
-- 24. Wykonaj kolejne czynności, aby sprawdzić później, czy audyt zadziałał.
--
-- 25. Sprawdź, czy użytkownik audit_user istnieje, jeśli tak, to go usuń kaskadowo
-- (na końcu należy podać opcję cascade)
--
-- 26. Utwórz nowego użytkownika audit_user identyfikowanego przez hasło oracle_4U
--
-- 27. Nadaj użytkownikowi rolę connect oraz wszystkie przywileje (GRANT ALL) na tabeli hr.jobs
--
-- 28. Podłącz się z sesji SQL*Plus jako audit_user i wykonaj kolejno polecenia: selekcji z tabeli
-- hr.jobs, aktualizacji kolumny max_salary poprzez pomnożenie jej przez 10 (zatwierdź transakcję) i ponownej selekcji.
--
-- 29. Przełącz się na użytkownika hr i wykonaj ponowną zmianę - podziel max_salary przez 10.
-- Zatwierdź i sprawdź rezultat zmiany.
--
-- 30. Przełącz się na administratora i usuń kaskadowo użytkownika audit_user
--
-- 31. Poprzez Enterprise Managera sprawdź informacje o obiektach poddanych audytowi - zakładka
-- Server | Audit Settings | Audited Objects. Uwaga dodatkowa: Czy z wyświetlonych informacji
-- można wywnioskować, który użytkownik obniżył wynagrodzenie?
--
-- 32. Wycofaj wszystkie zmiany związane z ustawionym wcześniej audytem: w Audited Objects wejdź
-- w schemat HR i kliknij Search, wybierz wszystkie trzy wiersze i kliknij Remove. Na stronie z
-- potwierdzeniem kliknij Show SQL. Potwierdź YES.
--
-- 33. Na stronie Audit Settings wybierz XML. W zakładce SPFile strony Initialization Parameters
-- wprowadź w pole nazwy do przeszukiwania audit i kliknij Go. Zmień nazwę parametru audit_trail
-- na DB (tak było na początku), sprawdź kod SQL i zatwierdź zmiany.
--
-- 34. Zmienił się statyczny parametr inicjalizacyjny, czyli ... zrestartuj bazę danych.
----------------------------------------------------------------------------------------------------------------

-- PODPUNKT 1 --

-- PODPUNKT 2 --
SELECT *
FROM dba_roles
WHERE role = 'hremployee';

-- rola nie istnieje 
DROP ROLE hremployee;

-- PODPUNKT 3 --
SELECT username
FROM dba_users
WHERE username IN ('smavris', 'NGREENBERG');

-- użytkownicy nie istnieją, w razie czego:
DROP USER smavris CASCADE;

DROP USER ngreenberg CASCADE;

-- PODPUNKT 4 --
CREATE ROLE hremployee;
GRANT CONNECT TO hremployee;

-- PODPUNKT 5 --
GRANT SELECT, UPDATE ON hr.employees TO hremployee;

-- PODPUNKT 6 --
GRANT hremployee TO smarvis, ngreenberg IDENTIFIED BY oracle_4U, oracle_4u;

-- PODPUNKT 7 --
UPDATE hr.employees
SET phone_number='123'
WHERE employee_id = '110';

SELECT employee_id, phone_number
FROM hr.employees
WHERE employee_id = '110';

-- PODPUNKT 8 --
BEGIN
    sys.dbms_lock.sleep(20);
END;
/

-- PODPUNKT 9 --
UPDATE hr.employees
SET phone_number='321'
WHERE employee_id = '110';
-- czeka...

-- PODPUNKT 10 --
-- emctl status dbconsole
-- emctl start dbconsole

-- PODPUNKT 11 --


-- PODPUNKT 12 --


-- PODPUNKT 13 --
-- 1 row updated

-- PODPUNKT 14 --
-- connection lost contact

-- PODPUNKT 15 --


-- PODPUNKT 16 --


-- PODPUNKT 17 --


-- PODPUNKT 18 --


-- PODPUNKT 19 --
ALTER SYSTEM SET audit_trail = "xml" SCOPE = SPFILE

-- PODPUNKT 20 --
    SHUTDOWN transactional;
STARTUP;

-- PODPUNKT 21 --


-- PODPUNKT 22 --


-- PODPUNKT 23 --
AUDIT DELETE, INSERT, UPDATE ON hr.jobs BY SESSION;

-- PODPUNKT 24 --


-- PODPUNKT 25 --
SELECT username
FROM dba_users
WHERE username = 'audit_user';

DROP USER audit_user CASCADE;

-- PODPUNKT 26 --
CREATE USER audit_user IDENTIFIED BY oracle_4U;

-- PODPUNKT 27 --
GRANT CONNECT TO audit_user;

GRANT ALL ON hr.jobs TO audit_user;

-- PODPUNKT 28 --
SELECT *
FROM hr.jobs;

UPDATE hr.jobs
SET max_salary=10 * max_salary;

SELECT *
FROM hr.jobs;

COMMIT;

-- PODPUNKT 29 --
UPDATE hr.jobs
SET max_salary=max_salary / 10;

SELECT *
FROM hr.jobs;

COMMIT;

-- PODPUNKT 30 --
DROP USER audit_user CASCADE;

-- PODPUNKT 31 --
-- nie można wywnioskować, który użytkownik obniżył wynagrodzenie

-- PODPUNKT 32 --
NOAUDIT DELETE ON hr.jobs;

NOAUDIT INSERT ON hr.jobs;

NOAUDIT UPDATE ON hr.jobs;

-- PODPUNKT 33 --
ALTER SYSTEM SET audit_trail = "db" SCOPE = SPFILE

-- PODPUNKT 34 --
-- zrestartuj bazę danych
