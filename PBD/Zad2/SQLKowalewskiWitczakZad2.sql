CREATE DATABASE biblioteka

USE biblioteka;

CREATE TABLE czytelnicy (
    id       CHAR(5) PRIMARY KEY NOT NULL,
    CONSTRAINT id_test CHECK (id LIKE '[a-Z][a-Z][0-9][0-9][0-9]'),
    nazwisko VARCHAR(15)         NOT NULL,
    imie     VARCHAR(15)         NOT NULL,
    pesel    DECIMAL(11, 0)      NOT NULL UNIQUE,
    data_ur  DATE                NOT NULL,
    plec     CHAR CHECK (plec = 'K' OR plec = 'M'),
    telefon  VARCHAR(15)
);


CREATE TABLE wypozyczenia (
    id_w   INT IDENTITY (1, 1) PRIMARY KEY,
    id_cz  CHAR(5),
    FOREIGN KEY (id_cz) REFERENCES czytelnicy (id),
    id_p   CHAR(5),
    FOREIGN KEY (id_p) REFERENCES czytelnicy (id),
    data_z DATE NOT NULL,
    data_w DATE NOT NULL UNIQUE,
    kara   INT DEFAULT 0,
    CHECK (kara >= 0),
    CONSTRAINT data_test_w CHECK (data_w < data_z)
);

CREATE TABLE pracownicy (
    id        INT IDENTITY (1,1) PRIMARY KEY,
    nazwisko  VARCHAR(15) NOT NULL,
    imie      VARCHAR(15) NOT NULL,
    data_ur   DATE        NOT NULL,
    data_zatr DATE        NOT NULL,
    CONSTRAINT data_test_p CHECK (data_ur < data_zatr),
)

CREATE TABLE wydawnictwa (
    id      INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
    nazwa   VARCHAR(50)                    NOT NULL,
    miasto  VARCHAR(50)                    NOT NULL,
    telefon VARCHAR(15)                    NOT NULL
);

CREATE TABLE ksiazki (
    sygn    VARCHAR(5) PRIMARY KEY UNIQUE,
    id_wyd  INT,
    FOREIGN KEY (id_wyd) REFERENCES wydawnictwa (id),
    tytul   VARCHAR(40) NOT NULL,
    cena    MONEY       NOT NULL,
    gatunek VARCHAR(40) NOT NULL
        CHECK (gatunek IN ('powie��', 'powie�� historyczna',
                           'dla dzieci', 'wiersze', 'krymina�',
                           'powies� science fiction', 'ksi��ka naukowa'))
);

ALTER TABLE pracownicy
    WITH NOCHECK ADD CONSTRAINT plec (plec='K'OR plec='M')

