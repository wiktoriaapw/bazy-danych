-- 1. Napisz procedur� wypisuj�c� do konsoli ci�g Fibonacciego. Procedura musi przyjmowa� jako 
--argument wej�ciowy liczb� n. Generowanie ci�gu Fibonacciego musi zosta� 
--zaimplementowane jako osobna funkcja, wywo�ywana przez procedur� 

CREATE SCHEMA oblicz;
GO

CREATE FUNCTION oblicz.Fib(@n INT)
RETURNS INT
AS
BEGIN

    DECLARE @wynik BIGINT;

    IF @n <= 0
        SET @wynik = 0;
    ELSE IF @n = 1
        SET @wynik = 1;
    ELSE
    BEGIN

        DECLARE @f1 BIGINT = 0;
        DECLARE @f2 BIGINT = 1;
        DECLARE @i INT = 2;

        WHILE @i <= @n
        BEGIN
            SET @wynik = @f1 + @f2;
            SET @f1 = @f2;
            SET @f2 = @wynik;
            SET @i = @i + 1;
        END
    END
    RETURN @wynik;
END;
GO
--osobna funkcja na generowanie
CREATE PROCEDURE oblicz.PoliczonyFib(@n INT)
AS
BEGIN

    DECLARE @i INT = 0;
    DECLARE @liczbaFib INT;

    WHILE @i <= @n
    BEGIN
        SET @liczbaFib = oblicz.Fib(@i);
        PRINT 'Liczba ciagu Fibonacciego na pozycji ' + CAST(@i AS VARCHAR(30)) + ' to ' + CAST(@liczbaFib AS VARCHAR(30));
        SET @i = @i + 1;
    END
END;
GO

EXEC oblicz.PoliczonyFib @n = 10;


-- 2 Napisz trigger DML, kt�ry po wprowadzeniu danych do tabeli Persons zmodyfikuje nazwisko tak, aby by�o napisane du�ymi literami. 

CREATE TRIGGER mod_Nazwisko

  ON Person.Person
  AFTER INSERT
  AS
  BEGIN
      UPDATE Person.Person SET LastName = UPPER(LastName)
  END;

  SELECT * FROM Person.Person WHERE BusinessEntityID = 3006;

  INSERT INTO Person.Person (BusinessEntityID, PersonType, NameStyle, Title, FirstName, MiddleName, LastName, Suffix, 
	EmailPromotion, AdditionalContactInfo, ModifiedDate)
	VALUES (3006, 'IN', 0, 'NULL', 'adam', 'jakub', 'nowak', NULL, 1, NULL, 2008-01-24);

SELECT * FROM Person.Person WHERE BusinessEntityID = 201;

  -- 3 Przygotuj trigger �taxRateMonitoring�, kt�ry wy�wietli komunikat o b��dzie, je�eli nast�pi 
--zmiana warto�ci w polu �TaxRate� o wi�cej ni� 30%

  CREATE TRIGGER taxRateMonitoring

  ON Sales.SalesTaxRate
  AFTER INSERT, UPDATE, DELETE
  AS
  BEGIN

    DECLARE @nowyTAX SMALLMONEY, @staryTAX SMALLMONEY;
    SELECT @nowyTAX = TaxRate FROM inserted;
    SELECT @staryTAX = TaxRate FROM deleted;

    IF @nowyTAX > @staryTAX*1.3 OR @nowyTAX < @staryTAX*0.7
    BEGIN
        PRINT 'B�AD';
        ROLLBACK;
    End
  END;

  SELECT * FROM Sales.SalesTaxRate;

  UPDATE Sales.SalesTaxRate SET TaxRate = TaxRate*1.4