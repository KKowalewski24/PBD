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

USE baza_hotel
GO

-- ZAPYTANIE 1 --
SELECT *, DATENAME(DW, poczatek_rezerwacji) AS dzien_rezerwacji,
       DATENAME(DW, koniec_rezerwacji) AS dzien_konca_rezerwacji
FROM rezerwacje_hist
WHERE (DATENAME(DW, poczatek_rezerwacji) = 'Monday')
  AND (DATENAME(DW, koniec_rezerwacji) = 'Monday' OR DATENAME(DW, koniec_rezerwacji) = 'Tuesday')

-- ZAPYTANIE 2 --
SELECT p.pokoj_nr,
       (SELECT COUNT(*) FROM rezerwacje_hist AS br WHERE br.pokoj_nr = p.pokoj_nr) +
       (SELECT COUNT(*) FROM rezerwacje AS r WHERE r.pokoj_nr = p.pokoj_nr) AS 'ilość rezerwacji'
FROM pokoje AS p
GROUP BY p.pokoj_nr

-- ZAPYTANIE 3 --
SELECT nazwisko, rezerwacja_nr
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
  AND r.klient_nr = k.klient_nr

-- ZAPYTANIE 4 --
SELECT DISTINCT x.imie, x.nazwisko, y.nazwisko AS 'współpracownik', s.nazwa AS 'stanowisko'
FROM pracownicy x, pracownicy y, stanowiska s
WHERE x.stanowisko_nr = y.stanowisko_nr
  AND x.pracownik_nr <> y.pracownik_nr
  AND x.stanowisko_nr = s.stanowisko_nr
  AND y.stanowisko_nr = s.stanowisko_nr
  AND y.nazwisko LIKE '%k'

-- ZAPYTANIE 5 --
SELECT CONCAT(nazwa, ' liczba pracowników: ', COUNT(*), ' suma pensji: ', SUM(placa))
FROM pracownicy AS p, stanowiska AS s
WHERE p.stanowisko_nr = s.stanowisko_nr
  AND ((YEAR(GETDATE()) - YEAR(data_urodzenia))) > 50
GROUP BY nazwa


-- ZAPYTANIE 6 --
SELECT DISTINCT k.imie, k.nazwisko, k.klient_nr
FROM klienci AS k, miasta AS m, rezerwacje AS r, pokoje AS p
WHERE k.miasto = m.miasto_nr
  AND (m.nazwa = 'Poznan' OR m.nazwa = 'Gdansk')
  AND k.klient_nr = r.klient_nr
  AND r.pokoj_nr = p.pokoj_nr
  AND p.cena > 800
  AND k.klient_nr IN
      (
          SELECT DISTINCT kk.klient_nr
          FROM klienci AS kk, rezerwacje_hist AS bb, pokoje AS pp
          WHERE kk.klient_nr = bb.klient_nr
            AND bb.pokoj_nr = pp.pokoj_nr
            AND pp.cena <= 800
      )

-- ZAPYTANIE 7 --
SELECT DISTINCT b.pokoj_nr
FROM rezerwacje_hist AS b, klienci AS k
WHERE b.klient_nr = k.klient_nr
  AND (k.typ = 2 OR k.typ = 3)
  AND b.pokoj_nr NOT IN
      (SELECT DISTINCT rr.pokoj_nr FROM rezerwacje AS rr)

-- ZAPYTANIE 8 --
SELECT s.nazwa AS 'stanowisko', p.imie, p.nazwisko, p.pracownik_nr, p.placa
FROM pracownicy AS p, stanowiska AS s
WHERE p.stanowisko_nr = s.stanowisko_nr
  AND p.pracownik_nr IN
      (SELECT TOP 1 pp.pracownik_nr FROM pracownicy AS pp WHERE p.stanowisko_nr = pp.stanowisko_nr)
ORDER BY s.nazwa

-- ZAPYTANIE 9 --
SELECT DISTINCT k.imie, k.nazwisko, k.klient_nr, m.nazwa AS 'miasto'
FROM klienci AS k, miasta AS m, rezerwacje AS r, pokoje AS p, rezerwacje_hist AS b
WHERE ((k.klient_nr = r.klient_nr AND r.pokoj_nr = p.pokoj_nr AND p.czy_jest_sejf = 1 AND
        p.czy_jest_wanna = 0)
    OR (k.klient_nr = b.klient_nr AND b.pokoj_nr = p.pokoj_nr AND p.czy_jest_sejf = 1 AND
        p.czy_jest_wanna = 0))
  AND k.miasto NOT IN (SELECT DISTINCT miasto FROM pracownicy_hist)
  AND k.miasto = m.miasto_nr

-- ZAPYTANIE 10 --
SELECT DISTINCT r.pokoj_nr, COUNT(*) AS 'ilosc_rezerwacji'
FROM rezerwacje AS r, klienci AS k
WHERE r.klient_nr = k.klient_nr
  AND k.miasto <> 1
  AND k.miasto <> 2
  AND r.pokoj_nr IN
      (
          SELECT DISTINCT bb.pokoj_nr
          FROM rezerwacje_hist AS bb, klienci AS kk, miasta AS mm
          WHERE bb.klient_nr = kk.klient_nr
            AND kk.miasto = mm.miasto_nr
            AND (mm.miasto_nr = 1 OR mm.miasto_nr = 2)
      )
GROUP BY r.pokoj_nr
HAVING COUNT(*) = 1


-- ZAPYTANIE 11 --
SELECT typ, count(typ) AS 'liczba klientów'
FROM klienci
GROUP BY typ

-- ZAPYTANIE 12 --
SELECT
TOP 1
klient_nr
,
klienci.imie
,
klienci.nazwisko
,
klienci.klient_nr
,
klienci.typ
,
(
    SELECT sum(dbo.cena_rezerwacji(rezerwacja_nr))
    FROM rezerwacje_hist
    WHERE rezerwacje_hist.klient_nr = klienci.klient_nr
) AS 'suma należności'
,
(
    SELECT pokoj_nr
    FROM rezerwacje_hist
    WHERE klient_nr = 2
    GROUP BY pokoj_nr
    HAVING count(pokoj_nr) =
           (
               SELECT
               TOP 1
               count(pokoj_nr)
               FROM rezerwacje_hist
               WHERE klient_nr = 2
               GROUP BY pokoj_nr
           )
) AS 'ulubiony pokoj'
FROM klienci
ORDER BY [suma należności] DESC

-- ZAPYTANIE 13 --
SELECT
TOP 1
pokoj_nr
,
cena
FROM pokoje
WHERE pokoj_nr / 100 =
      (
          SELECT pokoj_nr / 100 AS 'pietro'
          FROM rezerwacje_hist
          GROUP BY pokoj_nr / 100
          HAVING count(pokoj_nr) =
                 (
                     SELECT
                     TOP 1
                     count(pokoj_nr) AS 'liczba pokoi'
                     FROM rezerwacje_hist
                     GROUP BY pokoj_nr / 100
                     ORDER BY [liczba pokoi] DESC
                 )
      )


-- ZAPYTANIE 14 --
SELECT pracownik_nr, imie, nazwisko, nazwa
FROM pracownicy AS p, stanowiska AS s
WHERE p.stanowisko_nr = s.stanowisko_nr
  AND p.placa > (SELECT AVG(placa) FROM pracownicy)
GROUP BY pracownik_nr, imie, nazwisko, nazwa, placa


-- ZAPYTANIE 15 --
SELECT nazwa, COUNT(*) AS 'ilość pracowników'
FROM pracownicy AS p, stanowiska AS s
WHERE p.stanowisko_nr = s.stanowisko_nr
GROUP BY nazwa

------------------------------------------------------------
/*
-- SPIS WYWOLAN PROCEDUR I FUNKCJI

-- 1. przenosi archwailne rezerwacje do tabeli rezerwacje_hist
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
SELECT *, dbo.cena_rezerwacji(rezerwacja_nr) AS 'cena_rezerwacji'
FROM rezerwacje

-- PROCEDURA 2 --
SELECT pokoj_nr,
       dbo.dostepnosc_pokoju(pokoj_nr, '2018/8/8', 15) AS 'czy dostepny w terminie 08-23.08.2018)'
FROM pokoje
WHERE pokoj_nr LIKE '3%'

SELECT *
FROM pracownicy_hist
GO
