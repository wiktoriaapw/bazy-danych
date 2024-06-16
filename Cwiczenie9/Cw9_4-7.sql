---
BEGIN TRANSACTION;
	  UPDATE Production.Product SET StandardCost = StandardCost*1.1;
	  DECLARE @suma DECIMAL(10, 2);
	  SELECT @suma = SUM(StandardCost) FROM Production.Product;
	  IF @suma <= 50000 
		  BEGIN
			COMMIT;
		  END
	  ELSE 
		  BEGIN
			  ROLLBACK TRANSACTION;
			  PRINT 'Transakcja odrzucona';
		  END



----

BEGIN TRANSACTION;
	DECLARE @temp INT;
	DECLARE @pnumb VARCHAR(20) = 'HK-Y56N-98' 
	SELECT @temp = COUNT(*) FROM Production.Product WHERE ProductNumber = @pnumb; 
	IF @temp = 0
	BEGIN
		INSERT INTO Production.Product (Name, ProductNumber, Color, SafetyStockLevel, ReorderPoint, StandardCost, ListPrice, DaysToManufacture, SellStartDate)
		VALUES ('Helmet', @pnumb, 'Red', 100, 75, 10.00, 20.00, 1, '2011-05-31 00:00:00.000');
		COMMIT;
	END
	ELSE
	BEGIN
		ROLLBACK TRANSACTION;
		PRINT 'Produkt nie zostal dodany, poniewaz taki ProductNumber jest juz w bazie.'
	END



----

BEGIN TRANSACTION;

UPDATE Sales.SalesOrderDetail SET OrderQty = OrderQty - 1;

DECLARE @zero INT;
SELECT @zero = COUNT(*) FROM Sales.SalesOrderDetail WHERE OrderQty = 0;

IF @zero > 0
BEGIN
    ROLLBACK TRANSACTION;
    PRINT 'Transakcje anulowano, poniewaz OrderQty = 0.';
END
ELSE
BEGIN
    COMMIT;
    PRINT 'Transakcja wykonana.';
END


SELECT * FROM Sales.SalesOrderDetail WHERE OrderQty = 0;

-----

BEGIN TRANSACTION;
	DECLARE @avgcost DECIMAL (8, 2)
	DECLARE @del INT;
	SELECT @avgcost = AVG(StandardCost) FROM Production.Product;
	SELECT @del = COUNT(*) FROM Production.Product WHERE StandardCost > @avgcost; 
	IF @del <= 10
	BEGIN
		DELETE Production.Product WHERE StandardCost > @avgcost;
		COMMIT;
		PRINT 'Tarnsakcja wykonana. Produkty zostaly usuniete.';
	END
	ELSE
	BEGIN
		ROLLBACK TRANSACTION;
		PRINT 'Transakcja anulowana. Liczba produktow do usuniecia wynosi: '+ CAST(@del AS VARCHAR(10));
	END