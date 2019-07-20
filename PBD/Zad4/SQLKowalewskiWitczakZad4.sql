-- UZYCIE BAZY TEST_PRACOWNICY --
use test_pracownicy

-- PODPUNKT 1 --
insert into pracownicy 
values(9781,'PARMOWSKI','AKWIZYTOR',9235,GETDATE(),null,1150,null,null,70)

-- PODPUNKT 2 --
insert into pracownicy 
values(9782,'CIESZKOWSKI','LABORANT',9332,GETDATE()+12,null,1200,null,null,null)

-- PODPUNKT 3 --
insert into dbo.stanowiska 
values ('GLOWNY' + (select stanowisko from dbo.stanowiska where stanowisko = 'OPERATOR'),
  500 + (select placa_min from dbo.stanowiska where stanowisko = 'OPERATOR'),
  1000 + (select placa_max from dbo.stanowiska where stanowisko = 'OPERATOR'))

insert into dbo.stanowiska 
values ('GLOWNY' + (select stanowisko from dbo.stanowiska where stanowisko = 'LOGISTYK'),
  500 + (select placa_min from dbo.stanowiska where stanowisko = 'LOGISTYK'),
  1000 + (select placa_max from dbo.stanowiska where stanowisko = 'LOGISTYK'))

insert into dbo.stanowiska 
values ('GLOWNY' + (select stanowisko from dbo.stanowiska where stanowisko = 'TECHNOLOG'),
  500 + (select placa_min from dbo.stanowiska where stanowisko = 'TECHNOLOG'),
  1000 + (select placa_max from dbo.stanowiska where stanowisko = 'TECHNOLOG'))

-- PODPUNKT 4 --
update pracownicy set stanowisko = 'LABORANT', placa = placa*1.1
where stanowisko = 'PRAKTYKANT' and id_dzialu = 50

-- PODPUNKT 5 --
update pracownicy set dod_funkcyjny = dod_funkcyjny + ((select min(placa)from pracownicy) * 0.1)
where id_dzialu = 10

-- PODPUNKT 6 --
delete from dbo.stanowiska where stanowisko = 'PRAKTYKANT'

-- PODPUNKT 7 --
delete from pracownicy where stanowisko = 'LOGISTYK'
and data_zatr = (select max(data_zatr) from pracownicy where stanowisko = 'LOGISTYK')

-- PODPUNKT 8 --
create table pracownice(
    nr_akt int,
	nazwisko	VARCHAR(20),
	stanowisko VARCHAR(18),
	kierownik int CONSTRAINT praco_self_key REFERENCES pracownicy (nr_akt),
	data_zatr	DATETIME,
	data_zwol	DATETIME,
	placa MONEY,
	dod_funkcyjny MONEY,
	prowizja MONEY,
	id_dzialu	INT,
	CONSTRAINT praco_primary_key PRIMARY KEY (nr_akt),
	CONSTRAINT praco_foreign_key FOREIGN KEY (id_dzialu) REFERENCES dzialy (id_dzialu)
);

insert into pracownice (nr_akt, nazwisko, stanowisko, kierownik, data_zatr, data_zwol,
placa, dod_funkcyjny, prowizja, id_dzialu)

select nr_akt, nazwisko, stanowisko, kierownik, data_zatr, data_zwol,placa, dod_funkcyjny, prowizja, id_dzialu
from pracownicy where nazwisko like '%SKA'

select * from pracownice

-- PODPUNKT 9 --
drop table pracownice

-- PODPUNKT 10 --
create table projekty(
    id_projektu int,
    nazwa varchar(100),
    budzet float,
    termin_zak datetime,
    nr_kierownika int constraint proj_self_key references pracownicy (nr_akt)
    constraint proj_id_projektu_unique unique (id_projektu)
);

-- PODPUNKT 11 --
alter table projekty add typ varchar(20) not null, opis varchar(500), data_roz datetime

-- PODPUNKT 12 --
alter table projekty add default getdate() for data_roz

-- PODPUNKT 13 --
alter table projekty drop constraint proj_id_projektu_unique
alter table projekty alter column id_projektu int not null
alter table projekty add constraint proj_primary_key primary key (id_projektu)

-- PODPUNKT 14 --
alter table projekty add constraint check_data check (data_roz < termin_zak)

-- PODPUNKT 15 --
exec sp_rename 'projekty.opis','harmonogram','COLUMN';

-- PODPUNKT 16 --
alter table pracownicy drop column prowizja



-- PODPUNKT 17 --
use test_pracownicy

alter table pracownicy drop constraint prac_foreign_key;
alter table pracownicy add constraint prac_foreign_key foreign key (id_dzialu)
references dzialy (id_dzialu) on delete cascade

-- PODPUNKT 18 --
delete from dzialy where id_dzialu = 30

-- PODPUNKT 19 --
--OPERACJA NIEDOZWOLONA NIE MOZNA USUNAC KIEROWNIKA--
--delete from pracownicy where nr_akt = 8902

-- PODPUNKT 20 --
update pracownicy set data_zwol = getdate() where nr_akt = 8902

insert into prac_archiw select * from pracownicy where nr_akt = 8902

-- PODPUNKT 21 --
alter table pracownicy nocheck constraint prac_self_key
update pracownicy set kierownik = 8903 where kierownik = 8902
alter table pracownicy check constraint prac_self_key

-- PODPUNKT 22 --
delete from pracownicy where nr_akt = 8902

-- PODPUNKT 23 --
create index prac_nazw_index on pracownicy (nazwisko)

-- PODPUNKT 24 --
create index prac_nazw_index on dbo.stanowiska (placa_min, placa_max)

-- PODPUNKT 25 --
drop index prac_nazw_index on pracownicy
drop index stan_plac_index on dbo.stanowiska
