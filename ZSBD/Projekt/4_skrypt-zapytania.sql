-- AUTORZY: --
-- MICHAŁ KIDAWA    216796 --
-- KAMIL KOWALEWSKI 216806 --

------------------------------------------------------------
/*
-- SPIS ZAPYTAN

-- 1. Wyświetl ile razy był wynajmowany każdy pokój.

-- 2. Wyświetl pokoje, które są zarezerowane tylko raz przez klientów niepochodzących z Krakowa lub
        Wroclawia, jednak wcześniej były wynajęte chociaż raz właśnie przez klientów z tych miast

-- 3. Wyświetl imie, nazwisko pracowników zatrudnionych w hotelu oraz nazwiska wszystkich jego
        współpracowników zaczynajacych się na litere 'm'.

-- 4. Wyświetl pokoje, które były wynajmowane tylko przez klientów 1 lub 2 typu, ale nikt nie
        planuje wynajmować ich później

-- 5. Wyświetl liczba klientow danego typu

-- 6. Wyświetl pracowników zarabiających ponizej lub tyle co wartosc średniej płacy w hotelu.

-- 7. Wyświetl pracowników, którzy zarabiają najwięcej na swoim stanowisku, posortuj ich alfabetycznie
        po stanowiskach

-- 8. Wyświetl dane klienta ktory najwiecej zaplacil oraz jego ulubiony pokoj

-- 9. Wyświetl dla każdego stanowiska liczbę pracowników mających mniej niż 60 lat oraz sumę ich pensji.
        Rezultat zapytania umieść w jednym ciągu.

-- 10. Wyświetl klientów, którzy zawsze rezerwowali pokoje z wanna bez sejfu i pochodzą z miast,
        z których nie pochodzą byli pracownicy

-- 11. Wyświetl cena najdrozszego pokoju na najczesciej wybieranym pietrze

-- 12. Wyświetl imiona, nazwiska, adresy, numery telefonow klientów i numery ich rezerwacji,
        które zostały zrealizowane w dniu tygodnia, w którym było najmniej rezerwacji.

-- 13. Wyświetl dla każdego stanowiska liczbę pracowników.

-- 14. Wyświetl klientów, którzy pochodzą z Zamosciu bądź Szczecinie, a pokoje które będą wynajmowali
        kosztują więcej niż 800, mimo, że wcześniej nie wynajmowali takich pokoi

-- 15. Wyświetl rezerwacje, które zaczęły się w piatek, a skończyły w sobote lub niedziele.
*/
------------------------------------------------------------

USE baza_hotel
GO

-- ZAPYTANIE 1 --
SELECT p.pokoj_nr,
       (SELECT COUNT(*) FROM rezerwacje_hist AS br WHERE br.pokoj_nr = p.pokoj_nr) +
       (SELECT COUNT(*) FROM rezerwacje AS r WHERE r.pokoj_nr = p.pokoj_nr) AS 'ilość rezerwacji'
FROM pokoje AS p
GROUP BY p.pokoj_nr

-- ZAPYTANIE 2 --
SELECT DISTINCT r.pokoj_nr, COUNT(*) AS 'ilosc_rezerwacji'
FROM rezerwacje AS r, klienci AS k
WHERE r.klient_nr = k.klient_nr
  AND k.miasto <> 3
  AND k.miasto <> 6
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

-- ZAPYTANIE 3 --
SELECT DISTINCT x.imie, x.nazwisko, y.nazwisko AS 'współpracownik', s.nazwa AS 'stanowisko'
FROM pracownicy x, pracownicy y, stanowiska s
WHERE x.stanowisko_nr = y.stanowisko_nr
  AND x.pracownik_nr <> y.pracownik_nr
  AND x.stanowisko_nr = s.stanowisko_nr
  AND y.stanowisko_nr = s.stanowisko_nr
  AND y.nazwisko LIKE 'm%'

-- ZAPYTANIE 4 --
SELECT DISTINCT b.pokoj_nr
FROM rezerwacje_hist AS b, klienci AS k
WHERE b.klient_nr = k.klient_nr
  AND (k.typ = 1 OR k.typ = 2)
  AND b.pokoj_nr NOT IN
      (SELECT DISTINCT rr.pokoj_nr FROM rezerwacje AS rr)

-- ZAPYTANIE 5 --
SELECT typ, count(typ) AS 'liczba klientów'
FROM klienci
GROUP BY typ

-- ZAPYTANIE 6 --
SELECT pracownik_nr, imie, nazwisko, nazwa
FROM pracownicy AS p, stanowiska AS s
WHERE p.stanowisko_nr = s.stanowisko_nr
  AND p.placa <= (SELECT AVG(placa) FROM pracownicy)
GROUP BY pracownik_nr, imie, nazwisko, nazwa, placa

-- ZAPYTANIE 7 --
SELECT s.nazwa AS 'stanowisko', p.imie, p.nazwisko, p.pracownik_nr, p.placa
FROM pracownicy AS p, stanowiska AS s
WHERE p.stanowisko_nr = s.stanowisko_nr
  AND p.pracownik_nr IN
      (SELECT TOP 1 pp.pracownik_nr FROM pracownicy AS pp WHERE p.stanowisko_nr = pp.stanowisko_nr)
ORDER BY s.nazwa

-- ZAPYTANIE 8 --
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
    SELECT sum(dbo.wylicz_cene_rezerwacji_po_numerze(rezerwacja_nr))
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

-- ZAPYTANIE 9 --
SELECT CONCAT(nazwa, ' liczba pracowników: ', COUNT(*), ' suma pensji: ', SUM(placa))
FROM pracownicy AS p, stanowiska AS s
WHERE p.stanowisko_nr = s.stanowisko_nr
  AND ((YEAR(GETDATE()) - YEAR(data_urodzenia))) < 60
GROUP BY nazwa

-- ZAPYTANIE 10 --
SELECT DISTINCT k.imie, k.nazwisko, k.klient_nr, m.nazwa AS 'miasto'
FROM klienci AS k, miasta AS m, rezerwacje AS r, pokoje AS p, rezerwacje_hist AS b
WHERE ((k.klient_nr = r.klient_nr AND r.pokoj_nr = p.pokoj_nr AND p.czy_jest_sejf = 0 AND
        p.czy_jest_wanna = 1)
    OR (k.klient_nr = b.klient_nr AND b.pokoj_nr = p.pokoj_nr AND p.czy_jest_sejf = 0 AND
        p.czy_jest_wanna = 1))
  AND k.miasto NOT IN (SELECT DISTINCT miasto FROM pracownicy_hist)
  AND k.miasto = m.miasto_nr

-- ZAPYTANIE 11 --
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

-- ZAPYTANIE 12 --
SELECT imie, nazwisko, adres, telefon, rezerwacja_nr
FROM klienci AS k, rezerwacje AS r
WHERE DATENAME(DW, poczatek_rezerwacji) =
      (
          SELECT
          TOP 1
          DATENAME(DW, poczatek_rezerwacji)
          FROM rezerwacje
          GROUP BY DATENAME(DW, poczatek_rezerwacji)
          ORDER BY COUNT(*) ASC
      )
  AND r.klient_nr = k.klient_nr

-- ZAPYTANIE 13 --
SELECT nazwa, COUNT(*) AS 'ilość pracowników'
FROM pracownicy AS p, stanowiska AS s
WHERE p.stanowisko_nr = s.stanowisko_nr
GROUP BY nazwa

-- ZAPYTANIE 14 --
SELECT DISTINCT k.imie, k.nazwisko, k.klient_nr
FROM klienci AS k, miasta AS m, rezerwacje AS r, pokoje AS p
WHERE k.miasto = m.miasto_nr
  AND (m.nazwa = 'Zamosc' OR m.nazwa = 'Szczecin')
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

-- ZAPYTANIE 15 --
SELECT *, DATENAME(DW, poczatek_rezerwacji) AS dzien_rezerwacji,
       DATENAME(DW, koniec_rezerwacji) AS dzien_konca_rezerwacji
FROM rezerwacje_hist
WHERE (DATENAME(DW, poczatek_rezerwacji) = 'Friday')
  AND (DATENAME(DW, koniec_rezerwacji) = 'Saturday' OR DATENAME(DW, koniec_rezerwacji) = 'Sunday')

------------------------------------------------------------
/*
-- SPIS WYWOLAN PROCEDUR I FUNKCJI

-- 1. przenosi archwailne rezerwacje do tabeli rezerwacje_hist
-- 2. usuwa konkretnego (wskazanego przez numer przy wywolaniu) pracownika z tabeli pracownicy
-- 3. poprawia rejestracje, ktore nie byly poprawnie zarejestwoane (zbyt duza liczba osob) oraz
        drukuje komunikat, które z nich są niepoprawne
-- 4. najczesciej rezerwowany pokoj na danym pietrze
-- 5. oplaty_dla_pracownikow dla pracownikow w danym miesiacu z danego roku

-- 1. oblicza cenę danej rezerwacji
-- 2. sprawdzenie czy pokoj jest wolny w danym czasie

 */
------------------------------------------------------------
-- PROCEDURA 1 --
EXEC najpopularniejszy_pokoj_na_pietrze 2

-- PROCEDURA 2 --
EXEC popraw_bledna_liczbe_osob_w_rejestracji

-- PROCEDURA 3 --
EXEC archiwizuj_rezerwacje

-- PROCEDURA 4 --
EXEC oplaty_dla_pracownikow '2019', 'Luty'

-- PROCEDURA 5 --
EXEC usun_pracownika_po_numerze 6
EXEC usun_pracownika_po_numerze 7
EXEC usun_pracownika_po_numerze 8

-- FUNKCJA 1 --
SELECT pokoj_nr,
       dbo.sprawdz_dostepnosc_pokoju(pokoj_nr, '2019/8/8', 15) AS 'czy dostepny w terminie 08-23.08.2019)'
FROM pokoje
WHERE pokoj_nr LIKE '3%'

-- FUNKCJA 2 --
SELECT *,
       dbo.wylicz_cene_rezerwacji_po_numerze(rezerwacja_nr) AS 'wylicz_cene_rezerwacji_po_numerze'
FROM rezerwacje


SELECT *
FROM pracownicy_hist
GO
