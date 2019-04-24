-- ------------------------------------------------------
-- Script 12a: What is the impact of functions on query performance? (Where clause) 
-- ------------------------------------------------------
/*
In this example we will see effect of UDF on Index
We observe how performance degrades with UDF and what is the solution to resolve the issue
*/
-- --------------------------------------------------------------------------
-- Set Up
SET STATISTICS IO ON
USE tempdb
GO
-- Create Table
CREATE TABLE UDFEffect (ID INT, 
						FirstName VARCHAR(100), 
						LastName VARCHAR(100), 
						City VARCHAR(100),
						CreateDatatime DATETIME)
GO
-- Insert One Hundred Thousand Records
INSERT INTO UDFEffect (ID, FirstName, LastName, City, CreateDatatime)
SELECT TOP 100000 ROW_NUMBER() OVER (ORDER BY a.name) RowID, 
					'Bob', 
					CASE WHEN  ROW_NUMBER() OVER (ORDER BY a.name)%2 = 1 THEN 'Smith' 
					ELSE 'Brown' END,
					CASE WHEN ROW_NUMBER() OVER (ORDER BY a.name)%10 = 1 THEN 'New York' 
						WHEN  ROW_NUMBER() OVER (ORDER BY a.name)%10 = 5 THEN 'San Marino' 
						WHEN  ROW_NUMBER() OVER (ORDER BY a.name)%10 = 3 THEN 'Los Angeles' 
						WHEN ROW_NUMBER() OVER (ORDER BY a.name)%421 = 1 THEN 'Seattle'
						WHEN ROW_NUMBER() OVER (ORDER BY a.name)%5021 = 1 THEN '   Seattle   '
					ELSE 'Houston' END,
					CASE WHEN ROW_NUMBER() OVER (ORDER BY a.name)%10 = 1 THEN GETDATE()-10
						WHEN  ROW_NUMBER() OVER (ORDER BY a.name)%10 = 5 THEN GETDATE()-5
						WHEN  ROW_NUMBER() OVER (ORDER BY a.name)%10 = 3 THEN GETDATE()-3 
						WHEN ROW_NUMBER() OVER (ORDER BY a.name)%421 = 1 THEN GETDATE()+1
					ELSE GETDATE() END
FROM sys.all_objects a
CROSS JOIN sys.all_objects b
GO

-- Create Indexes 
-- Create Clustered Index
CREATE CLUSTERED INDEX IX_UDFEffect_ID
ON UDFEffect(ID)
GO

/* Enable execution plan using CTRL + M
OR 
Menu >> Query >> Include Actual Execution Plan
*/

---------------------------------------------------------------------
-- Index Scan due to Function Usage in WHERE - DATE
---------------------------------------------------------------------
-- Scan or seek?
SELECT ID, City, CreateDatatime
FROM UDFEffect
WHERE DATEDIFF(MINUTE,CreateDatatime,GETDATE()) < 0
GO








-- Create Index
CREATE NONCLUSTERED INDEX [IX_UDFEffect_CreateDatatime_Cover]
ON [dbo].[UDFEffect] ([CreateDatatime])
INCLUDE ([City])
GO






-- Scan Again or seek again 
SELECT ID, City, CreateDatatime
FROM UDFEffect
WHERE DATEDIFF(MINUTE,CreateDatatime,GETDATE()) < 0
GO







-- Convert Scan to Seek
SELECT ID, City, CreateDatatime
FROM UDFEffect
WHERE CreateDatatime > GETDATE()
GO

-- Clean Up
DROP TABLE UDFEffect
GO