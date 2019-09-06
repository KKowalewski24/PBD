-- UZYCIE BAZY TEST_PRACOWNICY --
USE test_pracownicy

-- PODPUNKT 1 --
INSERT INTO pracownicy
VALUES (9781, 'PARMOWSKI', 'AKWIZYTOR', 9235, GETDATE(), NULL, 1150, NULL, NULL, 70)

-- PODPUNKT 2 --
INSERT INTO pracownicy
VALUES (9782, 'CIESZKOWSKI', 'LABORANT', 9332, GETDATE() + 12, NULL, 1200, NULL, NULL, NULL)

-- PODPUNKT 3 --
INSERT INTO dbo.stanowiska
VALUES ('GLOWNY' + (SELECT stanowisko FROM dbo.stanowiska WHERE stanowisko = 'OPERATOR'),
        500 + (SELECT placa_min FROM dbo.stanowiska WHERE stanowisko = 'OPERATOR'),
        1000 + (SELECT placa_max FROM dbo.stanowiska WHERE stanowisko = 'OPERATOR'))

INSERT INTO dbo.stanowiska
VALUES ('GLOWNY' + (SELECT stanowisko FROM dbo.stanowiska WHERE stanowisko = 'LOGISTYK'),
        500 + (SELECT placa_min FROM dbo.stanowiska WHERE stanowisko = 'LOGISTYK'),
        1000 + (SELECT placa_max FROM dbo.stanowiska WHERE stanowisko = 'LOGISTYK'))

INSERT INTO dbo.stanowiska
VALUES ('GLOWNY' + (SELECT stanowisko FROM dbo.stanowiska WHERE stanowisko = 'TECHNOLOG'),
        500 + (SELECT placa_min FROM dbo.stanowiska WHERE stanowisko = 'TECHNOLOG'),
        1000 + (SELECT placa_max FROM dbo.stanowiska WHERE stanowisko = 'TECHNOLOG'))

-- PODPUNKT 4 --
UPDATE pracownicy
SET stanowisko = 'LABORANT',
    placa      = placa * 1.1
WHERE stanowisko = 'PRAKTYKANT'
  AND id_dzialu = 50

-- PODPUNKT 5 --
UPDATE pracownicy
SET dod_funkcyjny = dod_funkcyjny + ((SELECT min(placa) FROM pracownicy) * 0.1)
WHERE id_dzialu = 10

-- PODPUNKT 6 --
DELETE
FROM dbo.stanowiska
WHERE stanowisko = 'PRAKTYKANT'

-- PODPUNKT 7 --
DELETE
FROM pracownicy
WHERE stanowisko = 'LOGISTYK'
  AND data_zatr = (SELECT max(data_zatr) FROM pracownicy WHERE stanowisko = 'LOGISTYK')

-- PODPUNKT 8 --
CREATE TABLE pracownice (
    nr_akt        INT,
    nazwisko      VARCHAR(20),
    stanowisko    VARCHAR(18),
    kierownik     INT
        CONSTRAINT praco_self_key REFERENCES pracownicy (nr_akt),
    data_zatr     DATETIME,
    data_zwol     DATETIME,
    placa         MONEY,
    dod_funkcyjny MONEY,
    prowizja      MONEY,
    id_dzialu     INT,
    CONSTRAINT praco_primary_key PRIMARY KEY (nr_akt),
    CONSTRAINT praco_foreign_key FOREIGN KEY (id_dzialu) REFERENCES dzialy (id_dzialu)
);

INSERT INTO pracownice (nr_akt, nazwisko, stanowisko, kierownik, data_zatr, data_zwol,
                        placa, dod_funkcyjny, prowizja, id_dzialu)

SELECT nr_akt, nazwisko, stanowisko, kierownik, data_zatr, data_zwol, placa, dod_funkcyjny,
       prowizja, id_dzialu
FROM pracownicy
WHERE nazwisko LIKE '%SKA'

SELECT *
FROM pracownice

-- PODPUNKT 9 --
DROP TABLE pracownice

-- PODPUNKT 10 --
CREATE TABLE projekty (
    id_projektu   INT,
    nazwa         VARCHAR(100),
    budzet        FLOAT,
    termin_zak    DATETIME,
    nr_kierownika INT
        CONSTRAINT proj_self_key REFERENCES pracownicy (nr_akt)
        CONSTRAINT proj_id_projektu_unique UNIQUE (id_projektu)
);

-- PODPUNKT 11 --
ALTER TABLE projekty
    ADD typ VARCHAR(20) NOT NULL, opis VARCHAR(500), data_roz DATETIME

-- PODPUNKT 12 --
ALTER TABLE projekty
    ADD DEFAULT getdate() FOR data_roz

-- PODPUNKT 13 --
ALTER TABLE projekty
    DROP CONSTRAINT proj_id_projektu_unique
ALTER TABLE projekty
    ALTER COLUMN id_projektu INT NOT NULL
ALTER TABLE projekty
    ADD CONSTRAINT proj_primary_key PRIMARY KEY (id_projektu)

-- PODPUNKT 14 --
ALTER TABLE projekty
    ADD CONSTRAINT check_data CHECK (data_roz < termin_zak)

-- PODPUNKT 15 --
EXEC sp_rename 'projekty.opis', 'harmonogram', 'COLUMN';

-- PODPUNKT 16 --
ALTER TABLE pracownicy
    DROP COLUMN prowizja


-- PODPUNKT 17 --
USE test_pracownicy

ALTER TABLE pracownicy
    DROP CONSTRAINT prac_foreign_key;
ALTER TABLE pracownicy
    ADD CONSTRAINT prac_foreign_key FOREIGN KEY (id_dzialu)
        REFERENCES dzialy (id_dzialu) ON DELETE CASCADE

-- PODPUNKT 18 --
DELETE
FROM dzialy
WHERE id_dzialu = 30

-- PODPUNKT 19 --
--OPERACJA NIEDOZWOLONA NIE MOZNA USUNAC KIEROWNIKA--
--delete from pracownicy where nr_akt = 8902

-- PODPUNKT 20 --
UPDATE pracownicy
SET data_zwol = getdate()
WHERE nr_akt = 8902

INSERT INTO prac_archiw
SELECT *
FROM pracownicy
WHERE nr_akt = 8902

-- PODPUNKT 21 --
ALTER TABLE pracownicy
    NOCHECK CONSTRAINT prac_self_key
UPDATE pracownicy
SET kierownik = 8903
WHERE kierownik = 8902
ALTER TABLE pracownicy
    CHECK CONSTRAINT prac_self_key

-- PODPUNKT 22 --
DELETE
FROM pracownicy
WHERE nr_akt = 8902

-- PODPUNKT 23 --
CREATE INDEX prac_nazw_index ON pracownicy (nazwisko)

-- PODPUNKT 24 --
CREATE INDEX prac_nazw_index ON dbo.stanowiska (placa_min, placa_max)

-- PODPUNKT 25 --
DROP INDEX prac_nazw_index ON pracownicy
DROP INDEX stan_plac_index ON dbo.stanowiska
