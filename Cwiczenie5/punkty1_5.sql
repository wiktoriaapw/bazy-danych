USE firma;
GO

CREATE TABLE rozliczenia.wynagrodzenie (
    id_wynagrodzenia CHAR(4) PRIMARY KEY,
    data_ DATE NOT NULL,
    id_pracownika INT NOT NULL,
    id_godziny INT NOT NULL,
    id_pensji INT NOT NULL,
    id_premii INT NOT NULL,
    FOREIGN KEY (id_pracownika) REFERENCES rozliczenia.pracownicy(id_pracownika),
    FOREIGN KEY (id_godziny) REFERENCES rozliczenia.godziny(id_godziny),
    FOREIGN KEY (id_pensji) REFERENCES rozliczenia.pensje(id_pensji),
    FOREIGN KEY (id_premii) REFERENCES rozliczenia.premie(id_premii)
) ;


INSERT INTO rozliczenia.wynagrodzenie (id_wynagrodzenia, data_, id_pracownika, id_godziny, id_pensji, id_premii)
VALUES
(1, '2024-04-01', 1, 1, 3, 3),
(2, '2024-04-18', 2, 2, 1, 1),
(3, '2024-04-21', 3, 3, 4, 4),
(4, '2024-04-17', 4, 4, 7, 7),
(5, '2024-05-01', 5, 5, 8, 8),
(6, '2024-05-02', 6, 6, 2, 2),
(7, '2024-06-03', 7, 7, 9, 9),
(8, '2024-06-05', 8, 8, 10, 10),
(9, '2024-06-11', 9, 9, 5, 5),
(10, '2024-06-15', 10, 10, 6, 6);

