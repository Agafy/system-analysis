-- Все типы данных, кроме nvarchar и char, имеются в PostgreSQL. 
-- Вместо nvarchar используется тип данных varchar или text.
-- Если было nvarchar(255), то заменяем на text
-- Иначе можем заменить на varchar 
-- С nchar аналогично, только будет char и text
CREATE TABLE public.cardTypes(
	idCardType smallint NOT NULL,
	idCardSystem bigint NULL,
	name varchar(50) NULL,
	CONSTRAINT "PK_cardType" PRIMARY KEY (idCardType)
)

CREATE TABLE public.dirStatuses(
	idDirStatus smallint NOT NULL,
	name varchar(50) NULL,
	CONSTRAINT "PK_DirStatus" PRIMARY KEY (idDirStatus)
)

CREATE TABLE public.clients(
	idClient bigint NOT NULL,
	firstName text(255) NULL,
	middleName text(255) NULL,
	surname text(255) NULL,
	birthday date NULL,
	regAddress text(255) NULL,
	idDirStatus smallint NULL,
	createDate date NULL,
	PIN_EQ nchar(6) NULL,
	CONSTRAINT "PK_Client" PRIMARY KEY (idClient),
	CONSTRAINT "FK_DirStatus" FOREIGN KEY (idDirStatus) REFERENCES dirStatuses (idDirStatus)
)

CREATE TABLE public.departments(
	IdDepartment int NOT NULL,
	name text(255) NULL,
	idDepartmentsSystem bigint NULL,
	workTime text(255) NULL,
	phone text(255) NULL,
	addressString text(255) NULL,
	CONSTRAINT "PK_Department" PRIMARY KEY (IdDepartment)
)

CREATE TABLE public.dirChannels(
	idDirChannel smallint NOT NULL,
	name varchar(50) NULL,
	CONSTRAINT "PK_DirChannel" PRIMARY KEY (idDirChannel)
)

CREATE TABLE public.dirStatusesOrders(
	idDirStatusOrder smallint NOT NULL,
	name varchar(50) NULL,
	CONSTRAINT "PK_DirStatusOrder" PRIMARY KEY (idDirStatusOrder)
)

CREATE TABLE public.users(
	idUser bigint NOT NULL,
	login char(10) NULL,
	CONSTRAINT "PK_User" PRIMARY KEY (idUser)
)

CREATE TABLE public.orders(
	idOrder bigint NOT NULL,
	idClient bigint NULL,
	idDirChannel smallint NULL,
	idCardType smallint NULL,
	idDepartment int NULL,
	idDirStatusOrder smallint NULL,
	createDate date NULL,
	editUser bigint NULL,
	updateDate date NULL,
	CONSTRAINT "PK_Order" PRIMARY KEY (idOrder),
	CONSTRAINT "FK_Client" FOREIGN KEY (idClient) REFERENCES clients(idClient),
	CONSTRAINT "FK_DirChannel" FOREIGN KEY (idDirChannel) REFERENCES dirChannels(idDirChannel),
	CONSTRAINT "FK_CardType" FOREIGN KEY (idCardType) REFERENCES cardTypes(idCardType),
	CONSTRAINT "FK_Department" FOREIGN KEY (idDepartment) REFERENCES departments(IdDepartment),
	CONSTRAINT "FK_DirStatusOrder" FOREIGN KEY (idDirStatusOrder) REFERENCES dirStatusesOrders(idDirStatusOrder),
	CONSTRAINT "FK_editUser" FOREIGN KEY (editUser) REFERENCES users(idUser)
)


SELECT * FROM users
LIMIT 1000