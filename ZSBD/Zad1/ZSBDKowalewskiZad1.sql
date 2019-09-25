-- KAMIL KOWALEWSKI 216806 --

USE narciarze
GO

-- PODPUNKT 1 --
SELECT * FROM kraje

SELECT * FROM skocznie

SELECT * FROM trenerzy

SELECT * FROM zawodnicy

SELECT * FROM zawody

SELECT * FROM uczestnictwa_w_zawodach

-- PODPUNKT 2 --
SELECT DISTINCT kraj
FROM kraje
WHERE id_kraju NOT IN (SELECT id_kraju FROM zawodnicy)

-- PODPUNKT 3 --
SELECT kraj, count(*) AS liczba
FROM kraje, zawodnicy
WHERE kraje.id_kraju = zawodnicy.id_kraju
GROUP BY kraj

-- PODPUNKT 4 --
SELECT nazwisko
FROM zawodnicy
WHERE id_skoczka NOT IN (SELECT id_skoczka FROM uczestnictwa_w_zawodach)

-- PODPUNKT 5 --
SELECT nazwisko, count(*) AS ile
FROM zawodnicy, uczestnictwa_w_zawodach
WHERE zawodnicy.id_skoczka = uczestnictwa_w_zawodach.id_skoczka
GROUP BY nazwisko

-- PODPUNKT 6 --
SELECT nazwisko, nazwa
FROM zawodnicy, skocznie, zawody, uczestnictwa_w_zawodach
WHERE zawody.id_skoczni = skocznie.id_skoczni
  AND zawodnicy.id_skoczka = uczestnictwa_w_zawodach.id_skoczka
  AND uczestnictwa_w_zawodach.id_zawodow = zawody.id_zawodow
ORDER BY nazwisko, nazwa

-- PODPUNKT 7 --
SELECT nazwisko, (year(getdate()) - year(data_ur)) AS wiek
FROM zawodnicy
ORDER BY wiek DESC

-- PODPUNKT 8 --
SELECT nazwisko, min(year(data) - year(data_ur)) AS wiek
FROM zawodnicy, zawody, uczestnictwa_w_zawodach
WHERE uczestnictwa_w_zawodach.id_zawodow = zawody.id_zawodow
  AND uczestnictwa_w_zawodach.id_skoczka = zawodnicy.id_skoczka
GROUP BY nazwisko

-- PODPUNKT 9 --
SELECT DISTINCT nazwa, (sedz - k) AS "odleglosc"
FROM skocznie
ORDER BY (sedz - k) DESC

-- PODPUNKT 10 --
SELECT TOP 1 nazwa, k
FROM skocznie, zawody
WHERE skocznie.id_skoczni = zawody.id_skoczni
ORDER BY k DESC

-- PODPUNKT 11 --
SELECT DISTINCT kraj
FROM kraje, skocznie, zawody
WHERE kraje.id_kraju = skocznie.id_kraju
  AND skocznie.id_skoczni = zawody.id_skoczni

-- PODPUNKT 12 --
-- SELECT nazwisko, kraj, count(*) AS "ile"
-- FROM zawodnicy, kraje
-- WHERE zawodnicy.id_kraju = kraje.id_kraju
-- GROUP BY nazwisko,kraj

-- PODPUNKT 13 --


-- PODPUNKT 14 --


-- PODPUNKT 15 --


-- PODPUNKT 16 --


-- PODPUNKT 17 --

