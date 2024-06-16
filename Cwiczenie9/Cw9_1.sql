-- 1. Napisz zapytanie, kt�re wykorzystuje transakcj� (zaczyna j�), a nast�pnie
-- aktualizuje cen� produktu o ProductID r�wnym 680 w tabeli Production.Product
-- o 10% i nast�pnie zatwierdza transakcj�.

BEGIN TRANSACTION
  UPDATE Production.Product SET ListPrice = ListPrice*1.1
  WHERE ProductID = 680;
  COMMIT;

  SELECT * FROM [AdventureWorks2019].[Production].[Product] WHERE ProductID = 680;




--2. Napisz zapytanie, kt�re zaczyna transakcj�, usuwa produkt o ProductID r�wnym
--707 z tabeli Production. Product, ale nast�pnie wycofuje transakcj�.

BEGIN TRANSACTION;
BEGIN TRY
    DELETE Production.Product WHERE ProductID = 707;
    COMMIT TRANSACTION;
	PRINT 'Produkt zostal usuniety.'
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'Transakcje wycofano.';
END CATCH;




--3. Napisz zapytanie, kt�re zaczyna transakcj�, dodaje nowy produkt do tabeli
--Production.Product, a nast�pnie zatwierdza transakcj�.

BEGIN TRANSACTION;
INSERT INTO Production.Product (Name, ProductNumber, Color, SafetyStockLevel, ReorderPoint, 
    StandardCost, ListPrice, DaysToManufacture, SellStartDate)
VALUES ('Sports Shorts, S', 'GF-E12N-87', 'BLACK', 90, 55, 12.00, 21.00, 1, '2021-07-01 00:00:00.000');
COMMIT TRANSACTION;

SELECT * FROM [AdventureWorks2019].[Production].[Product] WHERE ProductNumber = 'GF-E12N-87';




