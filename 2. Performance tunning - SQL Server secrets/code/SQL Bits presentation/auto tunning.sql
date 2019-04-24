/*
Automatic tunning
*/ 

USE WideWorldImporters
GO

-- Clear procedure Cache
ALTER DATABASE SCOPED CONFIGURATION CLEAR PROCEDURE_CACHE
GO
-- Clear Query Store
ALTER DATABASE current SET QUERY_STORE CLEAR ALL
GO
DROP PROCEDURE MyNewSP
GO

CREATE OR ALTER PROCEDURE MyNewSP
@PackageTypeID INT
AS

SELECT SUM(UnitPrice*Quantity) [TotalPrice],
	   AVG(UnitPrice * Quantity) [AvegarePrice]
FROM Sales.InvoiceLines
WHERE PackageTypeID = @PackageTypeID
GO

/* Runnig queries again  CTRL + M here*/
-- clear cache
-- parameter sniffing .. Is there one thing you can do to fix parameter sniffing ?
ALTER DATABASE SCOPED CONFIGURATION CLEAR PROCEDURE_CACHE
GO

EXEC MyNewSP 7
GO 50

-- clear cache
ALTER DATABASE SCOPED CONFIGURATION CLEAR PROCEDURE_CACHE
GO
EXEC MyNewSP 1
GO
-- Assume we run 1 once in a while
EXEC MyNewSP 7
GO 50
-- what is the solution ?




-- recompile the procedure


-- OR


ALTER DATABASE WideWorldImporters
SET AUTOMATIC_TUNING ( FORCE_LAST_GOOD_PLAN = ON)

-- Clear procedure Cache
ALTER DATABASE SCOPED CONFIGURATION CLEAR PROCEDURE_CACHE
GO
-- try again :D
EXEC MyNewSP 1
GO
-- Assume we run 1 once in a while
EXEC MyNewSP 7
GO 50

-- Clean up
ALTER DATABASE WideWorldImporters
SET AUTOMATIC_TUNING ( FORCE_LAST_GOOD_PLAN = OFF)