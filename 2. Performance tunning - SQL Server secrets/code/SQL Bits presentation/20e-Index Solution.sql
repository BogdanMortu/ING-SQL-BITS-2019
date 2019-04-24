-- Creating index on Table
USE TestDB
GO
-- CREATE CLUSTERED INDEX IX_DL0 ON FirstTable (ID);
CREATE NONCLUSTERED INDEX IX_DL1 ON FirstTable (FirstName, LastName);
--CREATE NONCLUSTERED INDEX IX_DL2 ON FirstTable (FirstName);
--CREATE NONCLUSTERED INDEX IX_DL3 ON FirstTable (City);

-- DROP index on Table
DROP INDEX IX_DL0 ON FirstTable;
DROP INDEX IX_DL1 ON FirstTable;
DROP INDEX IX_DL2 ON FirstTable;
DROP INDEX IX_DL3 ON FirstTable;
