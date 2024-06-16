-- 1. Napisz zapytanie, które wykorzystuje transakcjê (zaczyna j¹), a nastêpnie
-- aktualizuje cenê produktu o ProductID równym 680 w tabeli Production.Product
-- o 10% i nastêpnie zatwierdza transakcjê.

BEGIN TRANSACTION
  UPDATE Production.Product SET ListPrice = ListPrice*1.1
  WHERE ProductID = 680;
  COMMIT;

  SELECT * FROM [AdventureWorks2019].[Production].[Product] WHERE ProductID = 680;




--2. Napisz zapytanie, które zaczyna transakcjê, usuwa produkt o ProductID równym
--707 z tabeli Production. Product, ale nastêpnie wycofuje transakcjê.

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




--3. Napisz zapytanie, które zaczyna transakcjê, dodaje nowy produkt do tabeli
--Production.Product, a nastêpnie zatwierdza transakcjê.

BEGIN TRANSACTION;
INSERT INTO Production.Product (Name, ProductNumber, Color, SafetyStockLevel, ReorderPoint, 
    StandardCost, ListPrice, DaysToManufacture, SellStartDate)
VALUES ('Sports Shorts, S', 'GF-E12N-87', 'BLACK', 90, 55, 12.00, 21.00, 1, '2021-07-01 00:00:00.000');
COMMIT TRANSACTION;

SELECT * FROM [AdventureWorks2019].[Production].[Product] WHERE ProductNumber = 'GF-E12N-87';




