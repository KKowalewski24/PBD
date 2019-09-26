-- KAMIL KOWALEWSKI 216806 --

USE biuro
GO

SELECT *
FROM biura

SELECT *
FROM personel

SELECT *
FROM wlasciciele

SELECT *
FROM nieruchomosci

SELECT *
FROM klienci

SELECT *
FROM wynajecia

SELECT *
FROM wizyty

SELECT *
FROM rejestracje

SELECT *
FROM biura2

SELECT *
FROM nieruchomosci2

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
SELECT
TOP 1
miasto
,
count(*) AS suma
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


-- PODPUNKT 8 --


-- PODPUNKT 9 --


-- PODPUNKT 10A --


-- PODPUNKT 10B --


-- PODPUNKT 10C --


-- PODPUNKT 10D --


