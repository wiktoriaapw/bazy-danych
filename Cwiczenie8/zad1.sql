--Wykorzystuj�c wyra�enie CTE zbuduj zapytanie, kt�re znajdzie informacje na temat stawki 
--pracownika oraz jego danych, a nast�pnie zapisze je do tabeli tymczasowej 
--TempEmployeeInfo

USE AdventureWorks2019;


WITH PracownikInfo AS (
SELECT e.BusinessEntityID, p.FirstName, p.LastName, h.Rate
  FROM HumanResources.EmployeePayHistory AS h
  INNER JOIN HumanResources.Employee AS e ON h.BusinessEntityID = e.BusinessEntityID
  INNER JOIN Person.Person AS p ON e.BusinessEntityID = p.BusinessEntityID
)

SELECT *
INTO TempEmployeeInfo
FROM PracownikInfo;

SELECT * FROM TempEmployeeInfo;