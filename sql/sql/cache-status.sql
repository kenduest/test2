
USE Brobridge
GO

SELECT name, is_cdc_enabled FROM sys.databases where name='Brobridge'; 
GO

USE Brobridge
GO

SELECT name, is_tracked_by_cdc FROM sys.tables WHERE object_id = object_id(N'DeliveryPool');
GO


