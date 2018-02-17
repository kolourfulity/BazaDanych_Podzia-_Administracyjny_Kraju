CREATE TABLE kraje (
    nazwa_kraju varchar(15) PRIMARY KEY
);
 
CREATE TABLE regiony (
    ID_regionu int IDENTITY(001,1) PRIMARY KEY,
    nazwa_regionu varchar(20) not null,
    kraj varchar(15) REFERENCES kraje,
    region_nadrzedny int REFERENCES regiony null
);
 
CREATE TABLE miasta (
    ID_miasta int IDENTITY(0001,1) PRIMARY KEY,
    nazwa_miasta varchar(20) not null,
    ID_regionu int REFERENCES regiony 
        ON UPDATE CASCADE
        ON DELETE CASCADE
);
 
CREATE TABLE urzedy (
    REGON int PRIMARY KEY,
    adres_siedziby char(30) not null,
    telefon_kontaktowy char(9),
    kraj varchar(15) REFERENCES kraje,
    ID_regionu int REFERENCES regiony, 
    ID_miasta int REFERENCES miasta
);
 
CREATE TABLE osoba (
    imie varchar(20) not null, 
    nazwisko varchar(20) not null, 
    PESEL varchar(11) PRIMARY KEY, 
    stanowisko varchar(20) not null,
    nr_REGON_urzedu int REFERENCES urzedy
        ON UPDATE CASCADE
);
 
CREATE TABLE konkurs (
    nazwa_konkursu varchar(50) not null, 
    kategoria_dzialania varchar(20) not null, 
    data_ogloszenia date, 
    data_zakonczenia date,  
    data_wynikow date, 
    numer varchar(10) PRIMARY KEY, 
    pula_pieniedzy int CHECK (pula_pieniedzy > 0)
);
 
CREATE TABLE wniosek (
    ID_wniosku int IDENTITY(100000,1) PRIMARY KEY, /*primary key => unique => not null*/
    rodzaj_zadania varchar(50) not null, 
    tytul_zadania varchar(50) not null, 
    data_zlozenia date, 
    opis varchar(100) not null, 
    cele_zadania varchar(100) not null, 
    status_zadania varchar(20) not null, 
    informacje_zwrotne varchar(50) null,
    numer_konkursu varchar(10) REFERENCES konkurs
        ON UPDATE CASCADE,
	nr_PESEL_os varchar(11) REFERENCES osoba
);
 
CREATE TABLE projekt (
    ID_projektu  int IDENTITY(100000,1) PRIMARY KEY, 
    koszt int CHECK (koszt > 0), 
    tytul varchar(30) not null,
    data date, 
    ID_wniosku int REFERENCES wniosek ON UPDATE CASCADE,
    osoba_odpowiedzialna_PESEL varchar(11) REFERENCES osoba
        ON UPDATE CASCADE
);
 
CREATE TABLE dotacja (
    data_przelewu date not null, 
    ID_wniosku int REFERENCES wniosek, 
    kwota  int CHECK (kwota > 0),
    PRIMARY KEY(ID_wniosku, data_przelewu),
	nr_konkursu varchar(10) REFERENCES konkurs
 
);

CREATE TABLE wydatek (
    kwota int CHECK (kwota > 0), 
    nr_faktury int PRIMARY KEY,
    ID_projektu int REFERENCES projekt
        ON UPDATE CASCADE

);
 


ALTER TABLE kraje 
ADD unia varchar(10)

