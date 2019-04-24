--------------------------------------------------------
-- Connection 2:
--------------------------------------------------------
USE TestDB
GO

-- Connection 2:
SELECT FirstName, LastName
FROM FirstTable
WHERE FirstName = 'Bob' AND LastName = 'Brown';
GO




























-- With Nolock
SELECT FirstName, LastName
FROM FirstTable WITH (NOLOCK)
WHERE FirstName = 'Bob' AND LastName = 'Brown';
GO