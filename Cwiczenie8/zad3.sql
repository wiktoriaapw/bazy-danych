--Napisz zapytanie, które zwróci wartoœæ sprzeda¿y dla poszczególnych kategorii produktów.
--Wykorzystaj CTE i bazê AdventureWorksLT.

USE AdventureWorksLT2019;

WITH Sprzedaz AS (
  SELECT pc.Name AS Category, o.UnitPrice 

  FROM SalesLT.ProductCategory AS pc

  INNER JOIN SalesLT.Product AS p ON p.ProductCategoryID = pc.ProductCategoryID

  INNER JOIN SalesLT.SalesOrderDetail AS o ON p.ProductID = o.ProductID

)
SELECT Category, SUM(UnitPrice) AS SalesValue
FROM Sprzedaz

GROUP BY Category;

