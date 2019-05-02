-- UZYCIE BAZY TEST_PRACOWNICY --
use test_pracownicy

-- PODPUNKT 1 --
insert into pracownicy values
(9781,'PARMOWSKI','AKWIZYTOR',9235,GETDATE(),null,1150,null,null,70)

-- PODPUNKT 2 --
insert into pracownicy values
(9782,'CIESZKOWSKI','LABORANT',9332,GETDATE()+12,null,1200,null,null,null)

-- PODPUNKT 3 --
insert into dbo.stanowiska values
('GLOWNY' + (select stanowisko from dbo.stanowiska where stanowisko = 'OPERATOR'),
  500 + (select placa_min from dbo.stanowiska where stanowisko = 'OPERATOR'),
  1000 + (select placa_max from dbo.stanowiska where stanowisko = 'OPERATOR'))

insert into dbo.stanowiska values
('GLOWNY' + (select stanowisko from dbo.stanowiska where stanowisko = 'LOGISTYK'),
  500 + (select placa_min from dbo.stanowiska where stanowisko = 'LOGISTYK'),
  1000 + (select placa_max from dbo.stanowiska where stanowisko = 'LOGISTYK'))

insert into dbo.stanowiska values
('GLOWNY' + (select stanowisko from dbo.stanowiska where stanowisko = 'TECHNOLOG'),
  500 + (select placa_min from dbo.stanowiska where stanowisko = 'TECHNOLOG'),
  1000 + (select placa_max from dbo.stanowiska where stanowisko = 'TECHNOLOG'))

-- PODPUNKT 4 --
update pracownicy set stanowisko = 'LABORANT', placa = placa*1.1
where stanowisko = 'PRAKTYKANT' and id_dzialu = 50

-- PODPUNKT 5 --
update pracownicy set dod_funkcyjny = dod_funkcyjny + ((select min(placa)from pracownicy) * 0.1)
where id_dzialu = 10

-- PODPUNKT 6 --
delete from stanowiska where stanowisko = 'PRAKTYKANT'

-- PODPUNKT 7 --
delete from pracownicy where stanowisko = 'LOGISTYK'
and data_zatr = (select max(data_zatr) from pracownicy where stanowisko = 'LOGISTYK')

-- PODPUNKT 8 --


-- PODPUNKT 9 --


-- PODPUNKT 10 --


-- PODPUNKT 11 --


-- PODPUNKT 12 --


-- PODPUNKT 13 --


-- PODPUNKT 14 --


-- PODPUNKT 15 --


-- PODPUNKT 16 --


-- PODPUNKT 17 --


-- PODPUNKT 18 --


-- PODPUNKT 19 --


-- PODPUNKT 20 --


-- PODPUNKT 21 --


-- PODPUNKT 22 --


-- PODPUNKT 23 --


-- PODPUNKT 24 --


-- PODPUNKT 25 --













