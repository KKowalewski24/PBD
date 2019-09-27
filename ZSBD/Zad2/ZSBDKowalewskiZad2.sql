-- KAMIL KOWALEWSKI 216806 --

USE biuro
GO

SELECT * FROM biuro.dbo.biura

SELECT * FROM biuro.dbo.personel

SELECT * FROM biuro.dbo.wlasciciele

SELECT * FROM biuro.dbo.nieruchomosci

SELECT * FROM biuro.dbo.klienci

SELECT * FROM biuro.dbo.wynajecia

SELECT * FROM biuro.dbo.wizyty

SELECT * FROM biuro.dbo.rejestracje

SELECT * FROM biuro.dbo.biura2

SELECT * FROM biuro.dbo.nieruchomosci2

-- PODPUNKT 1 --
SELECT nieruchomoscnr,
       (
           SELECT count(*)
           FROM biuro.dbo.wizyty
           WHERE biuro.dbo.wizyty.nieruchomoscnr = biuro.dbo.nieruchomosci.nieruchomoscnr
       ) AS ile_wizyt,
       (
           SELECT count(*)
           FROM biuro.dbo.wynajecia
           WHERE biuro.dbo.wynajecia.nieruchomoscnr = biuro.dbo.nieruchomosci.nieruchomoscnr
       ) AS ile_wynajmow
FROM biuro.dbo.nieruchomosci

-- PODPUNKT 2 --
SELECT nieruchomoscnr,
       (convert(VARCHAR(3),
                (czynsz * 100 / (
                                    SELECT
                                    TOP 1
                                    biuro.dbo.wynajecia.czynsz
                                    FROM biuro.dbo.wynajecia
                                    WHERE biuro.dbo.wynajecia.nieruchomoscnr =
                                          biuro.dbo.nieruchomosci.nieruchomoscnr
                                    ORDER BY od_kiedy
                                ) - 100)) + '%'
           ) AS podwyzka
FROM biuro.dbo.nieruchomosci

-- PODPUNKT 3 --
SELECT biuro.dbo.nieruchomosci.nieruchomoscnr,
       sum(biuro.dbo.wynajecia.czynsz * (datediff(MM, od_kiedy, do_kiedy) + 1)) AS ile
FROM biuro.dbo.nieruchomosci, biuro.dbo.wynajecia
WHERE biuro.dbo.nieruchomosci.nieruchomoscnr = biuro.dbo.wynajecia.nieruchomoscnr
GROUP BY biuro.dbo.nieruchomosci.nieruchomoscnr

-- PODPUNKT 4 --
SELECT DISTINCT biuronr,
                (
                    SELECT sum(0.3 * wyn.czynsz * (datediff(MM, od_kiedy, do_kiedy) + 1)) AS suma
                    FROM biuro.dbo.wynajecia wyn, biuro.dbo.nieruchomosci nieru
                    WHERE wyn.nieruchomoscnr = nieru.nieruchomoscnr
                      AND nieru.biuronr = nieru_zew.biuronr
                )
FROM biuro.dbo.nieruchomosci nieru_zew

-- PODPUNKT 5A --
SELECT TOP 1 miasto, count(*) AS suma
FROM biuro.dbo.nieruchomosci, biuro.dbo.wynajecia
WHERE biuro.dbo.nieruchomosci.nieruchomoscnr = biuro.dbo.wynajecia.nieruchomoscnr
GROUP BY miasto
ORDER BY suma DESC

-- PODPUNKT 5B --
SELECT TOP 1 miasto,
sum(biuro.dbo.wynajecia.czynsz * (datediff(MM, od_kiedy, do_kiedy) + 1)) AS suma
FROM biuro.dbo.nieruchomosci, biuro.dbo.wynajecia
WHERE biuro.dbo.nieruchomosci.nieruchomoscnr = biuro.dbo.wynajecia.nieruchomoscnr
GROUP BY miasto
ORDER BY suma DESC

-- PODPUNKT 6 --
SELECT DISTINCT biuro.dbo.wizyty.klientnr, biuro.dbo.wizyty.nieruchomoscnr
FROM biuro.dbo.klienci, biuro.dbo.wynajecia, biuro.dbo.wizyty
WHERE biuro.dbo.klienci.klientnr = biuro.dbo.wynajecia.klientnr
  AND biuro.dbo.wynajecia.klientnr = biuro.dbo.wizyty.klientnr
  AND biuro.dbo.wynajecia.nieruchomoscnr = biuro.dbo.wizyty.nieruchomoscnr

-- PODPUNKT 7 --
SELECT DISTINCT biuro.dbo.wynajecia.klientnr, count(DISTINCT biuro.dbo.wizyty.nieruchomoscnr)
FROM biuro.dbo.wynajecia, biuro.dbo.wizyty
WHERE biuro.dbo.wizyty.klientnr = biuro.dbo.wynajecia.klientnr
  AND data_wizyty < od_kiedy
  AND biuro.dbo.wizyty.nieruchomoscnr <>
      biuro.dbo.wynajecia.nieruchomoscnr -- OPERATOR <> MEANS NOT EQUAL TO
GROUP BY biuro.dbo.wynajecia.klientnr

-- PODPUNKT 8 --
SELECT DISTINCT biuro.dbo.klienci.klientnr
FROM biuro.dbo.klienci, biuro.dbo.wynajecia
WHERE biuro.dbo.klienci.klientnr = biuro.dbo.wynajecia.klientnr
  AND biuro.dbo.klienci.max_czynsz < biuro.dbo.wynajecia.czynsz

-- PODPUNKT 9 --
SELECT biuronr
FROM biuro.dbo.biura
WHERE biuro.dbo.biura.biuronr NOT IN (SELECT biuronr FROM biuro.dbo.nieruchomosci)

-- WERSJA Z LEFT JOIN, NIE USUWAC
-- SELECT biu.biuronr
-- FROM biuro.dbo.biura biu
--          LEFT JOIN biuro.dbo.nieruchomosci nieru ON biu.biuronr = nieru.biuronr
-- WHERE nieru.biuronr IS NULL

-- PODPUNKT 10A --
SELECT (
           SELECT count(*)
           FROM biuro.dbo.personel
           WHERE plec = 'k'
       ) AS kobiety,
       (
           SELECT count(*)
           FROM biuro.dbo.personel
           WHERE plec = 'M'
       ) AS mezczyzni

-- PODPUNKT 10B --
SELECT DISTINCT biu.biuronr,
                (
                    SELECT count(*)
                    FROM biuro.dbo.personel per
                    WHERE plec = 'k'
                      AND biu.biuronr = biuronr
                ) AS kobiety,
                (
                    SELECT count(*)
                    FROM biuro.dbo.personel per
                    WHERE plec = 'M'
                      AND biu.biuronr = biuronr
                ) AS mezczyzni
FROM biuro.dbo.biura biu, biuro.dbo.personel
WHERE biu.biuronr = biuro.dbo.personel.biuronr

-- PODPUNKT 10C --
SELECT DISTINCT miasto,
                (
                    SELECT count(*)
                    FROM biuro.dbo.biura, biuro.dbo.personel
                    WHERE plec = 'k'
                      AND biuro.dbo.biura.biuronr = biuro.dbo.personel.biuronr
                      AND biuro.dbo.biura.miasto = biu.miasto
                ) AS kobiety,
                (
                    SELECT count(*)
                    FROM biuro.dbo.biura, biuro.dbo.personel
                    WHERE plec = 'M'
                      AND biuro.dbo.biura.biuronr = biuro.dbo.personel.biuronr
                      AND biuro.dbo.biura.miasto = biu.miasto
                ) AS mezczyzni
FROM biuro.dbo.biura biu, biuro.dbo.personel
WHERE biu.biuronr = biuro.dbo.personel.biuronr

-- PODPUNKT 10D --
SELECT DISTINCT stanowisko,
                (
                    SELECT count(*)
                    FROM biuro.dbo.biura, biuro.dbo.personel
                    WHERE plec = 'k'
                      AND biuro.dbo.biura.biuronr = biuro.dbo.personel.biuronr
                      AND biuro.dbo.personel.stanowisko = per.stanowisko
                ) AS kobiety,
                (
                    SELECT count(*)
                    FROM biuro.dbo.biura, biuro.dbo.personel
                    WHERE plec = 'M'
                      AND biuro.dbo.biura.biuronr = biuro.dbo.personel.biuronr
                      AND biuro.dbo.personel.stanowisko = per.stanowisko
                ) AS mezczyzni
FROM biuro.dbo.biura biu, biuro.dbo.personel per
WHERE biu.biuronr = per.biuronr
