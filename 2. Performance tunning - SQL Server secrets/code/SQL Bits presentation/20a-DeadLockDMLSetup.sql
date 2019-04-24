--------------------------------------------------------
-- Deadlock DML
--------------------------------------------------------
USE master;
GO
IF DATABASEPROPERTYEX ('TestDb', 'Version') > 0 
DROP DATABASE TestDB;
GO 
CREATE DATABASE TestDb;
GO
USE TestDb
GO
-- First Table
CREATE TABLE FirstTable (ID INT, 
						FirstName VARCHAR(100), 
						LastName VARCHAR(100), 
						City VARCHAR(100))
GO
-- Insert One Hundred Thousand Records
-- INSERT 1
INSERT INTO FirstTable (ID,FirstName,LastName,City)
SELECT TOP 10000 ROW_NUMBER() OVER (ORDER BY a.name) RowID, 
					'Bob', 
					CASE WHEN  ROW_NUMBER() OVER (ORDER BY a.name)%2 = 1 THEN 'Smith' 
					ELSE 'Brown' END,
					CASE WHEN ROW_NUMBER() OVER (ORDER BY a.name)%10 = 1 THEN 'New York' 
						WHEN  ROW_NUMBER() OVER (ORDER BY a.name)%10 = 5 THEN 'San Marino' 
						WHEN  ROW_NUMBER() OVER (ORDER BY a.name)%10 = 3 THEN 'Los Angeles' 
					ELSE 'Houston' END
FROM sys.all_objects a
CROSS JOIN sys.all_objects b
GO

----------------------------------------------------
USE master
GO
ALTER DATABASE TestDB
SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO
DROP DATABASE TestDB
GO