SET STATISTICS IO ON
GO
USE AdventureWorks2014
GO

IF EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID (N'[dbo].vw_ViewLimit1'))
	DROP VIEW [dbo].[vw_ViewLimit1]
GO

CREATE VIEW vw_ViewLimit1
AS
	SELECT SalesOrderID
	, SalesOrderDetailID
	, CarrierTrackingNumber
	, OrderQty
	, sod.ProductID
	, SpecialOfferID
	, UnitPrice
	, UnitPriceDiscount
	, LineTotal
	, ReferenceOrderID
	FROM sales.SalesOrderDetail sod
	INNER JOIN Production.TransactionHistory th on sod.SalesOrderID = th.ReferenceOrderID
	WHERE SalesOrderDetailID > 111111
GO

-- Filter View with WHERE condition
SELECT *
FROM vw_ViewLimit1
WHERE SalesOrderDetailID > 111111
GO
SELECT *
FROM vw_ViewLimit1
GO
-- Which will run faster ??

-- Regular SELECT statement with WHERE condition
SELECT SalesOrderID
, SalesOrderDetailID
, CarrierTrackingNumber
, OrderQty
, sod.ProductID
, SpecialOfferID
, UnitPrice
, UnitPriceDiscount
, LineTotal
, ReferenceOrderID
FROM sales.SalesOrderDetail sod
INNER JOIN Production.TransactionHistory th on sod.SalesOrderID = th.ReferenceOrderID
WHERE SalesOrderDetailID > 111111
GO


-- we need to add one more column to the view

-- select with extra column
SELECT SalesOrderID
, SalesOrderDetailID
, CarrierTrackingNumber
, OrderQty
, sod.ProductID
, SpecialOfferID
, UnitPrice
, UnitPriceDiscount
, LineTotal
, ReferenceOrderID
, th.Quantity
FROM sales.SalesOrderDetail sod
INNER JOIN Production.TransactionHistory th on sod.SalesOrderID = th.ReferenceOrderID
WHERE SalesOrderDetailID > 111111
GO

-- view with extra column

SELECT v1.SalesOrderID
, v1.SalesOrderDetailID
, v1.CarrierTrackingNumber
, v1.OrderQty
, v1.ProductID
, v1.SpecialOfferID
, v1.UnitPrice
, v1.UnitPriceDiscount
, v1.LineTotal
, v1.ReferenceOrderID
, th.Quantity
FROM vw_ViewLimit1 v1
INNER JOIN Production.TransactionHistory th on v1.SalesOrderID = th.ReferenceOrderID
WHERE SalesOrderDetailID > 111111
GO

-- how to fix it without changing the view
drop index IX_RightNOW
ON sales.SalesOrderDetail
CREATE NONCLUSTERED INDEX IX_RightNOW
ON sales.SalesOrderDetail (SalesOrderDetailID)
INCLUDE (SalesOrderID
, CarrierTrackingNumber
, OrderQty
, ProductID
, SpecialOfferID
, UnitPrice
, UnitPriceDiscount
, LineTotal)

/*
Add distinct keywork ?!?
*/

SELECT DISTINCT SalesOrderID
, SalesOrderDetailID
, CarrierTrackingNumber
, OrderQty
, sod.ProductID
, SpecialOfferID
, UnitPrice
, UnitPriceDiscount
, LineTotal
, ReferenceOrderID
, th.Quantity
FROM sales.SalesOrderDetail sod
INNER JOIN Production.TransactionHistory th on sod.SalesOrderID = th.ReferenceOrderID
WHERE SalesOrderDetailID > 111111
GO

-- view with extra column

SELECT DISTINCT v1.SalesOrderID
, v1.SalesOrderDetailID
, v1.CarrierTrackingNumber
, v1.OrderQty
, v1.ProductID
, v1.SpecialOfferID
, v1.UnitPrice
, v1.UnitPriceDiscount
, v1.LineTotal
, v1.ReferenceOrderID
, th.Quantity
FROM vw_ViewLimit1 v1
INNER JOIN Production.TransactionHistory th on v1.SalesOrderID = th.ReferenceOrderID
WHERE SalesOrderDetailID > 111111
GO
