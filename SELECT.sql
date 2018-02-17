--1. Utworz widok zawierajacy: ID wniosku, nazwe konkursu, tytul zadania i nazwisko osoby podpisanej pod wnioskiem

CREATE VIEW informacje_wniosek
	(ID_wniosku, nazwa_konkursu, tytul_zadania, nazwisko)
	AS SELECT wniosek.ID_wniosku, konkurs.nazwa_konkursu, wniosek.tytul_zadania,osoba.nazwisko
	FROM wniosek, konkurs, osoba
	WHERE wniosek.numer_konkursu = konkurs.numer
	AND osoba.PESEL = wniosek.nr_PESEL_os
	
	
SELECT * FROM informacje_wniosek
DROP VIEW informacje_wniosek

--2. Dla kazdej osoby (urzednika) wypisz jego imie, nazwisko, PESEL, stanowisko i telefon kontaktowy. Sortuj wg nazwisk.

SELECT osoba.*, urzedy.telefon_kontaktowy, miasta.nazwa_miasta
	FROM osoba JOIN urzedy
		ON osoba.nr_REGON_urzedu = urzedy.REGON
		JOIN miasta
		ON urzedy.ID_miasta = miasta.ID_miasta			
	ORDER BY osoba.nazwisko 

--3. Wypisz nazwisko osoby i ilosc podpisanych wnioskow. Posortuj malejaco.
SELECT osoba.nazwisko, COUNT(wniosek.ID_wniosku) AS 'ilosc wnioskow'
	FROM osoba LEFT JOIN wniosek
	ON wniosek.nr_PESEL_os = osoba.PESEL
	GROUP BY (osoba.nazwisko)
	ORDER BY COUNT(wniosek.ID_wniosku) DESC

--4. wypisz ID tych wnioskow ktore maja jakies projekty 
SELECT wniosek.ID_wniosku
	FROM wniosek
	WHERE wniosek.ID_wniosku IN
		(SELECT projekt.ID_wniosku
			FROM projekt, wniosek
			WHERE projekt.ID_wniosku = wniosek.ID_wniosku 
			GROUP BY projekt.ID_wniosku
			HAVING COUNT (projekt.ID_wniosku) > 0)

--5. wypisz nazwy tych konkursow ktore sie juz zakonczyly
SELECT konkurs.nazwa_konkursu,
	CASE 
		WHEN konkurs.data_zakonczenia < '09/07/2011' THEN 'zakonczony'
		WHEN konkurs.data_zakonczenia > '09/07/2011' THEN 'w trakcie'
	END AS 'stan konkursu'
	FROM konkurs 
	ORDER BY konkurs.data_zakonczenia 

--6. wypisz ID_wniosku dla ktorego jest dotacja, date przelewu, jej kwote i nr konkursu w ktorym zostala przydzielona
--ktorej kwota jest wieksza od sredniej kwoty wszystkich dotacji

SELECT dotacja.ID_wniosku, dotacja.data_przelewu, dotacja.kwota, dotacja.nr_konkursu
	FROM dotacja
	WHERE dotacja.kwota > (
		SELECT AVG(dotacja.kwota)
			FROM dotacja
		)

--7. Wypisz ID projektu jesli mial jakis wydatek i laczna sume jaka zostala wydana na realizacje
SELECT projekt.ID_projektu, SUM(wydatek.kwota) AS 'wydano'
	FROM projekt INNER JOIN wydatek
	ON wydatek.ID_projektu = projekt.ID_projektu
	GROUP BY projekt.ID_projektu
	ORDER BY SUM(wydatek.kwota) DESC
	