create database biblioteka

use biblioteka;


create table Czytelnicy
(
	id			char(5) primary key not null,
	constraint id_test check (id like '[a-Z][a-Z][0-9][0-9][0-9]'),
	nazwisko	varchar(15) not null,
	imie		varchar(15) not null,
	pesel		decimal (11,0) not null unique,
	data_ur		date not null,
	plec		char check(plec='K'or plec='M'),
	telefon		varchar(15)
);


create table Wypozyczenia
(
	id_w		int	IDENTITY(1, 1)	primary key,
	id_cz		char(5),
	foreign key(id_cz) references Czytelnicy(id),				
	id_p		char(5),
	foreign key(id_p) references Czytelnicy(id),	
	data_z		date not null,
	data_w		date not null unique,
	kara int default 0, check(kara>=0),
	constraint data_test_w check(data_w < data_z)
);

create table Pracownicy
(
	id			int identity(1,1) primary key,
	nazwisko	varchar(15) not null,
	imie		varchar(15) not null,
	data_ur		date not null,
	data_zatr	date not null,
	constraint data_test_p check(data_ur < data_zatr),
)

create table wydawnictwa
(
	id			int identity(1,1) primary key not null,
	nazwa		varchar(50) not null,
	miasto		varchar(50) not null,
	telefon		varchar(15) not null
);

create table ksiazki
(
	sygn		varchar(5) primary key unique,
	id_wyd		int,
	foreign key(id_wyd) references Wydawnictwa(id),
	tytul		varchar(40) not null,
	cena		money not null,
	gatunek		varchar(40) not null
	check(gatunek in('powieœæ','powieœæ historyczna',
	'dla dzieci','wiersze','krymina³',
	'powiesæ science fiction','ksi¹¿ka naukowa'))
);

alter table Pracownicy with nocheck add constraint plec (plec='K'or plec='M')

