
create DATABASE TestDB2;
GO

USE TestDB2;
GO

create table users(
	id varchar(50) primary key,
	name varchar(50),
	nickname varchar(50),
	gender int,
	disabled bit,
	username varchar(50),
	password varchar(256),
	email varchar(80),
	phone varchar(50)
);

GO

