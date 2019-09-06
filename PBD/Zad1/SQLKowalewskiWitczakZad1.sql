CREATE DATABASE test1_kowalewski_witczak

--/////////////// TWORZENIE TABEL ///////////////--
CREATE TABLE osoby (
    nr_osoby INT PRIMARY KEY,
    imie     VARCHAR(40),
    nazwisko VARCHAR(40),
    adres    VARCHAR(500),
    wiek     INT
);

CREATE TABLE dzieci (
    nr_osoby   INT,
    nr_dziecka INT IDENTITY (100,1),
    imie       VARCHAR(40)
);

--DODAWANIE REKORDOW--
INSERT INTO osoby (nr_osoby, imie, nazwisko, adres, wiek)
VALUES (1, 'Baba', 'Jaga', 'Domek z Piernika 100', 154)

INSERT INTO dzieci(nr_osoby, imie)
VALUES (1, 'Jas')

INSERT INTO dzieci(nr_osoby, imie)
VALUES (2, 'Malgosia')

--DODANIE OPCJI AKTUALNEJ DATY--
ALTER TABLE osoby
    ADD data_wpisu DATE DEFAULT GETDATE()

INSERT INTO osoby(nr_osoby, imie, nazwisko, adres, wiek)
VALUES (2, 'Matka', 'Chrzestna', 'Wrozkolandia', 105)

--MOZLIWOSC DODANIA WLASNEGO IDENTYFIKATORA--
SET IDENTITY_INSERT dzieci ON

INSERT INTO dzieci(nr_osoby, nr_dziecka, imie)
VALUES (3, 10, 'Kopciuszek')

--USTAWIENIA OGRANICZENIA NA WPISYWANE DANE--
ALTER TABLE osoby
    WITH NOCHECK ADD CONSTRAINT wiek CHECK (wiek < 100)


--/////////////// NARZEDZIA ULATWIAJACE OBSLUGE ///////////////--

-- WYSWIETLANIE --
SELECT *
FROM osoby
SELECT *
FROM dzieci

--CZYSZCZENIE TABEL--

DELETE
FROM osoby
DELETE
FROM dzieci
