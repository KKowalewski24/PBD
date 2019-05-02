-- UZYCIE BAZY TEST_PRACOWNICY --
use test_pracownicy

-- PODPUNKT 1 --
select nazwisko, placa+isnull(dod_funkcyjny,0) as pensja from pracownicy

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
select id_dzialu, count(nr_akt) as ile_pracownikow from dbo.pracownicy group by id_dzialu

-- PODPUNKT  --


-- PODPUNKT  --


-- PODPUNKT  --





