-- UZYCIE BAZY TEST_PRACOWNICY --
use test_pracownicy

-- PODPUNKT 1 --
select nazwisko, placa+isnull(dod_funkcyjny,0) as pensja from dbo.pracownicy

-- PODPUNKT 2,4 -- alias -> dniowka
select nazwisko, placa/30 as dniowka from dbo.pracownicy

-- PODPUNKT 3,4 -- alias -> roczna
select nazwisko, placa*12 as roczna from dbo.pracownicy

-- PODPUNKT 5 --
select min(placa) from dbo.pracownicy

-- PODPUNKT 6 --
select nazwisko, placa, stanowisko from dbo.pracownicy 
where placa = (select min(placa) from dbo.pracownicy)

-- PODPUNKT 7 --
select nazwisko, placa, stanowisko from dbo.pracownicy 
where placa<(select avg(placa) from dbo.pracownicy

-- PODPUNKT 8 --
select id_dzialu, count(*) as liczba_pracownikow from pracownicy
group by id_dzialu

-- PODPUNKT 9 --
select nazwa + ' ' + nazwisko as procownik from dbo.dzialy, dbo.pracownicy
where pracownicy.id_dzialu = dzialy.id_dzialu

-- PODPUNKT 10 --
select id_dzialu, count(stanowisko) as liczba_pracownikow, stanowisko from dbo.pracownicy
group by stanowisko, id_dzialu

-- PODPUNKT 11 --
select nazwisko, nazwa, placa, placa_min, placa_max
from dbo.pracownicy, dbo.stanowiska, dbo.dzialy
where (placa_min > 1500 and placa_max < 3500)

-- PODPUNKT 12 --
select nazwisko, placa from dbo.pracownicy
where placa > (select max(placa) from dbo.pracownicy where id_dzialu='30')

-- PODPUNKT 13 --
select nazwisko, placa, round(placa-(select avg(placa) from dbo.pracownicy),2)
as roznica from dbo.pracownicy

-- PODPUNKT 14 --
select nazwa, round(avg(placa),2) as sred_placa
from pracownicy p join dzialy d on p.id_dzialu=d.id_dzialu
group by nazwa

-- PODPUNKT 15 --
select id_dzialu, nazwisko, placa from dbo.pracownicy pp
where placa > (select avg(placa) from dbo.pracownicy
where pp.id_dzialu = pracownicy.id_dzialu)

-- PODPUNKT 16 --
select p.nazwisko as pracownik, s.nazwisko as szef
from pracownicy p join pracownicy s on p.kierownik = s.nr_akt

-- PODPUNKT 17 --
select id_dzialu, (select count(id_dzialu)
from pracownicy where dzialy.id_dzialu = pracownicy.id_dzialu) from dzialy
where (select count(id_dzialu) from pracownicy
where dzialy.id_dzialu = pracownicy.id_dzialu = 0)
group by id_dzialu




