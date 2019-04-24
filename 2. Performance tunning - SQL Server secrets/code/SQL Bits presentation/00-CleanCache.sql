-- ------------------------------------------------------
-- Script 00: How to Clear the Cache?
-- ------------------------------------------------------
-- Older Method
DBCC FREEPROCCACHE
GO
-- Newer Method
ALTER DATABASE SCOPED CONFIGURATION CLEAR PROCEDURE_CACHE
GO