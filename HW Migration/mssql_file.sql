-- Не делала преобразований данных, так как данные перенеслись корректно

INSERT INTO [POSTGRESQL].[PlasticOrder].[public].[cardtypes]
SELECT idCardType, idCardSystem, IIF(name NOT LIKE '[A-Я]%', right(name, len(name)-2), name)
FROM PlasticOrder.dbo.cardTypes

INSERT INTO [POSTGRESQL].[PlasticOrder].[public].[users]
SELECT *
FROM PlasticOrder.dbo.users

INSERT INTO [POSTGRESQL].[PlasticOrder].[public].[dirstatusesorders]
SELECT *
FROM PlasticOrder.dbo.dirStatusesOrders

INSERT INTO [POSTGRESQL].[PlasticOrder].[public].[dirstatuses]
SELECT *
FROM PlasticOrder.dbo.dirStatuses

INSERT INTO [POSTGRESQL].[PlasticOrder].[public].[dirchannels]
SELECT *
FROM PlasticOrder.dbo.dirChannels

INSERT INTO [POSTGRESQL].[PlasticOrder].[public].[departments]
SELECT *
FROM PlasticOrder.dbo.departments

DECLARE @Offset INT = 0;  -- начальное смещение
DECLARE @BatchSize INT = 1000;  -- размер блока

WHILE EXISTS (
    SELECT 1
    FROM PlasticOrder.dbo.clients
    WHERE idClient > @Offset
)
BEGIN
    INSERT INTO [POSTGRESQL].[PlasticOrder].[public].[clients]
    SELECT *
    FROM PlasticOrder.dbo.clients
    ORDER BY idClient
    OFFSET @Offset ROWS
    FETCH NEXT @BatchSize ROWS ONLY;

    SET @Offset += @BatchSize;
END;

DECLARE @Offset INT = 0;  -- начальное смещение
DECLARE @BatchSize INT = 1000;  -- размер блока

WHILE EXISTS (
    SELECT 1
    FROM PlasticOrder.dbo.orders
    WHERE idOrder > @Offset
)
BEGIN
    INSERT INTO [POSTGRESQL].[PlasticOrder].[public].[orders]
    SELECT *
    FROM PlasticOrder.dbo.orders
    ORDER BY idOrder
    OFFSET @Offset ROWS
    FETCH NEXT @BatchSize ROWS ONLY;

    SET @Offset += @BatchSize;
END;



SELECT TOP 1000 * FROM users