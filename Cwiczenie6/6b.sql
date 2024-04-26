--a) Zmodyfikuj numer telefonu w tabeli pracownicy, dodaj¹c do niego kierunkowy dla Polski w nawiasie (+48)

ALTER TABLE rozliczenia.pracownicy
ADD nr_telefon NVARCHAR(20); 

UPDATE rozliczenia.pracownicy
SET nr_telefon = CONCAT('(+48) ', telefon)

ALTER TABLE rozliczenia.pracownicy
DROP COLUMN numer_telefonu, 


--b) Zmodyfikuj atrybut telefon w tabeli pracownicy tak, aby numer oddzielony by³ myœlnikami wg wzoru: ‘555-222-333’ 
ALTER TABLE rozliczenia.pracownicy
ALTER COLUMN telefon VARCHAR(12);

UPDATE rozliczenia.pracownicy
SET telefon = CONCAT(SUBSTRING(telefon, 1, 3), '-', SUBSTRING(telefon, 4, 3), '-', SUBSTRING(telefon, 7, 3))


-- c) Wyœwietl dane pracownika, którego nazwisko jest najd³u¿sze, u¿ywaj¹c du¿ych liter

SELECT TOP 1 
	UPPER(imie) AS imie,
    UPPER(nazwisko) AS nazwisko,
    UPPER(adres) AS adres,
    telefon
FROM rozliczenia.pracownicy
ORDER BY LEN(nazwisko) DESC;

--d) Wyœwietl dane pracowników i ich pensje zakodowane przy pomocy algorytmu md5 

SELECT imie, nazwisko, CONVERT(VARCHAR(32), HASHBYTES('MD5', CAST(kwota AS VARCHAR(20))), 2) pensja_md5  --konwersja wyniku na typ danych VARCHAR(32) w postaci szesnastkowej, kwota as.. -rowniez zmienamy typ danych na ciag znakow
FROM rozliczenia.pracownicy
JOIN rozliczenia.wynagrodzenie ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
JOIN rozliczenia.pensje ON wynagrodzenie.id_pensji = pensje.id_pensji


--f) Wyœwietl pracowników, ich pensje oraz premie. Wykorzystaj z³¹czenie lewostronne.

SELECT p.id_pracownika, p.imie, p.nazwisko, pen.kwota AS pensja, pm.kwota AS premia
FROM rozliczenia.pracownicy p
LEFT JOIN rozliczenia.wynagrodzenie w ON p.id_pracownika = w.id_pracownika
LEFT JOIN rozliczenia.pensje pen ON w.id_pensji = pen.id_pensji
LEFT JOIN rozliczenia.premie pm ON w.id_premii = pm.id_premii


/* g) wygeneruj raport (zapytanie), które zwróci w wyniki treœæ wg poni¿szego szablonu:
Pracownik Jan Nowak, w dniu 7.08.2017 otrzyma³ pensjê ca³kowit¹ na kwotê 7540 z³, gdzie 
wynagrodzenie zasadnicze wynosi³o: 5000 z³, premia: 2000 z³, nadgodziny: 540 z³*/

SELECT CONCAT('Pracownik ', p.imie, ' ', p.nazwisko, ', w dniu ', w.data_, 
' otrzyma³ pensjê ca³kowit¹ na kwotê ', pn.kwota, ' z³, gdzie wynagrodzenie zasadnicze wynosi³o: ', pn.kwota, ' z³, premia: ', pr.kwota, ' z³, nadgodziny: ', 
CASE
        WHEN godz.liczba_godzin > 160 THEN CAST(godz.liczba_godzin - 160 AS VARCHAR(10))
        ELSE '0'
    END) 
	AS raport

FROM rozliczenia.wynagrodzenie w
JOIN rozliczenia.godziny godz ON w.id_godziny = godz.id_godziny
JOIN rozliczenia.pracownicy p ON w.id_pracownika = p.id_pracownika
JOIN rozliczenia.pensje pn ON w.id_pensji = pn.id_pensji
JOIN rozliczenia.premie pr ON w.id_premii = pr.id_premii
ORDER BY p.id_pracownika
