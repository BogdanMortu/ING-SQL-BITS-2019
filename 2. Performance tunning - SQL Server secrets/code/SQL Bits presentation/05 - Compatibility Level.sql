USE WideWorldImporters
GO

-- SQL Server 2012
SET STATISTICS IO ON
ALTER DATABASE WideWorldImporters
SET COMPATIBILITY_LEVEL = 110
GO

SELECT *
FROM sales.Invoices i
INNER JOIN sales.InvoiceLines il on i.InvoiceID = il.InvoiceID
where i.AccountsPersonID = 2001 
	and i.DeliveryMethodID = 3


/*
Compatibility LEVEL
*/

-- SQL Server 2014
SET STATISTICS IO ON
ALTER DATABASE WideWorldImporters
SET COMPATIBILITY_LEVEL = 120
GO

SELECT *
FROM sales.Invoices i
INNER JOIN sales.InvoiceLines il on i.InvoiceID = il.InvoiceID
where i.AccountsPersonID = 2001 
	and i.DeliveryMethodID = 3


-- SQL Server 2016
SET STATISTICS IO ON
ALTER DATABASE WideWorldImporters
SET COMPATIBILITY_LEVEL = 130
GO

SELECT *
FROM sales.Invoices i
INNER JOIN sales.InvoiceLines il on i.InvoiceID = il.InvoiceID
where i.AccountsPersonID = 2001 
	and i.DeliveryMethodID = 3

-- SQL Server 2017
SET STATISTICS IO ON
ALTER DATABASE WideWorldImporters
SET COMPATIBILITY_LEVEL = 140
GO

SELECT *
FROM sales.Invoices i
INNER JOIN sales.InvoiceLines il on i.InvoiceID = il.InvoiceID
where i.AccountsPersonID = 2001 
	and i.DeliveryMethodID = 3