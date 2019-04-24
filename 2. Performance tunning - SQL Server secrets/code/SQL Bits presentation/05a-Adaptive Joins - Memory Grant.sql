------------------------------------------------
-- Adaptive Query Plans - Adaptive Joins
-- ------------------------------------------------------
-- Adaptive Joins

USE WideWorldImporters
GO
SET STATISTICS IO ON
GO
-- ---------------------------------
-- SQL Server 2014
ALTER DATABASE [WideWorldImporters] 
SET COMPATIBILITY_LEVEL = 120
GO
DECLARE @StockItemID  INT
--SET @StockItemID = 168
SET @StockItemID = 226
SELECT	ol.OrderID,ol.StockItemID,ol.Description,
		ol.OrderLineID,
		o.Comments, o.CustomerID
FROM Sales.OrderLines ol 
INNER JOIN Sales.Orders o ON ol.OrderID = o.OrderID
WHERE ol.StockItemID = @StockItemID
GO
-- ---------------------------------
-- SQL Server 2016
ALTER DATABASE [WideWorldImporters] 
SET COMPATIBILITY_LEVEL = 130
GO
DECLARE @StockItemID  INT
--SET @StockItemID = 168
SET @StockItemID = 226
SELECT	ol.OrderID,ol.StockItemID,ol.Description,
		ol.OrderLineID,
		o.Comments, o.CustomerID
FROM Sales.OrderLines ol 
INNER JOIN Sales.Orders o ON ol.OrderID = o.OrderID
WHERE ol.StockItemID = @StockItemID
GO
-- ---------------------------------
-- SQL Server 2017
ALTER DATABASE [WideWorldImporters] 
SET COMPATIBILITY_LEVEL = 140
GO
DECLARE @StockItemID  INT
--SET @StockItemID = 168
SET @StockItemID = 226
SELECT	ol.OrderID,ol.StockItemID,ol.Description,
		ol.OrderLineID,
		o.Comments, o.CustomerID
FROM Sales.OrderLines ol 
INNER JOIN Sales.Orders o ON ol.OrderID = o.OrderID
WHERE ol.StockItemID = @StockItemID
GO
-- --------------------------------------------------------
-- Memory Grant Feedback
-- --------------------------------------------------------
DECLARE @StockItemID  INT
--SET @StockItemID = 168
SET @StockItemID = 226
SELECT	ol.OrderID,ol.StockItemID,ol.Description,
		ol.OrderLineID,
		o.Comments, o.CustomerID
FROM Sales.OrderLines ol 
INNER JOIN Sales.Orders o ON ol.OrderID = o.OrderID
WHERE ol.StockItemID = @StockItemID
GO
-- --------------------------------------------------------
-- Show Plan Compare Demo (NO T SQL)
-- --------------------------------------------------------