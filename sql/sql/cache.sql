CREATE DATABASE SinoPacBank;
GO

USE SinoPacBank;
GO


-- 即時或是一般簡訊 

CREATE TABLE SI_SinoPacBank(
	UID		uniqueidentifier NOT NULL PRIMARY KEY,
	GUID       	char(36)	NOT NULL,
	MPhoneNum  	varchar(10)	NOT NULL,
	MsgData    	varchar(1000),	
	Priority   	tinyint,
	BookingTime	datetime,
	ExpireTime 	int,
	DepID      	varchar(8),
	MsgType    	varchar(5),
	Memo       	varchar(40),
	SenderID   	varchar(15),
	Bu         	char(6),
	Company    	char(6),
	Channel    	char(16),
	Reference  	char(64)
);

GO


CREATE TABLE MsgInfo(
	UID		uniqueidentifier NOT NULL PRIMARY KEY,
	GroupID     	varchar(10),
	UserName    	varchar(20),
	SourceType  	char(1),
	ObjectID    	varchar(36),
	SerialNo    	varchar(36)	NOT NULL,
	DestNo      	varchar(20),
	DestName    	varchar(36),
	DestCategory	char(8),
	MsgType     	char(1),
	MsgData     	varchar(1000),
	DelegateTime	char(14),
	SubmitTime  	char(14),
	OrderID     	varchar(20)	NOT NULL,
	MID         	varchar(5)	NOT NULL,
	OrderTime   	char(14),
	ExpireTime  	char(14)	NOT NULL,
	StatusFlag  	char(1),
	SubmitFlag  	varchar(3),
	StatusTime  	char(14),
	BatchCode   	varchar(64),
	Filler      	varchar(5)
);

GO

CREATE TABLE MsgMo(
	UID		uniqueidentifier NOT NULL PRIMARY KEY,
	SerialNo   	char(36) NOT NULL,
	ReceiveTime	char(14),
	MID        	char(10),
	DestNo     	char(20),
	MsgData    	varchar(256)
);

GO

