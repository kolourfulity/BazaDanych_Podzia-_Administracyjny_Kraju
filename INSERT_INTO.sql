

INSERT INTO kraje VALUES
    ('Polska', 'tak');
 
 
INSERT INTO regiony VALUES
    ('Pomorskie', (SELECT nazwa_kraju FROM kraje WHERE nazwa_kraju='Polska'), null),
    ('Mazowieckie', (SELECT nazwa_kraju FROM kraje WHERE nazwa_kraju='Polska'), null),
    ('gdanski', (SELECT nazwa_kraju FROM kraje WHERE nazwa_kraju='Polska'), (SELECT ID_regionu FROM regiony WHERE nazwa_regionu='Pomorskie')),
    ('Wielkopolskie', (SELECT nazwa_kraju FROM kraje WHERE nazwa_kraju='Polska'), null),
    ('kaliski', (SELECT nazwa_kraju FROM kraje WHERE nazwa_kraju='Polska'), (SELECT ID_regionu FROM regiony WHERE nazwa_regionu='Wielkopolskie')),
    ('Podlaskie', (SELECT nazwa_kraju FROM kraje WHERE nazwa_kraju='Polska'), null),
    ('suwalski', (SELECT nazwa_kraju FROM kraje WHERE nazwa_kraju='Polska'), (SELECT ID_regionu FROM regiony WHERE nazwa_regionu='Podlaskie'))
;
 
INSERT INTO miasta VALUES
    ('Suwalki', (SELECT ID_regionu FROM regiony WHERE nazwa_regionu='suwalski')),
    ('Kalisz', (SELECT ID_regionu FROM regiony WHERE nazwa_regionu='kaliski')),
    ('Gdansk', (SELECT ID_regionu FROM regiony WHERE nazwa_regionu='gdanski'))
;
 
INSERT INTO urzedy VALUES
    (396938972, '80-123 Kalisz', 501246953, (SELECT nazwa_kraju FROM kraje WHERE nazwa_kraju='Polska'), 
        (SELECT ID_regionu FROM regiony WHERE nazwa_regionu='kaliski'),(SELECT ID_miasta FROM miasta WHERE nazwa_miasta='Kalisz')),
    (813291726, '85-014 Suwalki', 743258951, (SELECT nazwa_kraju FROM kraje WHERE nazwa_kraju='Polska'), 
        (SELECT ID_regionu FROM regiony WHERE nazwa_regionu='suwalski'),(SELECT ID_miasta FROM miasta WHERE nazwa_miasta='Suwalki')),
    (318077752, '80-456 Gdansk', 742654369, (SELECT nazwa_kraju FROM kraje WHERE nazwa_kraju='Polska'), 
        (SELECT ID_regionu FROM regiony WHERE nazwa_regionu='gdanski'),(SELECT ID_miasta FROM miasta WHERE nazwa_miasta='Gdansk'))
 
;
 
INSERT INTO osoba VALUES
    ('Katarzyna', 'Dobrzanska', '94011611258', 'kierownik', (SELECT REGON FROM urzedy WHERE REGON=813291726)),
    ('Patryk', 'Blawat', '56100610333', 'kierownik', (SELECT REGON FROM urzedy WHERE REGON=318077752))
;
 
INSERT INTO konkurs VALUES
    ('odbudowa drog', 'komunikacja miejska', (SELECT TRY_PARSE('15/09/2010' as datetime USING 'pl-pl')),
        (SELECT TRY_PARSE('31/10/2010' as datetime USING 'pl-pl')), (SELECT TRY_PARSE('15/11/2010' as datetime USING 'pl-pl')),
        '1/2010', 1000000),
	('odnowa parku', 'spoleczenstwo', (SELECT TRY_PARSE('12/01/2010' as datetime USING 'pl-pl')),
        (SELECT TRY_PARSE('16/04/2010' as datetime USING 'pl-pl')), (SELECT TRY_PARSE('19/05/2010' as datetime USING 'pl-pl')),
        '2/2010', 1000000),
	('oswietlenie', 'spoleczenstwo', (SELECT TRY_PARSE('12/01/2012' as datetime USING 'pl-pl')),
        (SELECT TRY_PARSE('16/10/2011' as datetime USING 'pl-pl')), (SELECT TRY_PARSE('19/05/2012' as datetime USING 'pl-pl')),
        '1/2012', 3000000)
;

INSERT INTO wniosek VALUES
	('komunikacja', 'odnowa drog (Hallera, Starej,..)', (SELECT TRY_PARSE('2/08/2010' as datetime USING 'pl-pl')), 'glowne ulice miasta m. in. Hallera',
		'polepszenie zycia mieszkancow', 'zlozone', null, '1/2010', '94011611258'),
	('komunikacja', 'odnowa ul. Armii Krajowej', (SELECT TRY_PARSE('2/08/2010' as datetime USING 'pl-pl')), 'ulica Armii Krajowej',
		'ulatwienie dojazdu', 'zlozone', null, '1/2010', '56100610333'),
	('zielen dla wszystkich', 'odnowa parku Killinskiego', (SELECT TRY_PARSE('8/12/2010' as datetime USING 'pl-pl')), 'park Killinskiego',
		'swieze powietrze, miejsce spotkan', 'zlozone', null, '2/2010', '56100610333'),
	('zywe otoczenie', 'odnowa parku Zabrze', (SELECT TRY_PARSE('8/12/2010' as datetime USING 'pl-pl')), 'park Zabrze',
		'powietrze', 'zlozone', null, '2/2010', '56100610333')
;


 
INSERT INTO projekt VALUES
    (50000, 'ul. Hallera', (SELECT TRY_PARSE('6/11/2010' as datetime USING 'pl-pl')), (SELECT ID_wniosku FROM wniosek WHERE tytul_zadania='odnowa drog (Hallera, Starej,..)'),
        (SELECT PESEL FROM osoba WHERE PESEL='56100610333')),
	(50001, 'ul. Stara', (SELECT TRY_PARSE('6/11/2010' as datetime USING 'pl-pl')), (SELECT ID_wniosku FROM wniosek WHERE tytul_zadania='odnowa drog (Hallera, Starej,..)'),
        (SELECT PESEL FROM osoba WHERE PESEL='56100610333')),
	(50002, 'ul. Biala', (SELECT TRY_PARSE('6/11/2010' as datetime USING 'pl-pl')), (SELECT ID_wniosku FROM wniosek WHERE tytul_zadania='odnowa drog (Hallera, Starej,..)'),
        (SELECT PESEL FROM osoba WHERE PESEL='56100610333')),
	(50003, 'park Killinskiego', (SELECT TRY_PARSE('6/11/2010' as datetime USING 'pl-pl')), (SELECT ID_wniosku FROM wniosek WHERE tytul_zadania='odnowa parku Killinskiego'),
        (SELECT PESEL FROM osoba WHERE PESEL='56100610333')),
	(50004, 'park Zabrze', (SELECT TRY_PARSE('6/11/2010' as datetime USING 'pl-pl')), (SELECT ID_wniosku FROM wniosek WHERE tytul_zadania='odnowa parku Zabrze'),
        (SELECT PESEL FROM osoba WHERE PESEL='56100610333'))
;
 
INSERT INTO dotacja VALUES
    ((SELECT TRY_PARSE('2/08/2010' as datetime USING 'pl-pl')), (SELECT ID_wniosku FROM wniosek WHERE tytul_zadania='odnowa drog (Hallera, Starej,..)'),
        100000, (SELECT numer FROM konkurs WHERE numer='1/2010')),
	((SELECT TRY_PARSE('13/05/2010' as datetime USING 'pl-pl')), (SELECT ID_wniosku FROM wniosek WHERE tytul_zadania='odnowa ul. Armii Krajowej'),
        150000, (SELECT numer FROM konkurs WHERE numer='1/2010')),
	((SELECT TRY_PARSE('12/08/2010' as datetime USING 'pl-pl')), (SELECT ID_wniosku FROM wniosek WHERE tytul_zadania='odnowa parku Killinskiego'),
        200000, (SELECT numer FROM konkurs WHERE numer='2/2010')),
	((SELECT TRY_PARSE('19/10/2010' as datetime USING 'pl-pl')), (SELECT ID_wniosku FROM wniosek WHERE tytul_zadania='odnowa parku Zabrze'),
        50000, (SELECT numer FROM konkurs WHERE numer='2/2010')),
	((SELECT TRY_PARSE('11/12/2010' as datetime USING 'pl-pl')), (SELECT ID_wniosku FROM wniosek WHERE tytul_zadania='odnowa ul. Armii Krajowej'),
        350000, (SELECT numer FROM konkurs WHERE numer='1/2010')),
	((SELECT TRY_PARSE('7/10/2010' as datetime USING 'pl-pl')), (SELECT ID_wniosku FROM wniosek WHERE tytul_zadania='odnowa parku Zabrze'),
        150000, (SELECT numer FROM konkurs WHERE numer='2/2010'))
;
 
INSERT INTO wydatek VALUES
    (10000,1057,(SELECT ID_projektu FROM projekt WHERE tytul='ul. Hallera')),
    (30000,1067,(SELECT ID_projektu FROM projekt WHERE tytul='ul. Hallera')),
	(50000,1089,(SELECT ID_projektu FROM projekt WHERE tytul='ul. Stara')),
    (70000,1405,(SELECT ID_projektu FROM projekt WHERE tytul='ul. Stara')),
	(30000,1003,(SELECT ID_projektu FROM projekt WHERE tytul='ul. Biala')),
    (50000,1049,(SELECT ID_projektu FROM projekt WHERE tytul='ul. Hallera')),
	(5000,1455,(SELECT ID_projektu FROM projekt WHERE tytul='ul. Stara')),
	(10000,1007,(SELECT ID_projektu FROM projekt WHERE tytul='ul. Biala')),
    (50000,1077,(SELECT ID_projektu FROM projekt WHERE tytul='park Killinskiego'))
;