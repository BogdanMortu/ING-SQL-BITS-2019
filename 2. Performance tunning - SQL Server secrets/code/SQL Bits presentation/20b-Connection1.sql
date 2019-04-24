--------------------------------------------------------
-- Connection 1:
--------------------------------------------------------
USE TestDB
GO

-- Connection 1:
-- Begin Transaction
BEGIN TRAN
-- Update Statement
UPDATE FirstTable 
SET City = 'Seattle'
WHERE City = 'New York';
GO

--ROLLBACK
GO

