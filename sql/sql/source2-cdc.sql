USE SinoPacBank;
GO

EXEC sys.sp_cdc_enable_db
GO

EXEC sys.sp_cdc_enable_table
@source_schema = N'dbo',
@source_name   = N'BatchDeliveryPool',
@role_name     = NULL
GO

