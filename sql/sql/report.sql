CREATE DATABASE mbroker; 
GO

USE mbroker;
GO

create table send
(
    uid                 uniqueidentifier not null constraint pk_send primary key,
    event_code          varchar(25),
    way_name            varchar(50)  not null,
    send_from           tinyint      not null,
    send_time           datetime2    not null,
    expire_time         datetime2    not null,
    template_code       varchar(25),
    template_max_length smallint,
    send_mode           char         not null,
    limit_mode          tinyint,
    mod_reply           tinyint      not null default 0, 
    status              int          not null,
    priority            tinyint      not null,
    msg_type            varchar(5)   not null,
    req_department      varchar(12)  not null,
    req_bu              varchar(6),
    req_company         varchar(6),
    req_channel         varchar(16)                                not null,
    req_object_id       varchar(36),
    req_batch_id        varchar(64),
    memo                nvarchar(40),
    create_time         datetime2,
    create_user         uniqueidentifier,
    update_time         datetime2,
    update_user         uniqueidentifier,
    completed_time      datetime2,
    canceled_time       datetime2,
    update_expired_time datetime2
)
go

create table send_record
(
    uid                 uniqueidentifier not null constraint pk_send_record primary key,
    send_uid            uniqueidentifier not null,
    way_name            varchar(12)      not null,
    serial_number       int              not null default 0,
    send_time           datetime2        not null,
    expire_time         datetime2        not null,
    customer_id         varchar(20),
    customer_phone      varchar(20),
    customer_reference  varchar(64),
    req_group_id        varchar(36),
    req_uid             varchar(36),
    content             nvarchar(1000)   not null,
    return_code         varchar(10),
    calc_section        tinyint,
    sending_section     tinyint,
    section             tinyint,
    success_section     tinyint,
    failure_section     tinyint,
    section_status_list varchar(50),
    is_long             tinyint,
    is_international    tinyint,
    msg_id              varchar(50),
    actual_send_time    datetime2,
    actual_send_phone   varchar(20),
    gateway_id          int,
    status              tinyint	not null          default 0, 
    resp_code           varchar(5),
    gwrecvat            char(14),
    acceptat            char(14),
    sendat              char(14),
    finish_time         datetime2,
    meta                nvarchar(1000),
    create_time         datetime2,
    update_time         datetime2,
    deliver_time        datetime2,
    dr_time             datetime2,
    canceled_time       datetime2,
    update_expired_time datetime2
)
go


create table send_record_reply
(
    uid                uniqueidentifier not null constraint pk_send_record_reply primary key,
    send_record_uid    uniqueidentifier,
    customer_id        varchar(20),
    customer_phone     varchar(20),
    customer_reference varchar(64),
    tx_date            varchar(8),
    tx_time            varchar(6),
    event_code         varchar(25),
    return_code        nvarchar(25),
    create_time        datetime2,
    update_time        datetime2,
    reply_content      nvarchar(500)                              not null,
    reply_time         datetime2,
    status             tinyint,
    gateway_id         int,
    code               varchar(10)
)

go

CREATE DATABASE SinoPacBank;
GO

USE SinoPacBank;
GO


CREATE TABLE DeliveryResultLog (
	UID			BIGINT IDENTITY(1,1) PRIMARY KEY,
	DeliveryPoolUID		BIGINT NOT NULL,
	DeliverySendUID		UNIQUEIDENTIFIER,
	CreateTime		DATETIME DEFAULT SYSDATETIME(),
	Status			TINYINT
);

GO

