-- KAMIL KOWALEWSKI 216806 --

USE biuro
GO

SELECT * FROM biura

SELECT * FROM personel

SELECT * FROM wlasciciele

SELECT * FROM nieruchomosci

SELECT * FROM klienci

SELECT * FROM wynajecia

SELECT * FROM wizyty

SELECT * FROM rejestracje

SELECT * FROM biura2

SELECT * FROM nieruchomosci2

-- PODPUNKT 1 --
SELECT nieruchomoscnr,
       (
           SELECT count(*)
           FROM wizyty
           WHERE wizyty.nieruchomoscnr = nieruchomosci.nieruchomoscnr
       ) AS ile_wizyt,
       (
           SELECT count(*)
           FROM wynajecia
           WHERE wynajecia.nieruchomoscnr = nieruchomosci.nieruchomoscnr
       ) AS ile_wynajmow
FROM nieruchomosci

-- PODPUNKT 2 --
SELECT nieruchomoscnr,
       (convert(VARCHAR(3),
                (czynsz * 100 / (
                                    SELECT
                                    TOP 1
                                    wynajecia.czynsz
                                    FROM wynajecia
                                    WHERE wynajecia.nieruchomoscnr = nieruchomosci.nieruchomoscnr
                                    ORDER BY od_kiedy
                                ) - 100)) + '%'
           ) AS podwyzka
FROM nieruchomosci

-- PODPUNKT 3 --
SELECT nieruchomosci.nieruchomoscnr,
       sum(wynajecia.czynsz * (datediff(MM, od_kiedy, do_kiedy) + 1)) AS ile
FROM nieruchomosci, wynajecia
WHERE nieruchomosci.nieruchomoscnr = wynajecia.nieruchomoscnr
GROUP BY nieruchomosci.nieruchomoscnr

-- PODPUNKT 4 --
SELECT DISTINCT biuronr,
                (
                    SELECT sum(0.3 * wyn.czynsz * (datediff(MM, od_kiedy, do_kiedy) + 1)) AS suma
                    FROM wynajecia wyn, nieruchomosci nieru
                    WHERE wyn.nieruchomoscnr = nieru.nieruchomoscnr
                      AND nieru.biuronr = nieru_zew.biuronr
                )
FROM nieruchomosci nieru_zew

-- PODPUNKT 5A --
SELECT TOP 1 miasto, count(*) AS suma
FROM nieruchomosci, wynajecia
WHERE nieruchomosci.nieruchomoscnr = wynajecia.nieruchomoscnr
GROUP BY miasto
ORDER BY suma DESC

-- PODPUNKT 5B --
SELECT TOP 1 miasto, sum(wynajecia.czynsz * (datediff(MM, od_kiedy, do_kiedy) + 1)) AS suma
FROM nieruchomosci, wynajecia
WHERE nieruchomosci.nieruchomoscnr = wynajecia.nieruchomoscnr
GROUP BY miasto
ORDER BY suma DESC

-- PODPUNKT 6 --
SELECT DISTINCT wizyty.klientnr, wizyty.nieruchomoscnr
FROM klienci, wynajecia, wizyty
WHERE klienci.klientnr = wynajecia.klientnr
  AND wynajecia.klientnr = wizyty.klientnr
  AND wynajecia.nieruchomoscnr = wizyty.nieruchomoscnr

-- PODPUNKT 7 --
SELECT DISTINCT wynajecia.klientnr, count(DISTINCT wizyty.nieruchomoscnr)
FROM wynajecia, wizyty
WHERE wizyty.klientnr = wynajecia.klientnr
  AND data_wizyty < od_kiedy
  AND wizyty.nieruchomoscnr <> wynajecia.nieruchomoscnr -- OPERATOR <> MEANS NOT EQUAL TO
GROUP BY wynajecia.klientnr

-- PODPUNKT 8 --
SELECT DISTINCT klienci.klientnr
FROM klienci, wynajecia
WHERE klienci.klientnr = wynajecia.klientnr
  AND klienci.max_czynsz < wynajecia.czynsz

-- PODPUNKT 9 --
SELECT biuronr
FROM biura
WHERE biura.biuronr NOT IN (SELECT biuronr FROM nieruchomosci)

-- WERSJA Z LEFT JOIN, NIE USUWAC
-- SELECT biu.biuronr
-- FROM biura biu
--          LEFT JOIN nieruchomosci nieru ON biu.biuronr = nieru.biuronr
-- WHERE nieru.biuronr IS NULL

-- PODPUNKT 10A --
SELECT (
           SELECT count(*)
           FROM personel
           WHERE plec = 'k'
       ) AS kobiety,
       (
           SELECT count(*)
           FROM personel
           WHERE plec = 'M'
       ) AS mezczyzni

-- PODPUNKT 10B --
SELECT DISTINCT biu.biuronr,
                (
                    SELECT count(*)
                    FROM personel per
                    WHERE plec = 'k'
                      AND biu.biuronr = biuronr
                ) AS kobiety,
                (
                    SELECT count(*)
                    FROM personel per
                    WHERE plec = 'M'
                      AND biu.biuronr = biuronr
                ) AS mezczyzni
FROM biura biu, personel
WHERE biu.biuronr = personel.biuronr

-- PODPUNKT 10C --
SELECT DISTINCT miasto,
                (
                    SELECT count(*)
                    FROM biura, personel
                    WHERE plec = 'k'
                      AND biura.biuronr = personel.biuronr
                      AND biura.miasto = biu.miasto
                ) AS kobiety,
                (
                    SELECT count(*)
                    FROM biura, personel
                    WHERE plec = 'M'
                      AND biura.biuronr = personel.biuronr
                      AND biura.miasto = biu.miasto
                ) AS mezczyzni
FROM biura biu, personel
WHERE biu.biuronr = personel.biuronr

-- PODPUNKT 10D --
SELECT DISTINCT stanowisko,
                (
                    SELECT count(*)
                    FROM biura, personel
                    WHERE plec = 'k'
                      AND biura.biuronr = personel.biuronr
                      AND personel.stanowisko = per.stanowisko
                ) AS kobiety,
                (
                    SELECT count(*)
                    FROM biura, personel
                    WHERE plec = 'M'
                      AND biura.biuronr = personel.biuronr
                      AND personel.stanowisko = per.stanowisko
                ) AS mezczyzni
FROM biura biu, personel per
WHERE biu.biuronr = per.biuronr
