create database test1_Kowalewski_Witczak

--/////////////// TWORZENIE TABEL ///////////////--
create table osoby(
nr_osoby int primary key,
imie varchar(40),
nazwisko varchar(40),
adres varchar(500),
wiek int
);

create table dzieci(
nr_osoby int,
nr_dziecka int IDENTITY (100,1),
imie varchar(40)
);

--DODAWANIE REKORDOW--
insert into osoby (nr_osoby,imie,nazwisko,adres,wiek)
values(1,'Baba', 'Jaga', 'Domek z Piernika 100',154)

insert into dzieci(nr_osoby,imie)
values(1,'Jas')

insert into dzieci(nr_osoby,imie)
values(2,'Malgosia')

--DODANIE OPCJI AKTUALNEJ DATY--
alter table osoby add data_wpisu DATE DEFAULT GETDATE()

insert into osoby(nr_osoby,imie,nazwisko,adres,wiek)
values(2, 'Matka', 'Chrzestna', 'Wrozkolandia',105)

--MOZLIWOSC DODANIA WLASNEGO IDENTYFIKATORA--
SET IDENTITY_INSERT dzieci ON

insert into dzieci(nr_osoby,nr_dziecka,imie)
values(3,10,'Kopciuszek')

--USTAWIENIA OGRANICZENIA NA WPISYWANE DANE--
alter table osoby with nocheck add constraint wiek check(wiek<100)



--/////////////// NARZEDZIA ULATWIAJACE OBSLUGE ///////////////--

-- WYSWIETLANIE --
select * from osoby
select * from dzieci

--CZYSZCZENIE TABEL--

delete from osoby
delete from dzieci
