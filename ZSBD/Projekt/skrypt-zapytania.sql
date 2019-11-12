-- AUTORZY: --
-- MICHAŁ KIDAWA    216796 --
-- KAMIL KOWALEWSKI 216806 --

------------------------------------------------------------
/*
-- SPIS ZAPYTAN

-- 1. Wyświetl rezerwacje, które zaczęły się w poniedziałek, a skończyły w poniedziałek lub wtorek.
-- 2. Wyświetl ile razy był wynajmowany każdy pokój.
-- 3. Wyświetl nazwiska klientów i numery ich rezerwacji, które zostały zrealizowane w dniu tygodnia,
        w którym było najwięcej rezerwacji.
-- 4. Wyświetl imie, nazwisko pracowników zatrudnionych w hotelu oraz nazwiska wszystkich jego
        współpracowników kończących się na 'k'.
-- 5. Dla każdego stanowiska wyświetl liczbę pracowników mających więcej niż 50 lat oraz sumę ich pensji.
        Rezultat zapytania umieść w jednym ciągu.
-- 6. Wybierz klientów, którzy pochodzą z Poznania bądź Gdanska, a pokoje które będą wynajmowali
        kosztują więcej niż 900, mimo, że wcześniej nie wynajmowali takich pokojów
-- 7. Wybierz pokoje, które były wynajmowane tylko przez klientów 2 bądź 3 typu, ale nikt nie
        planuje wynajmować ich później
-- 8. Wybierz pracowników, którzy zarabiają najwięcej na swoim stanowisku, posortuj ich alfabetycznie
        po stanowiskach
-- 9. Wybierz klientów, którzy zawsze rezerwowali pokoje z sejfem bez wanny i pochodzą z miast,
        z których nie pochodzą byli pracownicy
-- 10.Wybierz pokoje, które są zarezerowane tylko raz przez klientów niepochodzących z Łodzi bądź
        Warszawy, jednak wcześniej były wynajęte chociaż raz właśnie przez klientów z tych miast
-- 11. liczba klientow danego typu
-- 12. dane klienta ktory najwiecej zaplacil oraz jego ulubiony pokoj
-- 13. cena najdrozszego pokoju na najczesciej wybieranym pietrze
-- 14. Wyświetl pracowników zarabiających powyżej średniej płacy w hotelu.
-- 15. Dla każdego stanowiska wyświetl liczbę pracowników.
*/
------------------------------------------------------------

USE hotel
GO

-- ZAPYTANIE 1 --
SELECT *, DATENAME(DW, poczatek_rezerwacji) AS dzien_rezerwacji,
       DATENAME(DW, koniec_rezerwacji) AS dzien_konca_rezerwacji
FROM byle_rezerwacje
WHERE (DATENAME(DW, poczatek_rezerwacji) = 'Monday')
  AND (DATENAME(DW, koniec_rezerwacji) = 'Monday' OR DATENAME(DW, koniec_rezerwacji) = 'Tuesday')

-- ZAPYTANIE 2 --
SELECT p.nr_pokoju,
       (SELECT COUNT(*) FROM byle_rezerwacje AS br WHERE br.nr_pokoju = p.nr_pokoju) +
       (SELECT COUNT(*) FROM rezerwacje AS r WHERE r.nr_pokoju = p.nr_pokoju) AS 'ilość rezerwacji'
FROM pokoje AS p
GROUP BY p.nr_pokoju

-- ZAPYTANIE 3 --
SELECT nazwisko, nr_rezerwacji
FROM klienci AS k, rezerwacje AS r
WHERE DATENAME(DW, poczatek_rezerwacji) =
      (
          SELECT
          TOP 1
          DATENAME(DW, poczatek_rezerwacji)
          FROM rezerwacje
          GROUP BY DATENAME(DW, poczatek_rezerwacji)
          ORDER BY COUNT(*) DESC
      )
  AND r.nr_klienta = k.nr_klienta

-- ZAPYTANIE 4 --
SELECT DISTINCT x.imie, x.nazwisko, y.nazwisko AS 'współpracownik', s.nazwa AS 'stanowisko'
FROM pracownicy x, pracownicy y, stanowiska s
WHERE x.nr_stanowiska = y.nr_stanowiska
  AND x.nr_pracownika <> y.nr_pracownika
  AND x.nr_stanowiska = s.nr_stanowiska
  AND y.nr_stanowiska = s.nr_stanowiska
  AND y.nazwisko LIKE '%k'

-- ZAPYTANIE 5 --
SELECT CONCAT(nazwa, ' liczba pracowników: ', COUNT(*), ' suma pensji: ', SUM(placa))
FROM pracownicy AS p, stanowiska AS s
WHERE p.nr_stanowiska = s.nr_stanowiska
  AND ((YEAR(GETDATE()) - YEAR(data_urodzenia))) > 50
GROUP BY nazwa


-- ZAPYTANIE 6 --
SELECT DISTINCT k.imie, k.nazwisko, k.nr_klienta
FROM klienci AS k, miasta AS m, rezerwacje AS r, pokoje AS p
WHERE k.miasto = m.nr_miasta
  AND (m.nazwa = 'Poznan' OR m.nazwa = 'Gdansk')
  AND k.nr_klienta = r.nr_klienta
  AND r.nr_pokoju = p.nr_pokoju
  AND p.cena > 800
  AND k.nr_klienta IN
      (
          SELECT DISTINCT kk.nr_klienta
          FROM klienci AS kk, byle_rezerwacje AS bb, pokoje AS pp
          WHERE kk.nr_klienta = bb.nr_klienta
            AND bb.nr_pokoju = pp.nr_pokoju
            AND pp.cena <= 800
      )

-- ZAPYTANIE 7 --
SELECT DISTINCT b.nr_pokoju
FROM byle_rezerwacje AS b, klienci AS k
WHERE b.nr_klienta = k.nr_klienta
  AND (k.typ = 2 OR k.typ = 3)
  AND b.nr_pokoju NOT IN
      (SELECT DISTINCT rr.nr_pokoju FROM rezerwacje AS rr)

-- ZAPYTANIE 8 --
SELECT s.nazwa AS 'stanowisko', p.imie, p.nazwisko, p.nr_pracownika, p.placa
FROM pracownicy AS p, stanowiska AS s
WHERE p.nr_stanowiska = s.nr_stanowiska
  AND p.nr_pracownika IN
      (SELECT TOP 1 pp.nr_pracownika FROM pracownicy AS pp WHERE p.nr_stanowiska = pp.nr_stanowiska)
ORDER BY s.nazwa

-- ZAPYTANIE 9 --
SELECT DISTINCT k.imie, k.nazwisko, k.nr_klienta, m.nazwa AS 'miasto'
FROM klienci AS k, miasta AS m, rezerwacje AS r, pokoje AS p, byle_rezerwacje AS b
WHERE ((k.nr_klienta = r.nr_klienta AND r.nr_pokoju = p.nr_pokoju AND p.czy_sejf = 1 AND
        p.czy_wanna = 0)
    OR (k.nr_klienta = b.nr_klienta AND b.nr_pokoju = p.nr_pokoju AND p.czy_sejf = 1 AND
        p.czy_wanna = 0))
  AND k.miasto NOT IN (SELECT DISTINCT miasto FROM byli_pracownicy)
  AND k.miasto = m.nr_miasta

-- ZAPYTANIE 10 --
SELECT DISTINCT r.nr_pokoju, COUNT(*) AS 'ilosc_rezerwacji'
FROM rezerwacje AS r, klienci AS k
WHERE r.nr_klienta = k.nr_klienta
  AND k.miasto <> 1
  AND k.miasto <> 2
  AND r.nr_pokoju IN
      (
          SELECT DISTINCT bb.nr_pokoju
          FROM byle_rezerwacje AS bb, klienci AS kk, miasta AS mm
          WHERE bb.nr_klienta = kk.nr_klienta
            AND kk.miasto = mm.nr_miasta
            AND (mm.nr_miasta = 1 OR mm.nr_miasta = 2)
      )
GROUP BY r.nr_pokoju
HAVING COUNT(*) = 1


-- ZAPYTANIE 11 --
SELECT typ, count(typ) AS 'liczba klientów'
FROM klienci
GROUP BY typ

-- ZAPYTANIE 12 --
SELECT
TOP 1
nr_klienta
,
klienci.imie
,
klienci.nazwisko
,
klienci.nr_klienta
,
klienci.typ
,
(
    SELECT sum(dbo.cena_rezerwacji(nr_rezerwacji))
    FROM byle_rezerwacje
    WHERE byle_rezerwacje.nr_klienta = klienci.nr_klienta
) AS 'suma należności'
,
(
    SELECT nr_pokoju
    FROM byle_rezerwacje
    WHERE nr_klienta = 2
    GROUP BY nr_pokoju
    HAVING count(nr_pokoju) =
           (
               SELECT
               TOP 1
               count(nr_pokoju)
               FROM byle_rezerwacje
               WHERE nr_klienta = 2
               GROUP BY nr_pokoju
           )
) AS 'ulubiony pokoj'
FROM klienci
ORDER BY [suma należności] DESC

-- ZAPYTANIE 13 --
SELECT
TOP 1
nr_pokoju
,
cena
FROM pokoje
WHERE nr_pokoju / 100 =
      (
          SELECT nr_pokoju / 100 AS 'pietro'
          FROM byle_rezerwacje
          GROUP BY nr_pokoju / 100
          HAVING count(nr_pokoju) =
                 (
                     SELECT
                     TOP 1
                     count(nr_pokoju) AS 'liczba pokoi'
                     FROM byle_rezerwacje
                     GROUP BY nr_pokoju / 100
                     ORDER BY [liczba pokoi] DESC
                 )
      )


-- ZAPYTANIE 14 --
SELECT nr_pracownika, imie, nazwisko, nazwa
FROM pracownicy AS p, stanowiska AS s
WHERE p.nr_stanowiska = s.nr_stanowiska
  AND p.placa > (SELECT AVG(placa) FROM pracownicy)
GROUP BY nr_pracownika, imie, nazwisko, nazwa, placa


-- ZAPYTANIE 15 --
SELECT nazwa, COUNT(*) AS 'ilość pracowników'
FROM pracownicy AS p, stanowiska AS s
WHERE p.nr_stanowiska = s.nr_stanowiska
GROUP BY nazwa

------------------------------------------------------------
/*
-- SPIS WYWOLAN PROCEDUR I FUNKCJI

-- 1. przenosi archwailne rezerwacje do tabeli byle_rezerwacje
-- 2. usuwa konkretnego (wskazanego przez numer przy wywolaniu) pracownika z tabeli pracownicy
-- 3. poprawia rejestracje, ktore nie byly poprawnie zarejestwoane (zbyt duza liczba osob) oraz
        drukuje komunikat, które z nich są niepoprawne
-- 4. najczesciej rezerwowany pokoj na danym pietrze
-- 5. oplaty dla pracownikow w danym miesiacu z danego roku

-- 1. oblicza cenę danej rezerwacji
-- 2. sprawdzenie czy pokoj jest wolny w danym czasie

 */
------------------------------------------------------------

-- PROCEDURA 1 --
EXEC rezerwacje_archiwalne

-- PROCEDURA 2 --
EXEC usun_pracownika 10
EXEC usun_pracownika 12
EXEC usun_pracownika 14

-- PROCEDURA 3 --
EXEC poprawnosc_rejestracji_osoby

-- PROCEDURA 4 --
EXEC najczestszy_pokoj 2

-- PROCEDURA 5 --
EXEC oplaty '2018', 'Styczen'


-- PROCEDURA 1 --
SELECT *, dbo.cena_rezerwacji(nr_rezerwacji) AS 'cena_rezerwacji'
FROM rezerwacje

-- PROCEDURA 2 --
SELECT nr_pokoju,
       dbo.dostepnosc_pokoju(nr_pokoju, '2018/8/8', 15) AS 'czy dostepny w terminie 08-23.08.2018)'
FROM pokoje
WHERE nr_pokoju LIKE '3%'

-- FIXME ADD TRIGGERS CALL

SELECT *
FROM byli_pracownicy
GO
