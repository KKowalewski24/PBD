INSERT INTO test_pracownicy.dbo.dzialy
VALUES (10, 'ZARZAD', 'CZESTOCHOWA');
INSERT INTO test_pracownicy.dbo.dzialy
VALUES (20, 'PRODUKCJA', 'HONG KONG');
INSERT INTO test_pracownicy.dbo.dzialy
VALUES (30, 'ZAOPATRZENIE', 'AMSTERDAM');
INSERT INTO test_pracownicy.dbo.dzialy
VALUES (40, 'MARKETING', 'PARYZ');
INSERT INTO test_pracownicy.dbo.dzialy
VALUES (50, 'BADANIA', 'JAMAJKA');
INSERT INTO test_pracownicy.dbo.dzialy
VALUES (60, 'KSIEGOWOSC', 'WIEDEN');
INSERT INTO test_pracownicy.dbo.dzialy
VALUES (70, 'SPRZEDAZ', 'CZESTOCHOWA');
INSERT INTO test_pracownicy.dbo.dzialy
VALUES (80, 'MAGAZYN', 'KLOBUCK');
GO
INSERT INTO test_pracownicy.dbo.taryfikator
VALUES (1, 1150, 1350);
INSERT INTO test_pracownicy.dbo.taryfikator
VALUES (2, 1351, 1550);
INSERT INTO test_pracownicy.dbo.taryfikator
VALUES (3, 1551, 2000);
INSERT INTO test_pracownicy.dbo.taryfikator
VALUES (4, 2001, 3000);
INSERT INTO test_pracownicy.dbo.taryfikator
VALUES (5, 3001, 9999);
GO
INSERT INTO test_pracownicy.dbo.stanowiska
VALUES ('PREZES', 6700, 9000);
INSERT INTO test_pracownicy.dbo.stanowiska
VALUES ('CZLONEK ZARZADU', 4000, 6000);
INSERT INTO test_pracownicy.dbo.stanowiska
VALUES ('GLOWNY INFORMATYK', 3000, 5000);
INSERT INTO test_pracownicy.dbo.stanowiska
VALUES ('DYREKTOR', 4000, 6000);
INSERT INTO test_pracownicy.dbo.stanowiska
VALUES ('TECHNOLOG', 1500, 2500);
INSERT INTO test_pracownicy.dbo.stanowiska
VALUES ('OPERATOR', 1200, 2000);
INSERT INTO test_pracownicy.dbo.stanowiska
VALUES ('LABORANT', 1150, 1500);
INSERT INTO test_pracownicy.dbo.stanowiska
VALUES ('INFORMATYK', 1500, 3000);
INSERT INTO test_pracownicy.dbo.stanowiska
VALUES ('LOGISTYK', 1200, 2000);
INSERT INTO test_pracownicy.dbo.stanowiska
VALUES ('MANAGER', 2000, 3000);
INSERT INTO test_pracownicy.dbo.stanowiska
VALUES ('GRAFIK', 1200, 2200);
INSERT INTO test_pracownicy.dbo.stanowiska
VALUES ('GLOWNY KSIEGOWY', 2500, 3500);
INSERT INTO test_pracownicy.dbo.stanowiska
VALUES ('KSIEGOWY', 2000, 3000);
INSERT INTO test_pracownicy.dbo.stanowiska
VALUES ('REFERENT', 1200, 1500);
INSERT INTO test_pracownicy.dbo.stanowiska
VALUES ('SPRZEDAWCA', 1200, 1500);
INSERT INTO test_pracownicy.dbo.stanowiska
VALUES ('MANAGER GRUPY', 2500, 3500);
INSERT INTO test_pracownicy.dbo.stanowiska
VALUES ('AKWIZYTOR', 1150, 1500);
INSERT INTO test_pracownicy.dbo.stanowiska
VALUES ('PRAKTYKANT', 1150, 1300);
GO
INSERT INTO test_pracownicy.dbo.pracownicy
VALUES (8901, 'KROL', 'PREZES', NULL, '1989/07/01', NULL, 7000, 4000, NULL, 10);
INSERT INTO test_pracownicy.dbo.pracownicy
VALUES (8902, 'MICHALSKI', 'DYREKTOR', 8901, '1989/08/15', NULL, 5000, 1500, NULL, 40);
INSERT INTO test_pracownicy.dbo.pracownicy
VALUES (9121, 'KUKULSKI', 'DYREKTOR', 8901, '1991/04/02', NULL, 5000, 1500, NULL, 30);
INSERT INTO test_pracownicy.dbo.pracownicy
VALUES (9011, 'WIERZBICKI', 'INFORMATYK', 8902, '1990/03/20', NULL, 2000, NULL, NULL, 40);
INSERT INTO test_pracownicy.dbo.pracownicy
VALUES (9235, 'FIKUS', 'DYREKTOR', 8901, '1994/09/16', NULL, 5000, 1500, NULL, 70);
INSERT INTO test_pracownicy.dbo.pracownicy
VALUES (8904, 'SKALSKI', 'GLOWNY INFORMATYK', 8901, '1989/08/18', NULL, 3500, 2500, NULL, 10);
INSERT INTO test_pracownicy.dbo.pracownicy
VALUES (8910, 'MONIUSZKO', 'DYREKTOR', 8901, '1989/09/01', NULL, 5000, 1500, NULL, 20);
INSERT INTO test_pracownicy.dbo.pracownicy
VALUES (8911, 'WRZOSEK', 'OPERATOR', 8910, '1989/11/10', NULL, 1500, NULL, NULL, 20);
INSERT INTO test_pracownicy.dbo.pracownicy
VALUES (9411, 'LISIECKI', 'LABORANT', 8910, '1994/09/10', NULL, 1300, NULL, NULL, 20);
INSERT INTO test_pracownicy.dbo.pracownicy
VALUES (8932, 'BRZOZKA', 'GLOWNY KSIEGOWY', 8901, '1989/12/06', NULL, 3000, 2000, NULL, 60);
INSERT INTO test_pracownicy.dbo.pracownicy
VALUES (8913, 'KOWALSKA', 'CZLONEK ZARZADU', 8901, '1989/11/15', NULL, 5000, 2000, NULL, 10);
INSERT INTO test_pracownicy.dbo.pracownicy
VALUES (9010, 'WISNIEWSKA', 'GRAFIK', 8902, '1990/02/12', NULL, 1800, NULL, NULL, 40);
INSERT INTO test_pracownicy.dbo.pracownicy
VALUES (9025, 'MALIK', 'LOGISTYK', 9121, '1990/06/01', NULL, 1500, NULL, NULL, 30);
INSERT INTO test_pracownicy.dbo.pracownicy
VALUES (9332, 'PRUSINSKA', 'DYREKTOR', 8901, '1997/07/15', NULL, 5000, 1500, NULL, 50);
INSERT INTO test_pracownicy.dbo.pracownicy
VALUES (9027, 'GADULA', 'LOGISTYK', 9121, '1990/06/20', NULL, 1500, NULL, NULL, 30);
INSERT INTO test_pracownicy.dbo.pracownicy
VALUES (9028, 'LESZCZYNSKI', 'SPRZEDAWCA', 9235, '1990/08/10', NULL, 1200, NULL, 6000, 70);
INSERT INTO test_pracownicy.dbo.pracownicy
VALUES (9102, 'KOWALCZYK', 'AKWIZYTOR', 9235, '1991/01/10', NULL, 1200, NULL, 12000, 70);
INSERT INTO test_pracownicy.dbo.pracownicy
VALUES (9122, 'WOJCIK', 'KSIEGOWY', 8932, '1991/05/10', NULL, 2200, NULL, NULL, 60);
INSERT INTO test_pracownicy.dbo.pracownicy
VALUES (9130, 'LELIWA', 'MANAGER', 8902, '1991/06/01', NULL, 2200, NULL, NULL, 40);
INSERT INTO test_pracownicy.dbo.pracownicy
VALUES (8920, 'WOJCIK', 'TECHNOLOG', 8910, '1989/12/01', NULL, 1800, NULL, NULL, 20);
INSERT INTO test_pracownicy.dbo.pracownicy
VALUES (9337, 'MAZUR', 'INFORMATYK', 8932, '1993/07/12', NULL, 2000, NULL, NULL, 60);
INSERT INTO test_pracownicy.dbo.pracownicy
VALUES (9345, 'SZCZESNY', 'OPERATOR', 8910, '1993/10/05', NULL, 1500, NULL, NULL, 20);
INSERT INTO test_pracownicy.dbo.pracownicy
VALUES (9403, 'BIELECKA', 'REFERENT', 8932, '1994/03/01', NULL, 1400, NULL, NULL, 60);
INSERT INTO test_pracownicy.dbo.pracownicy
VALUES (9120, 'RYBAK', 'TECHNOLOG', 8910, '1991/01/20', NULL, 1800, NULL, NULL, 20);
INSERT INTO test_pracownicy.dbo.pracownicy
VALUES (9641, 'MALYSZ', 'MANAGER GRUPY', 9235, '1996/12/05', NULL, 3000, 500, 10000, 70);
INSERT INTO test_pracownicy.dbo.pracownicy
VALUES (9731, 'NAWROCKI', 'LABORANT', 9332, '1997/04/01', NULL, 1300, NULL, NULL, 50);
INSERT INTO test_pracownicy.dbo.pracownicy
VALUES (9780, 'SAMOSINSKI', 'PRAKTYKANT', 9332, '2006/04/01', NULL, 1150, NULL, NULL, NULL);
GO
INSERT INTO test_pracownicy.dbo.prac_archiw
VALUES (9641, 'MALIK', 'SPRZEDAWCA', 9235, '1992/12/05', '1995/10/30', 1800, NULL, 5000, 70);
INSERT INTO test_pracownicy.dbo.prac_archiw
VALUES (9332, 'PROTASIEWICZ', 'LABORANT', 8910, '1993/03/15', '1994/12/01', 1200, NULL, NULL, 20);
INSERT INTO test_pracownicy.dbo.prac_archiw
VALUES (8912, 'SZCZERBA', 'OPERATOR', 8910, '1989/11/15', '1995/06/30', 1300, NULL, NULL, 20);
INSERT INTO test_pracownicy.dbo.prac_archiw
VALUES (9350, 'KWIATKOWSKA', 'REFERENT', 8932, '1994/01/10', '1998/03/31', 1100, NULL, NULL, 60);
INSERT INTO test_pracownicy.dbo.prac_archiw
VALUES (9440, 'BRODECKA', 'KSIEGOWY', 8932, '1994/10/10', '1999/09/30', 1600, NULL, NULL, 60);
INSERT INTO test_pracownicy.dbo.prac_archiw
VALUES (9153, 'MONETA', 'DYREKTOR', 8901, '1992/04/10', '1997/06/30', 3200, 1500, NULL, 50);
GO
SELECT *
FROM test_pracownicy.dbo.pracownicy;
SELECT *
FROM test_pracownicy.dbo.prac_archiw;
SELECT *
FROM test_pracownicy.dbo.stanowiska;
SELECT *
FROM test_pracownicy.dbo.dzialy;
GO
