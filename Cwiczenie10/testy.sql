-- Tworzenie tabeli GeoEon
CREATE DATABASE Cwiczenie10;

CREATE TABLE GeoEon (
    id_eon INT PRIMARY KEY,
    nazwa_eon VARCHAR(50) NOT NULL
);
SELECT * FROM GeoEon

-- Tworzenie tabeli GeoEra
CREATE TABLE GeoEra (
    id_era INT PRIMARY KEY,
    id_eon INT NOT NULL,
    nazwa_era VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_eon) REFERENCES GeoEon(id_eon)
);

-- Tworzenie tabeli GeoOkres
CREATE TABLE GeoOkres (
    id_okres INT PRIMARY KEY,
    id_era INT NOT NULL,
    nazwa_okres VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_era) REFERENCES GeoEra(id_era)
);

-- Tworzenie tabeli GeoEpoka
CREATE TABLE GeoEpoka (
    id_epoka INT PRIMARY KEY,
    id_okres INT NOT NULL,
    nazwa_epoka VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_okres) REFERENCES GeoOkres(id_okres)
);

-- Tworzenie tabeli GeoPietro
CREATE TABLE GeoPietro (
    id_pietro INT PRIMARY KEY,
    id_epoka INT NOT NULL,
    nazwa_pietro VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_epoka) REFERENCES GeoEpoka(id_epoka)
);

-- Wstawianie danych do tabeli GeoEon
INSERT INTO GeoEon (id_eon, nazwa_eon) VALUES
(1, 'Fanerozoik');

-- Wstawianie danych do tabeli GeoEra
INSERT INTO GeoEra (id_era, id_eon, nazwa_era) VALUES
(1, 1, 'Paleozoik'),
(2, 1, 'Mezozoik'),
(3, 1, 'Kenozoik');

-- Wstawianie danych do tabeli GeoOkres
INSERT INTO GeoOkres (id_okres, id_era, nazwa_okres) VALUES
(1, 1, 'Dewon'),
(2, 1, 'Karbon'),
(3, 1, 'Perm'),
(4, 2, 'Trias'),
(5, 2, 'Jura'),
(6, 2, 'Kreda'),
(7, 3, 'Paleogen'),
(8, 3, 'Neogen'),
(9, 3, 'Czwartorzad');

-- Wstawianie danych do tabeli GeoEpoka
INSERT INTO GeoEpoka (id_epoka, id_okres, nazwa_epoka) VALUES
(1, 1, 'Dolny'),
(2, 1, 'Srodkowy'),
(3, 2, 'Gorny'),
(4, 2, 'Dolny'),
(5, 3, 'Gorny'),
(6, 3, 'Dolny'),
(7, 4, 'Gorna'),
(8, 4, 'Srodkowa'),
(9, 4, 'Dolna'),
(10, 5, 'Gorna'),
(11, 5, 'Srodkowa'),
(12, 5, 'Dolna'),
(13, 6, 'Gorna'),
(14, 6, 'Dolna'),
(15, 7, 'Paleocen'),
(16, 7, 'Eocen'),
(17, 7, 'Oligocen'),
(18, 8, 'Miocen'),
(19, 8, 'Pliocen'),
(20, 9, 'Plejstocen'),
(21, 9, 'Holocen');

-- Wstawianie danych do tabeli GeoPietro
INSERT INTO GeoPietro (id_pietro, id_epoka, nazwa_pietro) VALUES
(1, 1, 'Dolny'),
(2, 2, 'Srodkowy'),
(3, 3, 'Gorny'),
(4, 4, 'Dolny'),
(5, 5, 'Gorny'),
(6, 6, 'Dolny'),
(7, 7, 'Gorna'),
(8, 8, 'Srodkowa'),
(9, 9, 'Dolna'),
(10, 10, 'Gorna'),
(11, 11, 'Srodkowa'),
(12, 12, 'Dolna'),
(13, 13, 'Gorna'),
(14, 14, 'Dolna'),
(15, 15, 'Paleocen'),
(16, 16, 'Eocen'),
(17, 17, 'Oligocen'),
(18, 18, 'Miocen'),
(19, 19, 'Pliocen'),
(20, 20, 'Plejstocen'),
(21, 21, 'Holocen');

-- Wstawianie danych do tabeli GeoPietro
SELECT 
    eon.id_eon,
    eon.nazwa_eon,
    era.id_era,
    era.nazwa_era,
    okres.id_okres,
    okres.nazwa_okres,
    epoka.id_epoka,
    epoka.nazwa_epoka,
    pietro.id_pietro,
    pietro.nazwa_pietro
INTO GeoTabela
FROM 
    GeoEon eon
JOIN 
    GeoEra era ON eon.id_eon = era.id_eon
JOIN 
    GeoOkres okres ON era.id_era = okres.id_era
JOIN 
    GeoEpoka epoka ON okres.id_okres = epoka.id_okres
JOIN 
    GeoPietro pietro ON epoka.id_epoka = pietro.id_epoka;

SELECT * FROM GeoTabela;


CREATE TABLE Milion(liczba int,cyfra int, bit int);
CREATE TABLE Dziesiec(cyfra int, bit int);
INSERT INTO Dziesiec (cyfra, bit) VALUES
(0, 1),
(1, 2),
(2, 3),
(3, 4),
(4, 5),
(5, 6),
(6, 7),
(7, 8),
(8, 9),
(9, 10);

SELECT * FROM Milion
INSERT INTO Milion SELECT a1.cyfra +10* a2.cyfra +100*a3.cyfra + 1000*a4.cyfra
+ 10000*a5.cyfra + 10000*a6.cyfra AS liczba , a1.cyfra AS cyfra, a1.bit AS bit
FROM Dziesiec a1, Dziesiec a2, Dziesiec a3, Dziesiec a4, Dziesiec a5, Dziesiec a6 ;

SET STATISTICS TIME ON
SELECT COUNT(*) FROM Milion INNER JOIN GeoTabela ON (Milion.liczba % 68)=(GeoTabela.id_pietro);
SET STATISTICS TIME OFF


SET STATISTICS TIME ON
SELECT COUNT(*)
FROM Milion
INNER JOIN GeoTabela ON (Milion.liczba % 68) = GeoTabela.id_pietro
INNER JOIN GeoEpoka ON GeoTabela.id_epoka = GeoEpoka.id_epoka
INNER JOIN GeoOkres ON GeoEpoka.id_okres = GeoOkres.id_okres
INNER JOIN GeoEra ON GeoOkres.id_era = GeoEra.id_era
INNER JOIN GeoEon ON GeoEra.id_eon = GeoEon.id_eon;
SET STATISTICS TIME OFF

SET STATISTICS TIME ON
SELECT COUNT(*) 
FROM Milion 
WHERE Milion.liczba % 68 = 
    (SELECT id_pietro 
     FROM GeoTabela 
     WHERE Milion.liczba % 68 = id_pietro);
SET STATISTICS TIME OFF

SET STATISTICS TIME ON
SELECT COUNT(*) 
FROM Milion 
WHERE Milion.liczba % 68 = (
    SELECT GeoPietro.id_pietro 
    FROM GeoPietro 
    JOIN GeoEpoka ON GeoPietro.id_epoka = GeoEpoka.id_epoka
    JOIN GeoOkres ON GeoEpoka.id_okres = GeoOkres.id_okres
    JOIN GeoEra ON GeoOkres.id_era = GeoEra.id_era
    JOIN GeoEon ON GeoEra.id_eon = GeoEon.id_eon
);
SET STATISTICS TIME OFF



CREATE INDEX idxEon ON geo.GeoEon(id_eon);
CREATE INDEX idxEra ON geo.GeoEra(id_era, id_eon);
CREATE INDEX idxOkres ON geo.GeoOkres(id_okres, id_era);
CREATE INDEX idxEpoka ON geo.GeoEpoka(id_epoka, id_okres);
CREATE INDEX idxPietro ON geo.GeoPietro(id_pietro, id_epoka);
CREATE INDEX idxLiczba ON Milion(liczba);
CREATE INDEX idxGeoTabela ON GeoTabela(id_pietro, id_epoka, id_era, id_okres,id_eon);