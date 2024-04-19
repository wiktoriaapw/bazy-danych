
USE FIRMA;
GO

-- a)
SELECT id_pracownika, nazwisko FROM rozliczenia.pracownicy;


-- b)
SELECT id_pracownika FROM rozliczenia.pracownicy
JOIN rozliczenia.pensje pe ON id_pracownika = id_pensji
WHERE kwota > 5000;


-- c)
SELECT wyn.id_pracownika FROM rozliczenia.wynagrodzenie wyn
JOIN rozliczenia.pensje pens ON wyn.id_pensji = pens.id_pensji 
JOIN rozliczenia.premie prem ON wyn.id_premii = prem.id_premii
WHERE pens.kwota > 2000 AND  prem.kwota > 700; 


-- d)
SELECT imie
FROM rozliczenia.pracownicy
WHERE imie LIKE 'J%';


-- e)
SELECT imie, nazwisko
FROM rozliczenia.pracownicy
WHERE nazwisko LIKE '%n%' AND imie LIKE '%a';


-- f)
SELECT prac.imie, prac.nazwisko, godz.liczba_godzin,
	CASE 
        WHEN godz.liczba_godzin > 160 THEN godz.liczba_godzin - 160 
        ELSE 0 
    END AS nadgodziny
	FROM rozliczenia.godziny godz 
JOIN rozliczenia.pracownicy prac 
ON godz.id_pracownika = prac.id_pracownika 
WHERE godz.liczba_godzin > 160; 


-- g)
SELECT imie, nazwisko, kwota
FROM rozliczenia.pracownicy 
JOIN rozliczenia.pensje  ON id_pracownika = id_pensji
WHERE kwota BETWEEN 4500 AND 5600;

--h)
SELECT pra.imie, pra.nazwisko FROM rozliczenia.wynagrodzenie wyn
JOIN rozliczenia.pracownicy pra -- 
ON wyn.id_pracownika = pra.id_pracownika 
JOIN rozliczenia.godziny god 
ON wyn.id_godziny = god.id_godziny 
WHERE god.liczba_godzin > 160 AND wyn.id_premii IS NULL; 


-- i)
SELECT imie, nazwisko, kwota AS pensja
FROM rozliczenia.pracownicy 
JOIN rozliczenia.pensje ON id_pracownika = id_pensji
ORDER BY kwota; 

--j)

SELECT pra.imie, pra.nazwisko, pen.kwota AS pensja, pre.kwota AS premia FROM rozliczenia.wynagrodzenie wyn 
JOIN rozliczenia.pracownicy pra 
ON wyn.id_pracownika = pra.id_pracownika 
JOIN rozliczenia.pensje pen 
ON wyn.id_pensji = pen.id_pensji 
JOIN rozliczenia.premie pre 
ON wyn.id_premii = pre.id_premii 
ORDER BY pen.kwota DESC, pre.kwota DESC; -- sortowanie malejaco