-- k)zlicz i pogrupuj pracowników wed³ug pola ‘stanowisko’


SELECT stanowisko, COUNT(*) AS liczba_pracownikow
FROM rozliczenia.pensje
GROUP BY stanowisko;

-- l)Policz œredni¹, minimaln¹ i maksymaln¹ p³acê dla stanowiska ‘kierownik’ (lub innego)

SELECT 
    AVG(kwota) AS srednia_placa,
    MIN(kwota) AS minimalna_placa,
    MAX(kwota) AS maksymalna_placa
FROM rozliczenia.pensje
WHERE stanowisko = 'In¿ynier'; -- lub zamiast 'kierownik' wpisz inne stanowisko

-- m)Policz sumê wszystkich wynagrodzeñ:

SELECT SUM(kwota) AS suma_wynagrodzen
FROM rozliczenia.pensje;

-- f) Policz sumê wynagrodzeñ w ramach danego stanowiska:

SELECT pen.stanowisko, SUM(wyn.kwota) as suma_wynagordzen
FROM rozliczenia.pensje pen
JOIN rozliczenia.wynagrodzenie wyn ON pen.id_pensji = wyn.id_pensji
GROUP BY pen.stanowisko;

-- g) Wyznacz liczbê premii przyznanych dla pracowników danego stanowiska:

SELECT p.stanowisko, COUNT(prem.id_premii) as liczba_premii
from rozliczenia.pensje p
JOIN rozliczenia.wynagrodzenie w ON p.id_pensji = w.id_pensji
JOIN rozliczenia.premie prem ON p.id_premii = prem.id_premii
GROUP BY p.stanowisko;

-- h) Usuñ wszystkich pracowników maj¹cych pensjê mniejsz¹ ni¿ 1200 z³:
-- nalezy soobno usuanc klucze
DELETE FROM rozliczenia.pracownicy
WHERE id_pracownika IN (
SELECT l id_pracownika
FROM rozliczenia.pracownicy l 
JOIN rozliczenia.wynagrodzenie w ON l.id_pracownika = w.id_pracownika
JOIN rozliczenia.pensje p ON w.id_pensji = w.id_pensji
WHERE kwota < 4450) ;



