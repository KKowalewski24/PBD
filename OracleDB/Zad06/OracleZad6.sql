-- MICHAŁ KIDAWA    216796 --
-- KAMIL KOWALEWSKI 216806 --

----------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------

-- PODPUNKT 1,2,3,4,5,6,7  --
-- Katalog istnieje
-- [oracle@localhost flash_recovery_area]$ ls
-- orcl  ORCL
-- wszystko zostało ustawione zgodnie z instrukcją
-- wykonano podanie danych logowania
-- baza została zrestartowana

-- PODPUNKT 8,9,10,11,12,13,14,15 --
-- wszystkie pola zostały wypełnione zgodnie z instrukcją
-- Test disk backup zakonczony sukcesem
-- Praca zakonczona sukcesem

-- PODPUNKT 16,17 --
-- Stworzony kopia została wyświetlona łącznie z jej szczegółami

-- PODPUNKT 18 --
-- Zawartość skryptu Step: Backup
-- shutdown immediate

SQL*Plus: RELEASE 11.2.0.2.0 Production ON Mon Apr 6 01:17:12 2020

Copyright (C) 1982, 2010, Oracle.  All rights reserved.

SQL> SQL> Connected.
SQL> SQL> SQL> DATABASE closed.
DATABASE dismounted.
ORACLE INSTANCE shut down.
SQL> SQL> Disconnected FROM Oracle DATABASE 11g ENTERPRISE EDITION RELEASE 11.2.0.2.0 - Production
WITH the Partitioning, OLAP, DATA MINING AND REAL Application Testing options
STARTUP MOUNT

SQL*Plus: RELEASE 11.2.0.2.0 Production ON Mon Apr 6 01:17:38 2020

Copyright (C) 1982, 2010, Oracle.  All rights reserved.

SQL> SQL> Connected TO an idle INSTANCE.
SQL> SQL> ORACLE INSTANCE started.

Total SYSTEM GLOBAL Area  456146944 BYTES
FIXED SIZE		    1344840 BYTES
VARIABLE SIZE		  352324280 BYTES
DATABASE Buffers	   96468992 BYTES
REDO Buffers		    6008832 BYTES
DATABASE mounted.
SQL> Disconnected FROM Oracle DATABASE 11g ENTERPRISE EDITION RELEASE 11.2.0.2.0 - Production
WITH THE Partitioning, OLAP, DATA MINING AND REAL Application Testing options

RECOVERY Manager: RELEASE 11.2.0.2.0 - Production ON Mon Apr 6 01:18:14 2020

Copyright (C) 1982, 2009, Oracle AND/
OR its affiliates.  All rights reserved.

RMAN> 
connected TO target DATABASE: ORCL (DBID=1229390655, NOT OPEN)
USING target DATABASE CONTROL FILE INSTEAD OF RECOVERY catalog

RMAN> 
ECHO
SET ON


RMAN>
SET command ID TO 'MONDAY_BACKUP_040620011645';
executing command:
SET COMMAND ID
    RMAN> BACKUP incremental LEVEL 0 cumulative device TYPE DISK TAG 'MONDAY_BACKUP_040620011645' DATABASE;
Starting BACKUP AT 06-APR-20
allocated channel: ORA_DISK_1
channel ORA_DISK_1: SID=10 device TYPE=DISK
channel ORA_DISK_1: starting incremental LEVEL 0 DATAFILE BACKUP
SET
    channel ORA_DISK_1: specifying DATAFILE (S) IN BACKUP
SET
INPUT datafile file number=00002 name=/home/oracle/app/oracle/oradata/orcl/sysaux01.dbf
INPUT datafile file number=00001 name=/home/oracle/app/oracle/oradata/orcl/system01.dbf
INPUT datafile file number=00004 name=/home/oracle/app/oracle/oradata/orcl/users01.dbf
...
...
...
plete, elapsed TIME: 00:00:02
Finished BACKUP AT 06-APR-20


RMAN> RUN {
2> ALLOCATE channel oem_backup_disk1 TYPE DISK  maxpiecesize 1000 G;
3> BACKUP TAG 'MONDAY_BACKUP_040620011645' CURRENT CONTROLFILE;
4> RELEASE channel oem_backup_disk1;
5> }
released channel: ORA_DISK_1
allocated channel: oem_backup_disk1
channel oem_backup_disk1: SID=10 device TYPE=DISK

Starting BACKUP AT 06-APR-20
channel oem_backup_disk1: starting FULL DATAFILE BACKUP
SET
    channel oem_backup_disk1: specifying DATAFILE (S) IN BACKUP
SET
    INCLUDING CURRENT CONTROL FILE IN BACKUP
SET
    channel oem_backup_disk1: starting piece 1 AT 06-APR-20
    channel oem_backup_disk1: finished piece 1 AT 06-APR-20
    piece handle=/
home/
oracle/
APP/
oracle/
flash_recovery_area/
ORCL/
BACKUPSET/2020_04_06/
o1_mf_ncnnf_MONDAY_BACKUP_040620_h8oslpj2_.bkp TAG=MONDAY_BACKUP_040620011645 COMMENT=NONE
channel oem_backup_disk1: BACKUP
SET COMPLETE, elapsed TIME : 00:00:01
    Finished BACKUP AT 06-APR-20
    released channel: oem_backup_disk1
    RMAN> EXIT;

RECOVERY Manager COMPLETE.
STARTUP open

SQL*Plus: RELEASE 11.2.0.2.0 Production ON Mon Apr 6 01:20:43 2020

Copyright (C) 1982, 2010, Oracle.  All rights reserved.

SQL> SQL> Connected.
SQL> SQL> 
DATABASE altered.

SQL> Disconnected FROM Oracle DATABASE 11g ENTERPRISE EDITION RELEASE 11.2.0.2.0 - Production
WITH the Partitioning, OLAP, DATA MINING AND REAL Application Testing options

-- PODPUNKT 19,20 --
-- Zosłaty wyswietlone szczegóły z BACKUP report

-- PODPUNKT 21,22,23,24 --
-- Walidacja przeprowadzona pomyslnie
-- VALIDATE BACKUPSET 4, 3, 2;
-- Job submission succeeded.

-- PODPUNKT 25,26,27,28,29,30,31,32 --
-- szczegóły zostały wyświetlone
-- Kolejne kroki wg instrukcji zostały wykonane
-- Polecenia zakonczone sukcesem - The job has been successfully submitted.

-- PODPUNKT 33 --
-- szczegóły zostały wyswietlone - RESTORING_MONDAY_BACKUP

-- PODPUNKT 34,35,36,37 --
-- Została wybrana opcja Datafiles -> Add -> wybrane pliki -> select

-- PODPUNKT 38 --
RUN {
SQL 'alter database datafile 4 offline';
SQL 'alter database datafile 5 offline';
RESTORE DATAFILE 4,5;
RECOVER datafile 4,5;
SQL 'alter database datafile 4 online';
SQL 'alter database datafile 5 online';
}

-- PODPUNKT 39,40 --
-- kroki wykonane wg instrukcji

-- PODPUNKT 41 --
RECOVERY Manager: RELEASE 11.2.0.2.0 - Production ON Mon Apr 6 01:59:11 2020

Copyright (C) 1982, 2009, Oracle AND/
OR its affiliates.  All rights reserved.

RMAN>
connected TO target DATABASE: ORCL (DBID=1229390655)
USING target DATABASE CONTROL FILE INSTEAD OF RECOVERY catalog

RMAN>
ECHO
SET ON


RMAN> RUN {
2> SQL 'alter database datafile 4 offline';
3> SQL 'alter database datafile 5 offline';
4> RESTORE DATAFILE 4,5;

-- PODPUNKT 42,43,44,45 --
kroki przeprowadzone zgodnie z instrukcją

-- PODPUNKT 46 --
Daily Script:
RUN {
ALLOCATE channel oem_disk_backup device TYPE DISK;
RECOVER COPY of DATABASE WITH TAG 'ORA_OEM_LEVEL_0';
BACKUP incremental LEVEL 1 cumulative  copies=1 FOR RECOVER OF COPY WITH TAG 'ORA_OEM_LEVEL_0' DATABASE;
}

-- PODPUNKT 47 --
-- Operacja zakonczona sukcesem - The job has been successfully submitted.

-- PODPUNKT 48,49,50 --
-- Operacje zakonczone sukcesem

-- PODPUNKT 51,52,53,54,55,56 --
-- zmiana na yes Enable row movement została wykonana dla tabel EMPLOYEES, JOBS, DEPARTMENTS

-- PODPUNKT 57,58,59,60,61,62,63 --
-- Operacja zakonczona powodzeniem

-- PODPUNKT 64,65,66,67,68,69 --
-- Operacja zakonczona powodzeniem

-- PODPUNKT 70 --
SQL>
SELECT *
FROM jobs;

-- JOB_ID     JOB_TITLE                           MIN_SALARY MAX_SALARY
-------- ----------------------------------- ---------- ----------
-- AD_PRES    President                                20000      40000
-- AD_VP      Administration Vice President            15000      30000
-- AD_ASST    Administration Assistant                  3000       6000
-- FI_MGR     Finance Manager                           8200      16000
-- FI_ACCOUNT Accountant                                4200       9000
-- AC_MGR     Accounting Manager                        8200      16000
-- AC_ACCOUNT Public Accountant                         4200       9000
-- SA_MAN     Sales Manager                            10000      20000
-- SA_REP     Sales Representative                      6000      12000
-- PU_MAN     Purchasing Manager                        8000      15000
-- PU_CLERK   Purchasing Clerk                          2500       5500
--
-- JOB_ID     JOB_TITLE                           MIN_SALARY MAX_SALARY
-------- ----------------------------------- ---------- ----------
-- ST_MAN     Stock Manager                             5500       8500
-- ST_CLERK   Stock Clerk                               2000       5000
-- SH_CLERK   Shipping Clerk                            2500       5500
-- IT_PROG    Programmer                                4000      10000
-- MK_MAN     Marketing Manager                         9000      15000
-- MK_REP     Marketing Representative                  4000       9000
-- HR_REP     Human Resources Representative            4000       9000
-- PR_REP     Public Relations Representative           4500      10500
--
-- 19 rows selected.
