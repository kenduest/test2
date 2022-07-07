create table apps
(
    uid              uniqueidentifier  not null
        constraint pk_apps
            primary key,
    code             varchar(32)       not null,
    name             nvarchar(100)     not null,
    client_id        varchar(32)       not null,
    client_secret    varchar(32)       not null,
    api_key          varchar(1024),
    allow_ip         varchar(500),
    allow_ip_enabled tinyint default 0 not null,
    aud_service      varchar(20),
    create_time      datetime2,
    create_user      uniqueidentifier,
    update_time      datetime2,
    update_user      uniqueidentifier,
    deleted          tinyint default 0 not null,
    delete_time      datetime2,
    delete_user      uniqueidentifier
)
go

exec sp_addextendedproperty 'MS_Description', '應用程式表', 'SCHEMA', 'dbo', 'TABLE', 'apps'
go

exec sp_addextendedproperty 'MS_Description', 'PK', 'SCHEMA', 'dbo', 'TABLE', 'apps', 'COLUMN', 'uid'
go

exec sp_addextendedproperty 'MS_Description', '應用程式代碼', 'SCHEMA', 'dbo', 'TABLE', 'apps', 'COLUMN', 'code'
go

exec sp_addextendedproperty 'MS_Description', '應用程式名稱', 'SCHEMA', 'dbo', 'TABLE', 'apps', 'COLUMN', 'name'
go

exec sp_addextendedproperty 'MS_Description', 'Client ID', 'SCHEMA', 'dbo', 'TABLE', 'apps', 'COLUMN', 'client_id'
go

exec sp_addextendedproperty 'MS_Description', 'Client Secret', 'SCHEMA', 'dbo', 'TABLE', 'apps', 'COLUMN',
     'client_secret'
go

exec sp_addextendedproperty 'MS_Description', 'API Key', 'SCHEMA', 'dbo', 'TABLE', 'apps', 'COLUMN', 'api_key'
go

exec sp_addextendedproperty 'MS_Description', '允許的IP名單。 多筆 IP 以逗號分隔。\n包含 IPv4 及 IPv6', 'SCHEMA', 'dbo', 'TABLE', 'apps',
     'COLUMN', 'allow_ip'
go

exec sp_addextendedproperty 'MS_Description', '是否啟用 IP 白名單判斷。 0 不啟用，1 啟用。', 'SCHEMA', 'dbo', 'TABLE', 'apps', 'COLUMN',
     'allow_ip_enabled'
go

exec sp_addextendedproperty 'MS_Description', '受理此 ApiKey 的服務名稱。如：message-api, deliver-api', 'SCHEMA', 'dbo', 'TABLE',
     'apps', 'COLUMN', 'aud_service'
go

exec sp_addextendedproperty 'MS_Description', '是否已刪除。0未刪除，1已刪除。', 'SCHEMA', 'dbo', 'TABLE', 'apps', 'COLUMN', 'deleted'
go

create index idx_apps_code
    on apps (code)
go

create index idx_apps_client_id
    on apps (client_id)
go

create index idx_apps_deleted
    on apps (deleted)
go

create table auth_signin_token
(
    uid           uniqueidentifier  not null
        constraint pk_auth_signin_token
            primary key,
    users_uid     uniqueidentifier  not null,
    id_token      varchar(max)      not null,
    access_token  varchar(max)      not null,
    refresh_token char(32),
    expired_time  datetime2,
    valid         tinyint default 1 not null,
    create_time   datetime2,
    update_time   datetime2
)
go

exec sp_addextendedproperty 'MS_Description', 'PK', 'SCHEMA', 'dbo', 'TABLE', 'auth_signin_token', 'COLUMN', 'uid'
go

exec sp_addextendedproperty 'MS_Description', '用戶鍵值', 'SCHEMA', 'dbo', 'TABLE', 'auth_signin_token', 'COLUMN',
     'users_uid'
go

exec sp_addextendedproperty 'MS_Description', 'ID token', 'SCHEMA', 'dbo', 'TABLE', 'auth_signin_token', 'COLUMN',
     'id_token'
go

exec sp_addextendedproperty 'MS_Description', 'Access Token', 'SCHEMA', 'dbo', 'TABLE', 'auth_signin_token', 'COLUMN',
     'access_token'
go

exec sp_addextendedproperty 'MS_Description', 'Refresh Token', 'SCHEMA', 'dbo', 'TABLE', 'auth_signin_token', 'COLUMN',
     'refresh_token'
go

exec sp_addextendedproperty 'MS_Description', 'Refresh token 的過期時間', 'SCHEMA', 'dbo', 'TABLE', 'auth_signin_token',
     'COLUMN', 'expired_time'
go

exec sp_addextendedproperty 'MS_Description', '是否有效。0失效，1有效。\n登出時更新為0。', 'SCHEMA', 'dbo', 'TABLE', 'auth_signin_token',
     'COLUMN', 'valid'
go

exec sp_addextendedproperty 'MS_Description', '建立時間', 'SCHEMA', 'dbo', 'TABLE', 'auth_signin_token', 'COLUMN',
     'create_time'
go

exec sp_addextendedproperty 'MS_Description', '更新時間', 'SCHEMA', 'dbo', 'TABLE', 'auth_signin_token', 'COLUMN',
     'update_time'
go

create index idx_auth_signin_token_refresh_token
    on auth_signin_token (refresh_token)
go

create table authority
(
    uid      uniqueidentifier not null
        constraint pk_authority
            primary key,
    code     varchar(50)      not null,
    name     nvarchar(50)     not null,
    seq      int default 0    not null,
    apply_to varchar(12)      not null
)
go

exec sp_addextendedproperty 'MS_Description', '系統權限項目主表', 'SCHEMA', 'dbo', 'TABLE', 'authority'
go

exec sp_addextendedproperty 'MS_Description', 'PK', 'SCHEMA', 'dbo', 'TABLE', 'authority', 'COLUMN', 'uid'
go

exec sp_addextendedproperty 'MS_Description', '權限代碼 (唯一不重覆)', 'SCHEMA', 'dbo', 'TABLE', 'authority', 'COLUMN', 'code'
go

exec sp_addextendedproperty 'MS_Description', '權限名稱', 'SCHEMA', 'dbo', 'TABLE', 'authority', 'COLUMN', 'name'
go

exec sp_addextendedproperty 'MS_Description', '排序順位', 'SCHEMA', 'dbo', 'TABLE', 'authority', 'COLUMN', 'seq'
go

exec sp_addextendedproperty 'MS_Description', '適用於。portal, api', 'SCHEMA', 'dbo', 'TABLE', 'authority', 'COLUMN',
     'apply_to'
go

create unique index unq_authority_code
    on authority (code)
go

create table channel_0
(
    send_record_uid uniqueidentifier not null
        constraint pk_channel_0
            primary key,
    send_uid        uniqueidentifier not null,
    way_name        varchar(12)      not null,
    send_time       datetime2        not null,
    status          tinyint          not null,
    priority        tinyint          not null,
    expire_time     datetime2        not null,
    phone           varchar(20),
    content         nvarchar(1000)   not null,
    limit_mode      tinyint,
    msg_type        varchar(5)       not null,
    req_department  varchar(12)      not null,
    req_channel     varchar(16)      not null,
    req_group_id    varchar(36),
    req_object_id   varchar(36),
    meta            nvarchar(1000),
    create_time     datetime2
)
go

exec sp_addextendedproperty 'MS_Description', '存放等待發送的訊息，供 kernel 進行發送，會有多個相同結構的資料表做分流', 'SCHEMA', 'dbo', 'TABLE',
     'channel_0'
go

exec sp_addextendedproperty 'MS_Description', '鍵值。與對應的 send_record.uid 同值。\n[range/list] n/a', 'SCHEMA', 'dbo', 'TABLE',
     'channel_0', 'COLUMN', 'send_record_uid'
go

exec sp_addextendedproperty 'MS_Description', '發送記錄鍵值', 'SCHEMA', 'dbo', 'TABLE', 'channel_0', 'COLUMN', 'send_uid'
go

exec sp_addextendedproperty 'MS_Description', '[definition] 發送機制\n[range/list] n/a\n[example] SMS\n[reference]  n/a',
     'SCHEMA', 'dbo', 'TABLE', 'channel_0', 'COLUMN', 'way_name'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 排定可發送的時間\n[range/list] n/a\n[example] 2023-01-02 14:01:22\n[reference]  n/a', 'SCHEMA', 'dbo',
     'TABLE', 'channel_0', 'COLUMN', 'send_time'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 處理狀態，處理完畢後，會從此表移除該筆紀錄\n[range/list] 0:待處理 1:處理中  2:失敗(deliver無回應或回應server-error)\n[example] 0\n[reference]  n/a',
     'SCHEMA', 'dbo', 'TABLE', 'channel_0', 'COLUMN', 'status'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 發送優先值，值越小越高\n[range/list] 最小值為1\n[example] 1\n[reference]  n/a', 'SCHEMA', 'dbo', 'TABLE',
     'channel_0', 'COLUMN', 'priority'
go

exec sp_addextendedproperty 'MS_Description', '訊息過期時間。超過這個時間就不發送。', 'SCHEMA', 'dbo', 'TABLE', 'channel_0', 'COLUMN',
     'expire_time'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 客戶電話號碼。國際簡訊輸入國碼+手機號碼，如：8613400000001。\n[range/list] n/a\n[example] 0910123456\n[reference]  n/a',
     'SCHEMA', 'dbo', 'TABLE', 'channel_0', 'COLUMN', 'phone'
go

exec sp_addextendedproperty 'MS_Description', '[definition] 訊息內容\n[range/list] n/a\n[example] n/a\n[reference]  n/a',
     'SCHEMA', 'dbo', 'TABLE', 'channel_0', 'COLUMN', 'content'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 啟用勿擾模式\n[range/list] null: 未啟用 0:不使用 1:限制早上發送\n[example] 1\n[reference]  n/a', 'SCHEMA', 'dbo',
     'TABLE', 'channel_0', 'COLUMN', 'limit_mode'
go

exec sp_addextendedproperty 'MS_Description', '[definition] 訊息型態。\n[range/list] n/a\n[example] 1\n[reference] n/a',
     'SCHEMA', 'dbo', 'TABLE', 'channel_0', 'COLUMN', 'msg_type'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 發送部門代碼(掛帳單位)\n[range/list] n/a\n[example] 1\n[reference] n/a', 'SCHEMA', 'dbo', 'TABLE', 'channel_0',
     'COLUMN', 'req_department'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 發送來源 / 系統。系統代號, 如T24主機系統(TWT24), ES7K, MMA系統(MMA)\n[range/list] n/a\n[example] 2023-03-25 16:58:02\n[reference] n/a',
     'SCHEMA', 'dbo', 'TABLE', 'channel_0', 'COLUMN', 'req_channel'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 發送代號(銀行自編KEY)。對應到簡訊商API的 DestName。\n[range/list] n/a\n[example]  n/a\n[reference]  n/a', 'SCHEMA',
     'dbo', 'TABLE', 'channel_0', 'COLUMN', 'req_group_id'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 發送來源的專案代號\n[range/list] n/a\n[example] 2023-03-25 16:58:02\n[reference] n/a', 'SCHEMA', 'dbo',
     'TABLE', 'channel_0', 'COLUMN', 'req_object_id'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 參數欄位，為JSON格式\n[range/list] n/a\n[example] n/a\n[reference]  n/a', 'SCHEMA', 'dbo', 'TABLE',
     'channel_0', 'COLUMN', 'meta'
go

exec sp_addextendedproperty 'MS_Description', '建立時間。', 'SCHEMA', 'dbo', 'TABLE', 'channel_0', 'COLUMN', 'create_time'
go

create index idx_channel_0_wayname_sendtime_status_priority
    on channel_0 (way_name, send_time, status, priority)
go

create index idx_channel_0_send_uid
    on channel_0 (send_uid)
go

create table channel_1
(
    send_record_uid uniqueidentifier not null
        constraint pk_channel_1
            primary key,
    send_uid        uniqueidentifier not null,
    way_name        varchar(12)      not null,
    send_time       datetime2        not null,
    status          tinyint          not null,
    priority        tinyint          not null,
    expire_time     datetime2        not null,
    phone           varchar(20),
    content         nvarchar(1000)   not null,
    limit_mode      tinyint,
    msg_type        varchar(5)       not null,
    req_department  varchar(12)      not null,
    req_channel     varchar(16)      not null,
    req_group_id    varchar(36),
    req_object_id   varchar(36),
    meta            nvarchar(1000),
    create_time     datetime2
)
go

exec sp_addextendedproperty 'MS_Description', '存放等待發送的訊息，供 kernel 進行發送，會有多個相同結構的資料表做分流', 'SCHEMA', 'dbo', 'TABLE',
     'channel_1'
go

exec sp_addextendedproperty 'MS_Description', '鍵值。與對應的 send_record.uid 同值。\n[range/list] n/a', 'SCHEMA', 'dbo', 'TABLE',
     'channel_1', 'COLUMN', 'send_record_uid'
go

exec sp_addextendedproperty 'MS_Description', '發送記錄鍵值', 'SCHEMA', 'dbo', 'TABLE', 'channel_1', 'COLUMN', 'send_uid'
go

exec sp_addextendedproperty 'MS_Description', '[definition] 發送機制\n[range/list] n/a\n[example] SMS\n[reference]  n/a',
     'SCHEMA', 'dbo', 'TABLE', 'channel_1', 'COLUMN', 'way_name'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 排定可發送的時間\n[range/list] n/a\n[example] 2023-01-02 14:01:22\n[reference]  n/a', 'SCHEMA', 'dbo',
     'TABLE', 'channel_1', 'COLUMN', 'send_time'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 處理狀態，處理完畢後，會從此表移除該筆紀錄\n[range/list] 0:待處理 1:處理中   2:失敗(deliver無回應或回應server-error)\n[example] 0\n[reference]  n/a',
     'SCHEMA', 'dbo', 'TABLE', 'channel_1', 'COLUMN', 'status'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 發送優先值，值越小越高\n[range/list] 最小值為1\n[example] 1\n[reference]  n/a', 'SCHEMA', 'dbo', 'TABLE',
     'channel_1', 'COLUMN', 'priority'
go

exec sp_addextendedproperty 'MS_Description', '訊息過期時間。超過這個時間就不發送。', 'SCHEMA', 'dbo', 'TABLE', 'channel_1', 'COLUMN',
     'expire_time'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 客戶電話號碼。國際簡訊輸入國碼+手機號碼，如：8613400000001。\n[range/list] n/a\n[example] 0910123456\n[reference]  n/a',
     'SCHEMA', 'dbo', 'TABLE', 'channel_1', 'COLUMN', 'phone'
go

exec sp_addextendedproperty 'MS_Description', '[definition] 訊息內容\n[range/list] n/a\n[example] n/a\n[reference]  n/a',
     'SCHEMA', 'dbo', 'TABLE', 'channel_1', 'COLUMN', 'content'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 啟用勿擾模式\n[range/list] null: 未啟用 0:不使用 1:限制早上發送\n[example] 1\n[reference]  n/a', 'SCHEMA', 'dbo',
     'TABLE', 'channel_1', 'COLUMN', 'limit_mode'
go

exec sp_addextendedproperty 'MS_Description', '[definition] 訊息型態。\n[range/list] n/a\n[example] 1\n[reference] n/a',
     'SCHEMA', 'dbo', 'TABLE', 'channel_1', 'COLUMN', 'msg_type'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 發送部門代碼(掛帳單位)\n[range/list] n/a\n[example] 1\n[reference] n/a', 'SCHEMA', 'dbo', 'TABLE', 'channel_1',
     'COLUMN', 'req_department'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 發送來源 / 系統。系統代號, 如T24主機系統(TWT24), ES7K, MMA系統(MMA)\n[range/list] n/a\n[example] 2023-03-25 16:58:02\n[reference] n/a',
     'SCHEMA', 'dbo', 'TABLE', 'channel_1', 'COLUMN', 'req_channel'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 發送代號(銀行自編KEY)。對應到簡訊商API的 DestName。\n[range/list] n/a\n[example]  n/a\n[reference]  n/a', 'SCHEMA',
     'dbo', 'TABLE', 'channel_1', 'COLUMN', 'req_group_id'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 發送來源的專案代號\n[range/list] n/a\n[example] 2023-03-25 16:58:02\n[reference] n/a', 'SCHEMA', 'dbo',
     'TABLE', 'channel_1', 'COLUMN', 'req_object_id'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 參數欄位，為JSON格式\n[range/list] n/a\n[example] n/a\n[reference]  n/a', 'SCHEMA', 'dbo', 'TABLE',
     'channel_1', 'COLUMN', 'meta'
go

exec sp_addextendedproperty 'MS_Description', '建立時間', 'SCHEMA', 'dbo', 'TABLE', 'channel_1', 'COLUMN', 'create_time'
go

create index idx_channel_1_wayname_sendtime_status_priority
    on channel_1 (way_name, send_time, status, priority)
go

create index idx_channel_1_send_uid
    on channel_1 (send_uid)
go

create table company
(
    uid         uniqueidentifier  not null
        constraint pk_company
            primary key,
    code        varchar(12)       not null,
    name        nvarchar(20)      not null,
    create_time datetime2,
    create_user uniqueidentifier,
    update_time datetime2,
    update_user uniqueidentifier,
    deleted     tinyint default 0 not null,
    delete_time datetime2,
    delete_user uniqueidentifier
)
go

exec sp_addextendedproperty 'MS_Description', '公司主檔', 'SCHEMA', 'dbo', 'TABLE', 'company'
go

exec sp_addextendedproperty 'MS_Description', 'PK', 'SCHEMA', 'dbo', 'TABLE', 'company', 'COLUMN', 'uid'
go

exec sp_addextendedproperty 'MS_Description', '公司代碼', 'SCHEMA', 'dbo', 'TABLE', 'company', 'COLUMN', 'code'
go

exec sp_addextendedproperty 'MS_Description', '公司名稱', 'SCHEMA', 'dbo', 'TABLE', 'company', 'COLUMN', 'name'
go

create index idx_company_code
    on company (code)
go

create index idx_company_deleted
    on company (deleted)
go

create table department
(
    uid         uniqueidentifier  not null
        constraint pk_department
            primary key,
    code        varchar(12)       not null,
    name        nvarchar(20)      not null,
    create_time datetime2,
    create_user uniqueidentifier,
    update_time datetime2,
    update_user uniqueidentifier,
    deleted     tinyint default 0 not null,
    delete_time datetime2,
    delete_user uniqueidentifier
)
go

exec sp_addextendedproperty 'MS_Description', '業務單位主表', 'SCHEMA', 'dbo', 'TABLE', 'department'
go

exec sp_addextendedproperty 'MS_Description', 'PK', 'SCHEMA', 'dbo', 'TABLE', 'department', 'COLUMN', 'uid'
go

exec sp_addextendedproperty 'MS_Description', '部門代碼', 'SCHEMA', 'dbo', 'TABLE', 'department', 'COLUMN', 'code'
go

exec sp_addextendedproperty 'MS_Description', '部門名稱', 'SCHEMA', 'dbo', 'TABLE', 'department', 'COLUMN', 'name'
go

create table blacklist
(
    uid            uniqueidentifier  not null
        constraint pk_blacklist
            primary key,
    customer_phone varchar(20)       not null,
    customer_id    varchar(20),
    customer_name  nvarchar(20),
    department_uid uniqueidentifier  not null
        constraint fk_blacklist_department
            references department,
    memo           nvarchar(100),
    enabled        tinyint default 1 not null,
    create_time    datetime2,
    create_user    uniqueidentifier,
    update_time    datetime2,
    update_user    uniqueidentifier,
    deleted        tinyint default 0 not null,
    delete_time    datetime2,
    delete_user    uniqueidentifier
)
go

exec sp_addextendedproperty 'MS_Description', '黑名單管理', 'SCHEMA', 'dbo', 'TABLE', 'blacklist'
go

exec sp_addextendedproperty 'MS_Description', 'PK', 'SCHEMA', 'dbo', 'TABLE', 'blacklist', 'COLUMN', 'uid'
go

exec sp_addextendedproperty 'MS_Description', '客戶門號', 'SCHEMA', 'dbo', 'TABLE', 'blacklist', 'COLUMN', 'customer_phone'
go

exec sp_addextendedproperty 'MS_Description', '客戶身份證字號', 'SCHEMA', 'dbo', 'TABLE', 'blacklist', 'COLUMN', 'customer_id'
go

exec sp_addextendedproperty 'MS_Description', '客戶姓名', 'SCHEMA', 'dbo', 'TABLE', 'blacklist', 'COLUMN', 'customer_name'
go

exec sp_addextendedproperty 'MS_Description', '業務部門鍵值。', 'SCHEMA', 'dbo', 'TABLE', 'blacklist', 'COLUMN',
     'department_uid'
go

exec sp_addextendedproperty 'MS_Description', '備註。加入原因。', 'SCHEMA', 'dbo', 'TABLE', 'blacklist', 'COLUMN', 'memo'
go

exec sp_addextendedproperty 'MS_Description', '是否啟用', 'SCHEMA', 'dbo', 'TABLE', 'blacklist', 'COLUMN', 'enabled'
go

create index idx_blacklist_customer_phone
    on blacklist (customer_phone)
go

create index idx_blacklist_customer_id
    on blacklist (customer_id)
go

create index idx_blacklist_customer_name
    on blacklist (customer_name)
go

create index idx_blacklist_deleted
    on blacklist (deleted)
go

create index idx_department_code
    on department (code)
go

create index idx_department_deleted
    on department (deleted)
go

create table fields
(
    uid         uniqueidentifier  not null
        constraint pk_vars
            primary key,
    name        varchar(50)       not null,
    max_length  smallint          not null,
    memo        nvarchar(100),
    deletable   tinyint default 1 not null,
    create_time datetime2,
    create_user uniqueidentifier,
    update_time datetime2,
    update_user uniqueidentifier,
    deleted     tinyint default 0 not null,
    delete_time datetime2,
    delete_user uniqueidentifier
)
go

exec sp_addextendedproperty 'MS_Description', '樣版參數管理', 'SCHEMA', 'dbo', 'TABLE', 'fields'
go

exec sp_addextendedproperty 'MS_Description', '變數名稱', 'SCHEMA', 'dbo', 'TABLE', 'fields', 'COLUMN', 'name'
go

exec sp_addextendedproperty 'MS_Description', '變數資料長度上限', 'SCHEMA', 'dbo', 'TABLE', 'fields', 'COLUMN', 'max_length'
go

exec sp_addextendedproperty 'MS_Description', '備註說明', 'SCHEMA', 'dbo', 'TABLE', 'fields', 'COLUMN', 'memo'
go

exec sp_addextendedproperty 'MS_Description', '是否可被刪除。 0不可刪除，1可刪除', 'SCHEMA', 'dbo', 'TABLE', 'fields', 'COLUMN',
     'deletable'
go

create index idx_vars_deleted
    on fields (deleted)
go

create table log_operation
(
    uid             uniqueidentifier default newsequentialid() not null
        constraint pk_log_operation
            primary key,
    users_uid       uniqueidentifier                           not null,
    user_id         varchar(50)                                not null,
    user_name       nvarchar(10),
    department_code varchar(12),
    department_name nvarchar(50),
    function_name   varchar(50)                                not null,
    action_name     varchar(12)                                not null,
    text            nvarchar(200),
    before_data     nvarchar(max),
    after_data      nvarchar(max),
    create_time     datetime2,
    client_ip       varchar(15)
)
go

exec sp_addextendedproperty 'MS_Description', '系統功能操作記錄表', 'SCHEMA', 'dbo', 'TABLE', 'log_operation'
go

exec sp_addextendedproperty 'MS_Description', 'PK', 'SCHEMA', 'dbo', 'TABLE', 'log_operation', 'COLUMN', 'uid'
go

exec sp_addextendedproperty 'MS_Description', '操作者鍵值', 'SCHEMA', 'dbo', 'TABLE', 'log_operation', 'COLUMN', 'users_uid'
go

exec sp_addextendedproperty 'MS_Description', '操作者員工號', 'SCHEMA', 'dbo', 'TABLE', 'log_operation', 'COLUMN', 'user_id'
go

exec sp_addextendedproperty 'MS_Description', '操作者姓名', 'SCHEMA', 'dbo', 'TABLE', 'log_operation', 'COLUMN', 'user_name'
go

exec sp_addextendedproperty 'MS_Description', '部門代碼', 'SCHEMA', 'dbo', 'TABLE', 'log_operation', 'COLUMN',
     'department_code'
go

exec sp_addextendedproperty 'MS_Description', '操作者所屬部門名稱', 'SCHEMA', 'dbo', 'TABLE', 'log_operation', 'COLUMN',
     'department_name'
go

exec sp_addextendedproperty 'MS_Description', '功能項目名稱(代碼)', 'SCHEMA', 'dbo', 'TABLE', 'log_operation', 'COLUMN',
     'function_name'
go

exec sp_addextendedproperty 'MS_Description', '執行動作名稱(代碼)', 'SCHEMA', 'dbo', 'TABLE', 'log_operation', 'COLUMN',
     'action_name'
go

exec sp_addextendedproperty 'MS_Description', '操作記錄文字內容(操作行為描述)', 'SCHEMA', 'dbo', 'TABLE', 'log_operation', 'COLUMN',
     'text'
go

exec sp_addextendedproperty 'MS_Description', '異動前的資料內容。JSON格式，key為資料表欄位名稱。', 'SCHEMA', 'dbo', 'TABLE', 'log_operation',
     'COLUMN', 'before_data'
go

exec sp_addextendedproperty 'MS_Description', '異動後的資料內容。JSON格式，key為資料表欄位名稱。', 'SCHEMA', 'dbo', 'TABLE', 'log_operation',
     'COLUMN', 'after_data'
go

exec sp_addextendedproperty 'MS_Description', '連線IP', 'SCHEMA', 'dbo', 'TABLE', 'log_operation', 'COLUMN', 'client_ip'
go

create index idx_log_operation_user_id
    on log_operation (user_id)
go

create index idx_log_operation_create_time
    on log_operation (create_time)
go

create index idx_log_operation_function_name
    on log_operation (function_name)
go

create index idx_log_operation_department_code
    on log_operation (department_code)
go

create table resource
(
    uid         uniqueidentifier  not null
        constraint pk_resource
            primary key,
    name        nvarchar(100)     not null,
    alt_name    nvarchar(100),
    path        nvarchar(1024)    not null,
    mime_type   varchar(256),
    create_time datetime2,
    create_user uniqueidentifier,
    update_time datetime2,
    update_user uniqueidentifier,
    deleted     tinyint default 0 not null,
    delete_time datetime2,
    delete_user uniqueidentifier
)
go

exec sp_addextendedproperty 'MS_Description', '資源檔案主表', 'SCHEMA', 'dbo', 'TABLE', 'resource'
go

exec sp_addextendedproperty 'MS_Description', 'PK', 'SCHEMA', 'dbo', 'TABLE', 'resource', 'COLUMN', 'uid'
go

exec sp_addextendedproperty 'MS_Description', '資源檔案名稱', 'SCHEMA', 'dbo', 'TABLE', 'resource', 'COLUMN', 'name'
go

exec sp_addextendedproperty 'MS_Description', '替代名稱', 'SCHEMA', 'dbo', 'TABLE', 'resource', 'COLUMN', 'alt_name'
go

exec sp_addextendedproperty 'MS_Description', '資源檔案存放路徑', 'SCHEMA', 'dbo', 'TABLE', 'resource', 'COLUMN', 'path'
go

exec sp_addextendedproperty 'MS_Description', 'MIME-TYPE', 'SCHEMA', 'dbo', 'TABLE', 'resource', 'COLUMN', 'mime_type'
go

create index idx_resource_deleted
    on resource (deleted)
go

create table return_code
(
    customer_phone varchar(25)  not null
        constraint pk_return_code
            primary key,
    return_code    nvarchar(25) not null,
    update_time    datetime2
)
go

create table role
(
    uid         uniqueidentifier  not null
        constraint pk_role
            primary key,
    name        nvarchar(50)      not null,
    memo        nvarchar(100),
    authority   varchar(1000),
    create_time datetime2,
    create_user uniqueidentifier,
    update_time datetime2,
    update_user uniqueidentifier,
    deleted     tinyint default 0 not null,
    delete_time datetime2,
    delete_user uniqueidentifier
)
go

exec sp_addextendedproperty 'MS_Description', '帳號角色主表', 'SCHEMA', 'dbo', 'TABLE', 'role'
go

exec sp_addextendedproperty 'MS_Description', 'PK', 'SCHEMA', 'dbo', 'TABLE', 'role', 'COLUMN', 'uid'
go

exec sp_addextendedproperty 'MS_Description', '角色名稱', 'SCHEMA', 'dbo', 'TABLE', 'role', 'COLUMN', 'name'
go

exec sp_addextendedproperty 'MS_Description', '描述備註', 'SCHEMA', 'dbo', 'TABLE', 'role', 'COLUMN', 'memo'
go

exec sp_addextendedproperty 'MS_Description',
     '權限設定。JSON格式。\n格式示意：[ { code, permission } ]\ncode：對應 authority.code \npermission：readable, editable, none。',
     'SCHEMA', 'dbo', 'TABLE', 'role', 'COLUMN', 'authority'
go

exec sp_addextendedproperty 'MS_Description', '是否已刪除。0未刪除，1已刪除。', 'SCHEMA', 'dbo', 'TABLE', 'role', 'COLUMN', 'deleted'
go

create index idx_role_deleted
    on role (deleted)
go

create table send
(
    uid                 uniqueidentifier default newsequentialid() not null
        constraint pk_send
            primary key,
    event_code          varchar(25),
    way_name            varchar(50)                                not null,
    send_from           tinyint                                    not null,
    send_time           datetime2                                  not null,
    expire_time         datetime2                                  not null,
    template_code       varchar(25),
    template_max_length smallint,
    send_mode           char                                       not null,
    limit_mode          tinyint,
    mod_reply           tinyint          default 0                 not null,
    status              int                                        not null,
    priority            tinyint                                    not null,
    msg_type            varchar(5)                                 not null,
    req_department      varchar(12)                                not null,
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

exec sp_addextendedproperty 'MS_Description', '記錄發送資料，主表', 'SCHEMA', 'dbo', 'TABLE', 'send'
go

exec sp_addextendedproperty 'MS_Description', 'PK', 'SCHEMA', 'dbo', 'TABLE', 'send', 'COLUMN', 'uid'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] event代碼\n[range/list] n/a\n[example] EVENT01\n[reference]  n/a', 'SCHEMA', 'dbo', 'TABLE', 'send',
     'COLUMN', 'event_code'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 發送機制識別值。\n[range/list] n/a\n[example]  SMS\n[reference]  n/a\n註：未來可支援一筆訊息發送至多個管道，多筆以逗號分隔。', 'SCHEMA',
     'dbo', 'TABLE', 'send', 'COLUMN', 'way_name'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 發送方式\n[range/list] 1: message-api, 2: db-sync, 3: portal\n[example] 1\n[reference] n/a', 'SCHEMA',
     'dbo', 'TABLE', 'send', 'COLUMN', 'send_from'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 預計發送時間 \n[range/list] n/a\n[example] 2023-02-02 15:22:33\n[reference] n/a', 'SCHEMA', 'dbo', 'TABLE',
     'send', 'COLUMN', 'send_time'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 訊息過期時間。超過這個時間就不能發送。預設為發送時間+86400秒。\n[range/list] n/a\n[example] 2023-02-02 15:22:33\n[reference] n/a',
     'SCHEMA', 'dbo', 'TABLE', 'send', 'COLUMN', 'expire_time'
go

exec sp_addextendedproperty 'MS_Description', '[definition] 樣版代碼\n[range/list] n/a\n[example] TEMP01\n[reference]  n/a',
     'SCHEMA', 'dbo', 'TABLE', 'send', 'COLUMN', 'template_code'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 發送當下樣版內容可允許的最大長度\n[range/list] 0 to 65535\n[example] 50\n[reference]  n/a', 'SCHEMA', 'dbo', 'TABLE',
     'send', 'COLUMN', 'template_max_length'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 發送模式\n[range/list] R:即時, S:預約\n[example] S\n[reference] n/a', 'SCHEMA', 'dbo', 'TABLE', 'send',
     'COLUMN', 'send_mode'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 啟用勿擾模式\n[range/list] null: 未使用 0:不使用, 1:限制只能早上發送\n[example] 1\n[reference] n/a', 'SCHEMA', 'dbo',
     'TABLE', 'send', 'COLUMN', 'limit_mode'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 是否啟用訊息需要回覆\n[range/list] 0:停用, 1:啟用 \n[example] 0\n[reference] n/a', 'SCHEMA', 'dbo', 'TABLE',
     'send', 'COLUMN', 'mod_reply'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 處理狀態\n[range/list] 1:待審核  2:已核可 3:已核退  4:處理作業中 5:處理完成 6:處理失敗,7:己取消, 8:已過期。\n[example] 1\n[reference] n/a',
     'SCHEMA', 'dbo', 'TABLE', 'send', 'COLUMN', 'status'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 發送優先值 0~9。9為優先權最高，0~6 受宵禁限制。\n[range/list] 最小值為0\n[example] 1\n[reference] n/a', 'SCHEMA', 'dbo',
     'TABLE', 'send', 'COLUMN', 'priority'
go

exec sp_addextendedproperty 'MS_Description', '[definition] 訊息型態。\n[range/list] n/a\n[example] 1\n[reference] n/a',
     'SCHEMA', 'dbo', 'TABLE', 'send', 'COLUMN', 'msg_type'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 發送部門代碼(掛帳單位)\n[range/list] n/a\n[example] 1\n[reference] n/a', 'SCHEMA', 'dbo', 'TABLE', 'send',
     'COLUMN', 'req_department'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 事業群代碼。事業群別代碼, 如BU2000表示個金事業群。\n[range/list] n/a\n[example] n/a\n[reference] n/a', 'SCHEMA', 'dbo',
     'TABLE', 'send', 'COLUMN', 'req_bu'
go

exec sp_addextendedproperty 'MS_Description', '[definition] 子公司代碼。\n[range/list] n/a\n[example] n/a\n[reference] n/a',
     'SCHEMA', 'dbo', 'TABLE', 'send', 'COLUMN', 'req_company'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 發送來源 / 系統。系統代號, 如T24主機系統(TWT24), ES7K, MMA系統(MMA)\n[range/list] n/a\n[example] n/a\n[reference] n/a',
     'SCHEMA', 'dbo', 'TABLE', 'send', 'COLUMN', 'req_channel'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 發送來源的專案代號\n[range/list] n/a\n[example] n/a\n[reference] n/a', 'SCHEMA', 'dbo', 'TABLE', 'send',
     'COLUMN', 'req_object_id'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 請求端產生的批次代碼\n[range/list] n/a\n[example] n/a\n[reference] n/a', 'SCHEMA', 'dbo', 'TABLE', 'send',
     'COLUMN', 'req_batch_id'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 備註。未來可放主機交易序號或帳號以供追蹤查詢。\n[range/list] n/a\n[example] n/a\n[reference] n/a\n註：對應模擬資料庫的 memo 欄位。',
     'SCHEMA', 'dbo', 'TABLE', 'send', 'COLUMN', 'memo'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 建立時間\n[range/list] n/a\n[example] 2023-03-25 16:58:02\n[reference] n/a', 'SCHEMA', 'dbo', 'TABLE',
     'send', 'COLUMN', 'create_time'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 更新時間。內容異動最後更新時間。\n[range/list] n/a\n[example] 2023-03-25 16:58:02\n[reference] n/a', 'SCHEMA', 'dbo',
     'TABLE', 'send', 'COLUMN', 'update_time'
go

exec sp_addextendedproperty 'MS_Description', '作業完成時間。由系統排程更新。', 'SCHEMA', 'dbo', 'TABLE', 'send', 'COLUMN',
     'completed_time'
go

exec sp_addextendedproperty 'MS_Description', '觸發取消發送的時間。由 portal 或 message-api 更新。', 'SCHEMA', 'dbo', 'TABLE', 'send',
     'COLUMN', 'canceled_time'
go

exec sp_addextendedproperty 'MS_Description', '觸發標記已過期的時間。由系統排程觸發。', 'SCHEMA', 'dbo', 'TABLE', 'send', 'COLUMN',
     'update_expired_time'
go

create index idx_send_req_batch_id
    on send (req_batch_id)
go

create index idx_send_req_department
    on send (req_department)
go

create index idx_send_event_code
    on send (event_code)
go

create index idx_send_req_channel
    on send (req_channel)
go

create index idx_send_send_time
    on send (send_time)
go

create index idx_send_status
    on send (status)
go

create index idx_send_priority
    on send (priority)
go

create table send_record
(
    uid                 uniqueidentifier default newsequentialid() not null
        constraint pk_send_record
            primary key,
    send_uid            uniqueidentifier                           not null
        constraint fk_send_record_send
            references send,
    way_name            varchar(12)                                not null,
    serial_number       int              default 0                 not null,
    send_time           datetime2                                  not null,
    expire_time         datetime2                                  not null,
    customer_id         varchar(20),
    customer_phone      varchar(20),
    customer_reference  varchar(64),
    req_group_id        varchar(36),
    req_uid             varchar(36),
    content             nvarchar(1000)                             not null,
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
    status              tinyint          default 0                 not null,
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

exec sp_addextendedproperty 'MS_Description', '記錄訊息發送明細資料，為每筆名單', 'SCHEMA', 'dbo', 'TABLE', 'send_record'
go

exec sp_addextendedproperty 'MS_Description', '發送訊息鍵值', 'SCHEMA', 'dbo', 'TABLE', 'send_record', 'COLUMN', 'uid'
go

exec sp_addextendedproperty 'MS_Description', '發送記錄鍵值', 'SCHEMA', 'dbo', 'TABLE', 'send_record', 'COLUMN', 'send_uid'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 發送機制識別值\n[range/list] n/a\n[example]  SMS\n[reference]  n/a', 'SCHEMA', 'dbo', 'TABLE',
     'send_record', 'COLUMN', 'way_name'
go

exec sp_addextendedproperty 'MS_Description', '[definition] 發送序號\n[range/list] n/a\n[example] n/a\n[reference]  n/a',
     'SCHEMA', 'dbo', 'TABLE', 'send_record', 'COLUMN', 'serial_number'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 預計發送時間 \n[range/list] n/a\n[example] 2023-02-02 15:22:33\n[reference] n/a', 'SCHEMA', 'dbo', 'TABLE',
     'send_record', 'COLUMN', 'send_time'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 訊息過期時間。超過這個時間就不發送。\n[range/list] n/a\n[example] 2023-02-02 15:22:33\n[reference] n/a', 'SCHEMA',
     'dbo', 'TABLE', 'send_record', 'COLUMN', 'expire_time'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 接收者/客戶的身分證字號。\n[range/list] n/a\n[example] A123456789\n[reference] /a', 'SCHEMA', 'dbo', 'TABLE',
     'send_record', 'COLUMN', 'customer_id'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 客戶門號。國際簡訊輸入國碼+手機號碼，如：8613400000001。\n[range/list] n/a\n[example] n/a\n[reference] n/a', 'SCHEMA',
     'dbo', 'TABLE', 'send_record', 'COLUMN', 'customer_phone'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 客戶對照值。放置客戶帳號或卡號等之後四碼。\n[range/list] n/a\n[example] n/a\n[reference] n/a', 'SCHEMA', 'dbo', 'TABLE',
     'send_record', 'COLUMN', 'customer_reference'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 發送代號(銀行自編KEY)。對應到簡訊商API的 DestName。\n[range/list] n/a\n[example]  n/a\n[reference]  n/a', 'SCHEMA',
     'dbo', 'TABLE', 'send_record', 'COLUMN', 'req_group_id'
go

exec sp_addextendedproperty 'MS_Description', '請求端產生的訊息唯一鍵值', 'SCHEMA', 'dbo', 'TABLE', 'send_record', 'COLUMN',
     'req_uid'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 訊息內容，為已經組好的內容，支援機敏資料加密\n[range/list] n/a\n[example] n/a\n[reference] n/a', 'SCHEMA', 'dbo', 'TABLE',
     'send_record', 'COLUMN', 'content'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 通知對象需輸入的回覆代碼。使用於雙向簡訊。\n[range/list] n/a\n[example] 20001\n[reference] n/a', 'SCHEMA', 'dbo', 'TABLE',
     'send_record', 'COLUMN', 'return_code'
go

exec sp_addextendedproperty 'MS_Description', '[definition] 預估的發送通數\n[range/list] n/a\n[example] 2\n[reference]  n/a',
     'SCHEMA', 'dbo', 'TABLE', 'send_record', 'COLUMN', 'calc_section'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 傳送中通數。deliver送出時更新。\n[range/list] n/a\n[example] 1\n[reference] n/a', 'SCHEMA', 'dbo', 'TABLE',
     'send_record', 'COLUMN', 'sending_section'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 總通數。DR回寫時寫入。 section = success_section + failure_section\n[range/list] n/a\n[example] 3\n[reference]  n/a',
     'SCHEMA', 'dbo', 'TABLE', 'send_record', 'COLUMN', 'section'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 成功通數。DR發生時更新。\n[range/list] n/a\n[example] 1\n[reference] n/a', 'SCHEMA', 'dbo', 'TABLE',
     'send_record', 'COLUMN', 'success_section'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 失敗通數。DR發生時更新。\n[range/list] n/a\n[example] 1\n[reference] n/a', 'SCHEMA', 'dbo', 'TABLE',
     'send_record', 'COLUMN', 'failure_section'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 各通數的狀態\n[range/list] [第一通狀態],[第二通狀態],...\n[example] 0,1,2  (第1通:傳送中, 第2通成功, 第3通失敗)\n[reference] n/a',
     'SCHEMA', 'dbo', 'TABLE', 'send_record', 'COLUMN', 'section_status_list'
go

exec sp_addextendedproperty 'MS_Description', '[definition] 是否為長簡訊\n[range/list] 0:否 1:是\n[example] 1\n[reference] n/a',
     'SCHEMA', 'dbo', 'TABLE', 'send_record', 'COLUMN', 'is_long'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 是否為國際簡訊\n[range/list] 0:否 1:是\n[example] 0\n[reference] n/a', 'SCHEMA', 'dbo', 'TABLE',
     'send_record', 'COLUMN', 'is_international'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] GW代發業者回覆msg-id\n[range/list] n/a\n[example] n/a\n[reference] n/a', 'SCHEMA', 'dbo', 'TABLE',
     'send_record', 'COLUMN', 'msg_id'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 實際發送時間，送到GW的時間\n[range/list] n/a\n[example] 2022-03-25 15:20:15\n[reference] n/a', 'SCHEMA', 'dbo',
     'TABLE', 'send_record', 'COLUMN', 'actual_send_time'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 實際發送出去的手機門號。 記錄簡訊商回報的發送門號。\n[range/list] n/a\n[example] n/a\n[reference] n/a', 'SCHEMA', 'dbo',
     'TABLE', 'send_record', 'COLUMN', 'actual_send_phone'
go

exec sp_addextendedproperty 'MS_Description', '[definition] GW代號。\n[range/list] n/a\n[example] n/a\n[reference] n/a',
     'SCHEMA', 'dbo', 'TABLE', 'send_record', 'COLUMN', 'gateway_id'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 發送狀態(至gateway)\n[range/list] 0:未處理 1:成功  2:失敗  3:已取消  4:已逾期\n[example] 0\n[reference] n/a', 'SCHEMA',
     'dbo', 'TABLE', 'send_record', 'COLUMN', 'status'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] GW回報訊息發送狀態\n[range/list] 0:傳送成功, 1:傳送失敗   2:傳送中   3:手機未開或手機簡訊已滿, 4:電話號碼錯誤, 5:資料錯誤, 6:傳送被拒, 7:逾時失敗\n[example] 2\n[reference] n/a',
     'SCHEMA', 'dbo', 'TABLE', 'send_record', 'COLUMN', 'resp_code'
go

exec sp_addextendedproperty 'MS_Description', 'DR回傳之簡訊商接收時間。格式：yyyyMMddHHmmss (共14碼)', 'SCHEMA', 'dbo', 'TABLE',
     'send_record', 'COLUMN', 'gwrecvat'
go

exec sp_addextendedproperty 'MS_Description', 'DR回傳之機房接收時間。格式：yyyyMMddHHmmss (14碼)。', 'SCHEMA', 'dbo', 'TABLE',
     'send_record', 'COLUMN', 'acceptat'
go

exec sp_addextendedproperty 'MS_Description', 'DR回傳之ISP接收時間。格式：yyyyMMddHHmmss (共14碼)。', 'SCHEMA', 'dbo', 'TABLE',
     'send_record', 'COLUMN', 'sendat'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 客戶收到訊息時間\n[range/list] n/a\n[example] 2022-03-26 15:20:10\n[reference] n/a', 'SCHEMA', 'dbo',
     'TABLE', 'send_record', 'COLUMN', 'finish_time'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 參數欄位，為JSON格式\n[range/list] n/a\n[example]  n/a\n[reference]  n/a', 'SCHEMA', 'dbo', 'TABLE',
     'send_record', 'COLUMN', 'meta'
go

exec sp_addextendedproperty 'MS_Description', '建立時間', 'SCHEMA', 'dbo', 'TABLE', 'send_record', 'COLUMN', 'create_time'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 最後一次更新時間\n[range/list] n/a\n[example] 2022-03-22 01:02:03\n[reference] n/a', 'SCHEMA', 'dbo',
     'TABLE', 'send_record', 'COLUMN', 'update_time'
go

exec sp_addextendedproperty 'MS_Description', 'deliver成功將訊息送出給gateway的時間。(有成功收到 gateway response)。\n由 deliver 更新。',
     'SCHEMA', 'dbo', 'TABLE', 'send_record', 'COLUMN', 'deliver_time'
go

exec sp_addextendedproperty 'MS_Description', 'gateway回寫 DR 的時間。由 deliver 更新。', 'SCHEMA', 'dbo', 'TABLE', 'send_record',
     'COLUMN', 'dr_time'
go

exec sp_addextendedproperty 'MS_Description', '觸發取消發送的時間。由 portal 或 message-api 更新。', 'SCHEMA', 'dbo', 'TABLE',
     'send_record', 'COLUMN', 'canceled_time'
go

exec sp_addextendedproperty 'MS_Description', '觸發標記已過期的時間。由系統排程觸發。', 'SCHEMA', 'dbo', 'TABLE', 'send_record', 'COLUMN',
     'update_expired_time'
go

create index idx_send_record_msg_id
    on send_record (msg_id)
go

create index idx_send_record_finish_time
    on send_record (finish_time)
go

create index idx_send_record_gateway_id
    on send_record (gateway_id)
go

create index idx_send_record_send_time
    on send_record (send_time)
go

create index idx_send_record_customer_phone
    on send_record (customer_phone)
go

create index idx_send_record_status
    on send_record (status)
go

create index idx_send_record_customer_id
    on send_record (customer_id)
go

create index idx_send_record_way_name
    on send_record (way_name)
go

create index idx_send_record_send_uid
    on send_record (send_uid)
go

create table send_record_deliver
(
    uid                 uniqueidentifier default newsequentialid() not null
        constraint pk_send_record_deliver
            primary key,
    send_record_uid     uniqueidentifier                           not null
        constraint fk_send_record_deliver_send_record
            references send_record
            on update cascade on delete cascade,
    way_name            varchar(25)                                not null,
    expected_gateway_id int                                        not null,
    actual_gateway_id   int                                        not null,
    create_time         datetime2                                  not null,
    memo                nvarchar(100)
)
go

exec sp_addextendedproperty 'MS_Description', 'message-deliver發送給gateway的記錄表。', 'SCHEMA', 'dbo', 'TABLE',
     'send_record_deliver'
go

exec sp_addextendedproperty 'MS_Description', 'PK', 'SCHEMA', 'dbo', 'TABLE', 'send_record_deliver', 'COLUMN', 'uid'
go

exec sp_addextendedproperty 'MS_Description', '發送訊息鍵值', 'SCHEMA', 'dbo', 'TABLE', 'send_record_deliver', 'COLUMN',
     'send_record_uid'
go

exec sp_addextendedproperty 'MS_Description', '[definition] 發送機制\n[range/list] n/a\n[example] SMS\n[reference]  n/a',
     'SCHEMA', 'dbo', 'TABLE', 'send_record_deliver', 'COLUMN', 'way_name'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 預計發送的gateway代號。\n[range/list] n/a\n[example] n/a\n[reference] n/a', 'SCHEMA', 'dbo', 'TABLE',
     'send_record_deliver', 'COLUMN', 'expected_gateway_id'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 實際發送的gateway代號。\n[range/list] n/a\n[example] n/a\n[reference] n/a', 'SCHEMA', 'dbo', 'TABLE',
     'send_record_deliver', 'COLUMN', 'actual_gateway_id'
go

exec sp_addextendedproperty 'MS_Description', '[definition] 建立時間\n[range/list] n/a\n[example] n/a\n[reference] n/a',
     'SCHEMA', 'dbo', 'TABLE', 'send_record_deliver', 'COLUMN', 'create_time'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 備註。記錄預期gateway與實際gateway不一致時的錯誤訊息。\n[range/list] n/a\n[example] n/a\n[reference] n/a', 'SCHEMA',
     'dbo', 'TABLE', 'send_record_deliver', 'COLUMN', 'memo'
go

create index idx_send_record_deliver_send_record_uid
    on send_record_deliver (send_record_uid)
go

create table send_record_error
(
    uid                uniqueidentifier default newsequentialid() not null
        constraint pk_send_record_error
            primary key,
    send_record_uid    uniqueidentifier                           not null
        constraint fk_send_record_error_send_record
            references send_record
            on update cascade on delete cascade,
    customer_id        varchar(20),
    customer_phone     varchar(20),
    customer_reference varchar(64),
    content            nvarchar(1000),
    error_code         tinyint                                    not null,
    error_message      nvarchar(1000),
    data               nvarchar(1000),
    create_time        datetime2
)
go

exec sp_addextendedproperty 'MS_Description', '簡訊發送異常記錄', 'SCHEMA', 'dbo', 'TABLE', 'send_record_error'
go

exec sp_addextendedproperty 'MS_Description', '發送異常記錄鍵值', 'SCHEMA', 'dbo', 'TABLE', 'send_record_error', 'COLUMN', 'uid'
go

exec sp_addextendedproperty 'MS_Description', '發送訊息鍵值', 'SCHEMA', 'dbo', 'TABLE', 'send_record_error', 'COLUMN',
     'send_record_uid'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 接收者/客戶的身分證字號。\n[range/list] n/a\n[example] A123456789\n[reference] /a', 'SCHEMA', 'dbo', 'TABLE',
     'send_record_error', 'COLUMN', 'customer_id'
go

exec sp_addextendedproperty 'MS_Description', '[definition] 客戶門號\n[range/list] n/a\n[example] n/a\n[reference] n/a',
     'SCHEMA', 'dbo', 'TABLE', 'send_record_error', 'COLUMN', 'customer_phone'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 客戶對照值。放置客戶帳號或卡號等之後四碼。\n[range/list] n/a\n[example] n/a\n[reference] n/a', 'SCHEMA', 'dbo', 'TABLE',
     'send_record_error', 'COLUMN', 'customer_reference'
go

exec sp_addextendedproperty 'MS_Description', '[definition] 簡訊內容\n[range/list] n/a\n[example] n/a\n[reference] n/a',
     'SCHEMA', 'dbo', 'TABLE', 'send_record_error', 'COLUMN', 'content'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 錯誤代碼\n[range/list] 1:黑名單, 2:資料格式檢查錯誤, 3:簡訊則數為0,  4: gateway回應發送失敗。5: gateway服務異常,  6: 其它系統異常。\n[example] 1\n[reference] n/a',
     'SCHEMA', 'dbo', 'TABLE', 'send_record_error', 'COLUMN', 'error_code'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 異常訊息\n[range/list] n/a\n[example] 位於黑名單類別 (全域)中\n[reference] n/a', 'SCHEMA', 'dbo', 'TABLE',
     'send_record_error', 'COLUMN', 'error_message'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 當下異常需要保存的資料，為JSON格式\n[range/list] n/a\n[example] n/a\n[reference] n/a', 'SCHEMA', 'dbo', 'TABLE',
     'send_record_error', 'COLUMN', 'data'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 建立時間\n[range/list] n/a\n[example] 2022-03-02 15:01:01\n[reference] n/a', 'SCHEMA', 'dbo', 'TABLE',
     'send_record_error', 'COLUMN', 'create_time'
go

create index idx_send_record_error_send_record_uid
    on send_record_error (send_record_uid)
go

create table send_record_reply
(
    uid                uniqueidentifier default newsequentialid() not null
        constraint pk_send_record_reply
            primary key,
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

exec sp_addextendedproperty 'MS_Description', '訊息回覆之紀錄，用於雙向簡訊', 'SCHEMA', 'dbo', 'TABLE', 'send_record_reply'
go

exec sp_addextendedproperty 'MS_Description', 'PK', 'SCHEMA', 'dbo', 'TABLE', 'send_record_reply', 'COLUMN', 'uid'
go

exec sp_addextendedproperty 'MS_Description', '發送訊息鍵值', 'SCHEMA', 'dbo', 'TABLE', 'send_record_reply', 'COLUMN',
     'send_record_uid'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 接收者/客戶的身分證字號。\n[range/list] n/a\n[example] A123456789\n[reference] /a', 'SCHEMA', 'dbo', 'TABLE',
     'send_record_reply', 'COLUMN', 'customer_id'
go

exec sp_addextendedproperty 'MS_Description', '[definition] 客戶門號\n[range/list] n/a\n[example] n/a\n[reference] n/a',
     'SCHEMA', 'dbo', 'TABLE', 'send_record_reply', 'COLUMN', 'customer_phone'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 客戶對照值。放置客戶帳號或卡號等之後四碼。\n[range/list] n/a\n[example] n/a\n[reference] n/a', 'SCHEMA', 'dbo', 'TABLE',
     'send_record_reply', 'COLUMN', 'customer_reference'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 回報內容之日期資訊\n[range/list] n/a\n[example] n/a\n[reference]  n/a', 'SCHEMA', 'dbo', 'TABLE',
     'send_record_reply', 'COLUMN', 'tx_date'
go

exec sp_addextendedproperty 'MS_Description', '[definition] 回覆的時間資訊\n[range/list] n/a\n[example] n/a\n[reference] /a',
     'SCHEMA', 'dbo', 'TABLE', 'send_record_reply', 'COLUMN', 'tx_time'
go

exec sp_addextendedproperty 'MS_Description', '[definition] event代碼\n[range/list] n/a\n[example] n/a\n[reference] n/a',
     'SCHEMA', 'dbo', 'TABLE', 'send_record_reply', 'COLUMN', 'event_code'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 通知對象需要回覆的代碼，用來核對GW回報的回覆內容之用\n[range/list] n/a\n[example] 20001\n[reference] n/a', 'SCHEMA', 'dbo',
     'TABLE', 'send_record_reply', 'COLUMN', 'return_code'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 建立時間\n[range/list] n/a\n[example] 2022-03-05 10:22:33\n[reference] n/a', 'SCHEMA', 'dbo', 'TABLE',
     'send_record_reply', 'COLUMN', 'create_time'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 最後一次更新時間\n[range/list] n/a\n[example] 2022-03-06 02:55:21\n[reference] n/a', 'SCHEMA', 'dbo',
     'TABLE', 'send_record_reply', 'COLUMN', 'update_time'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 通知對象所回覆的內容\n[range/list] n/a\n[example] n/a\n[reference] n/a', 'SCHEMA', 'dbo', 'TABLE',
     'send_record_reply', 'COLUMN', 'reply_content'
go

exec sp_addextendedproperty 'MS_Description', '回覆內容寫入時間', 'SCHEMA', 'dbo', 'TABLE', 'send_record_reply', 'COLUMN',
     'reply_time'
go

exec sp_addextendedproperty 'MS_Description', '[definition] 狀態\n[range/list]  n/a\n[example] 1\n[reference] n/a',
     'SCHEMA', 'dbo', 'TABLE', 'send_record_reply', 'COLUMN', 'status'
go

exec sp_addextendedproperty 'MS_Description', '[definition] GW代號。\n[range/list] n/a\n[example] n/a\n[reference] n/a',
     'SCHEMA', 'dbo', 'TABLE', 'send_record_reply', 'COLUMN', 'gateway_id'
go

exec sp_addextendedproperty 'MS_Description', '簡訊特碼', 'SCHEMA', 'dbo', 'TABLE', 'send_record_reply', 'COLUMN', 'code'
go

create index idx_send_record_reply_customer_phone
    on send_record_reply (customer_phone)
go

create index idx_send_record_reply_reply_content
    on send_record_reply (reply_content)
go

create index idx_send_record_reply_return_code
    on send_record_reply (return_code)
go

create index idx_send_record_reply_status
    on send_record_reply (status)
go

create index idx_send_record_reply_tx_date_time
    on send_record_reply (tx_date, tx_time)
go

create index idx_send_record_reply_reply_time
    on send_record_reply (reply_time)
go

create index idx_send_record_reply_send_record_uid
    on send_record_reply (send_record_uid)
go

create table send_record_reply_action
(
    uid                   uniqueidentifier default newsequentialid() not null
        constraint pk_send_record_reply_action
            primary key,
    send_record_reply_uid uniqueidentifier                           not null
        constraint fk_send_record_reply_action_send_record_reply
            references send_record_reply
            on update cascade on delete cascade,
    mod_name              varchar(45),
    status                tinyint,
    return_val            varchar(10),
    return_message        nvarchar(1000),
    create_time           datetime2,
    update_time           datetime2,
    meta                  nvarchar(1000)
)
go

exec sp_addextendedproperty 'MS_Description', '當通知對象回覆內容正確時，系統回報給其他系統之紀錄表', 'SCHEMA', 'dbo', 'TABLE',
     'send_record_reply_action'
go

exec sp_addextendedproperty 'MS_Description', 'PK', 'SCHEMA', 'dbo', 'TABLE', 'send_record_reply_action', 'COLUMN',
     'uid'
go

exec sp_addextendedproperty 'MS_Description', '訊息回覆記錄鍵值', 'SCHEMA', 'dbo', 'TABLE', 'send_record_reply_action',
     'COLUMN', 'send_record_reply_uid'
go

exec sp_addextendedproperty 'MS_Description', '[definition] 對應的模組名稱\n[range/list] IVR\n[example] IVR\n[reference] n/a',
     'SCHEMA', 'dbo', 'TABLE', 'send_record_reply_action', 'COLUMN', 'mod_name'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 狀態\n[range/list] 0:停用 1:啟用 2:等待執行, 3成功  4:失敗\n[example] 1\n[reference]', 'SCHEMA', 'dbo', 'TABLE',
     'send_record_reply_action', 'COLUMN', 'status'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 目標系統所回覆結果\n[range/list] n/a\n[example] n/a\n[reference] n/a', 'SCHEMA', 'dbo', 'TABLE',
     'send_record_reply_action', 'COLUMN', 'return_val'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 目標系統所回覆的訊息內容\n[range/list] n/a\n[example] n/a\n[reference] n/a', 'SCHEMA', 'dbo', 'TABLE',
     'send_record_reply_action', 'COLUMN', 'return_message'
go

exec sp_addextendedproperty 'MS_Description', '[definition] 建立時間\n[range/list] n/a\n[example] n/a\n[reference] n/a',
     'SCHEMA', 'dbo', 'TABLE', 'send_record_reply_action', 'COLUMN', 'create_time'
go

exec sp_addextendedproperty 'MS_Description', '[definition] 最後一次更新時間\n[range/list] n/a\n[example] n/a\n[reference] n/a',
     'SCHEMA', 'dbo', 'TABLE', 'send_record_reply_action', 'COLUMN', 'update_time'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 與目標系統介接所使用的參數，為JSON格式\n[range/list] n/a\n[example] n/a\n[reference] n/a', 'SCHEMA', 'dbo', 'TABLE',
     'send_record_reply_action', 'COLUMN', 'meta'
go

create table send_use_mod
(
    send_uid uniqueidentifier not null
        constraint fk_send_use_mod_send
            references send,
    mod_name varchar(45)      not null,
    meta     nvarchar(1000),
    constraint pk_send_use_mod
        primary key (send_uid, mod_name)
)
go

exec sp_addextendedproperty 'MS_Description', 'send_use_mod\n該批訊息所套用的模組，此表可支援系統擴充功能之用。\n例如雙向簡訊串IVR, LMS等其他系統', 'SCHEMA',
     'dbo', 'TABLE', 'send_use_mod'
go

exec sp_addextendedproperty 'MS_Description', '發送批次鍵值', 'SCHEMA', 'dbo', 'TABLE', 'send_use_mod', 'COLUMN', 'send_uid'
go

exec sp_addextendedproperty 'MS_Description', '[definition] 模組名稱\n[range/list] n/a\n[example]  IVR\n[reference]  n/a',
     'SCHEMA', 'dbo', 'TABLE', 'send_use_mod', 'COLUMN', 'mod_name'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 參數欄位，為JSON格式\n[range/list] n/a\n[example] n/a\n[reference]  n/a', 'SCHEMA', 'dbo', 'TABLE',
     'send_use_mod', 'COLUMN', 'meta'
go

create table send_use_way
(
    uid              uniqueidentifier default newsequentialid() not null
        constraint pk_send_use_way
            primary key,
    send_uid         uniqueidentifier                           not null
        constraint fk_send_use_way_send
            references send,
    way_name         varchar(12)                                not null,
    gateway_id       int,
    total            int,
    undelivery       int,
    success          int,
    failure          int,
    expired          int,
    canceled         int,
    total_section    int,
    success_section  int,
    failure_section  int,
    expired_section  int,
    canceled_section int,
    total_reply      int,
    create_time      datetime2
)
go

exec sp_addextendedproperty 'MS_Description', 'send_use_way\n紀錄每批訊息所套用的發送機制，\n例如同時發送SMS、Line等機制，則該批訊息會有兩筆紀錄在此表',
     'SCHEMA', 'dbo', 'TABLE', 'send_use_way'
go

exec sp_addextendedproperty 'MS_Description', 'PK', 'SCHEMA', 'dbo', 'TABLE', 'send_use_way', 'COLUMN', 'uid'
go

exec sp_addextendedproperty 'MS_Description', '發送記錄鍵值', 'SCHEMA', 'dbo', 'TABLE', 'send_use_way', 'COLUMN', 'send_uid'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 發送機制識別值\n[range/list] SMS | LINE | IMessage\n[example] SMS\n[reference]  n/a', 'SCHEMA', 'dbo',
     'TABLE', 'send_use_way', 'COLUMN', 'way_name'
go

exec sp_addextendedproperty 'MS_Description', '簡訊商代碼', 'SCHEMA', 'dbo', 'TABLE', 'send_use_way', 'COLUMN', 'gateway_id'
go

exec sp_addextendedproperty 'MS_Description', '[definition] 預計發送總數量\n[range/list] n/a\n[example] 100\n[reference]  n/a',
     'SCHEMA', 'dbo', 'TABLE', 'send_use_way', 'COLUMN', 'total'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 總未送出筆數。undelivery = canceled + expired。\n[range/list] n/a\n[example] 2\n[reference] n/a', 'SCHEMA',
     'dbo', 'TABLE', 'send_use_way', 'COLUMN', 'undelivery'
go

exec sp_addextendedproperty 'MS_Description', '[definition] 總成功筆數\n[range/list] n/a\n[example] 7\n[reference] n/a',
     'SCHEMA', 'dbo', 'TABLE', 'send_use_way', 'COLUMN', 'success'
go

exec sp_addextendedproperty 'MS_Description', '[definition] 總失敗筆數\n[range/list] n/a\n[example] 1\n[reference] n/a',
     'SCHEMA', 'dbo', 'TABLE', 'send_use_way', 'COLUMN', 'failure'
go

exec sp_addextendedproperty 'MS_Description', '已過期的訊息數量', 'SCHEMA', 'dbo', 'TABLE', 'send_use_way', 'COLUMN', 'expired'
go

exec sp_addextendedproperty 'MS_Description', '已取消訊息數量', 'SCHEMA', 'dbo', 'TABLE', 'send_use_way', 'COLUMN', 'canceled'
go

exec sp_addextendedproperty 'MS_Description', '[definition] 總通數\n[range/list] n/a\n[example] 10\n[reference] n/a',
     'SCHEMA', 'dbo', 'TABLE', 'send_use_way', 'COLUMN', 'total_section'
go

exec sp_addextendedproperty 'MS_Description', '[definition] 總成功通數\n[range/list] n/a\n[example] 7\n[reference] n/a',
     'SCHEMA', 'dbo', 'TABLE', 'send_use_way', 'COLUMN', 'success_section'
go

exec sp_addextendedproperty 'MS_Description', '[definition] 總失敗通數\n[range/list] n/a\n[example] 1\n[reference] n/a',
     'SCHEMA', 'dbo', 'TABLE', 'send_use_way', 'COLUMN', 'failure_section'
go

exec sp_addextendedproperty 'MS_Description', '已過期的發送則數', 'SCHEMA', 'dbo', 'TABLE', 'send_use_way', 'COLUMN',
     'expired_section'
go

exec sp_addextendedproperty 'MS_Description', '已取消的發送則數', 'SCHEMA', 'dbo', 'TABLE', 'send_use_way', 'COLUMN',
     'canceled_section'
go

exec sp_addextendedproperty 'MS_Description', '[definition] 總回覆通數\n[range/list] n/a\n[example] 1\n[reference] n/a',
     'SCHEMA', 'dbo', 'TABLE', 'send_use_way', 'COLUMN', 'total_reply'
go

exec sp_addextendedproperty 'MS_Description', '建立時間。由系統排程建立。', 'SCHEMA', 'dbo', 'TABLE', 'send_use_way', 'COLUMN',
     'create_time'
go

create index idx_send_use_way_create_time
    on send_use_way (create_time)
go

create index idx_send_use_way_send_uid
    on send_use_way (send_uid)
go

create index idx_send_use_way_way_name
    on send_use_way (way_name)
go

create index idx_send_use_way_gateway_id
    on send_use_way (gateway_id)
go

create table settings
(
    uid         uniqueidentifier  not null
        constraint pk_settings
            primary key,
    name        varchar(100)      not null,
    value       varchar(1000)     not null,
    memo        nvarchar(100),
    create_time datetime2,
    create_user uniqueidentifier,
    update_time datetime2,
    update_user uniqueidentifier,
    deleted     tinyint default 0 not null,
    delete_time datetime2,
    delete_user uniqueidentifier
)
go

exec sp_addextendedproperty 'MS_Description', '系統參數設定', 'SCHEMA', 'dbo', 'TABLE', 'settings'
go

exec sp_addextendedproperty 'MS_Description', 'PK', 'SCHEMA', 'dbo', 'TABLE', 'settings', 'COLUMN', 'uid'
go

exec sp_addextendedproperty 'MS_Description', '參數名稱。格式：命名資訊以 . 號分隔。', 'SCHEMA', 'dbo', 'TABLE', 'settings', 'COLUMN',
     'name'
go

exec sp_addextendedproperty 'MS_Description', '參數值。', 'SCHEMA', 'dbo', 'TABLE', 'settings', 'COLUMN', 'value'
go

exec sp_addextendedproperty 'MS_Description', '備註說明', 'SCHEMA', 'dbo', 'TABLE', 'settings', 'COLUMN', 'memo'
go

exec sp_addextendedproperty 'MS_Description', '是否已刪除。0未刪除，1已刪除。', 'SCHEMA', 'dbo', 'TABLE', 'settings', 'COLUMN',
     'deleted'
go

create index idx_settings_name
    on settings (name)
go

create index idx_settings_deleted
    on settings (deleted)
go

create table shortlist
(
    uid            uniqueidentifier  not null
        constraint pk_shortlist
            primary key,
    code           varchar(12)       not null,
    name           nvarchar(25)      not null,
    recipients     nvarchar(1000)    not null,
    department_uid uniqueidentifier  not null
        constraint fk_shortlist_department
            references department,
    memo           nvarchar(100),
    enabled        tinyint default 1 not null,
    create_time    datetime2         not null,
    create_user    uniqueidentifier  not null,
    update_time    datetime2,
    update_user    uniqueidentifier,
    deleted        tinyint default 0 not null,
    delete_time    datetime2,
    delete_user    uniqueidentifier
)
go

exec sp_addextendedproperty 'MS_Description', '種子名單', 'SCHEMA', 'dbo', 'TABLE', 'shortlist'
go

exec sp_addextendedproperty 'MS_Description', 'PK', 'SCHEMA', 'dbo', 'TABLE', 'shortlist', 'COLUMN', 'uid'
go

exec sp_addextendedproperty 'MS_Description', '種子名單代碼', 'SCHEMA', 'dbo', 'TABLE', 'shortlist', 'COLUMN', 'code'
go

exec sp_addextendedproperty 'MS_Description', '名單名稱', 'SCHEMA', 'dbo', 'TABLE', 'shortlist', 'COLUMN', 'name'
go

exec sp_addextendedproperty 'MS_Description', '名單。格式：JSON array。\n格式示意：\n[ { phone, name, departmentName } ]', 'SCHEMA',
     'dbo', 'TABLE', 'shortlist', 'COLUMN', 'recipients'
go

exec sp_addextendedproperty 'MS_Description', '所屬部門鍵值', 'SCHEMA', 'dbo', 'TABLE', 'shortlist', 'COLUMN',
     'department_uid'
go

exec sp_addextendedproperty 'MS_Description', '是否啟用', 'SCHEMA', 'dbo', 'TABLE', 'shortlist', 'COLUMN', 'enabled'
go

create index idx_shortlist_deleted
    on shortlist (deleted)
go

create index idx_shortlist_code
    on shortlist (code)
go

create table template
(
    code        varchar(25)       not null,
    title       nvarchar(100),
    content     nvarchar(1000)    not null,
    max_length  smallint          not null,
    status      tinyint,
    fields      varchar(1000),
    create_time datetime2,
    update_time datetime2,
    deleted     tinyint default 0 not null,
    delete_time datetime2,
    create_user uniqueidentifier,
    update_user uniqueidentifier,
    delete_user uniqueidentifier,
    uid         uniqueidentifier  not null
        constraint pk_template
            primary key
)
go

exec sp_addextendedproperty 'MS_Description', '樣版資料表，為主表', 'SCHEMA', 'dbo', 'TABLE', 'template'
go

exec sp_addextendedproperty 'MS_Description', '[definition] 樣版代碼\n[range/list] n/a\n[example] 1\n[reference] n/a',
     'SCHEMA', 'dbo', 'TABLE', 'template', 'COLUMN', 'code'
go

exec sp_addextendedproperty 'MS_Description', '[definition] 樣版名稱\n[range/list] n/a\n[example] n/a\n[reference] n/a',
     'SCHEMA', 'dbo', 'TABLE', 'template', 'COLUMN', 'title'
go

exec sp_addextendedproperty 'MS_Description', '[definition] 樣版內容\n[range/list] n/a\n[example] n/a\n[reference] n/a',
     'SCHEMA', 'dbo', 'TABLE', 'template', 'COLUMN', 'content'
go

exec sp_addextendedproperty 'MS_Description', '[definition] 樣版內容最大長度\n[range/list] n/a\n[example] 46\n[reference] n/a',
     'SCHEMA', 'dbo', 'TABLE', 'template', 'COLUMN', 'max_length'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 狀態\n[range/list] 1:使用中, 2:待審核, 3:核退待修改, 4:停用\n[example] 1\n[reference] n/a', 'SCHEMA', 'dbo',
     'TABLE', 'template', 'COLUMN', 'status'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 樣版動態欄位設定。JSON 格式。\n[range/list] n/a\n[example] n/a\n[reference] n/a\n格式示意：\n[ { seq, fieldName,.maxLength  } ]',
     'SCHEMA', 'dbo', 'TABLE', 'template', 'COLUMN', 'fields'
go

exec sp_addextendedproperty 'MS_Description', '[definition] 建立時間\n[range/list] n/a\n[example] n/a\n[reference]',
     'SCHEMA', 'dbo', 'TABLE', 'template', 'COLUMN', 'create_time'
go

exec sp_addextendedproperty 'MS_Description', '[definition] 最後一次更新時間\n[range/list] n/a\n[example] n/a\n[reference]',
     'SCHEMA', 'dbo', 'TABLE', 'template', 'COLUMN', 'update_time'
go

exec sp_addextendedproperty 'MS_Description', '[definition] 是否已刪除\n[range/list] 0,1\n[example] 0\n[reference]',
     'SCHEMA', 'dbo', 'TABLE', 'template', 'COLUMN', 'deleted'
go

exec sp_addextendedproperty 'MS_Description', '[definition] 刪除時間\n[range/list] n/a\n[example] n/a\n[reference] n/a',
     'SCHEMA', 'dbo', 'TABLE', 'template', 'COLUMN', 'delete_time'
go

exec sp_addextendedproperty 'MS_Description', 'PK', 'SCHEMA', 'dbo', 'TABLE', 'template', 'COLUMN', 'uid'
go

create table event
(
    code               varchar(25)               not null,
    title              nvarchar(20)              not null,
    uid                uniqueidentifier          not null
        constraint pk_event
            primary key,
    category           varchar(20)               not null,
    blacklist_enabled  tinyint     default 0     not null,
    blacklist_category varchar(20),
    shortlist_enabled  tinyint     default 0     not null,
    shortlist_uid      uniqueidentifier
        constraint fk_event_shortlist
            references shortlist,
    template_enabled   tinyint     default 0     not null,
    template_uid       uniqueidentifier
        constraint fk_event_template
            references template,
    content            nvarchar(1000),
    way_names          varchar(20) default 'SMS' not null,
    req_department     varchar(8)                not null,
    create_time        datetime2,
    create_user        uniqueidentifier,
    update_time        datetime2,
    update_user        uniqueidentifier,
    deleted            tinyint     default 0     not null,
    delete_time        datetime2,
    delete_user        uniqueidentifier
)
go

exec sp_addextendedproperty 'MS_Description', '事件管理', 'SCHEMA', 'dbo', 'TABLE', 'event'
go

exec sp_addextendedproperty 'MS_Description', '事件代碼', 'SCHEMA', 'dbo', 'TABLE', 'event', 'COLUMN', 'code'
go

exec sp_addextendedproperty 'MS_Description', '事件標題', 'SCHEMA', 'dbo', 'TABLE', 'event', 'COLUMN', 'title'
go

exec sp_addextendedproperty 'MS_Description', 'PK', 'SCHEMA', 'dbo', 'TABLE', 'event', 'COLUMN', 'uid'
go

exec sp_addextendedproperty 'MS_Description', '訊息類型。 otp, notification, marketing', 'SCHEMA', 'dbo', 'TABLE', 'event',
     'COLUMN', 'category'
go

exec sp_addextendedproperty 'MS_Description', '是否使用黑名單', 'SCHEMA', 'dbo', 'TABLE', 'event', 'COLUMN',
     'blacklist_enabled'
go

exec sp_addextendedproperty 'MS_Description', '黑名單種類。 none, department, all', 'SCHEMA', 'dbo', 'TABLE', 'event',
     'COLUMN', 'blacklist_category'
go

exec sp_addextendedproperty 'MS_Description', '是否使用種子名單', 'SCHEMA', 'dbo', 'TABLE', 'event', 'COLUMN',
     'shortlist_enabled'
go

exec sp_addextendedproperty 'MS_Description', '種子名單鍵值', 'SCHEMA', 'dbo', 'TABLE', 'event', 'COLUMN', 'shortlist_uid'
go

exec sp_addextendedproperty 'MS_Description', '是否使用文字樣版', 'SCHEMA', 'dbo', 'TABLE', 'event', 'COLUMN',
     'template_enabled'
go

exec sp_addextendedproperty 'MS_Description', '文字樣版鍵值', 'SCHEMA', 'dbo', 'TABLE', 'event', 'COLUMN', 'template_uid'
go

exec sp_addextendedproperty 'MS_Description', '訊息內容。不套用文字樣版時須有值。', 'SCHEMA', 'dbo', 'TABLE', 'event', 'COLUMN',
     'content'
go

exec sp_addextendedproperty 'MS_Description', '訊息通知方式。 多筆以逗號分隔。 SMS, LINE, PUSH', 'SCHEMA', 'dbo', 'TABLE', 'event',
     'COLUMN', 'way_names'
go

exec sp_addextendedproperty 'MS_Description', '掛帳業務部門代碼', 'SCHEMA', 'dbo', 'TABLE', 'event', 'COLUMN', 'req_department'
go

create index idx_event_code
    on event (code)
go

create index idx_template_code
    on template (code)
go

create index idx_template_deleted
    on template (deleted)
go

create table users
(
    uid                    uniqueidentifier  not null
        constraint pk_users
            primary key,
    user_id                varchar(50)       not null,
    password               varchar(128),
    name                   nvarchar(10),
    role_uid               uniqueidentifier  not null
        constraint fk_users_role
            references role,
    department_uid         uniqueidentifier
        constraint fk_users_department
            references department,
    company_uid            uniqueidentifier
        constraint fk_users_company
            references company,
    email                  varchar(100),
    phone_number           varchar(20),
    last_login_time        datetime2,
    last_login_message     nvarchar(150),
    enabled                tinyint default 1 not null,
    confidential_apply_uid uniqueidentifier,
    create_time            datetime2,
    create_user            uniqueidentifier,
    update_time            datetime2,
    update_user            uniqueidentifier,
    deleted                tinyint default 0 not null,
    delete_time            datetime2,
    delete_user            uniqueidentifier
)
go

exec sp_addextendedproperty 'MS_Description', '使用者表', 'SCHEMA', 'dbo', 'TABLE', 'users'
go

exec sp_addextendedproperty 'MS_Description', 'PK', 'SCHEMA', 'dbo', 'TABLE', 'users', 'COLUMN', 'uid'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 使用者代號，對應到LDAP\n[range/list] n/a\n[example] Z00015048\n[reference] n/a', 'SCHEMA', 'dbo', 'TABLE',
     'users', 'COLUMN', 'user_id'
go

exec sp_addextendedproperty 'MS_Description', '密碼。本系統驗證才會使用。', 'SCHEMA', 'dbo', 'TABLE', 'users', 'COLUMN', 'password'
go

exec sp_addextendedproperty 'MS_Description', '[definition] 使用者姓名\n[range/list] n/a\n[example] n/a\n[reference] n/a',
     'SCHEMA', 'dbo', 'TABLE', 'users', 'COLUMN', 'name'
go

exec sp_addextendedproperty 'MS_Description', '角色鍵值', 'SCHEMA', 'dbo', 'TABLE', 'users', 'COLUMN', 'role_uid'
go

exec sp_addextendedproperty 'MS_Description', '部門鍵值', 'SCHEMA', 'dbo', 'TABLE', 'users', 'COLUMN', 'department_uid'
go

exec sp_addextendedproperty 'MS_Description', '公司鍵值', 'SCHEMA', 'dbo', 'TABLE', 'users', 'COLUMN', 'company_uid'
go

exec sp_addextendedproperty 'MS_Description', '[definition] 使用者電子信箱\n[range/list] n/a\n[example]  n/a\n[reference] n/a',
     'SCHEMA', 'dbo', 'TABLE', 'users', 'COLUMN', 'email'
go

exec sp_addextendedproperty 'MS_Description', '[definition] 電話\n[range/list] n/a\n[example]  n/a\n[reference] n/a',
     'SCHEMA', 'dbo', 'TABLE', 'users', 'COLUMN', 'phone_number'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 使用者最後登入時間\n[range/list] n/a\n[example] 2021-01-02 09:25:54\n[reference] n/a', 'SCHEMA', 'dbo',
     'TABLE', 'users', 'COLUMN', 'last_login_time'
go

exec sp_addextendedproperty 'MS_Description',
     '[definition] 使用者最後登入訊息\n[range/list] failcnt:failmsg\n[example] 0:success, 1:login failed, 2:account disabled or intruder locked, 3:exception message\n[reference] n/a',
     'SCHEMA', 'dbo', 'TABLE', 'users', 'COLUMN', 'last_login_message'
go

exec sp_addextendedproperty 'MS_Description', '是否啟用。0 停用，1啟用。', 'SCHEMA', 'dbo', 'TABLE', 'users', 'COLUMN', 'enabled'
go

exec sp_addextendedproperty 'MS_Description', '敏資權限申請資料鍵值', 'SCHEMA', 'dbo', 'TABLE', 'users', 'COLUMN',
     'confidential_apply_uid'
go

create index idx_users_user_id
    on users (user_id)
go

create index idx_users_deleted
    on users (deleted)
go

create table users_confidential_apply
(
    uid                  uniqueidentifier  not null
        constraint pk_users_confidential_apply
            primary key,
    form_number          varchar(20)       not null,
    applicants_user_id   varchar(50)       not null,
    auditor_group_email  varchar(50)       not null,
    applicants_users_uid uniqueidentifier  not null
        constraint fk_users_confidential_apply_users
            references users,
    auditor_users_uid    uniqueidentifier
        constraint fk_users_confidential_apply_users_0
            references users,
    status               tinyint default 0 not null,
    memo                 nvarchar(100),
    create_time          datetime2,
    create_user          uniqueidentifier,
    update_time          datetime2,
    update_user          uniqueidentifier,
    deleted              tinyint default 0 not null,
    delete_time          datetime2,
    delete_user          uniqueidentifier
)
go

exec sp_addextendedproperty 'MS_Description', '敏資查閱權限管理表', 'SCHEMA', 'dbo', 'TABLE', 'users_confidential_apply'
go

exec sp_addextendedproperty 'MS_Description', 'PK', 'SCHEMA', 'dbo', 'TABLE', 'users_confidential_apply', 'COLUMN',
     'uid'
go

exec sp_addextendedproperty 'MS_Description', '需求單號', 'SCHEMA', 'dbo', 'TABLE', 'users_confidential_apply', 'COLUMN',
     'form_number'
go

exec sp_addextendedproperty 'MS_Description', '審核者群組電子信箱', 'SCHEMA', 'dbo', 'TABLE', 'users_confidential_apply',
     'COLUMN', 'auditor_group_email'
go

exec sp_addextendedproperty 'MS_Description', '申請人鍵值', 'SCHEMA', 'dbo', 'TABLE', 'users_confidential_apply', 'COLUMN',
     'applicants_users_uid'
go

exec sp_addextendedproperty 'MS_Description', '審核此申請的人員鍵值', 'SCHEMA', 'dbo', 'TABLE', 'users_confidential_apply',
     'COLUMN', 'auditor_users_uid'
go

exec sp_addextendedproperty 'MS_Description', '狀態。 0 未審核、1 已通過、2 已退回。', 'SCHEMA', 'dbo', 'TABLE',
     'users_confidential_apply', 'COLUMN', 'status'
go

exec sp_addextendedproperty 'MS_Description', '備註', 'SCHEMA', 'dbo', 'TABLE', 'users_confidential_apply', 'COLUMN',
     'memo'
go

alter table users
    add constraint fk_users_users_confidential_apply
        foreign key (confidential_apply_uid) references users_confidential_apply
go

create index idx_users_confidential_apply_deleted
    on users_confidential_apply (deleted)
go

