USE mbroker;
GO

EXEC sys.sp_cdc_enable_db
GO

EXEC sys.sp_cdc_enable_table
@source_schema = N'dbo',
@source_name   = N'send',
@role_name     = NULL
GO

EXEC sys.sp_cdc_enable_table
@source_schema = N'dbo',
@source_name   = N'send_record',
@role_name     = NULL
GO


EXEC sys.sp_cdc_enable_table
@source_schema = N'dbo',
@source_name   = N'send_record_reply',
@role_name     = NULL
GO

EXEC sys.sp_cdc_enable_table
@source_schema = N'dbo',
@source_name   = N'SI_SinoPacBank',
@role_name     = NULL
GO

EXEC sys.sp_cdc_enable_table
@source_schema = N'dbo',
@source_name   = N'MsgInfo',
@role_name     = NULL
GO

EXEC sys.sp_cdc_enable_table
@source_schema = N'dbo',
@source_name   = N'MsgMo',
@role_name     = NULL
GO
