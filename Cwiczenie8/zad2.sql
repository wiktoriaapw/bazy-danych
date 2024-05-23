USE AdventureWorksLT2019;

WITH PrzychodSprzedaz AS (

SELECT c.CompanyName AS CompanyContact, h.TotalDue AS Revenue
  FROM SalesLT.Customer AS c
  INNER JOIN SalesLT.SalesOrderHeader AS h ON c.CustomerID = h.CustomerID
)
SELECT * FROM PrzychodSprzedaz
ORDER BY CompanyContact;