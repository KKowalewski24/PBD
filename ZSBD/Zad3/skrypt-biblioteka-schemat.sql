IF exists(SELECT 1
          FROM master.dbo.sysdatabases
          WHERE name = 'biblioteka')
    DROP DATABASE biblioteka
GO
CREATE DATABASE biblioteka
GO

CREATE TABLE biblioteka.dbo.czytelnicy (
    id       CHAR(5)
        CONSTRAINT czytelnicy_pk PRIMARY KEY,
    nazwisko VARCHAR(15)   NOT NULL,
    imie     VARCHAR(15)   NOT NULL,
    pesel    CHAR(11)      NOT NULL,
    data_ur  SMALLDATETIME NOT NULL,
    plec     CHAR(1)       NOT NULL
        CONSTRAINT czytelnicy_plec_ch CHECK (plec = 'K' OR plec = 'M'),
    telefon  VARCHAR(15),
    CONSTRAINT czytelnicy_nr_check CHECK (
            SUBSTRING(id, 1, 1) BETWEEN 'A' AND 'Z' AND
            SUBSTRING(id, 2, 1) BETWEEN 'A' AND 'Z' AND
            SUBSTRING(id, 3, 1) BETWEEN '0' AND '9' AND
            SUBSTRING(id, 4, 1) BETWEEN '0' AND '9' AND
            SUBSTRING(id, 5, 1) BETWEEN '0' AND '9'),
    CONSTRAINT czytelnicy_pesel_check CHECK (
            SUBSTRING(pesel, 1, 1) BETWEEN '0' AND '9' AND
            SUBSTRING(pesel, 2, 1) BETWEEN '0' AND '9' AND
            SUBSTRING(pesel, 3, 1) BETWEEN '0' AND '9' AND
            SUBSTRING(pesel, 4, 1) BETWEEN '0' AND '9' AND
            SUBSTRING(pesel, 5, 1) BETWEEN '0' AND '9' AND
            SUBSTRING(pesel, 6, 1) BETWEEN '0' AND '9' AND
            SUBSTRING(pesel, 7, 1) BETWEEN '0' AND '9' AND
            SUBSTRING(pesel, 8, 1) BETWEEN '0' AND '9' AND
            SUBSTRING(pesel, 9, 1) BETWEEN '0' AND '9' AND
            SUBSTRING(pesel, 10, 1) BETWEEN '0' AND '9' AND
            SUBSTRING(pesel, 11, 1) BETWEEN '0' AND '9')
);
GO

CREATE TABLE biblioteka.dbo.pracownicy (
    id        INT IDENTITY (1,1)
        CONSTRAINT pracownicy_pk PRIMARY KEY,
    nazwisko  VARCHAR(15) NOT NULL,
    imie      VARCHAR(15) NOT NULL,
    data_ur   SMALLDATETIME,
    data_zatr SMALLDATETIME,
    CONSTRAINT pracownicy_daty_check CHECK (data_ur < data_zatr),
);
GO

CREATE TABLE biblioteka.dbo.wydawnictwa (
    id      INT IDENTITY (1,1)
        CONSTRAINT wydawnictwa_pk PRIMARY KEY,
    nazwa   VARCHAR(50) NOT NULL,
    miasto  VARCHAR(40) NOT NULL,
    telefon VARCHAR(12)
);
GO

CREATE TABLE biblioteka.dbo.ksiazki (
    sygn    CHAR(5)
        CONSTRAINT ksiazki_pk PRIMARY KEY,
    id_wyd  INT,
    tytul   VARCHAR(40) NOT NULL,
    cena    MONEY       NOT NULL,
    strony  INT,
    gatunek VARCHAR(30),
    CONSTRAINT wydawnictwa_fk FOREIGN KEY (id_wyd) REFERENCES wydawnictwa (id),
    CONSTRAINT ksiazki_check_gat CHECK (gatunek IN
                                        ('powieść', 'powieść historyczna', 'dla dzieci', 'wiersze', 'kryminał',
                                         'powieść science fiction', 'książka naukowa')),
    CONSTRAINT ksiazki_check_cena CHECK (cena > 0)
);
GO

CREATE TABLE biblioteka.dbo.wypozyczenia (
    id_w   INT IDENTITY (1,1),
    sygn   CHAR(5)         NOT NULL,
    id_cz  CHAR(5)         NOT NULL,
    id_p   INT             NOT NULL,
    data_w SMALLDATETIME   NOT NULL,
    data_z SMALLDATETIME,
    kara   MONEY DEFAULT 0 NOT NULL,
    CONSTRAINT wypoz_pk PRIMARY KEY (id_w),
    CONSTRAINT czytelnicy_fk FOREIGN KEY (id_cz) REFERENCES czytelnicy (id),
    CONSTRAINT pracownicy_fk FOREIGN KEY (id_p) REFERENCES pracownicy (id),
    CONSTRAINT ksiazki_fk FOREIGN KEY (sygn) REFERENCES ksiazki (sygn),
    CONSTRAINT wypoz_check_daty CHECK (data_w < data_z),
    CONSTRAINT wypoz_check_kara CHECK (kara >= 0)
);
GO
