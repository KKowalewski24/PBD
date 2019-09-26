IF exists(SELECT 1
          FROM master.dbo.sysdatabases
          WHERE name = 'biuro')
    DROP DATABASE biuro
GO
CREATE DATABASE biuro
GO

USE biuro;
GO

CREATE TABLE biura (
    biuronr VARCHAR(4)  NOT NULL PRIMARY KEY,
    ulica   VARCHAR(25) NOT NULL,
    miasto  VARCHAR(25) NOT NULL,
    kod     VARCHAR(6)  NOT NULL
);
GO

CREATE TABLE personel (
    personelnr VARCHAR(4)    NOT NULL PRIMARY KEY,
    imie       VARCHAR(25)   NOT NULL,
    nazwisko   VARCHAR(25)   NOT NULL,
    stanowisko VARCHAR(25)   NOT NULL,
    plec       CHAR(1)       NOT NULL
        CONSTRAINT czytelnicy_plec_ch CHECK (plec = 'K' OR plec = 'M'),
    dataur     SMALLDATETIME NOT NULL,
    pensja     SMALLINT      NOT NULL,
    biuronr    VARCHAR(4)    NOT NULL,
    CONSTRAINT fkpersonelbiuro FOREIGN KEY (biuronr) REFERENCES biura (biuronr)
);
GO

CREATE TABLE wlasciciele (
    wlascicielnr VARCHAR(4)  NOT NULL PRIMARY KEY,
    imie         VARCHAR(25) NOT NULL,
    nazwisko     VARCHAR(25) NOT NULL,
    adres        VARCHAR(45) NOT NULL,
    telefon      VARCHAR(15) NOT NULL
);
GO

CREATE TABLE nieruchomosci (
    nieruchomoscnr VARCHAR(4)  NOT NULL PRIMARY KEY,
    ulica          VARCHAR(25) NOT NULL,
    miasto         VARCHAR(25) NOT NULL,
    kod            VARCHAR(6)  NOT NULL,
    typ            VARCHAR(25) NOT NULL,
    pokoje         TINYINT     NOT NULL,
    czynsz         SMALLINT    NOT NULL,
    wlascicielnr   VARCHAR(4)  NOT NULL,
    personelnr     VARCHAR(4)  NOT NULL,
    biuronr        VARCHAR(4)  NOT NULL,
    CONSTRAINT fknieruchomoscipersonel FOREIGN KEY (personelnr) REFERENCES personel (personelnr),
    CONSTRAINT fknieruchomosciwlasciciele FOREIGN KEY (wlascicielnr) REFERENCES wlasciciele (wlascicielnr),
    CONSTRAINT fknieruchomoscibiura FOREIGN KEY (biuronr) REFERENCES biura (biuronr)
);
GO

CREATE TABLE klienci (
    klientnr    VARCHAR(4)  NOT NULL PRIMARY KEY,
    imie        VARCHAR(25) NOT NULL,
    nazwisko    VARCHAR(25) NOT NULL,
    adres       VARCHAR(45) NOT NULL,
    telefon     VARCHAR(15),
    preferencje VARCHAR(25),
    max_czynsz  SMALLINT,
);
GO

CREATE TABLE wynajecia (
    umowanr         VARCHAR(4)    NOT NULL PRIMARY KEY,
    nieruchomoscnr  VARCHAR(4)    NOT NULL,
    klientnr        VARCHAR(4)    NOT NULL,
    czynsz          SMALLINT      NOT NULL,
    forma_platnosci VARCHAR(25)   NOT NULL,
    kaucja          SMALLINT      NOT NULL,
    zaplacona       TINYINT,
    od_kiedy        SMALLDATETIME NOT NULL,
    do_kiedy        SMALLDATETIME NOT NULL,
    CONSTRAINT fkwynajecianieruchomosci FOREIGN KEY (nieruchomoscnr) REFERENCES nieruchomosci (nieruchomoscnr),
    CONSTRAINT fkklienci FOREIGN KEY (klientnr) REFERENCES klienci (klientnr)
);
GO

CREATE TABLE wizyty (
    klientnr       VARCHAR(4)    NOT NULL,
    nieruchomoscnr VARCHAR(4)    NOT NULL,
    data_wizyty    SMALLDATETIME NOT NULL,
    uwagi          VARCHAR(255),
    CONSTRAINT pkwizyty PRIMARY KEY (klientnr, nieruchomoscnr),
    CONSTRAINT fkwizytynieruchomosci FOREIGN KEY (nieruchomoscnr) REFERENCES nieruchomosci (nieruchomoscnr),
    CONSTRAINT fkwizytyklienci FOREIGN KEY (klientnr) REFERENCES klienci (klientnr)
);
GO

CREATE TABLE rejestracje (
    klientnr         VARCHAR(4)    NOT NULL,
    biuronr          VARCHAR(4)    NOT NULL,
    personelnr       VARCHAR(4)    NOT NULL,
    data_rejestracji SMALLDATETIME NOT NULL,
    CONSTRAINT pkrejestracje PRIMARY KEY (klientnr, biuronr, personelnr),
    CONSTRAINT fkrejestracjeklienci FOREIGN KEY (klientnr) REFERENCES klienci (klientnr),
    CONSTRAINT fkrejestracjebiura FOREIGN KEY (biuronr) REFERENCES biura (biuronr),
    CONSTRAINT fkrejestracjepersonel FOREIGN KEY (personelnr) REFERENCES personel (personelnr)
);
GO

CREATE TABLE biura2 (
    biuronr VARCHAR(4)  NOT NULL PRIMARY KEY,
    miasto  VARCHAR(25) NOT NULL
);
GO

CREATE TABLE nieruchomosci2 (
    nieruchomoscnr VARCHAR(4) PRIMARY KEY NOT NULL,
    miasto         VARCHAR(25)            NOT NULL
);
GO


--   WPROWADZANIE DANYCH

INSERT INTO biura
VALUES ('B001', 'Piękna 46', 'Białystok', '15-900');
INSERT INTO biura
VALUES ('B002', 'Cicha 56', 'Łomża', '18-400');
INSERT INTO biura
VALUES ('B003', 'Mała 63', 'Białystok', '15-900');
INSERT INTO biura
VALUES ('B004', 'Miodowa 32', 'Grajewo', '19-300');
INSERT INTO biura
VALUES ('B005', 'Dobra 22', 'Łomża', '18-400');
INSERT INTO biura
VALUES ('B006', 'Słoneczna 55', 'Białystok', '15-900');
INSERT INTO biura
VALUES ('B007', 'Akacjowa 16', 'Augustów', '16-300');
GO

INSERT INTO personel
VALUES ('SA8', 'Katarzyna', 'Morawska', 'kierownik', 'K', '1971-05-06', 1700, 'B007');
INSERT INTO personel
VALUES ('SA9', 'Maria', 'Hojna', 'asystent', 'K', '1970-2-19', 900, 'B007');
INSERT INTO personel
VALUES ('SB20', 'Sabina', 'Bober', 'dyrektor', 'K', '1940-6-3', 2400, 'B003');
INSERT INTO personel
VALUES ('SB21', 'Daniel', 'Frankowski', 'kierownik', 'M', '1958-3-24', 1800, 'B003');
INSERT INTO personel
VALUES ('SB22', 'Małgorzata', 'Kowalska', 'asystent', 'K', '1972-3-15', 1000, 'B003');
INSERT INTO personel
VALUES ('SB23', 'Anna', 'Biały', 'asystent', 'K', '1960-11-10', 1200, 'B003');
INSERT INTO personel
VALUES ('SB30', 'Katarzyna', 'Michalska', 'dyrektor', 'K', '1960-11-17', 2500, 'B006');
INSERT INTO personel
VALUES ('SB31', 'Dawid', 'Piotrowski', 'asystent', 'M', '1975-3-22', 1100, 'B006');
INSERT INTO personel
VALUES ('SB32', 'Małgorzata', 'Plichta', 'asystent', 'K', '1971-10-3', 1200, 'B006');
INSERT INTO personel
VALUES ('SG20', 'Karolina', 'Mucha', 'dyrektor', 'K', '1953-3-3', 2200, 'B004');
INSERT INTO personel
VALUES ('SG21', 'Piotr', 'Cybulski', 'asystent', 'M', '1974-12-6', 1300, 'B004');
INSERT INTO personel
VALUES ('SL20', 'Paweł', 'Nowak', 'kierownik', 'M', '1962-2-2', 1500, 'B002');
INSERT INTO personel
VALUES ('SL21', 'Paweł', 'Kowalski', 'asystent', 'M', '1969-5-5', 1000, 'B002');
INSERT INTO personel
VALUES ('SL22', 'Monika', 'Munk', 'asystent', 'K', '1977-7-26', 1100, 'B002');
INSERT INTO personel
VALUES ('SL30', 'Jan', 'Wiśniewski', 'dyrektor', 'M', '1945-10-1', 3000, 'B005');
INSERT INTO personel
VALUES ('SL31', 'Julia', 'Lisicka', 'asystent', 'K', '1965-7-13', 900, 'B005');
INSERT INTO personel
VALUES ('SL32', 'Michał', 'Brzęczyk', 'asystent', 'M', '1959-3-15', 1000, 'B005');
GO

INSERT INTO wlasciciele
VALUES ('CO15', 'Paweł', 'Kowalewski', '19-200 Grajewo, Jarzębinowa 2', '0-87-444 5555');
INSERT INTO wlasciciele
VALUES ('CO40', 'Tatiana', 'Marcinkowski', '15-900 Białystok, Wodna 63', '0-85-111 5555');
INSERT INTO wlasciciele
VALUES ('CO46', 'Jan', 'Kowalski', '16-300 Augustów, Fabryczna 2', '0-87-555 4444');
INSERT INTO wlasciciele
VALUES ('CO87', 'Karol', 'Frankowski', '15-900 Białystok, Agrestowa 6', '0-85-222 6666');
INSERT INTO wlasciciele
VALUES ('CO93', 'Tomasz', 'Szymański', '15-900 Białystok, Parkowa 12', '0-85-333 4444');
GO

INSERT INTO nieruchomosci
VALUES ('A14', 'Handlowa 16', 'Augustów', '16-300', 'dom', 6, 715, 'CO46', 'SA9', 'B007');
INSERT INTO nieruchomosci
VALUES ('B16', 'Nowa 5', 'Białystok', '15-900', 'mieszkanie', 4, 495, 'CO93', 'SB21', 'B003');
INSERT INTO nieruchomosci
VALUES ('B17', 'Mała 2', 'Białystok', '15-900', 'mieszkanie', 3, 412, 'CO93', 'SB23', 'B003');
INSERT INTO nieruchomosci
VALUES ('B18', 'Leśna 6', 'Białystok', '15-900', 'mieszkanie', 3, 385, 'CO40', 'SB23', 'B003');
INSERT INTO nieruchomosci
VALUES ('B21', 'Dobra 18', 'Białystok', '15-900', 'dom', 5, 660, 'CO87', 'SB22', 'B003');
INSERT INTO nieruchomosci
VALUES ('G01', 'Długa 33', 'Grajewo', '19-200', 'dom', 7, 830, 'CO15', 'SG21', 'B004');
INSERT INTO nieruchomosci
VALUES ('L94', 'Akacjowa 6', 'Łomża', '18-400', 'mieszkanie', 4, 440, 'CO87', 'SL31', 'B005');
GO

INSERT INTO klienci
VALUES ('CO16', 'Alicja', 'Stefańska', '15-900 Białystok', '0-85-333 2222', 'mieszkanie', 400);
INSERT INTO klienci
VALUES ('CO17', 'Katarzyna', 'Winiarska', '15-900 Białystok', ' ', 'mieszkanie', 420);
INSERT INTO klienci
VALUES ('CO18', 'Anna', 'Nowak', '15-900 Białystok', ' ', 'dom', 850);
INSERT INTO klienci
VALUES ('CR51', 'Michał', 'Rafalski', 'Tykocin,', '0-86-123 4567', 'dom', 750);
INSERT INTO klienci
VALUES ('CR52', 'Ludwik', 'Wierzba', '19-200 Grajewo', ' ', 'mieszkanie', 375);
INSERT INTO klienci
VALUES ('CR53', 'Janusz', 'Kalinowski', '18-400 Łomża', '0-86-444 5555', 'mieszkanie', 425);
INSERT INTO klienci
VALUES ('CR54', 'Maria', 'Tomaszewska', '16-300 Augustów, Trawiasta 5', '0-87-111 6666', 'mieszkanie', 600);
GO

INSERT INTO wynajecia
VALUES ('1001', 'B16', 'CO16', 410, 'gotówka', 900, 1, '2003-10-01', '2004-03-31');
INSERT INTO wynajecia
VALUES ('1002', 'B21', 'CR51', 580, 'czek', 1200, 1, '2003-11-01', '2004-04-30');
INSERT INTO wynajecia
VALUES ('1003', 'B17', 'CO17', 350, 'gotówka', 800, 1, '2003-12-01', '2004-05-31');
INSERT INTO wynajecia
VALUES ('1004', 'B18', 'CR52', 300, 'karta visa', 700, 1, '2004-01-01', '2004-06-30');
INSERT INTO wynajecia
VALUES ('1005', 'A14', 'CR54', 650, 'karta Visa', 1300, 1, '2004-02-01', '2004-07-31');
INSERT INTO wynajecia
VALUES ('1006', 'L94', 'CR53', 400, 'gotówka', 800, 1, '2004-03-01', '2004-08-31');
INSERT INTO wynajecia
VALUES ('1007', 'G01', 'CO18', 800, 'karta visa', 1600, 1, '2002-04-01', '2004-09-30');
INSERT INTO wynajecia
VALUES ('1011', 'B16', 'CO16', 450, 'gotówka', 900, 1, '2004-04-01', '2004-09-30');
INSERT INTO wynajecia
VALUES ('1012', 'B21', 'CR51', 600, 'gotówka', 1200, 1, '2004-05-01', '2005-04-30');
INSERT INTO wynajecia
VALUES ('1013', 'B17', 'CO17', 400, 'karta visa', 800, 1, '2004-06-01', '2004-11-30');
INSERT INTO wynajecia
VALUES ('1014', 'B18', 'CR52', 350, 'gotówka', 700, 1, '2004-07-01', '2005-06-30');
INSERT INTO wynajecia
VALUES ('1015', 'A14', 'CR54', 650, 'gotówka', 1300, 1, '2004-08-01', '2005-01-31');
INSERT INTO wynajecia
VALUES ('1016', 'L94', 'CR53', 400, 'gotówka', 800, 0, '2004-09-01', '2005-05-30');
INSERT INTO wynajecia
VALUES ('1017', 'G01', 'CO18', 820, 'gotówka', 1600, 0, '2004-10-01', '2005-07-30');
INSERT INTO wynajecia
VALUES ('1021', 'B16', 'CO16', 450, 'gotówka', 900, 1, '2004-10-01', '2005-09-30');
INSERT INTO wynajecia
VALUES ('1023', 'G01', 'CO18', 800, 'gotówka', 1600, 1, '2006-08-01', '2009-07-31');
GO

INSERT INTO wizyty
VALUES ('CR51', 'A14', '2001-5-24', 'za mały');
INSERT INTO wizyty
VALUES ('CR51', 'B16', '2001-4-28', ' ');
INSERT INTO wizyty
VALUES ('CR51', 'L94', '2001-5-26', ' ');
INSERT INTO wizyty
VALUES ('CR52', 'A14', '2001-5-14', 'brak jadalni');
INSERT INTO wizyty
VALUES ('CR53', 'L94', '2001-4-20', 'za daleko');
INSERT INTO wizyty
VALUES ('CO16', 'A14', '2001-03-03', ' ');
INSERT INTO wizyty
VALUES ('CO16', 'B18', '2001-03-03', ' ');
INSERT INTO wizyty
VALUES ('CO16', 'G01', '2001-03-03', ' ');
INSERT INTO wizyty
VALUES ('CO17', 'L94', '2001-03-03', ' ');
INSERT INTO wizyty
VALUES ('CO18', 'B16', '2001-03-03', ' ');
INSERT INTO wizyty
VALUES ('CO18', 'B17', '2001-03-03', ' ');
INSERT INTO wizyty
VALUES ('CO18', 'B18', '2001-03-03', ' ');
INSERT INTO wizyty
VALUES ('CO18', 'B21', '2001-03-03', ' ');
INSERT INTO wizyty
VALUES ('CO18', 'G01', '2001-03-03', ' ');
INSERT INTO wizyty
VALUES ('CO18', 'L94', '2001-03-03', ' ');
INSERT INTO wizyty
VALUES ('CR54', 'A14', '2001-03-01', ' ');
INSERT INTO wizyty
VALUES ('CR54', 'B17', '2001-03-01', ' ');
INSERT INTO wizyty
VALUES ('CR54', 'B21', '2001-03-01', ' ');
INSERT INTO wizyty
VALUES ('CR54', 'L94', '2001-03-01', ' ');
GO

INSERT INTO rejestracje
VALUES ('CR54', 'B003', 'SG21', '2000-4-11');
INSERT INTO rejestracje
VALUES ('CR52', 'B007', 'SL31', '2000-3-7');
INSERT INTO rejestracje
VALUES ('CR53', 'B003', 'SG21', '1999-11-16');
INSERT INTO rejestracje
VALUES ('CR51', 'B005', 'SL31', '2001-1-2');
GO


INSERT INTO biura2
VALUES ('B002', 'Łomża');
INSERT INTO biura2
VALUES ('B003', 'Białystok');
INSERT INTO biura2
VALUES ('B004', 'Grajewo');
GO

INSERT INTO nieruchomosci2
VALUES ('A14', 'Augustów');
INSERT INTO nieruchomosci2
VALUES ('B4', 'Białystok');
INSERT INTO nieruchomosci2
VALUES ('L94', 'Łomża');
GO

SELECT *
FROM biura;
SELECT *
FROM personel;
SELECT *
FROM wlasciciele;
SELECT *
FROM nieruchomosci;
SELECT *
FROM klienci;
SELECT *
FROM wynajecia;
SELECT *
FROM wizyty;
SELECT *
FROM rejestracje;
SELECT *
FROM biura2;
SELECT *
FROM nieruchomosci2;
