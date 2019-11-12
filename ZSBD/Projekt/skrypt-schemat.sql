-- AUTORZY: --
-- MICHAŁ KIDAWA    216796 --
-- KAMIL KOWALEWSKI 216806 --

------------------------------------------------------------
/*
-- SPIS TABEL

-- 1.
-- 2.
-- 3.
-- 4.
-- 5.
-- 6.
-- 7.
-- 8.
 */
------------------------------------------------------------

IF EXISTS(SELECT 1
          FROM master.dbo.sysdatabases
          WHERE name = 'hotel')
    DROP DATABASE hotel
GO

CREATE DATABASE hotel
GO

-- TABELA 1 --
CREATE TABLE hotel.dbo.miasta (
    nr_miasta INT IDENTITY (1,1),
    nazwa     VARCHAR(25) NOT NULL,

    CONSTRAINT miasta_kg PRIMARY KEY (nr_miasta)
);
GO

-- TABELA 2 --
CREATE TABLE hotel.dbo.pokoje (
    nr_pokoju  INT   NOT NULL,
    ilosc_osob INT   NOT NULL,
    cena       MONEY NOT NULL,
    czy_wanna  BIT,
    czy_sejf   BIT,

    CONSTRAINT pokoje_kg PRIMARY KEY (nr_pokoju)
);
GO

-- TABELA 3 --
CREATE TABLE hotel.dbo.klienci (
    nr_klienta     INT IDENTITY (1,1),
    imie           VARCHAR(25) NOT NULL,
    nazwisko       VARCHAR(25) NOT NULL,
    data_urodzenia DATE        NOT NULL,
    miasto         INT         NOT NULL,
    adres          VARCHAR(45) NOT NULL,
    telefon        VARCHAR(15) NOT NULL,
    typ            INT         NOT NULL,

    CONSTRAINT klienci_kg PRIMARY KEY (nr_klienta),
    CONSTRAINT klienci_ko_miasto FOREIGN KEY (miasto) REFERENCES hotel.dbo.miasta (nr_miasta),

    CONSTRAINT klienci_sprawdz_typ CHECK (typ <= 3 AND typ >= 1)
);
GO

-- TABELA 4 --
CREATE TABLE hotel.dbo.stanowiska (
    nr_stanowiska   INT IDENTITY (1,1),
    nazwa           VARCHAR(50) NOT NULL,
    placa_minimalna MONEY       NOT NULL,

    CONSTRAINT stanowisko_kg PRIMARY KEY (nr_stanowiska)
)
GO
-- TABELA 5 --
CREATE TABLE hotel.dbo.pracownicy (
    nr_pracownika     INT IDENTITY (1,1),
    imie              VARCHAR(25) NOT NULL,
    nazwisko          VARCHAR(25) NOT NULL,
    miasto            INT         NOT NULL,
    adres             VARCHAR(45) NOT NULL,
    telefon           VARCHAR(15) NOT NULL,
    data_urodzenia    DATE        NOT NULL,
    data_zatrudnienia DATE        NOT NULL,
    data_zwolnienia   DATE,
    nr_stanowiska     INT         NOT NULL,
    placa             MONEY       NOT NULL,

    CONSTRAINT pracownicy_kg PRIMARY KEY (nr_pracownika),
    CONSTRAINT pracownicy_ko_miasto FOREIGN KEY (miasto) REFERENCES hotel.dbo.miasta (nr_miasta),
    CONSTRAINT pracownicy_ko_stanowisko FOREIGN KEY (nr_stanowiska) REFERENCES hotel.dbo.stanowiska (nr_stanowiska),

    CONSTRAINT pracownicy_sprawdz_daty CHECK (data_urodzenia < data_zatrudnienia),
--	CONSTRAINT pracownicy_sprawdz_placa CHECK (placa >= (SELECT s.placa_minimalna FROM stanowiska AS s WHERE s.nr_stanowiska = nr_stanowiska))
);
GO

-- TABELA 6 --
CREATE TABLE hotel.dbo.byli_pracownicy (
    nr_pracownika     INT         NOT NULL,
    imie              VARCHAR(25) NOT NULL,
    nazwisko          VARCHAR(25) NOT NULL,
    miasto            INT         NOT NULL,
    adres             VARCHAR(45) NOT NULL,
    telefon           VARCHAR(15) NOT NULL,
    data_urodzenia    DATE        NOT NULL,
    data_zatrudnienia DATE        NOT NULL,
    data_zwolnienia   DATE        NOT NULL,
    nr_stanowiska     INT         NOT NULL,
    placa             MONEY       NOT NULL,

    CONSTRAINT byli_pracownicy_kg PRIMARY KEY (nr_pracownika),
    CONSTRAINT byli_pracownicy_ko_miasto FOREIGN KEY (miasto) REFERENCES hotel.dbo.miasta (nr_miasta),
    CONSTRAINT byli_pracownicy_ko_stanowisko FOREIGN KEY (nr_stanowiska) REFERENCES hotel.dbo.stanowiska (nr_stanowiska)
);
GO

-- TABELA 7 --
CREATE TABLE hotel.dbo.rezerwacje (
    nr_rezerwacji       INT IDENTITY (1,1),
    nr_klienta          INT  NOT NULL,
    nr_pokoju           INT  NOT NULL,
    ile_osob            INT  NOT NULL,
    poczatek_rezerwacji DATE NOT NULL,
    dni                 INT  NOT NULL,

    CONSTRAINT rezerwacje_kg PRIMARY KEY (nr_rezerwacji),
    CONSTRAINT rezerwacje_ko_pokoj FOREIGN KEY (nr_pokoju) REFERENCES hotel.dbo.pokoje (nr_pokoju),
    CONSTRAINT rezerwacje_ko_klient FOREIGN KEY (nr_klienta) REFERENCES hotel.dbo.klienci (nr_klienta),

--	CONSTRAINT rezerwacje_sprawdz_il_os CHECK (ile_osob <= (SELECT p.ilosc_osob FROM pokoje AS p WHERE p.nr_pokoju = nr_pokoju))
);
GO

-- TABELA 8 --
CREATE TABLE hotel.dbo.byle_rezerwacje (
    nr_rezerwacji       INT,
    nr_klienta          INT  NOT NULL,
    nr_pokoju           INT  NOT NULL,
    ile_osob            INT  NOT NULL,
    poczatek_rezerwacji DATE NOT NULL,
    koniec_rezerwacji   DATE NOT NULL,

    CONSTRAINT byle_rezerwacje_kg PRIMARY KEY (nr_rezerwacji),
    CONSTRAINT byle_rezerwacje_ko_pokoj FOREIGN KEY (nr_pokoju) REFERENCES hotel.dbo.pokoje (nr_pokoju),
    CONSTRAINT byle_rezerwacje_ko_klient FOREIGN KEY (nr_klienta) REFERENCES hotel.dbo.klienci (nr_klienta),
);
GO
