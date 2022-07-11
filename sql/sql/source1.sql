CREATE DATABASE SinoPacBank;
GO

USE SinoPacBank;
GO


-- 即時或是一般簡訊 

CREATE TABLE DeliveryPool (
	UID		BIGINT IDENTITY(1,1) PRIMARY KEY,
        SerialNum       INT,
        MPhoneNum       VARCHAR(10) NOT NULL,
        MsgData         VARCHAR(4000) NOT NULL,
        Priority        TINYINT NOT NULL,
        BookingTime     DATETIME NOT NULL,
        ExpireTime      INT,
        DepID           VARCHAR(8) NOT NULL,
        MsgType         VARCHAR(5) NOT NULL,
        Memo            VARCHAR(40),
        SenderID        VARCHAR(15) NOT NULL,
        Bu              VARCHAR(6),
        Company         VARCHAR(6) NOT NULL,
        Channel         VARCHAR(16) NOT NULL,
        Reference       VARCHAR(64),
	GroupID		VARCHAR(36),
	ObjectID	VARCHAR(36)
);

GO

-- 放置一般簡訊送到 API 失敗時候能夠定期重送的資訊記錄

CREATE TABLE DeliveryUnhandleDeliveryPool (
	DeliveryPoolUID	BIGINT NOT NULL,	
	CreateTime	DATETIME DEFAULT SYSDATETIME(),
	FOREIGN KEY(DeliveryPoolUID) REFERENCES DeliveryPool(UID)
);

GO

-- Delivery Log
-- 放置一般簡訊送到 API 溝通歷史資訊記錄

CREATE TABLE DeliveryResultLog (
	UID			BIGINT IDENTITY(1,1) PRIMARY KEY,
	DeliveryPoolUID		BIGINT NOT NULL,
	DeliverySendUID		UNIQUEIDENTIFIER,
	CreateTime		DATETIME DEFAULT SYSDATETIME(),
	Status			TINYINT,
);

GO

