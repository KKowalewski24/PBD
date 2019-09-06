-- UZYCIE BAZY TEST_PRACOWNICY --
USE test_pracownicy

-- PODPUNKT 1 --
SELECT nazwisko, placa + isnull(dod_funkcyjny, 0) AS pensja
FROM dbo.pracownicy

-- PODPUNKT 2,4 -- alias -> dniowka
SELECT nazwisko, placa / 30 AS dniowka
FROM dbo.pracownicy

-- PODPUNKT 3,4 -- alias -> roczna
SELECT nazwisko, placa * 12 AS roczna
FROM dbo.pracownicy

-- PODPUNKT 5 --
SELECT min(placa)
FROM dbo.pracownicy

-- PODPUNKT 6 --
SELECT nazwisko, placa, stanowisko
FROM dbo.pracownicy
WHERE placa = (SELECT min(placa) FROM dbo.pracownicy)

-- PODPUNKT 7 --
SELECT nazwisko, placa, stanowisko
FROM dbo.pracownicy
WHERE placa < (SELECT avg(placa) FROM dbo.pracownicy)

-- PODPUNKT 8 --
SELECT id_dzialu, count(*) AS liczba_pracownikow
FROM pracownicy
GROUP BY id_dzialu

-- PODPUNKT 9 --
SELECT nazwa + ' ' + nazwisko AS procownik
FROM dbo.dzialy,
     dbo.pracownicy
WHERE pracownicy.id_dzialu = dzialy.id_dzialu

-- PODPUNKT 10 --
SELECT id_dzialu, count(stanowisko) AS liczba_pracownikow, stanowisko
FROM dbo.pracownicy
GROUP BY stanowisko, id_dzialu

-- PODPUNKT 11 --
SELECT nazwisko, nazwa, placa, placa_min, placa_max
FROM dbo.pracownicy,
     dbo.stanowiska,
     dbo.dzialy
WHERE (placa_min > 1500 AND placa_max < 3500)

-- PODPUNKT 12 --
SELECT nazwisko, placa
FROM dbo.pracownicy
WHERE placa > (SELECT max(placa) FROM dbo.pracownicy WHERE id_dzialu = '30')

-- PODPUNKT 13 --
SELECT nazwisko, placa, round(placa - (SELECT avg(placa) FROM dbo.pracownicy), 2)
    AS roznica
FROM dbo.pracownicy

-- PODPUNKT 14 --
SELECT nazwa, avg(placa) AS srednia
FROM pracownicy,
     dzialy
WHERE pracownicy.id_dzialu = dzialy.id_dzialu
GROUP BY nazwa

-- PODPUNKT 15 --
SELECT id_dzialu, nazwisko, placa
FROM dbo.pracownicy pp
WHERE placa > (SELECT avg(placa)
               FROM dbo.pracownicy
               WHERE pp.id_dzialu = pracownicy.id_dzialu)

-- PODPUNKT 16 --
SELECT prac2.nazwisko, prac1.nazwisko AS nazwisko_szefa
FROM pracownicy prac1,
     pracownicy prac2
WHERE prac1.nr_akt = prac2.kierownik

-- PODPUNKT 17 --
SELECT nazwa, id_dzialu
FROM dzialy
WHERE id_dzialu
          NOT IN (SELECT ISNULL(id_dzialu, 0) FROM pracownicy)
