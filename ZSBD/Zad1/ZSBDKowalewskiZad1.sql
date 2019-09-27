-- KAMIL KOWALEWSKI 216806 --

USE narciarze
GO

-- PODPUNKT 1 --
SELECT * FROM narciarze.dbo.kraje

SELECT * FROM narciarze.dbo.skocznie

SELECT * FROM narciarze.dbo.trenerzy

SELECT * FROM narciarze.dbo.zawodnicy

SELECT * FROM narciarze.dbo.zawody

SELECT * FROM narciarze.dbo.uczestnictwa_w_zawodach

-- PODPUNKT 2 --
SELECT DISTINCT kraj
FROM narciarze.dbo.kraje
WHERE id_kraju NOT IN (SELECT id_kraju FROM narciarze.dbo.zawodnicy)

-- PODPUNKT 3 --
SELECT kraj, count(*) AS liczba
FROM narciarze.dbo.kraje, narciarze.dbo.zawodnicy
WHERE narciarze.dbo.kraje.id_kraju = narciarze.dbo.zawodnicy.id_kraju
GROUP BY kraj

-- PODPUNKT 4 --
SELECT nazwisko
FROM narciarze.dbo.zawodnicy
WHERE id_skoczka NOT IN (SELECT id_skoczka FROM narciarze.dbo.uczestnictwa_w_zawodach)

-- PODPUNKT 5 --
SELECT nazwisko, count(*) AS ile
FROM narciarze.dbo.zawodnicy, narciarze.dbo.uczestnictwa_w_zawodach
WHERE narciarze.dbo.zawodnicy.id_skoczka = narciarze.dbo.uczestnictwa_w_zawodach.id_skoczka
GROUP BY nazwisko

-- PODPUNKT 6 --
SELECT nazwisko, nazwa
FROM narciarze.dbo.zawodnicy, narciarze.dbo.skocznie, narciarze.dbo.zawody,
     narciarze.dbo.uczestnictwa_w_zawodach
WHERE narciarze.dbo.zawody.id_skoczni = narciarze.dbo.skocznie.id_skoczni
  AND narciarze.dbo.zawodnicy.id_skoczka = narciarze.dbo.uczestnictwa_w_zawodach.id_skoczka
  AND narciarze.dbo.uczestnictwa_w_zawodach.id_zawodow = narciarze.dbo.zawody.id_zawodow
ORDER BY nazwisko, nazwa

-- PODPUNKT 7 --
SELECT nazwisko, (year(getdate()) - year(data_ur)) AS wiek
FROM narciarze.dbo.zawodnicy
ORDER BY wiek DESC

-- PODPUNKT 8 --
SELECT nazwisko, min(year(data) - year(data_ur)) AS wiek
FROM narciarze.dbo.zawodnicy, narciarze.dbo.zawody, narciarze.dbo.uczestnictwa_w_zawodach
WHERE narciarze.dbo.uczestnictwa_w_zawodach.id_zawodow = narciarze.dbo.zawody.id_zawodow
  AND narciarze.dbo.uczestnictwa_w_zawodach.id_skoczka = narciarze.dbo.zawodnicy.id_skoczka
GROUP BY nazwisko

-- PODPUNKT 9 --
SELECT DISTINCT nazwa, (sedz - k) AS "odleglosc"
FROM narciarze.dbo.skocznie
ORDER BY (sedz - k) DESC

-- PODPUNKT 10 --
SELECT TOP 1 nazwa, k
FROM narciarze.dbo.skocznie, narciarze.dbo.zawody
WHERE narciarze.dbo.skocznie.id_skoczni = narciarze.dbo.zawody.id_skoczni
ORDER BY k DESC

-- PODPUNKT 11 --
SELECT DISTINCT kraj
FROM narciarze.dbo.kraje, narciarze.dbo.skocznie, narciarze.dbo.zawody
WHERE narciarze.dbo.kraje.id_kraju = narciarze.dbo.skocznie.id_kraju
  AND narciarze.dbo.skocznie.id_skoczni = narciarze.dbo.zawody.id_skoczni

-- PODPUNKT 12 --
SELECT nazwisko, kraj, count(*) AS "ile"
FROM narciarze.dbo.kraje, narciarze.dbo.skocznie, narciarze.dbo.zawodnicy, narciarze.dbo.zawody,
     narciarze.dbo.uczestnictwa_w_zawodach
WHERE narciarze.dbo.kraje.id_kraju = narciarze.dbo.skocznie.id_kraju
  AND narciarze.dbo.kraje.id_kraju = narciarze.dbo.zawodnicy.id_kraju
  AND narciarze.dbo.skocznie.id_skoczni = narciarze.dbo.zawody.id_skoczni
  AND narciarze.dbo.zawodnicy.id_skoczka = narciarze.dbo.uczestnictwa_w_zawodach.id_skoczka
  AND narciarze.dbo.zawody.id_zawodow = narciarze.dbo.uczestnictwa_w_zawodach.id_zawodow
GROUP BY nazwisko, kraj
ORDER BY nazwisko

-- PODPUNKT 13 --
INSERT INTO narciarze.dbo.trenerzy
VALUES (7, 'Corby', 'Fisher', '1975-07-20')

-- PODPUNKT 14 --
ALTER TABLE narciarze.dbo.zawodnicy
    ADD trener INT

-- PODPUNKT 15 --
UPDATE narciarze.dbo.zawodnicy
SET narciarze.dbo.zawodnicy.trener=id_kraju

-- PODPUNKT 16 --
ALTER TABLE narciarze.dbo.zawodnicy
    ADD CONSTRAINT fkzawodnicytrenerzy FOREIGN KEY (trener) REFERENCES narciarze.dbo.trenerzy (id_trenera)

-- PODPUNKT 17 --
UPDATE narciarze.dbo.trenerzy
SET data_ur_t = (
                    SELECT
                    TOP 1
                    dateadd(YEAR, -5, data_ur)
                    FROM narciarze.dbo.zawodnicy
                    ORDER BY data_ur DESC
                )
WHERE data_ur_t IS NULL
