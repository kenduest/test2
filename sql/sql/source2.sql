
CREATE DATABASE Brobridge;
GO

USE Brobridge;
GO

-- BATCH Delivery
-- For Batch

CREATE TABLE DeliveryPool (
	UID		uniqueidentifier NOT NULL DEFAULT NEWSEQUENTIALID() PRIMARY KEY,
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
	ObjectID	VARCHAR(36),
	BatchID		VARCHAR(36)
);

GO

-- 放置一般簡訊送到 API 失敗時候能夠定期重送的資訊記錄

CREATE TABLE DeliveryUHandleDeliveryPool (
	UID			BIGINT IDENTITY(1,1) PRIMARY KEY,
	DeliveryPoolUID		UNIQUEIDENTIFIER NOT NULL,	
	CreateTime		DATETIME2 DEFAULT SYSDATETIME(),
	FOREIGN KEY(DeliveryPoolUID) REFERENCES DeliveryPool(UID)
);

GO

-- 放置一般簡訊送到 Kernel DB 溝通資訊記錄

CREATE TABLE ReplicationResultLog (
	UID			BIGINT IDENTITY(1,1) PRIMARY KEY,
	DeliveryPoolUID		UNIQUEIDENTIFIER NOT NULL,
	CreateTime		DATETIME2 DEFAULT SYSDATETIME(),
	Status			TINYINT
	FOREIGN KEY(DeliveryPoolUID) REFERENCES DeliveryPool(UID)
);

