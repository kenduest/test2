
USE TestDB
GO
SELECT name, is_cdc_enabled FROM sys.databases;
GO

SELECT name, is_tracked_by_cdc FROM sys.tables WHERE object_id = object_id(N'users');
GO


