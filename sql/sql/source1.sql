
CREATE DATABASE smsdb;
GO

USE smsdb;
GO


-- 即時或是一般簡訊 

CREATE TABLE DeliveryPool (
	UID		UNIQUEIDENTIFIER DEFAULT NEWSEQUENTIALID() PRIMARY KEY,
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

