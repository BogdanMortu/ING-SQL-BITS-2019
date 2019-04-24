-- ------------------------------------------------------
-- Script 21: How IMPLICIT conversion can kill database performance?
-- ------------------------------------------------------

/*
Implicit conversion often reduces the performance of the query.
Let us see how we can overcome the performance issue.
*/
--- Create a sample table
USE tempdb 
GO 

IF OBJECT_ID('orders', 'U') IS NOT NULL BEGIN
	DROP TABLE orders 
END
GO

CREATE TABLE orders (OrderID INT IDENTITY, 
					OrderDate DATETIME, 
					Amount MONEY, 
					Refno VARCHAR(20))
INSERT INTO orders (OrderDate, Amount, Refno) 
SELECT TOP 100000
	DATEADD(minute, ABS(a.object_id % 50000 ), CAST('2010-02-01' AS DATETIME)),
	ABS(a.object_id % 10),
	CAST(ABS(a.object_id) AS VARCHAR)
FROM sys.all_objects a
CROSS JOIN sys.all_objects b
GO
INSERT INTO orders (OrderDate, Amount, Refno)  SELECT GETDATE(), 100, '555'
GO

SELECT TOP 10 * 
FROM orders 
GO

CREATE NONCLUSTERED INDEX idx_refno ON orders(refno)
INCLUDE(amount)
GO

-- CTRL + M
-- Query 1
SELECT COUNT(*) 
FROM orders 
WHERE Refno = 555 
GO 
-- Query 2
SELECT COUNT(*) 
FROM orders 
WHERE Refno = '555'
GO




-- Run query in another window to check implecity conversion



-- Change the Datatype

DROP INDEX idx_refno ON Orders
ALTER TABLE Orders ALTER COLUMN Refno INT
GO

CREATE NONCLUSTERED INDEX idx_refno ON orders(refno)
INCLUDE(amount)
GO

-- CTRL + M
-- Query 1
SELECT COUNT(*) 
FROM orders 
WHERE Refno = 555 
GO
-- Query 2
SELECT COUNT(*) 
FROM orders 
WHERE Refno = '555'
GO

-- Data Type Precedence (Transact-SQL)
-- https://msdn.microsoft.com/en-us/library/ms190309.aspx