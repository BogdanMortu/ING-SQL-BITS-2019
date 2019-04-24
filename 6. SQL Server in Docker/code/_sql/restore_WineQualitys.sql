USE [master]
RESTORE DATABASE [WineQuality]
FROM DISK = N'/sql/WineQuality.bak'
WITH FILE = 1,
MOVE N'WineQuality' TO N'/var/opt/mssql/data/WineQuality.mdf',
MOVE N'WineQuality_log' TO N'/var/opt/mssql/data/WineQuality_log.ldf',
NOUNLOAD, STATS = 5
GO