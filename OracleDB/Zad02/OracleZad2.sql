-- MICHAŁ KIDAWA    216796 --
-- KAMIL KOWALEWSKI 216806 --

----------------------------------------------------------------------------------------------------------------
--
-- CZĘŚĆ 1 – do realizacji poprzez Oracle SQL Developer lub SQL* Plus
-- 1. Wyświetl informacje o bazie danych, do której się przyłączyłeś: nazwę, datę utworzenia
-- oraz tryb otwarcia, wykorzystując perspektywę v$database. Sprawdź, jakie inne informacje
-- można z niej wyciągnąć.
--
-- 2. Sprawdź globalną nazwę bazy danych wykorzystując tabelę systemową global_name.
--
-- 3. Wyświetl informacje o nazwie instancji Twojej bazy danych wykorzystując perspektywę v$instance.
--
-- 4. Wyświetl informacje o wersji SZBD wykorzystując perspektywę v$version.
--
-- 5. Korzystając z dynamicznej perspektywy V$SGA, podaj bieżące ustawienia SGA
-- ( w SQL*Plus można również użyć polecenia show SGA)
--
-- 6. Wyświetl informacje o przestrzeniach tabel w Twojej bazie danych oraz o lokalizacji
-- plików danych przestrzeni tabel. Skorzystaj z tabel systemowych dba_tablespaces oraz
-- dba_data_files oraz jako alternatywę dla tych tabel perspektywy v$tablespace i v$datafile.
--
-- 7. Wyświetl wolny obszar z każdej przestrzeni tabel wykorzystując perspektywę dba_free_space
--
-- 8. Korzystając z perspektywy DBA_SEGMENTS, wyświetl zajęte segmenty dla przestrzeni USERS,
-- których  właścicielem jest jeden z użytkowników (HR / SCOTT / inny).
--
-- 9. Wyświetl informacje o lokalizacji plików kontrolnych Twojej bazy danych korzystając z
-- perspektywy v$controlfile.
--
-- 10. Podaj status i lokalizację plików dziennika powtórzeń korzystając z dynamicznych
-- perspektyw V$LOG oraz V$LOGFILE.
--
-- 11. Sprawdź rezultaty wykonania następujących poleceń:
--
SELECT a.tablespace_name, a.bytes bytes_used, b.bytes bytes_free, b.largest,
       round(((a.bytes - b.bytes) / a.bytes) * 100, 2) percent_used
FROM (
         SELECT tablespace_name, sum(bytes) bytes FROM dba_data_files GROUP BY tablespace_name
     ) a,
     (
         SELECT tablespace_name, sum(bytes) bytes, max(bytes) largest
         FROM dba_free_space
         GROUP BY tablespace_name
     ) b
WHERE a.tablespace_name = b.tablespace_name
ORDER BY ((a.bytes - b.bytes) / a.bytes) DESC;

SELECT owner, segment_name, segment_type, tablespace_name, bytes
FROM dba_segments
WHERE tablespace_name = 'USERS'
  AND owner LIKE 'STUDENT%'
ORDER BY owner, segment_name;
--
-- 12. Sprawdź, jacy użytkownicy są założeni w bazie oraz na jakim użytkowniku obecnie pracujesz.
--
-- CZĘŚĆ 2 – do realizacji poprzez Enterprise Managera
--
-- 13. Na podstawie przestrzeni USERS sprawdź, ile procent wolnej przestrzeni może być użyte,
-- zanim pojawi się  próg:
--
-- ostrzegawczy,
-- krytyczny.
--
--
-- 14. Ile segmentów ma przestrzeń tabel USERS?
--
-- 15. Który indeks przestrzeni USERS zajmuje najwięcej miejsca?

-- 16. Który segment jest przechowywany jako pierwszy w przestrzeni USERS? (Na dole strony
-- kliknąć znak "+" obok napisu EXTENT MAP. Po pojawieniu się mapy, na górze strony wybrać wszystkie typy.)
--
-- 17. Upewnij się, że plik kontrolny jest zwielokrotniony (powinny być przynajmniej 2)
--
-- Zwielokrotnianie plików dziennika powtórzeń
--
-- 18. Wybierz opcję Server | Storage | Redo Log Groups
--
-- 19. Wybierz pierwszą grupę i kliknij Edit
--
--
-- 20. Kliknij Add, podaj nową nazwę redo01_02.log, pozostaw domyślny folder.
-- Kliknij Apply, żeby zapisać zmiany.
--
-- 21. Powtórz czynności dla pozostałych grup, nadając odpowiednie nazwy poszczególnym plikom.
--
--
--
-- Tworzenie dodatkowych przestrzeni tabel
--
-- Rezultatem wykonania poniższych poleceń będzie utworzenie nowej przestrzeni zarządzanej
-- lokalnie o nazwie FSDATA do przechowywania tabel i drugiej FSINDX do przechowywania indeksów
--
-- 22. Wybierz link Server | Storage | Tablespaces i opcję Create
--
-- 23. Wprowadź nazwę FSDATA i zaznacz opcje Locally Managed | Permanent | Read Write.
-- Kliknij Add, żeby dodać plik dla przestrzeni.
--
-- 24. Wprowadź następujące opcje:
--
-- file name: flowers_data. dbf
--
-- file directory: domyślnie
--
-- file size: 100 MB
--
-- Automatically extend datafile: Yes
--
-- increment: 100 MB
--
-- Maximum file size: 1 GB
--
-- 25. Kliknij Continue i na koniec OK.
--
-- 26. Utwórz drugą przestrzeń tabel o nazwie FSINDX i nazwie pliku flowers_indx.dbf Pozostałe
-- parametry analogicznie do poprzedniej. Do utworzenia tej przestrzeni jako narzędzia użyj
-- SQL*Plus i odpowiednich poleceń SQL.
--
----------------------------------------------------------------------------------------------------------------

-- PODPUNKT 1 --
SELECT name, created, open_mode
FROM v$database;

-- PODPUNKT 2 --
SELECT *
FROM global_name;

-- PODPUNKT 3 --
SELECT instance_name
FROM v$instance;

-- PODPUNKT 4 --
SELECT *
FROM v$version;

-- PODPUNKT 5 --
SELECT *
FROM v$sga;

-- PODPUNKT 6 --
SELECT *
FROM dba_tablespaces;

SELECT *
FROM dba_data_files;

SELECT *
FROM v$tablespace;

SELECT *
FROM v$datafile;

-- PODPUNKT 7 --
SELECT tablespace_name, bytes
FROM dba_free_space;

-- PODPUNKT 8 --
SELECT segment_name
FROM dba_segments
WHERE owner IN ('HR', 'SCOTT');

-- PODPUNKT 9 --
SELECT name
FROM v$controlfile;

-- PODPUNKT 10 --
SELECT f.member, l.status
FROM v$logfile f, v$log l
WHERE l.group# = f.group#;

-- PODPUNKT 11 --
SELECT a.tablespace_name, a.bytes bytes_used, b.bytes bytes_free, b.largest,
       round(((a.bytes - b.bytes) / a.bytes) * 100, 2) percent_used
FROM (
         SELECT tablespace_name, sum(bytes) bytes FROM dba_data_files GROUP BY tablespace_name
     ) a,
     (
         SELECT tablespace_name, sum(bytes) bytes, max(bytes) largest
         FROM dba_free_space
         GROUP BY tablespace_name
     ) b
WHERE a.tablespace_name = b.tablespace_name
ORDER BY ((a.bytes - b.bytes) / a.bytes) DESC;

-- TABLESPACE_NAME                BYTES_USED BYTES_FREE    LARGEST PERCENT_USED
-- ------------------------------ ---------- ---------- ---------- ------------
-- SYSTEM                          881852416     196608     196608        99.98
-- SYSAUX                         1320157184  111083520    5242880        91.59
-- APEX_2614203650434107             7340032     720896     720896        90.18
-- EXAMPLE                          85983232   11599872    8192000        86.51
-- USERS                           235929600   46071808   37748736        80.47
-- APEX_2041602962184952             2097152    1048576    1048576           50
-- APEX_2610402357158758             2097152    1048576    1048576           50
-- APEX_2611417663389985             2097152    1048576    1048576           50
-- APEX_1930613455248703             2097152    1048576    1048576           50
-- UNDOTBS1                        178257920  162725888   48234496         8.71
--
-- 10 ROWS selected.


SELECT owner, segment_name, segment_type, tablespace_name, bytes
FROM dba_segments
WHERE tablespace_name = 'USERS'
  AND owner LIKE 'STUDENT%'
ORDER BY owner, segment_name;

NO ROWS selected

-- PODPUNKT 12 --
SELECT username
FROM dba_users;

SELECT user
FROM dual;

-- PODPUNKT 13 --
-- 85% / 97%
-- home -> SPACE summary (DATABASE SIZE) -> USERS (threshholds)

-- PODPUNKT 14 --
-- home -> SPACE summary (DATABASE SIZE) -> ACTIONS (SHOW TABLESPACE CONTENTS)

-- PODPUNKT 15 --
-- SCOTT.SYS_LOB0000101611C00002$$
-- j/w -> SORT BY SIZE (KB)

-- PODPUNKT 16 --
-- (Na dole strony kliknąć znak "+" obok napisu EXTENT MAP. Po pojawieniu się mapy, na górze strony wybrać wszystkie typy.)
-- j/w -> EXTENT MAP

-- PODPUNKT 17 --
-- home -> SPACE summary (DATABASE SIZE) -> OBJECT TYPE  (CONTROL files)

-- PODPUNKT 18 --
-- Wybierz opcję Server | STORAGE | REDO LOG GROUPS

-- PODPUNKT 19 --
-- Wybierz pierwszą grupę i kliknij Edit

-- PODPUNKT 20 --
-- Kliknij ADD, podaj nową nazwę redo01_02.log, pozostaw domyślny FOLDER. Kliknij APPLY, żeby zapisać zmiany.

-- PODPUNKT 21 --
-- Powtórz czynności dla pozostałych grup, nadając odpowiednie nazwy poszczególnym plikom.

-- PODPUNKT 22 --
-- Wybierz LINK Server | STORAGE | Tablespaces i opcję CREATE

-- PODPUNKT 23 --
-- Wprowadź nazwę FSDATA i zaznacz opcje Locally MANAGED | PERMANENT | READ WRITE. Kliknij ADD, żeby dodać plik dla przestrzeni.

-- PODPUNKT 24 --
-- Wprowadź następujące opcje:...

-- PODPUNKT 25 --
-- Kliknij CONTINUE i na koniec OK.

-- PODPUNKT 26 --
-- Utwórz drugą przestrzeń tabel o nazwie FSINDX i nazwie pliku flowers_indx.dbf Pozostałe parametry analogicznie do poprzedniej. Do utworzenia tej przestrzeni jako narzędzia użyj SQL*Plus i odpowiednich poleceń SQL.
CREATE TABLESPACE fsindx
    DATAFILE 'flowers_indx.dbf'
    SIZE 100 m
    AUTOEXTEND ON
    NEXT 100 m MAXSIZE 1 g
    EXTENT MANAGEMENT LOCAL;
