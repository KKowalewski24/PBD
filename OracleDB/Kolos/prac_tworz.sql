CREATE TABLE dzialy (
 id_dzialu	NUMBER(2),
 nazwa		VARCHAR2(15),
 siedziba	VARCHAR2(15),
 CONSTRAINT dzialy_primary_key PRIMARY KEY (id_dzialu)
);
CREATE TABLE stanowiska (
 stanowisko	VARCHAR2(18),
 placa_min	NUMBER(7,2), 
 placa_max	NUMBER(7,2), 
 CONSTRAINT stan_primary_key PRIMARY KEY (stanowisko)
);
CREATE TABLE pracownicy (
 nr_akt	NUMBER(4),
 nazwisko	VARCHAR2(20),
 stanowisko	VARCHAR2(18),
 kierownik	NUMBER(4) CONSTRAINT prac_self_key REFERENCES pracownicy (nr_akt),
 data_zatr	DATE,
 data_zwol	DATE,
 placa		NUMBER(7,2), 
 dod_funkcyjny	NUMBER(7,2),
 prowizja	NUMBER(7,2),
 id_dzialu	NUMBER(2),
 CONSTRAINT prac_primary_key PRIMARY KEY (nr_akt),
 CONSTRAINT prac_stanowiska_fk FOREIGN KEY (stanowisko) REFERENCES stanowiska (stanowisko),
 CONSTRAINT prac_dzialy_fk FOREIGN KEY (id_dzialu) REFERENCES dzialy (id_dzialu)
);