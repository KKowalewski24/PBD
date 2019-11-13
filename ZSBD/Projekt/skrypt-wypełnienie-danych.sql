USE baza_hotel
GO

INSERT INTO miasta (nazwa)
VALUES ('Warszawa'),
       ('Lodz'),
       ('Krakow'),
       ('Poznan'),
       ('Gdansk'),
       ('Wroclaw'),
       ('Torun'),
       ('Zamosc'),
       ('Lublin'),
       ('Szczecin');

SELECT *
FROM miasta
GO

INSERT INTO pokoje (pokoj_nr, liczba_osob, cena, czy_jest_wanna, czy_jest_sejf)
VALUES ('100', '2', '500', '0', '1'),
       ('101', '3', '500', '0', '0'),
       ('102', '4', '800', '1', '0'),
       ('103', '3', '800', '0', '1'),
       ('104', '4', '800', '0', '0'),
       ('105', '4', '900', '0', '1'),
       ('106', '1', '600', '0', '0'),
       ('107', '2', '600', '0', '1'),
       ('108', '4', '800', '1', '0'),
       ('109', '3', '1000', '0', '1'),
       ('200', '2', '900', '0', '0'),
       ('201', '2', '900', '1', '0'),
       ('202', '4', '700', '1', '1'),
       ('203', '1', '700', '1', '0'),
       ('204', '3', '1000', '1', '0'),
       ('205', '1', '600', '1', '1'),
       ('206', '1', '800', '0', '0'),
       ('207', '3', '500', '0', '0'),
       ('208', '3', '800', '0', '1'),
       ('209', '4', '700', '1', '0'),
       ('300', '4', '600', '0', '0'),
       ('301', '1', '700', '0', '1'),
       ('302', '3', '800', '0', '0'),
       ('303', '1', '800', '1', '0'),
       ('304', '3', '600', '1', '0'),
       ('305', '4', '1000', '1', '0'),
       ('306', '4', '1000', '1', '0'),
       ('307', '3', '800', '0', '1'),
       ('308', '1', '600', '1', '0'),
       ('309', '2', '600', '0', '0'),
       ('400', '4', '500', '1', '1'),
       ('401', '1', '1000', '1', '1'),
       ('402', '2', '600', '1', '1'),
       ('403', '1', '900', '1', '1'),
       ('404', '1', '700', '1', '0'),
       ('405', '1', '700', '0', '1'),
       ('406', '1', '800', '0', '1'),
       ('407', '2', '500', '1', '1'),
       ('408', '3', '800', '0', '1'),
       ('409', '4', '700', '1', '1'),
       ('500', '1', '800', '0', '0'),
       ('501', '2', '800', '0', '0'),
       ('502', '1', '500', '1', '0'),
       ('503', '1', '600', '0', '1'),
       ('504', '4', '800', '1', '0'),
       ('505', '2', '500', '0', '1'),
       ('506', '1', '500', '1', '0'),
       ('507', '2', '900', '1', '0'),
       ('508', '3', '700', '0', '0'),
       ('509', '3', '1000', '0', '0'),
       ('600', '4', '600', '0', '0'),
       ('601', '3', '500', '1', '1'),
       ('602', '1', '600', '0', '0'),
       ('603', '2', '800', '1', '1'),
       ('604', '4', '600', '1', '1'),
       ('605', '4', '900', '1', '0'),
       ('606', '1', '500', '0', '1'),
       ('607', '4', '500', '0', '1'),
       ('608', '3', '500', '1', '0'),
       ('609', '3', '700', '0', '0'),
       ('700', '4', '900', '1', '0'),
       ('701', '4', '800', '1', '1'),
       ('702', '1', '500', '1', '0'),
       ('703', '1', '900', '1', '0'),
       ('704', '2', '900', '0', '1'),
       ('705', '2', '900', '1', '0'),
       ('706', '2', '600', '0', '0'),
       ('707', '4', '700', '1', '0'),
       ('708', '4', '800', '1', '0'),
       ('709', '3', '1000', '0', '0'),
       ('800', '3', '500', '1', '0'),
       ('801', '1', '900', '1', '0'),
       ('802', '4', '800', '0', '1'),
       ('803', '4', '800', '0', '0'),
       ('804', '4', '500', '1', '1'),
       ('805', '2', '800', '0', '1'),
       ('806', '3', '900', '0', '1'),
       ('807', '1', '900', '0', '1'),
       ('808', '3', '800', '1', '1'),
       ('809', '2', '700', '1', '1'),
       ('900', '4', '900', '0', '1'),
       ('901', '1', '500', '1', '0'),
       ('902', '4', '800', '1', '1'),
       ('903', '2', '1000', '0', '0'),
       ('904', '1', '500', '0', '1'),
       ('905', '1', '600', '0', '0'),
       ('906', '4', '600', '1', '1'),
       ('907', '4', '900', '0', '0'),
       ('908', '3', '600', '0', '0'),
       ('909', '4', '600', '1', '1')

SELECT *
FROM pokoje
GO



INSERT INTO klienci (imie, nazwisko, miasto, adres, telefon, data_urodzenia, typ)
VALUES ('Janusz', 'Andrzejewski', '4', 'Andrzejowska 110', '524868981', '1992/6/14', '2'),
       ('Barbara', 'Stępień', '9', 'Przemysławowska 145', '569287655', '1998/6/19', '1'),
       ('Władysław', 'Sadowski', '9', 'Józefowska 75', '516826966', '1994/6/18', '3'),
       ('Ryszard', 'Michalski', '6', 'Leszekowska 86', '575538424', '1997/1/2', '3'),
       ('Przemysław', 'Witkowski', '6', 'Leszekowska 116', '552299275', '1990/5/30', '3'),
       ('Jolanta', 'Wysocki', '2', 'Robertowska 71', '575692526', '1942/2/13', '3'),
       ('Alicja', 'Mazur', '6', 'Krzysztofowska 29', '595679283', '1988/2/10', '1'),
       ('Józef', 'Szymański', '3', 'Adamowska 26', '516338739', '1960/8/25', '2'),
       ('Jadwiga', 'Pawlak', '9', 'Edwardowska 65', '546444451', '1958/4/26', '1'),
       ('Robert', 'Krajewski', '2', 'Mieczysławowska 45', '588733163', '1969/12/21', '3'),
       ('Mariusz', 'Michalski', '2', 'Marekowska 39', '599994453', '1968/5/12', '2'),
       ('Anna', 'Kaźmierczak', '5', 'Mirosławowska 61', '522273573', '1950/6/12', '3'),
       ('Dawid', 'Zając', '8', 'Mieczysławowska 97', '574422364', '1962/4/19', '1'),
       ('Aleksandra', 'Dąbrowski', '2', 'Edwardowska 140', '556645889', '1956/9/9', '2'),
       ('Paulina', 'Olszewski', '5', 'Mateuszowska 65', '543551672', '1994/8/20', '3'),
       ('Małgorzata', 'Olszewski', '3', 'Myszkorowska 107', '551228516', '1997/9/26', '1'),
       ('Daniel', 'Krajewski', '4', 'Władysławowska 2', '568212614', '1992/3/30', '3'),
       ('Leszek', 'Jasiński', '7', 'Januszowska 50', '562927859', '1954/11/4', '1'),
       ('Marzena', 'Kaczmarek', '7', 'Januszowska 60', '588138641', '1993/8/11', '3'),
       ('Kazimiera', 'Sawicki', '2', 'Januszowska 104', '545812991', '1953/6/24', '1'),
       ('Daniel', 'Kowalczyk', '5', 'Leszekowska 79', '588481316', '1945/11/1', '3'),
       ('Grażyna', 'Andrzejewski', '7', 'Leszekowska 137', '549932573', '1984/12/13', '1'),
       ('Mariola', 'Urbański', '4', 'Wojciechowska 63', '573994512', '1995/12/10', '1'),
       ('Grażyna', 'Maciejewski', '10', 'Krzysztofowska 115', '595684533', '1954/12/24', '2'),
       ('Irena', 'Kowalczyk', '2', 'Marcinowska 58', '546543664', '1944/5/28', '3'),
       ('Bożena', 'Kalinowski', '3', 'Damianowska 112', '586873894', '1969/11/3', '2'),
       ('Patrycja', 'Kalinowski', '8', 'Krzysztofowska 47', '564865949', '1986/1/30', '2'),
       ('Robert', 'Majewski', '4', 'Janowska 86', '533242686', '1954/8/1', '3'),
       ('Sławomir', 'Nowak', '6', 'Przemysławowska 55', '532829699', '1973/1/4', '2'),
       ('Maciej', 'Chmielewski', '3', 'Mieczysławowska 85', '539921858', '1955/9/5', '1'),
       ('Leszek', 'Urbański', '2', 'Janowska 27', '589114847', '1975/7/25', '2'),
       ('Marzena', 'Kubiak', '9', 'Damianowska 25', '575166658', '1976/4/15', '3'),
       ('Waldemar', 'Szymański', '7', 'Maciejowska 131', '536217379', '1961/2/13', '1'),
       ('Urszula', 'Lewandowski', '4', 'Mieczysławowska 40', '581556235', '1940/9/25', '1'),
       ('Kazimiera', 'Zając', '7', 'Krzysztofowska 66', '543536943', '1952/6/22', '3'),
       ('Paulina', 'Wróblewski', '10', 'Mirosławowska 148', '529151764', '1991/2/6', '3'),
       ('Halina', 'Tomaszewski', '1', 'Stanisławowska 70', '564693215', '1980/5/10', '2'),
       ('Wanda', 'Zalewski', '5', 'Wojciechowska 27', '516774545', '1998/8/21', '2'),
       ('Mirosław', 'Adamczyk', '5', 'Przemysławowska 70', '517266337', '1959/3/1', '2'),
       ('Monika', 'Maciejewski', '6', 'Łukaszowska 54', '593896886', '1990/5/28', '1'),
       ('Anna', 'Sikorski', '8', 'Jacekowska 70', '586372697', '1978/4/22', '2'),
       ('Anna', 'Sobczak', '6', 'Adamowska 74', '584844614', '1975/1/30', '3'),
       ('Marta', 'Nowakowski', '3', 'Dariuszowska 13', '594434687', '1974/1/4', '3'),
       ('Jarosław', 'Mazur', '10', 'Marcinowska 106', '511724491', '1949/12/1', '2'),
       ('Czesław', 'Dąbrowski', '1', 'Edwardowska 47', '599434396', '1978/3/19', '2'),
       ('Wiesław', 'Duda', '7', 'Kazimierzowska 129', '587838245', '1975/3/22', '3'),
       ('Justyna', 'Szymański', '9', 'Marianowska 51', '598797285', '1963/6/9', '2'),
       ('Sławomir', 'Szewczyk', '5', 'Rafałowska 144', '571831242', '1980/3/1', '2'),
       ('Artur', 'Kalinowski', '8', 'Grzegorzowska 103', '515488677', '1940/4/16', '3'),
       ('Bożena', 'Nowicki', '1', 'Janowska 90', '536973878', '1966/4/27', '3'),
       ('Grażyna', 'Wiśniewski', '6', 'Damianowska 21', '594925959', '1952/6/26', '2'),
       ('Ryszard', 'Kubiak', '2', 'Arturowska 83', '522143479', '1953/12/5', '2'),
       ('Maciej', 'Dudek', '3', 'Rafałowska 131', '511665125', '1940/6/23', '2'),
       ('Rafał', 'Zalewski', '2', 'Januszowska 50', '531376338', '1965/9/13', '2'),
       ('Marcin', 'Brzeziński', '3', 'Michałowska 121', '595215134', '1981/1/27', '3'),
       ('Agnieszka', 'Adamski', '1', 'Jacekowska 99', '531483952', '1944/1/2', '1'),
       ('Sławomir', 'Kubiak', '3', 'Damianowska 6', '576899874', '1990/10/6', '3'),
       ('Barbara', 'Krajewski', '2', 'Dariuszowska 39', '557749345', '1991/12/3', '1'),
       ('Ewelina', 'Jaworski', '3', 'Grzegorzowska 8', '517662931', '1973/1/6', '1'),
       ('Artur', 'Adamczyk', '1', 'Tadeuszowska 57', '595837313', '1944/5/14', '1'),
       ('Aneta', 'Zalewski', '8', 'Łukaszowska 57', '548421499', '1998/9/11', '3'),
       ('Genowefa', 'Szewczyk', '2', 'Wojciechowska 88', '536538691', '1957/11/19', '3'),
       ('Zbigniew', 'Dudek', '8', 'Damianowska 64', '538648583', '1943/10/7', '2'),
       ('Marek', 'Zawadzki', '7', 'Rafałowska 87', '596229964', '1989/7/14', '2'),
       ('Karolina', 'Michalski', '7', 'Dawidowska 103', '581773145', '1968/4/11', '1'),
       ('Iwona', 'Nowakowski', '8', 'Arturowska 32', '525332698', '1956/2/6', '2'),
       ('Sławomir', 'Kozłowski', '1', 'Dawidowska 8', '566269232', '1984/5/25', '1'),
       ('Przemysław', 'Wilk', '2', 'Marianowska 138', '555671421', '1972/6/19', '2'),
       ('Magdalena', 'Grabowski', '1', 'Grzegorzowska 119', '516941822', '1961/3/7', '3'),
       ('Adam', 'Pietrzak', '8', 'Rafałowska 23', '582854369', '1954/9/15', '3'),
       ('Stefania', 'Adamczyk', '10', 'Janowska 125', '529684835', '1977/5/8', '3'),
       ('Krystyna', 'Olszewski', '8', 'Arturowska 63', '563172447', '1951/5/13', '2'),
       ('Magdalena', 'Kwiatkowski', '2', 'Damianowska 110', '582922924', '1941/2/14', '1'),
       ('Ewa', 'Baranowski', '3', 'Mirosławowska 28', '544769794', '1983/11/15', '3'),
       ('Agata', 'Mazur', '3', 'Wiesławowska 46', '584219863', '1951/11/9', '3'),
       ('Iwona', 'Majewski', '1', 'Stanisławowska 85', '598472739', '1977/7/19', '3'),
       ('Dorota', 'Szymański', '10', 'Michałowska 8', '554485738', '1998/5/13', '1'),
       ('Sebastian', 'Szewczyk', '5', 'Wojciechowska 26', '546967154', '1998/11/10', '3'),
       ('Mirosław', 'Jankowski', '9', 'Tomaszowska 19', '569496889', '1996/9/13', '1'),
       ('Paulina', 'Kucharski', '3', 'Ryszardowska 79', '552626647', '1953/8/17', '2'),
       ('Jakub', 'Czarnecki', '4', 'Władysławowska 137', '543424321', '1973/7/13', '3'),
       ('Myszkor', 'Jasiński', '10', 'Władysławowska 122', '516917347', '1962/7/6', '2'),
       ('Teresa', 'Maciejewski', '10', 'Damianowska 92', '587142712', '1967/9/6', '2'),
       ('Edward', 'Wysocki', '10', 'Marianowska 82', '538877114', '1980/4/21', '3'),
       ('Władysław', 'Urbański', '5', 'Zdzisławowska 76', '596943242', '1978/9/10', '3'),
       ('Jan', 'Jaworski', '10', 'Krzysztofowska 93', '559442163', '1989/9/25', '2'),
       ('Wiesław', 'Szulc', '7', 'Henrykowska 61', '545383597', '1947/12/7', '1'),
       ('Marzena', 'Szymański', '1', 'Myszkorowska 90', '548618273', '1974/1/12', '2'),
       ('Myszkor', 'Czerwiński', '1', 'Tadeuszowska 112', '514418756', '1981/8/3', '1'),
       ('Zdzisław', 'Adamczyk', '10', 'Leszekowska 46', '552537179', '1953/8/27', '3'),
       ('Leszek', 'Kozłowski', '10', 'Krzysztofowska 52', '527589776', '1971/8/12', '3'),
       ('Aleksandra', 'Mazurek', '4', 'Myszkorowska 60', '571187659', '1981/2/20', '1'),
       ('Magdalena', 'Dudek', '1', 'Januszowska 143', '589345134', '1955/6/19', '2'),
       ('Edward', 'Wojciechowski', '10', 'Robertowska 130', '546978792', '1955/10/6', '2'),
       ('Robert', 'Wieczorek', '10', 'Jacekowska 1', '565278842', '1996/4/21', '2'),
       ('Janina', 'Stępień', '4', 'Danielowska 13', '599843916', '1953/2/18', '2'),
       ('Maciej', 'Zakrzewski', '2', 'Zbigniewowska 40', '571524879', '1948/6/19', '1'),
       ('Halina', 'Krajewski', '7', 'Mieczysławowska 2', '518779965', '1958/9/18', '1'),
       ('Leszek', 'Grabowski', '6', 'Pawełowska 72', '582341986', '1940/1/29', '2'),
       ('Dorota', 'Kołodziej', '7', 'Dariuszowska 50', '548967627', '1992/12/25', '1'),
       ('Dariusz', 'Wojciechowski', '6', 'Jarosławowska 114', '558164841', '1951/5/16', '2'),
       ('Bożena', 'Głowacki', '7', 'Romanowska 7', '513469344', '1996/2/24', '1'),
       ('Monika', 'Wojciechowski', '6', 'Dawidowska 92', '561439955', '1992/10/13', '3'),
       ('Iwona', 'Szymański', '2', 'Zbigniewowska 124', '596827396', '1986/2/2', '2'),
       ('Henryk', 'Rutkowski', '2', 'Stanisławowska 51', '535885911', '1981/10/26', '1'),
       ('Renata', 'Laskowski', '8', 'Sebastianowska 61', '568887425', '1941/10/16', '3'),
       ('Małgorzata', 'Olszewski', '1', 'Czesławowska 30', '558695481', '1975/10/24', '2'),
       ('Grzegorz', 'Brzeziński', '10', 'Jerzyowska 9', '528659254', '1994/4/27', '1'),
       ('Renata', 'Baranowski', '10', 'Piotrowska 64', '571148948', '1973/4/22', '3'),
       ('Jerzy', 'Wilk', '2', 'Rafałowska 23', '582237833', '1973/1/2', '3'),
       ('Zofia', 'Nowakowski', '7', 'Andrzejowska 140', '548951191', '1994/2/2', '3'),
       ('Leszek', 'Krawczyk', '6', 'Henrykowska 29', '554746178', '1943/3/5', '3'),
       ('Katarzyna', 'Stępień', '3', 'Stanisławowska 65', '569391998', '1968/5/5', '2'),
       ('Sylwia', 'Kaczmarek', '1', 'Myszkorowska 142', '597862546', '1994/6/27', '1'),
       ('Urszula', 'Duda', '6', 'Dariuszowska 116', '563543878', '1969/1/7', '1'),
       ('Robert', 'Lewandowski', '8', 'Dawidowska 141', '582296525', '1942/10/15', '3'),
       ('Monika', 'Włodarczyk', '4', 'Marekowska 18', '547243433', '1977/7/21', '1'),
       ('Michał', 'Kowalski', '5', 'Zbigniewowska 28', '541473143', '1996/7/24', '3'),
       ('Paulina', 'Jakubowski', '5', 'Kazimierzowska 12', '515845442', '1963/1/6', '2'),
       ('Adam', 'Kozłowski', '10', 'Mateuszowska 143', '575942676', '1995/10/7', '3'),
       ('Genowefa', 'Wasilewski', '7', 'Tomaszowska 112', '586878195', '1964/1/8', '2'),
       ('Katarzyna', 'Kowalczyk', '10', 'Robertowska 30', '592352216', '1971/2/25', '1'),
       ('Alicja', 'Kwiatkowski', '1', 'Henrykowska 112', '536247181', '1991/1/7', '2'),
       ('Paweł', 'Adamczyk', '3', 'Sławomirowska 58', '595954463', '1974/11/11', '2'),
       ('Bożena', 'Stępień', '1', 'Józefowska 13', '533332173', '1989/10/28', '3'),
       ('Jarosław', 'Urbański', '6', 'Mirosławowska 124', '555445585', '1996/7/24', '2'),
       ('Marzena', 'Ziółkowski', '2', 'Maciejowska 142', '543455686', '1999/1/11', '1'),
       ('Ewa', 'Borkowski', '3', 'Maciejowska 42', '514869914', '1958/9/3', '3'),
       ('Marta', 'Kalinowski', '4', 'Romanowska 128', '558471666', '1992/1/22', '1'),
       ('Mariola', 'Kubiak', '8', 'Wojciechowska 85', '593698687', '1973/3/11', '2'),
       ('Marzena', 'Rutkowski', '7', 'Rafałowska 8', '534679492', '1978/10/13', '3'),
       ('Mirosław', 'Piotrowski', '6', 'Mariuszowska 30', '559389998', '1984/9/23', '2'),
       ('Natalia', 'Duda', '3', 'Robertowska 33', '541948173', '1970/3/27', '1'),
       ('Stefania', 'Dudek', '9', 'Robertowska 5', '585199375', '1958/9/15', '1'),
       ('Daniel', 'Lis', '1', 'Marcinowska 130', '595882112', '1979/8/18', '1'),
       ('Zofia', 'Jankowski', '5', 'Zbigniewowska 111', '534998531', '1991/7/10', '2'),
       ('Sylwia', 'Baran', '5', 'Tadeuszowska 50', '597959142', '1995/2/27', '3'),
       ('Magdalena', 'Sokołowski', '6', 'Mirosławowska 88', '579751957', '1996/12/15', '3'),
       ('Wiesław', 'Baran', '8', 'Jerzyowska 34', '516497556', '1979/10/13', '2'),
       ('Małgorzata', 'Makowski', '3', 'Przemysławowska 68', '548313416', '1959/1/26', '2'),
       ('Krystyna', 'Pietrzak', '9', 'Mariuszowska 71', '593571926', '1958/8/14', '2'),
       ('Barbara', 'Sobczak', '4', 'Danielowska 69', '529168581', '1981/1/23', '3'),
       ('Janina', 'Maciejewski', '6', 'Mariuszowska 19', '558856736', '1992/4/7', '1'),
       ('Paweł', 'Sikorski', '1', 'Jarosławowska 129', '555883533', '1947/9/29', '3'),
       ('Jadwiga', 'Wiśniewski', '4', 'Łukaszowska 101', '553793631', '1947/2/16', '1'),
       ('Marta', 'Krawczyk', '6', 'Mariuszowska 80', '569312772', '1973/1/13', '1'),
       ('Marian', 'Chmielewski', '8', 'Leszekowska 110', '538498884', '1954/4/5', '1'),
       ('Sylwia', 'Sobczak', '10', 'Januszowska 41', '597794133', '1961/7/24', '3'),
       ('Adam', 'Mazurek', '4', 'Arturowska 150', '589847373', '1968/3/16', '3'),
       ('Helena', 'Kalinowski', '7', 'Zbigniewowska 43', '575528326', '1946/10/17', '2'),
       ('Jerzy', 'Kaźmierczak', '6', 'Edwardowska 72', '585993651', '1961/1/21', '1'),
       ('Michał', 'Szymański', '10', 'Marianowska 124', '576841262', '1958/10/26', '3'),
       ('Jakub', 'Makowski', '3', 'Jarosławowska 103', '596278658', '1941/2/28', '1'),
       ('Sławomir', 'Rutkowski', '1', 'Władysławowska 42', '583253873', '1962/1/23', '3'),
       ('Łukasz', 'Zalewski', '4', 'Januszowska 119', '528743631', '1956/6/1', '3'),
       ('Maciej', 'Zieliński', '6', 'Myszkorowska 146', '515982328', '1970/3/19', '3'),
       ('Grzegorz', 'Kozłowski', '3', 'Andrzejowska 72', '517994941', '1980/9/22', '1'),
       ('Stanisław', 'Piotrowski', '3', 'Edwardowska 74', '543748585', '1953/12/13', '3'),
       ('Jadwiga', 'Walczak', '3', 'Maciejowska 136', '587635736', '1987/10/13', '2'),
       ('Bożena', 'Sikorski', '6', 'Łukaszowska 12', '582912748', '1990/8/1', '2'),
       ('Myszkor', 'Olszewski', '8', 'Władysławowska 53', '573143397', '1997/1/17', '2'),
       ('Przemysław', 'Wróbel', '1', 'Marekowska 20', '523966552', '1954/4/12', '3'),
       ('Katarzyna', 'Rutkowski', '3', 'Zdzisławowska 57', '525921638', '1976/6/4', '3'),
       ('Jolanta', 'Górski', '10', 'Marianowska 4', '556519723', '1955/12/8', '2'),
       ('Rafał', 'Witkowski', '2', 'Marekowska 53', '545669136', '1985/8/17', '2'),
       ('Małgorzata', 'Majewski', '3', 'Czesławowska 60', '535959631', '1978/11/13', '3'),
       ('Halina', 'Andrzejewski', '5', 'Marcinowska 75', '556192789', '1944/1/23', '3'),
       ('Stanisława', 'Szczepański', '4', 'Maciejowska 21', '571877458', '1981/11/28', '1'),
       ('Renata', 'Cieślak', '6', 'Marcinowska 9', '579339638', '1965/2/17', '3'),
       ('Agata', 'Pietrzak', '7', 'Jakubowska 104', '592834646', '1975/10/3', '1'),
       ('Edyta', 'Pawlak', '2', 'Piotrowska 68', '598573776', '1997/2/5', '1'),
       ('Patrycja', 'Włodarczyk', '4', 'Waldemarowska 148', '544613174', '1973/12/13', '2'),
       ('Mirosław', 'Ziółkowski', '9', 'Damianowska 25', '555697375', '1982/2/21', '1'),
       ('Małgorzata', 'Jabłoński', '8', 'Arturowska 5', '513492689', '1976/6/30', '3'),
       ('Damian', 'Majewski', '10', 'Myszkorowska 83', '587617632', '1980/12/24', '3'),
       ('Iwona', 'Kucharski', '10', 'Arturowska 7', '536151498', '1984/4/15', '3'),
       ('Przemysław', 'Kwiatkowski', '6', 'Danielowska 141', '592696493', '1990/8/29', '2'),
       ('Janina', 'Urbański', '6', 'Andrzejowska 126', '546615273', '1951/1/19', '3'),
       ('Katarzyna', 'Maciejewski', '5', 'Dariuszowska 121', '528384821', '1999/3/14', '2'),
       ('Mieczysław', 'Olszewski', '4', 'Arturowska 114', '583489294', '1975/9/18', '2'),
       ('Jacek', 'Kowalski', '6', 'Zdzisławowska 85', '594593789', '1999/9/29', '2'),
       ('Anna', 'Pawłowski', '10', 'Mateuszowska 136', '587545864', '1959/7/10', '2'),
       ('Aneta', 'Brzeziński', '2', 'Sebastianowska 49', '596546459', '1950/1/15', '1'),
       ('Wojciech', 'Brzeziński', '5', 'Kazimierzowska 139', '545841441', '1959/6/15', '3'),
       ('Wiesława', 'Lewandowski', '1', 'Piotrowska 38', '519412111', '1959/8/13', '2'),
       ('Rafał', 'Malinowski', '8', 'Andrzejowska 1', '542319669', '1996/1/21', '3'),
       ('Genowefa', 'Pawłowski', '5', 'Dariuszowska 17', '558315224', '1967/12/19', '2'),
       ('Mariola', 'Szymański', '2', 'Robertowska 37', '552131127', '1964/6/9', '2'),
       ('Grzegorz', 'Zawadzki', '2', 'Dawidowska 2', '587868182', '1972/4/27', '3'),
       ('Przemysław', 'Woźniak', '1', 'Zdzisławowska 116', '512373521', '1976/2/28', '1'),
       ('Patrycja', 'Jankowski', '2', 'Michałowska 33', '572485315', '1947/5/27', '3'),
       ('Jarosław', 'Mazurek', '8', 'Stanisławowska 61', '559493164', '1967/11/24', '1'),
       ('Wojciech', 'Krawczyk', '10', 'Adamowska 44', '528349254', '1945/10/17', '2'),
       ('Rafał', 'Jaworski', '9', 'Zdzisławowska 117', '567293775', '1971/6/20', '2'),
       ('Łukasz', 'Pietrzak', '4', 'Ryszardowska 41', '511793643', '1996/5/2', '3'),
       ('Genowefa', 'Lis', '8', 'Leszekowska 142', '528723153', '1989/12/8', '2'),
       ('Mieczysław', 'Kołodziej', '8', 'Jerzyowska 122', '564252584', '1988/12/5', '2'),
       ('Barbara', 'Jakubowski', '6', 'Józefowska 33', '576844895', '1949/5/26', '2'),
       ('Daniel', 'Tomaszewski', '7', 'Januszowska 138', '549825654', '1960/2/25', '2'),
       ('Maria', 'Sikora', '3', 'Danielowska 48', '561347969', '1943/3/13', '1');

SELECT *
FROM klienci
GO

INSERT INTO stanowiska (nazwa, placa_minimalna)
VALUES ('Barista', '4000'),
       ('Barman', '5000'),
       ('Concierge', '8000'),
       ('Kelner', '3000'),
       ('Kucharz', '6000'),
       ('Konserwator', '7000'),
       ('Pokojowka', '3000'),
       ('Sprzataczka', '3500'),
       ('Operator windy', '4500'),
       ('Recepjonista', '4000'),
       ('Dyrektor hotelu', '18000'),
       ('Kierownik lokalu gastronomicznego', '11000'),
       ('Specjalista ds. rezerwacji', '13000');

SELECT *
FROM stanowiska
GO

INSERT INTO pracownicy (imie, nazwisko, miasto, adres, telefon, data_urodzenia, data_zatrudnienia,
                        stanowisko_nr, placa)
VALUES ('Katarzyna', 'Kubiak', '1', 'Mieczysławowska 78', '512648351', '1971/5/2', '2015/8/12', '6',
        '10000'),
       ('Wiesława', 'Makowski', '2', 'Tomaszowska 145', '515763547', '1966/12/20', '2013/4/3', '4',
        '11000'),
       ('Marcin', 'Kozłowski', '9', 'Piotrowska 11', '543519164', '1992/4/21', '2010/12/28', '4',
        '12000'),
       ('Czesław', 'Olszewski', '8', 'Dariuszowska 87', '519271258', '1968/4/30', '2004/11/18', '7',
        '5000'),
       ('Stefania', 'Górski', '1', 'Wiesławowska 83', '571142548', '1956/9/25', '2013/5/16', '7',
        '9000'),
       ('Marek', 'Kowalski', '8', 'Myszkorowska 56', '555916273', '1971/2/4', '2005/1/8', '3',
        '5000'),
       ('Jan', 'Sobczak', '1', 'Czesławowska 144', '526541778', '1955/3/20', '2012/1/12', '6',
        '14000'),
       ('Mariusz', 'Jasiński', '4', 'Arturowska 76', '556576628', '1979/5/11', '2013/3/14', '7',
        '12000'),
       ('Marek', 'Nowak', '8', 'Mirosławowska 67', '525628584', '1981/8/17', '2013/2/2', '1',
        '9000'),
       ('Mieczysław', 'Brzeziński', '1', 'Andrzejowska 132', '515576385', '1960/9/6', '2011/2/15',
        '8', '9000'),
       ('Marek', 'Kalinowski', '2', 'Mariuszowska 139', '541672118', '1943/8/15', '2004/4/4', '7',
        '9000'),
       ('Magdalena', 'Wróbel', '3', 'Wojciechowska 91', '579925144', '1989/2/11', '2013/12/23', '3',
        '7000'),
       ('Jacek', 'Tomaszewski', '3', 'Mateuszowska 48', '568254716', '1971/10/27', '2010/11/7', '5',
        '7000'),
       ('Patrycja', 'Borkowski', '10', 'Rafałowska 70', '517394124', '1993/2/1', '2014/2/30', '7',
        '3000'),
       ('Edyta', 'Przybylski', '9', 'Mirosławowska 73', '555382578', '1975/9/9', '2012/9/11', '5',
        '7000'),
       ('Zdzisław', 'Olszewski', '7', 'Grzegorzowska 133', '582894613', '1992/11/11', '2015/12/13',
        '1', '4000'),
       ('Michał', 'Król', '8', 'Mirosławowska 133', '546787518', '1954/7/16', '2003/8/19', '10',
        '7000'),
       ('Krystyna', 'Kubiak', '4', 'Damianowska 147', '557352653', '1941/12/13', '2015/8/2', '10',
        '13000'),
       ('Andrzej', 'Czarnecki', '7', 'Adamowska 42', '529126475', '1993/7/16', '2012/11/12', '6',
        '7000'),
       ('Tomasz', 'Woźniak', '1', 'Waldemarowska 97', '521865828', '1995/8/30', '2013/8/9', '4',
        '10000'),
       ('Paulina', 'Witkowski', '10', 'Sebastianowska 37', '525772717', '1973/10/29', '2005/10/4',
        '3', '11000'),
       ('Kazimiera', 'Piotrowski', '8', 'Jakubowska 30', '546297566', '1953/10/20', '2013/10/6',
        '4', '12000'),
       ('Marcin', 'Jasiński', '1', 'Dariuszowska 20', '534251271', '1964/1/26', '2011/9/13', '6',
        '4000'),
       ('Władysław', 'Krawczyk', '4', 'Mieczysławowska 1', '572412133', '1948/6/1', '2014/2/11',
        '10', '7000'),
       ('Agnieszka', 'Czerwiński', '7', 'Grzegorzowska 113', '582565798', '1978/1/24', '2012/1/23',
        '10', '6000'),
       ('Krystyna', 'Kozłowski', '3', 'Jakubowska 91', '563688181', '1975/10/13', '2010/2/2', '6',
        '14000'),
       ('Daniel', 'Michalak', '3', 'Piotrowska 66', '521596873', '1969/12/2', '2010/3/4', '5',
        '3000'),
       ('Rafał', 'Urbański', '1', 'Grzegorzowska 32', '544558142', '1940/11/7', '2014/3/15', '8',
        '2000'),
       ('Mariusz', 'Zieliński', '6', 'Przemysławowska 82', '516585286', '1949/12/27', '2013/2/16',
        '4', '12000'),
       ('Sebastian', 'Kamiński', '6', 'Tomaszowska 51', '558735446', '1963/4/14', '2001/10/27', '1',
        '11000'),
       ('Urszula', 'Lewandowski', '1', 'Mirosławowska 122', '518476762', '1973/1/26', '2011/6/13',
        '8', '7000'),
       ('Jacek', 'Tomaszewski', '8', 'Józefowska 90', '545164622', '1986/3/14', '2002/12/5', '6',
        '10000'),
       ('Wojciech', 'Zieliński', '9', 'Januszowska 74', '549129376', '1985/8/18', '2013/5/3', '6',
        '8000'),
       ('Wojciech', 'Kowalski', '4', 'Sebastianowska 131', '564944371', '1950/2/1', '2010/9/12',
        '4', '7000'),
       ('Maria', 'Rutkowski', '3', 'Mieczysławowska 131', '527925321', '1971/3/18', '2014/7/20',
        '8', '6000'),
       ('Jadwiga', 'Sawicki', '1', 'Ryszardowska 142', '589656565', '1946/8/18', '2012/1/18', '8',
        '5000'),
       ('Elżbieta', 'Olszewski', '6', 'Januszowska 108', '512133937', '1989/1/27', '2001/5/18', '1',
        '5000'),
       ('Justyna', 'Wróblewski', '4', 'Tomaszowska 93', '529926185', '1963/8/6', '2002/4/5', '9',
        '5000'),
       ('Agnieszka', 'Olszewski', '7', 'Czesławowska 30', '545776581', '1975/10/23', '2014/4/17',
        '2', '2000'),
       ('Urszula', 'Stępień', '8', 'Jerzyowska 92', '535836895', '1969/2/19', '2012/7/27', '4',
        '4000'),
       ('Sylwia', 'Michalak', '8', 'Kazimierzowska 120', '592575151', '1975/7/9', '2011/6/9', '8',
        '8000'),
       ('Alicja', 'Kołodziej', '10', 'Pawełowska 47', '562152247', '1950/10/16', '2000/10/20', '3',
        '6000'),
       ('Janusz', 'Cieślak', '8', 'Waldemarowska 114', '597843313', '1963/5/18', '2003/10/25', '10',
        '8000'),
       ('Myszkor', 'Chmielewski', '4', 'Józefowska 47', '587475637', '1996/4/28', '2011/3/17', '4',
        '4000'),
       ('Krzysztof', 'Adamski', '3', 'Mateuszowska 70', '559982429', '1982/10/26', '2004/3/18', '3',
        '6000'),
       ('Natalia', 'Kamiński', '1', 'Waldemarowska 107', '588918237', '1969/9/12', '2003/2/25', '2',
        '8000'),
       ('Dariusz', 'Adamczyk', '10', 'Marianowska 84', '594617996', '1970/11/29', '2005/12/5', '8',
        '5000'),
       ('Artur', 'Michalak', '10', 'Marianowska 91', '596738322', '1956/12/4', '2011/5/28', '1',
        '9000'),
       ('Tomasz', 'Marciniak', '6', 'Grzegorzowska 133', '588996665', '1961/8/8', '2015/12/13', '5',
        '3000'),
       ('Bożena', 'Kaźmierczak', '2', 'Mirosławowska 21', '528581617', '1969/5/26', '2015/10/20',
        '6', '6000'),
       ('Jacek', 'Walczak', '9', 'Adamowska 16', '572118311', '1968/3/23', '2013/1/11', '4',
        '8000'),
       ('Zbigniew', 'Tomaszewski', '3', 'Ryszardowska 107', '596711123', '1965/9/25', '2014/3/14',
        '6', '11000'),
       ('Ewelina', 'Sokołowski', '8', 'Piotrowska 51', '581466383', '1951/2/26', '2001/4/24', '8',
        '11000'),
       ('Mateusz', 'Sawicki', '10', 'Kamilowska 40', '589966425', '1977/5/23', '2015/11/17', '7',
        '8000'),
       ('Kazimiera', 'Andrzejewski', '7', 'Sebastianowska 121', '588918623', '1968/3/15',
        '2003/6/6', '1', '6000'),
       ('Małgorzata', 'Zieliński', '8', 'Maciejowska 106', '594298166', '1995/11/21', '2003/2/5',
        '3', '12000'),
       ('Mateusz', 'Kalinowski', '2', 'Romanowska 132', '555995529', '1972/6/1', '2003/9/14', '9',
        '5000'),
       ('Helena', 'Adamczyk', '9', 'Zdzisławowska 26', '592772971', '1980/5/27', '2015/7/9', '4',
        '7000'),
       ('Sławomir', 'Kwiatkowski', '3', 'Rafałowska 45', '523564459', '1966/6/5', '2002/5/19', '3',
        '7000'),
       ('Jolanta', 'Piotrowski', '4', 'Przemysławowska 75', '572531915', '1971/4/29', '2003/8/13',
        '2', '4000'),
       ('Rafał', 'Ziółkowski', '10', 'Mateuszowska 141', '536856939', '1963/9/17', '2000/7/17', '9',
        '6000'),
       ('Artur', 'Szymański', '3', 'Waldemarowska 100', '565428533', '1985/4/21', '2000/8/10', '9',
        '6000'),
       ('Stanisława', 'Pietrzak', '7', 'Mieczysławowska 15', '591866236', '1986/2/14', '2012/8/27',
        '6', '6000'),
       ('Genowefa', 'Jasiński', '2', 'Piotrowska 140', '564553742', '1958/5/23', '2015/3/6', '2',
        '8000'),
       ('Agnieszka', 'Kowalski', '1', 'Krzysztofowska 2', '527185714', '1981/3/9', '2012/1/9', '8',
        '6000'),
       ('Patrycja', 'Mazur', '8', 'Rafałowska 84', '559864857', '1966/1/13', '2002/4/24', '5',
        '11000'),
       ('Ryszard', 'Dąbrowski', '4', 'Mirosławowska 15', '549169593', '1954/1/6', '2011/3/16', '10',
        '10000'),
       ('Jakub', 'Wiśniewski', '6', 'Januszowska 21', '568723652', '1974/5/9', '2010/5/11', '4',
        '6000'),
       ('Helena', 'Jankowski', '4', 'Jacekowska 132', '584497957', '1945/1/13', '2005/9/16', '7',
        '6000'),
       ('Dorota', 'Kaźmierczak', '6', 'Maciejowska 121', '582595198', '1967/7/21', '2005/8/3', '9',
        '11000'),
       ('Krystyna', 'Wróbel', '4', 'Mateuszowska 132', '585739212', '1961/9/28', '2010/2/11', '8',
        '6000'),
       ('Patrycja', 'Rutkowski', '8', 'Marekowska 114', '541844543', '1944/10/14', '2011/3/5', '3',
        '7000'),
       ('Elżbieta', 'Szymański', '6', 'Wiesławowska 4', '523938547', '1976/6/1', '2012/3/8', '2',
        '10000'),
       ('Irena', 'Pawlak', '1', 'Przemysławowska 117', '526326333', '1972/1/14', '2005/2/29', '3',
        '7000'),
       ('Elżbieta', 'Kucharski', '8', 'Kamilowska 85', '577291724', '1950/6/28', '2011/9/12', '1',
        '6000'),
       ('Kazimierz', 'Piotrowski', '1', 'Leszekowska 66', '551917324', '1986/1/19', '2014/7/10',
        '3', '7000'),
       ('Danuta', 'Czarnecki', '10', 'Piotrowska 139', '568415951', '1958/8/26', '2005/6/8', '4',
        '4000'),
       ('Elżbieta', 'Zieliński', '8', 'Leszekowska 104', '529277428', '1998/4/2', '2005/3/26', '3',
        '6000'),
       ('Dorota', 'Brzeziński', '5', 'Rafałowska 70', '527171372', '1987/9/27', '2000/12/19', '1',
        '9000'),
       ('Izabela', 'Malinowski', '2', 'Tomaszowska 121', '572512823', '1989/12/3', '2015/10/4', '4',
        '13000');

SELECT *
FROM pracownicy
GO

INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('72', '302', '2', '2019/1/27', '19');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('30', '205', '2', '2019/6/30', '11');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('48', '103', '4', '2019/11/27', '9');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('182', '203', '1', '2019/7/19', '9');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('68', '209', '3', '2019/2/19', '5');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('178', '102', '3', '2019/7/14', '14');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('182', '301', '4', '2019/6/13', '6');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('119', '106', '3', '2019/11/22', '9');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('70', '308', '1', '2019/12/24', '20');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('45', '208', '4', '2019/8/3', '7');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('177', '309', '1', '2019/6/28', '16');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('134', '100', '2', '2019/1/23', '8');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('22', '204', '3', '2019/3/18', '6');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('177', '109', '3', '2019/6/22', '15');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('3', '104', '4', '2019/1/15', '3');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('35', '203', '2', '2019/12/8', '12');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('108', '101', '3', '2019/7/22', '12');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('113', '309', '4', '2019/6/3', '19');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('117', '205', '2', '2019/7/21', '18');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('66', '300', '1', '2019/5/29', '5');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('34', '207', '3', '2019/1/12', '12');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('169', '108', '4', '2019/12/2', '11');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('76', '208', '1', '2019/8/11', '1');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('125', '302', '3', '2019/3/22', '10');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('198', '101', '4', '2019/10/18', '13');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('129', '301', '4', '2019/4/4', '4');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('197', '306', '1', '2019/1/28', '7');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('33', '203', '3', '2019/9/29', '16');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('179', '101', '3', '2019/12/20', '19');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('175', '104', '2', '2019/10/11', '8');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('134', '102', '3', '2019/5/23', '13');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('194', '306', '2', '2019/10/10', '20');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('14', '104', '3', '2019/2/20', '3');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('16', '105', '4', '2019/10/2', '20');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('109', '205', '4', '2019/7/27', '3');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('76', '209', '3', '2019/1/7', '12');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('159', '209', '4', '2019/12/10', '18');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('38', '200', '2', '2019/12/13', '18');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('175', '106', '1', '2019/2/24', '12');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('133', '108', '4', '2019/10/12', '1');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('118', '103', '2', '2019/4/30', '10');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('187', '103', '2', '2019/8/25', '18');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('148', '305', '4', '2019/12/30', '9');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('64', '307', '3', '2019/7/4', '5');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('88', '206', '3', '2019/1/16', '21');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('45', '309', '2', '2019/1/26', '12');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('92', '306', '2', '2019/11/28', '5');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('79', '305', '3', '2019/2/16', '7');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('115', '105', '3', '2019/3/7', '7');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('1', '100', '1', '2019/3/23', '2');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('117', '108', '3', '2019/4/25', '21');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('181', '306', '4', '2019/1/12', '20');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('121', '108', '2', '2019/6/17', '13');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('166', '208', '1', '2019/11/26', '3');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('125', '200', '4', '2019/5/5', '9');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('192', '207', '4', '2019/4/17', '18');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('26', '105', '2', '2019/10/9', '5');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('9', '201', '3', '2019/9/22', '7');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('107', '108', '2', '2019/10/5', '3');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('11', '309', '2', '2019/8/23', '8');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('120', '209', '2', '2019/1/30', '8');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('114', '306', '2', '2019/7/9', '14');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('137', '302', '4', '2019/9/1', '12');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('171', '302', '3', '2019/1/5', '11');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('21', '207', '3', '2019/10/12', '16');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('152', '200', '2', '2019/5/6', '11');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('87', '107', '3', '2019/6/3', '14');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('41', '202', '4', '2019/8/6', '18');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('90', '201', '1', '2019/11/8', '9');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('169', '106', '3', '2019/4/7', '2');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('61', '201', '4', '2019/4/9', '19');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('81', '207', '1', '2019/1/22', '2');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('143', '307', '3', '2019/9/12', '10');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('142', '204', '1', '2019/5/18', '14');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('156', '103', '2', '2019/1/5', '5');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('131', '308', '2', '2019/1/5', '20');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('86', '203', '3', '2019/12/22', '8');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('175', '303', '4', '2019/5/10', '8');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('109', '301', '2', '2019/10/24', '9');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('10', '207', '4', '2019/9/25', '13');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('159', '107', '1', '2019/2/8', '5');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('144', '309', '1', '2019/11/6', '16');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('71', '103', '3', '2019/6/12', '10');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('111', '106', '3', '2019/4/12', '18');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('88', '305', '2', '2019/4/15', '10');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('53', '102', '3', '2019/5/19', '3');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('161', '306', '1', '2019/2/27', '1');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('93', '208', '1', '2019/11/29', '4');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('141', '306', '3', '2019/7/16', '15');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('35', '308', '1', '2019/6/23', '15');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('8', '206', '2', '2019/12/9', '10');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('136', '107', '1', '2019/11/30', '1');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('129', '300', '1', '2019/7/2', '3');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('180', '102', '1', '2019/2/14', '20');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('56', '204', '1', '2019/5/13', '16');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('122', '209', '3', '2019/2/6', '8');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('85', '202', '1', '2019/2/4', '1');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('47', '200', '2', '2019/3/1', '4');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('109', '207', '1', '2019/4/23', '1');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('23', '109', '1', '2019/4/25', '4');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('151', '101', '1', '2019/8/21', '13');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('132', '105', '3', '2019/8/7', '21');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('114', '307', '1', '2019/2/27', '13');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('120', '105', '2', '2019/1/10', '1');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('37', '208', '2', '2019/12/29', '14');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('173', '205', '2', '2019/3/4', '14');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('68', '309', '3', '2019/4/14', '15');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('168', '304', '2', '2019/11/29', '11');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('128', '104', '4', '2019/11/20', '11');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('107', '106', '4', '2019/2/13', '3');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('81', '300', '2', '2019/9/5', '17');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('174', '105', '4', '2019/8/13', '6');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('97', '203', '1', '2019/8/16', '9');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('126', '102', '4', '2019/7/18', '8');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('171', '202', '4', '2019/10/12', '9');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('153', '201', '4', '2019/7/26', '1');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('194', '108', '4', '2019/12/4', '5');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('132', '304', '1', '2019/6/30', '15');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('38', '308', '3', '2019/5/18', '20');
INSERT INTO rezerwacje (klient_nr, pokoj_nr, liczba_osob, poczatek_rezerwacji, liczba_dni)
VALUES ('149', '207', '4', '2019/10/9', '10');

SELECT *
FROM rezerwacje
GO
