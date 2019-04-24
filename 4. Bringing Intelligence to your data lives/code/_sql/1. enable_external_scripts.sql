EXEC sp_configure "external scripts enabled", 1
GO
RECONFIGURE
GO


--restart the server

--start SQL Server Launchpad service

--Good to go! let's test it!