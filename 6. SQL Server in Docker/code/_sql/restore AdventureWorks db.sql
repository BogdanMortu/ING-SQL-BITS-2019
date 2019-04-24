USE [master]
RESTORE DATABASE [AdventureWorks2017]
FROM DISK = N'/sql/AdventureWorks2017.bak'
WITH FILE = 1,
MOVE N'AdventureWorks2017' TO N'/var/opt/mssql/data/AdventureWorks.mdf',
MOVE N'AdventureWorks2017_log' TO N'/var/opt/mssql/data/AdventureWorks_log.ldf',
NOUNLOAD, STATS = 5
GO

--------------------------------------------------------------------------------

USE [master]
RESTORE DATABASE [AdventureWorks2016] FROM  
DISK = N'/var/opt/mssql/backup/AdventureWorks2016.bak' 
WITH  FILE = 1,  
MOVE N'AdventureWorks2016_Data' TO N'/var/opt/mssql/data/AdventureWorks2016_Data.mdf',  
MOVE N'AdventureWorks2016_Log' TO N'/var/opt/mssql/data/AdventureWorks2016_Log.ldf',  
NOUNLOAD,  STATS = 5

GO