-- KAMIL KOWALEWSKI 216806 --

USE narciarze
GO

-- PODPUNKT 1. Wyświetl zawartość każdej z tabel schematu. --
SELECT * FROM narciarze.dbo.kraje

SELECT * FROM narciarze.dbo.skocznie

SELECT * FROM narciarze.dbo.trenerzy

SELECT * FROM narciarze.dbo.zawodnicy

SELECT * FROM narciarze.dbo.zawody

SELECT * FROM narciarze.dbo.uczestnictwa_w_zawodach

-- PODPUNKT 2. Sprawdź, czy dla każdego wpisanego kraju istnieje przynajmniej jeden zawodnik. --
SELECT DISTINCT kraj
FROM narciarze.dbo.kraje
WHERE id_kraju NOT IN (SELECT id_kraju FROM narciarze.dbo.zawodnicy)

-- PODPUNKT 3. Podaj liczbę zawodników z każdego kraju wraz z jego nazwą. --
SELECT kraj, count(*) AS liczba
FROM narciarze.dbo.kraje, narciarze.dbo.zawodnicy
WHERE narciarze.dbo.kraje.id_kraju = narciarze.dbo.zawodnicy.id_kraju
GROUP BY kraj

-- PODPUNKT 4. Sprawdź, czy istnieją zawodnicy, którzy nie brali udziału w żadnych zawodach. --
SELECT nazwisko
FROM narciarze.dbo.zawodnicy
WHERE id_skoczka NOT IN (SELECT id_skoczka FROM narciarze.dbo.uczestnictwa_w_zawodach)

-- PODPUNKT 5. Dla każdego zawodnika podaj jego nazwisko oraz liczbę zawodów, w których brał udział --
SELECT nazwisko, count(*) AS ile
FROM narciarze.dbo.zawodnicy, narciarze.dbo.uczestnictwa_w_zawodach
WHERE narciarze.dbo.zawodnicy.id_skoczka = narciarze.dbo.uczestnictwa_w_zawodach.id_skoczka
GROUP BY nazwisko

-- PODPUNKT 6. Dla każdego zawodnika podaj nazwę skoczni, na której skakał. --
SELECT nazwisko, nazwa
FROM narciarze.dbo.zawodnicy, narciarze.dbo.skocznie, narciarze.dbo.zawody,
     narciarze.dbo.uczestnictwa_w_zawodach
WHERE narciarze.dbo.zawody.id_skoczni = narciarze.dbo.skocznie.id_skoczni
  AND narciarze.dbo.zawodnicy.id_skoczka = narciarze.dbo.uczestnictwa_w_zawodach.id_skoczka
  AND narciarze.dbo.uczestnictwa_w_zawodach.id_zawodow = narciarze.dbo.zawody.id_zawodow
ORDER BY nazwisko, nazwa

-- PODPUNKT 7. Ile lat ma każdy z zawodników? Wynik uporządkuj malejąco względem wieku. --
SELECT nazwisko, (year(getdate()) - year(data_ur)) AS wiek
FROM narciarze.dbo.zawodnicy
ORDER BY wiek DESC

-- PODPUNKT 8. Ile lat miał każdy z zawodników, gdy uczestniczył w swoich pierwszych zawodach? --
SELECT nazwisko, min(year(data) - year(data_ur)) AS wiek
FROM narciarze.dbo.zawodnicy, narciarze.dbo.zawody, narciarze.dbo.uczestnictwa_w_zawodach
WHERE narciarze.dbo.uczestnictwa_w_zawodach.id_zawodow = narciarze.dbo.zawody.id_zawodow
  AND narciarze.dbo.uczestnictwa_w_zawodach.id_skoczka = narciarze.dbo.zawodnicy.id_skoczka
GROUP BY nazwisko

-- PODPUNKT 9. Dla każdej skoczni podaj odległość między punktem bezpieczeństwa (sedz) a punktem konstrukcyjnym (k) --
SELECT DISTINCT nazwa, (sedz - k) AS "odleglosc"
FROM narciarze.dbo.skocznie
ORDER BY (sedz - k) DESC

-- PODPUNKT 10. Podaj nazwę skoczni, na której odbywały się zawody, która ma najdłuższy punkt konstrukcyjny. --
SELECT TOP 1 nazwa, k
FROM narciarze.dbo.skocznie, narciarze.dbo.zawody
WHERE narciarze.dbo.skocznie.id_skoczni = narciarze.dbo.zawody.id_skoczni
ORDER BY k DESC

-- PODPUNKT 11. Podaj, w jakich krajach odbywały się zawody. --
SELECT DISTINCT kraj
FROM narciarze.dbo.kraje, narciarze.dbo.skocznie, narciarze.dbo.zawody
WHERE narciarze.dbo.kraje.id_kraju = narciarze.dbo.skocznie.id_kraju
  AND narciarze.dbo.skocznie.id_skoczni = narciarze.dbo.zawody.id_skoczni

-- PODPUNKT 12. Podaj, ile razy każdy z zawodników skakał na skoczni we własnym kraju. --
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

-- PODPUNKT 13. Wprowadź nowego trenera z USA (imię: Corby nazwisko: Fisher ur.: 20.07.1975). --
INSERT INTO narciarze.dbo.trenerzy
VALUES (7, 'Corby', 'Fisher', '1975-07-20')

-- PODPUNKT 14. Dodaj kolumnę trener do tabeli zawodnicy. --
ALTER TABLE narciarze.dbo.zawodnicy
    ADD trener INT

-- PODPUNKT 15. Do kolumny trener w tabeli zawodnicy wprowadź numery trenerów, uwzględniając w każdym przypadku kraj. --
UPDATE narciarze.dbo.zawodnicy
SET narciarze.dbo.zawodnicy.trener=id_kraju

-- PODPUNKT 16. Utwórz powiązanie między trenerami a zawodnikami. --
ALTER TABLE narciarze.dbo.zawodnicy
    ADD CONSTRAINT fkzawodnicytrenerzy FOREIGN KEY (trener) REFERENCES narciarze.dbo.trenerzy (id_trenera)

-- PODPUNKT 17. Dla tych trenerów, którzy nie mają wprowadzonej daty urodzenia, wprowadź datę o 5 starszą, niż data urodzenia jego najstarszego zawodnika. --
UPDATE narciarze.dbo.trenerzy
SET data_ur_t = (
                    SELECT
                    TOP 1
                    dateadd(YEAR, -5, data_ur)
                    FROM narciarze.dbo.zawodnicy
                    ORDER BY data_ur DESC
                )
WHERE data_ur_t IS NULL
