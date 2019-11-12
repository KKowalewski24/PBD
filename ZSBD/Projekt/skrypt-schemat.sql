-- AUTORZY: --
-- MICHAŁ KIDAWA    216796 --
-- KAMIL KOWALEWSKI 216806 --

------------------------------------------------------------
/*
-- SPIS TABEL

-- 1. miasta
-- 2. pokoje
-- 3. klienci
-- 4. stanowiska
-- 5. pracownicy
-- 6. pracownicy_hist
-- 7. rezerwacje
-- 8. rezerwacje_hist
 */
------------------------------------------------------------

IF EXISTS(SELECT 1
          FROM master.dbo.sysdatabases
          WHERE name = 'baza_hotel')
    DROP DATABASE baza_hotel
GO

CREATE DATABASE baza_hotel
GO

-- TABELA 1 --
CREATE TABLE baza_hotel.dbo.miasta (
    miasto_nr INT IDENTITY (1,1),
    nazwa     VARCHAR(25) NOT NULL,

    CONSTRAINT miasta_klucz_glowny PRIMARY KEY (miasto_nr)
);
GO

-- TABELA 2 --
CREATE TABLE baza_hotel.dbo.pokoje (
    pokoj_nr       INT   NOT NULL,
    liczba_osob    INT   NOT NULL,
    cena           MONEY NOT NULL,
    czy_jest_wanna BIT,
    czy_jest_sejf  BIT,

    CONSTRAINT pokoje_klucz_glowny PRIMARY KEY (pokoj_nr)
);
GO

-- TABELA 3 --
CREATE TABLE baza_hotel.dbo.klienci (
    klient_nr      INT IDENTITY (1,1),
    imie           VARCHAR(25) NOT NULL,
    nazwisko       VARCHAR(25) NOT NULL,
    data_urodzenia DATE        NOT NULL,
    miasto         INT         NOT NULL,
    adres          VARCHAR(45) NOT NULL,
    telefon        VARCHAR(15) NOT NULL,
    typ            INT         NOT NULL,

    CONSTRAINT klienci_klucz_glowny PRIMARY KEY (klient_nr),
    CONSTRAINT klienci_miasto_klucz_obcy FOREIGN KEY (miasto)
        REFERENCES baza_hotel.dbo.miasta (miasto_nr),

    CONSTRAINT klienci_sprawdz_typ CHECK (typ <= 3 AND typ >= 1)
);
GO

-- TABELA 4 --
CREATE TABLE baza_hotel.dbo.stanowiska (
    stanowisko_nr   INT IDENTITY (1,1),
    nazwa           VARCHAR(50) NOT NULL,
    placa_minimalna MONEY       NOT NULL,

    CONSTRAINT stanowisko_klucz_glowny PRIMARY KEY (stanowisko_nr)
)
GO
-- TABELA 5 --
CREATE TABLE baza_hotel.dbo.pracownicy (
    pracownik_nr      INT IDENTITY (1,1),
    imie              VARCHAR(25) NOT NULL,
    nazwisko          VARCHAR(25) NOT NULL,
    miasto            INT         NOT NULL,
    adres             VARCHAR(45) NOT NULL,
    telefon           VARCHAR(15) NOT NULL,
    data_urodzenia    DATE        NOT NULL,
    data_zatrudnienia DATE        NOT NULL,
    data_zwolnienia   DATE,
    stanowisko_nr     INT         NOT NULL,
    placa             MONEY       NOT NULL,

    CONSTRAINT pracownicy_klucz_glowny PRIMARY KEY (pracownik_nr),
    CONSTRAINT pracownicy_miasto_klucz_obcy FOREIGN KEY (miasto)
        REFERENCES baza_hotel.dbo.miasta (miasto_nr),
    CONSTRAINT pracownicy_stanowisko_klucz_obcy FOREIGN KEY (stanowisko_nr)
        REFERENCES baza_hotel.dbo.stanowiska (stanowisko_nr),

    CONSTRAINT pracownicy_sprawdz_daty CHECK (data_urodzenia < data_zatrudnienia),
--	CONSTRAINT pracownicy_sprawdz_placa CHECK (placa >= (SELECT s.placa_minimalna FROM stanowiska AS s WHERE s.stanowisko_nr = stanowisko_nr))
);
GO

-- TABELA 6 --
CREATE TABLE baza_hotel.dbo.pracownicy_hist (
    pracownik_nr      INT         NOT NULL,
    imie              VARCHAR(25) NOT NULL,
    nazwisko          VARCHAR(25) NOT NULL,
    miasto            INT         NOT NULL,
    adres             VARCHAR(45) NOT NULL,
    telefon           VARCHAR(15) NOT NULL,
    data_urodzenia    DATE        NOT NULL,
    data_zatrudnienia DATE        NOT NULL,
    data_zwolnienia   DATE        NOT NULL,
    stanowisko_nr     INT         NOT NULL,
    placa             MONEY       NOT NULL,

    CONSTRAINT pracownicy_hist_klucz_glowny PRIMARY KEY (pracownik_nr),
    CONSTRAINT pracownicy_hist_miasto_klucz_obcy FOREIGN KEY (miasto)
        REFERENCES baza_hotel.dbo.miasta (miasto_nr),
    CONSTRAINT pracownicy_hist_stanowisko_klucz_glowny FOREIGN KEY (stanowisko_nr)
        REFERENCES baza_hotel.dbo.stanowiska (stanowisko_nr)
);
GO

-- TABELA 7 --
CREATE TABLE baza_hotel.dbo.rezerwacje (
    rezerwacja_nr       INT IDENTITY (1,1),
    klient_nr           INT  NOT NULL,
    pokoj_nr            INT  NOT NULL,
    liczba_osob         INT  NOT NULL,
    poczatek_rezerwacji DATE NOT NULL,
    liczba_dni          INT  NOT NULL,

    CONSTRAINT rezerwacje_klucz_glowny PRIMARY KEY (rezerwacja_nr),
    CONSTRAINT rezerwacje_pokoj_klucz_obcy FOREIGN KEY (pokoj_nr)
        REFERENCES baza_hotel.dbo.pokoje (pokoj_nr),
    CONSTRAINT rezerwacje_klient_klucz_obcy FOREIGN KEY (klient_nr)
        REFERENCES baza_hotel.dbo.klienci (klient_nr),

--	CONSTRAINT rezerwacje_sprawdz_il_os CHECK (liczba_osob <= (SELECT p.liczba_osob FROM pokoje AS p WHERE p.pokoj_nr = pokoj_nr))
);
GO

-- TABELA 8 --
CREATE TABLE baza_hotel.dbo.rezerwacje_hist (
    rezerwacja_nr       INT,
    klient_nr           INT  NOT NULL,
    pokoj_nr            INT  NOT NULL,
    liczba_osob         INT  NOT NULL,
    poczatek_rezerwacji DATE NOT NULL,
    koniec_rezerwacji   DATE NOT NULL,

    CONSTRAINT rezerwacje_hist_klucz_glowny PRIMARY KEY (rezerwacja_nr),
    CONSTRAINT rezerwacje_hist_pokoj_klucz_obcy FOREIGN KEY (pokoj_nr)
        REFERENCES baza_hotel.dbo.pokoje (pokoj_nr),
    CONSTRAINT rezerwacje_hist_klient_klucz_obcy FOREIGN KEY (klient_nr)
        REFERENCES baza_hotel.dbo.klienci (klient_nr),
);
GO
