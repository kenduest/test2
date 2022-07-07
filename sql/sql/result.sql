CREATE DATABASE Brobridge;
GO

USE Brobridge;
GO

CREATE TABLE DeliveryLog (
	ID		INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
	SerialNum	BIGINT NOT NULL,
	CreateTime	DATETIME,
	ExpireTime 	INT, 
	DepID      	VARCHAR(8),
	MsgType    	VARCHAR(5),
	Memo       	VARCHAR(40),	
	SenderID   	VARCHAR(15),
	Bu		CHAR(6),	
	Company		CHAR(6)	,
	Channel		CHAR(16),
	Reference	char(64)
);

GO

