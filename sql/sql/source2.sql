
CREATE DATABASE SinoPacBank;
GO

USE SinoPacBank;
GO

-- BATCH Delivery
-- For Batch

CREATE TABLE BatchDeliveryPool (
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
	ObjectID	VARCHAR(36),
	BatchID		VARCHAR(36)
);

GO

-- 放置一般簡訊送到 API 失敗時候能夠定期重送的資訊記錄

CREATE TABLE BatchDeliveryUnhandleDeliveryPool (
	DeliveryPoolUID		BIGINT NOT NULL PRIMARY KEY,	
	CreateTime		DATETIME2 DEFAULT SYSDATETIME(),
	FOREIGN KEY(DeliveryPoolUID) REFERENCES BatchDeliveryPool(UID)
);

GO

