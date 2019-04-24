-- ------------------------------------------------------
-- Script 12c: Challenge - Don't Change the Code -- Fix Query Performance
-- ------------------------------------------------------
/*
One Rule: Fix the Query Performance without changing query code or data inside table.
*/
-- --------------------------------------------------------------------------
-- Set Up
SET STATISTICS IO ON
USE tempdb
GO
-- Create Table
IF OBJECT_ID('dbo.UDFEffect', 'U') IS NOT NULL 
  DROP TABLE dbo.UDFEffect; 

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

CREATE NONCLUSTERED INDEX [IX_UDFEffect_City]
ON [dbo].[UDFEffect] ([City])
GO

/* Enable execution plan using CTRL + M
OR 
Menu >> Query >> Include Actual Execution Plan
*/

---------------------------------------------------------------------
-- Index Scan due to Function Usage in WHERE - TRIM
---------------------------------------------------------------------
-- Get all the records where city is Seattle (Ignore spaces)

-- Seek - Incorrect Answer
SELECT ID, City
FROM UDFEffect
WHERE City = 'Seattle'
GO

-- Scan - Correct Answer
SELECT ID, City
FROM UDFEffect
WHERE RTRIM(LTRIM(City)) = 'Seattle'
GO

-- Seek - Wrong Thinking - Incorrect Answer
SELECT ID, City
FROM UDFEffect
WHERE City = RTRIM(LTRIM('   Seattle'))
GO











/* Adding Computed Column can solve the performance degradation problem.*/

-- Add Computed Column
ALTER TABLE dbo.UDFEffect ADD
	CityTrim  AS RTRIM(LTRIM(City))
GO

-- ? - Correct Answer
SELECT ID, City
FROM UDFEffect
WHERE CityTrim = 'Seattle'
GO

-- Create non clustered index on Computed Column
CREATE NONCLUSTERED INDEX IX_UDFEffect_CityTrim
ON UDFEffect (CityTrim, City)
GO

-- Seek - Correct Answer
SELECT ID, City
FROM UDFEffect
WHERE CityTrim = 'Seattle'
GO

-- How computed columns improves performance
-- ? - Correct Answer 
SELECT ID, City
FROM UDFEffect
WHERE RTRIM(LTRIM(City)) = 'Seattle'
GO



-- Original Query
SELECT ID, City
FROM UDFEffect
WHERE City = 'Seattle'
GO

/* Observation : Usage of UDF can reduce performance, 
	incorporating UDF logic into Computed Column and 
	creating Index on that column improves performance. */

-- Clean up Database
DROP TABLE UDFEffect
GO